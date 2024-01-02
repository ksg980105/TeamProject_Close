package member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import member.model.MemberDao;

@Controller
public class DuplicateController {

	private final String command = "/duplicate.member";
	
	@Autowired
	private MemberDao memberDao;
	
	@RequestMapping(value = command)
	@ResponseBody
	public String duplicate(@RequestParam("inputid") String inputid) {
		
		int cnt = memberDao.findId(inputid);
		if(cnt == 0) {
			return "YES";
		}else {
			return "NO";
		}
	}
	
}
