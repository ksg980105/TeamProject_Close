package qna.controller;

import java.io.File;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import qna.model.QnaBean;
import qna.model.QnaDao;

@Controller
public class QnaDeleteController {

	private final String command = "/delete.qna";
	private final String gotoPage = "redirect:/list.qna";
	
	@Autowired
	QnaDao qnaDao;
	
	@Autowired
	ServletContext servletContext;
	
	@RequestMapping(value = command)
	public String delete(@RequestParam("pageNumber") String pageNumber,
							@RequestParam("qna_number") String qna_number,
							Model model) {
		
		QnaBean qnaBean = qnaDao.selectQna(qna_number);
		qnaDao.deleteQna(qna_number);
		
		String uploadPath =  servletContext.getRealPath("/resources/qnaImage/");
		
		File image = new File(uploadPath+File.separator+qnaBean.getImage());
		
		image.delete();
		
		model.addAttribute("pageNumber", pageNumber);
		return gotoPage;
		
	}
	
}
