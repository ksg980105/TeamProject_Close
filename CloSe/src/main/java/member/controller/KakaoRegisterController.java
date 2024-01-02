package member.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import member.model.MemberBean;
import member.model.MemberDao;

@Controller
public class KakaoRegisterController {

	private final String command = "/kakaoRegister.member";
	private final String viewPage = "kakaoRegisterForm";

	@Autowired
	ServletContext servletContext;
	
	@Autowired
	private MemberDao memberDao;

	@RequestMapping(value = command, method = RequestMethod.GET)
	public String registerGet() {

		return viewPage;
	}

	@RequestMapping(value = command, method = RequestMethod.POST)
	public String registerPost(@Valid MemberBean mb, BindingResult bresult, HttpServletResponse response, HttpServletRequest request, Model model) throws IOException{
		PrintWriter out;
		out = response.getWriter();
		response.setContentType("text/html; charset=UTF-8");
		
		if(bresult.hasErrors()) {
			return viewPage;
		}
		
		String path = servletContext.getRealPath("/resources/memberImage");
		System.out.println(path);
		File directory = new File(path);
	    if (!directory.exists()) {
	        directory.mkdirs();
	    }
	    
	    String imageName = mb.getMember_image();
	    File uploadImage = new File(path + File.separator + imageName);
	    try {
			mb.getUpload().transferTo(uploadImage);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		model.addAttribute("memberBean", mb);
		memberDao.kakaoRegister(mb);
		out.println("<script>alert('카카오 회원가입이 완료되었습니다 로그인페이지로 이동합니다.'); location.href='" + request.getContextPath() + "/login.member';</script>");
		out.flush();

		return null;


	}
}
