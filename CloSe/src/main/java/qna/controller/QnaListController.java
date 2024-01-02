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
public class QnaListController {
	
	private final String command = "/list.qna";
	private final String viewPage = "qnaList";
	
	@Autowired
	QnaDao qnaDao;
	
	@RequestMapping(value = command)
	public String list(@RequestParam(value = "whatColumn", required = false) String whatColumn,
						@RequestParam(value = "keyword", required = false) String keyword,
						@RequestParam(value = "pageNumber", required = false) String pageNumber,
						HttpServletRequest request,
						HttpSession session,
						Model model) {
		
		System.out.println("whatColumn : " + whatColumn);
		System.out.println("keyword : " + keyword);
		
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
		 
		 model.addAttribute("lists", lists);
		 model.addAttribute("pageInfo", pageInfo);
		 model.addAttribute("number", number);
		 
		return viewPage;
	}
	
}
