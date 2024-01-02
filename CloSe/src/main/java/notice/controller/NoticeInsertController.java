package notice.controller;

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
import org.springframework.web.multipart.MultipartFile;

import notice.model.NoticeBean;
import notice.model.NoticeDao;

@Controller
public class NoticeInsertController {
	
	private final String command = "insert.notice";
	private final String viewPage = "noticeInsertForm";
	private final String gotoPage = "redirect:/list.notice";
	
	@Autowired
	ServletContext servletContext;
	
	@Autowired
	NoticeDao noticeDao;
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public String insertForm() {
		return viewPage;
	}
	
	@RequestMapping(value = command, method = RequestMethod.POST)
	public String insert(@Valid NoticeBean noticeBean,
							BindingResult bResult,
							HttpServletResponse response,
							Model model) throws IOException {
		if(bResult.hasErrors()) {
			return viewPage;
		}
		noticeBean.setWrite_date(new Timestamp(System.currentTimeMillis()));
		String uploadPath = servletContext.getRealPath("/resources/noticeImage");
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		int cnt = noticeDao.insertNotice(noticeBean);
		File destination = new File(uploadPath+File.separator+noticeBean.getImage());
		
		MultipartFile multi = noticeBean.getUpload();
		try {
			multi.transferTo(destination);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return gotoPage;
	}
	
}
