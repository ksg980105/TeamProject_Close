package qna.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;

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

import qna.model.QnaBean;
import qna.model.QnaDao;

@Controller
public class QnaInsertController {

	private final String command = "/insert.qna";
	private final String viewPage = "qnaInsertForm";
	private final String gotoPage = "redirect:/list.qna";
	
	@Autowired
	QnaDao qnaDao;
	
	@Autowired
	ServletContext servletContext;
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public String insertForm() {
		
		return viewPage;
	}
	
	@RequestMapping(value = command, method = RequestMethod.POST)
	public String insert(@Valid QnaBean qnaBean,
							BindingResult bResult,
							Model model) throws IOException {
		
		System.out.println("문의유형 : " + qnaBean.getQna_category());
		System.out.println("제목 : " + qnaBean.getTitle());
		System.out.println("내용 : " + qnaBean.getContent());
		System.out.println("사진첨부 : " + qnaBean.getImage());
		
		if(qnaBean.getSecret() == null) {
			qnaBean.setSecret("NO");
		}
		
		if(bResult.hasErrors()) {
			return viewPage;
		}
		qnaBean.setWrite_date(new Timestamp(System.currentTimeMillis()));
		
		String uploadPath = servletContext.getRealPath("/resources/qnaImage");
		
		int cnt = qnaDao.insertQna(qnaBean);
		File destination = new File(uploadPath+File.separator+qnaBean.getImage());
		
		MultipartFile multi = qnaBean.getUpload();
		try {
			multi.transferTo(destination);
		}catch(Exception e) {
			e.printStackTrace();
		} 
		
		
		return gotoPage;
	}
	
}
