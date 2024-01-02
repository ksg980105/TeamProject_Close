package member.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
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
public class UpdateController {

	private final String command = "/update.member";
	private final String viewPage = "updateForm";

	@Autowired
	private MemberDao memberDao;

	@Autowired
	ServletContext servletContext;

	@RequestMapping(value = command, method = RequestMethod.GET)
	public String update() {

		return viewPage;
	}

	@RequestMapping(value = command, method = RequestMethod.POST)
	public void update(MemberBean memberBean, HttpServletResponse response, HttpServletRequest request,
			HttpSession session) throws IOException {
		PrintWriter out;
		out = response.getWriter();
		response.setContentType("text/html; charset=UTF-8");

		String path = servletContext.getRealPath("/resources/memberImage");

		File directory = new File(path);
		if (!directory.exists()) {
			directory.mkdirs();
		}

		String imageName = memberBean.getMember_image();
		File uploadImage = new File(path + File.separator + imageName);

		try {
			memberBean.getUpload().transferTo(uploadImage);
		} catch (Exception e) {
			e.printStackTrace();
		}

		if (memberBean.getSocial().equals("kakao")) {
			session.setAttribute("kakaoLoginInfo", memberBean);
			memberDao.memberUpdate(memberBean);

			out.println("<script>alert('회원정보가 수정되었습니다.'); location.href='" + request.getContextPath()
					+ "/mypage.member';</script>");
			out.flush();
		} else {
			session.setAttribute("loginInfo", memberBean);
			memberDao.memberUpdate(memberBean);

			out.println("<script>alert('회원정보가 수정되었습니다.'); location.href='" + request.getContextPath()
					+ "/mypage.member';</script>");
			out.flush();
		}

	}
}
