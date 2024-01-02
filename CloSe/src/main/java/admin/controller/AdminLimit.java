package admin.controller;

import java.sql.Date;
import java.time.LocalDate;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import member.model.MemberBean;
import member.model.MemberDao;

@Controller
public class AdminLimit {

	private final String command = "limit.member";
	private final String gotoPage = "redirect:/adminPage.member";

	@Autowired
	MemberDao memberDao;

	@RequestMapping(value = command, method = RequestMethod.GET)
	public String limit(@RequestParam("member_id") String member_id, @RequestParam("pageNumber") String pageNumber,
			Model model) {

		MemberBean memberBean = memberDao.getMember(member_id);

		LocalDate now = LocalDate.now();

		switch (memberBean.getBan_count()) {
		case 0:
			memberDao.updateMemberBanExpiration(member_id, Date.valueOf(now.plusDays(7)));
			break;
		case 1:
			memberDao.updateMemberBanExpiration(member_id, Date.valueOf(now.plusDays(30)));
			break;
		case 2:
			memberDao.updateMemberBanExpiration(member_id, Date.valueOf(now.plusYears(1000)));
			break;
		}

		memberBean.setBan_count(memberBean.getBan_count() + 1);

		int cnt = memberDao.updateMemberBan(memberBean);

		if (cnt == -1) {
			System.out.println("update memberBan 실패");
		} else {
			System.out.println("update memberBan 성공");
		}

		model.addAttribute("member_id", member_id);
		model.addAttribute("pageNumber", pageNumber);
		return gotoPage;
	}
}
