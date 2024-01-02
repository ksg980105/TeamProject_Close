package qna.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import qna.model.QnaBean;
import qna.model.QnaDao;
import utility.Paging;

@Controller
public class QnaUpdateController {

	private final String command = "/update.qna";
	private final String viewPage = "qnaUpdateForm";
	private final String gotoPage = "redirect:/list.qna";
	
	@Autowired
	ServletContext servletContext;
	
	@Autowired
	QnaDao qnaDao;
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public String updateForm(@RequestParam("pageNumber") String pageNumber,
								@RequestParam("qna_number") String qna_number,
								HttpServletRequest request,
								Model model) {
		QnaBean qnaBean = qnaDao.selectQna(qna_number);
		
		model.addAttribute("qnaBean", qnaBean);
		model.addAttribute("pageNumber", pageNumber);
		model.addAttribute("qna_number", qna_number);
		
		return viewPage;
	}
	
	@RequestMapping(value = command, method = RequestMethod.POST)
	public String update(@Valid QnaBean qnaBean,
							BindingResult bResult, 
							@RequestParam("pageNumber") String pageNumber,
							@RequestParam("qna_number") String qna_number,
							HttpServletResponse response,
							HttpSession session,
							Model model) throws IOException {
		
		System.out.println("image : " + qnaBean.getImage());
		
		if(bResult.hasErrors()) {
			model.addAttribute("pageNumber", pageNumber);
			model.addAttribute("qna_number", qna_number);
			return viewPage;
		}
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		String uploadPath = servletContext.getRealPath("/resources/qnaImage/");
		
		if(qnaBean.getSecret() == null) {
			qnaBean.setSecret("NO");
		}
		
		int cnt = qnaDao.updateQna(qnaBean);
		File destination = new File(uploadPath+File.separator+qnaBean.getImage());
		File destination2 = new File(uploadPath+File.separator+qnaBean.getUpload2());
		MultipartFile multi = qnaBean.getUpload();
		
		try {
			multi.transferTo(destination);
			destination2.delete();
			model.addAttribute("pageNumber", pageNumber);
			return gotoPage;
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		if(cnt == -1) {
			out.println("<script>alert('올바른 형식이 아닙니다.');</script>");
			out.flush();
			model.addAttribute("pageNumber", pageNumber);
			model.addAttribute("qna_number", qna_number);
			return viewPage;
		}
		
		model.addAttribute("pageNumber", pageNumber);
		return gotoPage;
	}
	
}
