package member.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import member.model.MemberBean;
import member.model.MemberDao;

@Controller
public class FindIdController {
	
	private final String command = "/findid.member";
	private final String viewPage = "findIdForm";
	
	@Autowired
	private MemberDao memberDao;
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public String findid() {
		
		return viewPage;
	}
	
	@RequestMapping(value = command, method = RequestMethod.POST)
	public ModelAndView findid(@RequestParam("name") String name,
						 @RequestParam("phone") String phone,
						 HttpServletResponse response) throws IOException {
		
		ModelAndView mav = new ModelAndView();
		
		PrintWriter out;
		out = response.getWriter();
		response.setContentType("text/html; charset=UTF-8");
		
		Map<String, String> params = new HashMap<String, String>();
	    params.put("name", name);
	    params.put("phone", phone);
		
		MemberBean memberBean = memberDao.findwithNameAndPhone(params);
		
		if(memberBean == null) {
			out.println("<script>alert('회원정보가 없습니다.')</script>");
			out.flush();
			mav.setViewName(viewPage);
			return mav;
		}else {
			if(phone.equals(memberBean.getPhone())) {
				if(memberBean.getSocial().equals("kakao")) {
					out.println("<script>alert('카카오 회원입니다. 카카오톡 로그인을 이용해주세요.')</script>");
					out.flush();
					mav.setViewName(viewPage);
					return mav;
					
				}else {
					String memberId = memberBean.getMember_id();
					String alertMessage = "아이디는 [" + memberId + "] 입니다.";
					
					out.println("<script>alert('" + alertMessage + "')</script>");
					out.flush();
					mav.setViewName(viewPage);
					return mav;
				}
				
			}else {
				out.println("<script>alert('휴대폰 번호가 일치하지 않습니다.')</script>");
				out.flush();
				mav.setViewName(viewPage);
				return mav;
			}
		}
	}
}
