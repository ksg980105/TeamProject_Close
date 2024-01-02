package admin.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import member.model.MemberDao;

@Controller
public class AdminLimitCancelController {

	private final String command = "limitCancel.member";
	private final String gotoPage = "redirect:/adminPage.member";

	@Autowired
	MemberDao memberDao;
	
	@RequestMapping(command)
	public String limitCancel(@RequestParam("member_id") String member_id,
								@RequestParam("pageNumber") String pageNumber,
								Model model) {
		
		int cnt = memberDao.updateMemberBanCancel(member_id);
		
		if(cnt == -1) {
			System.out.println("실패");
		}else {
			System.out.println("성공");
		}
		
		model.addAttribute("pageNumber", pageNumber);
		return gotoPage;
	}
	
}
