package notice.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import notice.model.NoticeBean;
import notice.model.NoticeDao;

@Controller
public class NoticeDetailController {

	private final String command = "/detail.notice";
	private final String viewPage = "noticeDetail";
	
	@Autowired
	NoticeDao noticeDao;
	
	@RequestMapping(value = command)
	public String detail(@RequestParam("pageNumber") String pageNumebr,
							@RequestParam("notice_number") String notice_number,
							Model model) {
		
		NoticeBean noticeBean = noticeDao.detailNotice(notice_number);
		
		model.addAttribute("pageNumber", pageNumebr);
		model.addAttribute("noticeBean", noticeBean);
		return viewPage;
	}
	
	
}
