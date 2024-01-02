package member.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import member.model.MemberBean;
import member.model.MemberDao;

@Controller
public class KakaoLoginController {

   private final String command = "/kakaologin.member";
   private final String gotoPage = "view.main";

   @Autowired
   private MemberDao memberDao;

   @RequestMapping(value = command, method = RequestMethod.GET)
   public void kakaoregister(@RequestParam("member_id") String member_id, HttpSession session,
         HttpServletResponse response, HttpServletRequest request) throws IOException {
      session.setAttribute("member_id", member_id);
      String prevPage = (String) session.getAttribute("prevPage");
      PrintWriter out = response.getWriter();
      response.setContentType("text/html; charset=UTF-8");

      MemberBean memberBean = memberDao.findwithId(member_id);// 가입한 아이디가 있는지 확인

		if (memberBean == null) {
			out.println("<script>alert('등록된 정보가없어 회원가입페이지로 이동합니다.'); location.href='" + request.getContextPath()
					+ "/kakaoRegister.member';</script>");
			out.flush();
		} else {
			Date now = new Date();
			Date ban_expiration = memberBean.getBan_expiration();
			System.out.println("now : " + now);
			System.out.println("ban_expiration : " + ban_expiration);
			if (memberBean.getBan_count() > 0 && memberBean.getBan_expiration() != null) {
				if (!now.after(ban_expiration)) {
					out.println("<script>alert('규칙 위반으로 계정 이용 정지 기간입니다.'); location.href='" + gotoPage + "';</script>");
					out.flush();
				} 
			} else {
				session.setAttribute("kakaoLoginInfo", memberBean);
				if (prevPage != null && !prevPage.isEmpty()
						&& !prevPage.equals("http://localhost:8080/ex/kakaoRegister.member")) {
					session.removeAttribute("prevPage");
					out.println("<script>alert('로그인 되었습니다.'); location.href='" + prevPage + "';</script>");
					out.flush();
				} else {
					out.println("<script>alert('로그인 되었습니다.'); location.href='" + gotoPage + "';</script>");
					out.flush();
				}
			}
		}
	}
}
