package member.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import member.model.EventDao;
import member.model.MemberDao;

@Controller
public class DeleteController {
	
	private final String command = "/delete.member";
	private final String gotoPage = "/view.main";
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private EventDao eventDao;
	
	@RequestMapping(value = command)
	public void delete(@RequestParam("member_id") String member_id, HttpServletResponse response, HttpServletRequest request) throws IOException {
		
		PrintWriter out;
		out = response.getWriter();
		response.setContentType("text/html; charset=UTF-8");
		
		memberDao.memberDelete(member_id);
		eventDao.deleteCoupon(member_id);
		
		out.println("<script>alert('탈퇴 완료되었습니다.'); location.href='" + request.getContextPath() + "/logout.jsp';</script>");
		out.flush();
	}
}
