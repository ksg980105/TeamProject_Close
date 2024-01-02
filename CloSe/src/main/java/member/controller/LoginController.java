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

import member.model.MemberBean;
import member.model.MemberDao;

@Controller
public class LoginController {

   private final String command = "/login.member";
   private final String viewPage = "loginForm";
   private final String gotoPage = "view.main";

   @Autowired
   private MemberDao memberDao;

   @RequestMapping(value = command, method = RequestMethod.GET)
   public String login(HttpSession session, HttpServletRequest request) {
      session.setAttribute("prevPage", request.getHeader("Referer"));
      System.out.println("request.getHeader:" + request.getHeader("Referer"));
      return viewPage;
   }

   @RequestMapping(value = command, method = RequestMethod.POST)
   public String login(MemberBean mb, HttpServletResponse response, HttpSession session) throws IOException {
      String prevPage = (String) session.getAttribute("prevPage");

      PrintWriter out;
      out = response.getWriter();
      response.setContentType("text/html; charset=UTF-8");

      MemberBean memberBean = memberDao.getDetail(mb.getMember_id());

      if (memberBean == null) {
         out.println("<script>alert('가입하지 않은 회원입니다.');</script>");
         out.flush();
         return viewPage;
      } else { // 아이디 존재함
         if (memberBean.getPassword().equals(mb.getPassword())) { // 비번이 일치함
            if (memberBean.getBan_count() > 0 && memberBean.getBan_expiration() != null) {
               Date now = new Date();
               Date ban_expiration = memberBean.getBan_expiration();
               System.out.println("now : " + now);
               System.out.println("ban_expiration : " + ban_expiration);
               if (!now.after(ban_expiration)) {
                  out.println(
                        "<script>alert('규칙 위반으로 계정 이용 정지 기간입니다.'); location.href='" + gotoPage + "';</script>");
                  out.flush();
               }
            } else {
               session.setAttribute("loginInfo", memberBean); // DB에서 가져온 레코드를 loginInfo로 설정
               if (prevPage != null && !prevPage.isEmpty()
                     && !prevPage.equals("http://localhost:8080/ex/register.member")
                     && !prevPage.equals("http://localhost:8080/ex/findid.member")
                     && !prevPage.equals("http://localhost:8080/ex/findpw.member")
                     && !prevPage.contains("http://localhost:8080/ex/sendEmail.member")) {
                  // 이전 페이지의 URL을 세션에서 제거
                  session.removeAttribute("prevPage");
                  out.println("<script>alert('로그인 되었습니다.'); location.href='" + prevPage + "';</script>");
                  out.flush();
               } else {
                  // 이전 페이지의 URL이 없으면 기본적으로 메인 페이지로 리다이렉트
                  out.println("<script>alert('로그인 되었습니다.'); location.href='" + gotoPage + "';</script>");
                  out.flush();
               }
            }
         }
      }
      out.println("<script>alert('비밀번호가 일치하지 않습니다.');</script>");
      out.flush();
      return viewPage;
   }
}