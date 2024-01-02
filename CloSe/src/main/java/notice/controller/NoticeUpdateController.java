package notice.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import notice.model.NoticeBean;
import notice.model.NoticeDao;

@Controller
public class NoticeUpdateController {

	private final String command = "/update.notice";
	private final String viewPage = "noticeUpdateForm";
	private final String gotoPage = "redirect:/list.notice";
	
	@Autowired
	ServletContext servletContext;
	
	@Autowired
	NoticeDao noticeDao;
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public String updateForm(@RequestParam("notice_number") String notice_number,
								@RequestParam("pageNumber") String pageNumber,
								Model model) {
		
		NoticeBean noticeBean = noticeDao.getNoticeByNumber(notice_number);
		
		model.addAttribute("noticeBean", noticeBean);
		model.addAttribute("pageNumber", pageNumber);
		return viewPage;
	}
	
	@RequestMapping(value = command, method = RequestMethod.POST)
	public String update(@Valid NoticeBean noticeBean,
							BindingResult bResult,
							@RequestParam("pageNumber") String pageNumber,
							HttpServletResponse response,
							Model model) throws IOException {
		if(bResult.hasErrors()) {
			model.addAttribute("pageNumber", pageNumber);
			return viewPage;
		}
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		String uploadPath = servletContext.getRealPath("/resources/noticeImage/");
		
		int cnt = noticeDao.updateNotice(noticeBean);
		File destination = new File(uploadPath+File.separator+noticeBean.getImage());
		File destination2 = new File(uploadPath+File.separator+noticeBean.getUpload2());
		MultipartFile multi = noticeBean.getUpload();
		try {
			multi.transferTo(destination);
			destination2.delete();
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		if(cnt == -1) {
			out.println("<script>alert('올바른 형식이 아닙니다.');</script>");
			out.flush();
			model.addAttribute("pageNumber", pageNumber);
			return viewPage;
		}
		model.addAttribute("pageNumber", pageNumber);
		return gotoPage;
	}
	
	
}
