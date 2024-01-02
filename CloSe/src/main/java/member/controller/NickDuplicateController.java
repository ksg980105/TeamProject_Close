package member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import member.model.MemberDao;

@Controller
public class NickDuplicateController {
	
	private final String command = "/nickduplicate.member";
	
	@Autowired
	private MemberDao memberDao;
	
	@RequestMapping(value = command)
	@ResponseBody
	public String duplicate(@RequestParam("inputnick") String inputnick) {
		
		int cnt = memberDao.findNick(inputnick);
		
		if(cnt == 0) {
			return "YES";
		}else {
			return "NO";
		}
	}
}
