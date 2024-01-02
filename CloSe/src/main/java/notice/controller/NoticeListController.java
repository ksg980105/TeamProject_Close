package notice.controller;

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

import notice.model.NoticeBean;
import notice.model.NoticeDao;
import utility.Paging;

@Controller
public class NoticeListController {

	private final String command = "/list.notice";
	private final String viewPage = "noticeList";
	
	@Autowired
	NoticeDao noticeDao;
	
	@RequestMapping(value = command)
	public String list(@RequestParam(value = "whatColumn", required = false) String whatColumn,
						@RequestParam(value = "keyword", required = false) String keyword,
						@RequestParam(value = "pageNumber", required = false) String pageNumber,
						HttpServletRequest request,
						Model model) {
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("whatColumn", whatColumn);
		map.put("keyword", "%"+keyword+"%");
		
		int totalCount = noticeDao.getTotalCount(map);
		String url = request.getContextPath()+command;
		
		Paging pageInfo = new Paging(pageNumber, "5", totalCount, url, whatColumn, keyword);
		
		int number = totalCount - (pageInfo.getPageNumber() -1) * 10;
		
		List<NoticeBean> lists = noticeDao.getAllNotice(map, pageInfo);
		model.addAttribute("lists", lists);
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("number", number);
		return viewPage;
	}
	
}
