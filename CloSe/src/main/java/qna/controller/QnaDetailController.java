package qna.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import qna.model.QnaBean;
import qna.model.QnaDao;
import utility.Paging;

@Controller
public class QnaDetailController {

	private final String command = "/detail.qna";
	private final String viewPage = "qnaDetail";
	
	@Autowired
	QnaDao qnaDao;
	
	@RequestMapping(value = command)
	public String detail(@RequestParam(value = "whatColumn", required = false) String whatColumn,
							@RequestParam(value = "keyword", required = false) String keyword,
							@RequestParam(value = "pageNumber", required = false) String pageNumber,
							@RequestParam(value = "qna_number") String qna_number,
							HttpServletRequest request,
							HttpSession session,
							Model model) {
		
		 Map<String, String> map = new HashMap<String, String>();
		 map.put("whatColumn", whatColumn); 
		 map.put("keyword", "%"+keyword+"%");
		 
		 int totalCount = qnaDao.getTotalCount(map);
		 String url = request.getContextPath() + command;
		 
		 Paging pageInfo = new Paging(pageNumber, "5", totalCount, url, whatColumn, keyword);
		 
		 map.put("begin", String.valueOf(pageInfo.getBeginRow())); 
		 map.put("end", String.valueOf(pageInfo.getEndRow()));
		 
		 int number = totalCount - (pageInfo.getPageNumber() -1) * 10;
		 
		 List<QnaBean> lists = qnaDao.getAllQna(map, pageInfo);
		 List<QnaBean> lists2 = qnaDao.getAllQna2(map, pageInfo);
		
		QnaBean qnaBean = qnaDao.selectQna(qna_number);
		model.addAttribute("pageNumber", pageNumber);
		model.addAttribute("qna_number", qna_number);
		model.addAttribute("lists", lists);
		model.addAttribute("lists2", lists2);
		model.addAttribute("qnaBean", qnaBean);
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("number", number);
		model.addAttribute("content", qnaBean.getContent());
		
		return viewPage;
	}
	
	
}
