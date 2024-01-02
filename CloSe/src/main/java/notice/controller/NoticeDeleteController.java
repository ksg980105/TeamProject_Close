package notice.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import notice.model.NoticeBean;
import notice.model.NoticeDao;
import qna.model.QnaBean;
import utility.Paging;

@Controller
public class NoticeDeleteController {

	private final String command = "/delete.notice";
	private final String viewPage = "noticeDeleteForm";
	private final String gotoPage = "redirect:/list.notice";
	
	@Autowired
	ServletContext servletContext;
	
	@Autowired
	NoticeDao noticeDao;
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public String deleteForm(@RequestParam(value = "whatColumn", required = false) String whatColumn,
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
	
	@RequestMapping(value = command, method = RequestMethod.POST)
	public String delete(@RequestParam(value = "chk", required = false) List<Integer> chk_number,
							@RequestParam("pageNumber") String pageNumber,
							Model model) {
		for(Integer notice_number : chk_number) {
			System.out.println("notice_number : " + notice_number);
		}
		
		if(chk_number != null) {
			for(Integer notice_number : chk_number) {
				NoticeBean noticeBean = noticeDao.selectNotice(notice_number);
				noticeDao.deleteNotice(notice_number);
				String uploadPath = servletContext.getRealPath("/resources/noticeImage");
				File image = new File(uploadPath+File.separator+noticeBean.getImage());
				image.delete();
			}
		}else {
			model.addAttribute("pageNumber", pageNumber);
			return viewPage;
		}
		
		model.addAttribute("pageNumber", pageNumber);
		return gotoPage;
	}
	
}
