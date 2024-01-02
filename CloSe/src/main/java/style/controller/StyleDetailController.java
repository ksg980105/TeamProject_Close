package style.controller;

import java.io.File;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import member.model.MemberBean;
import style.model.HeartDao;
import style.model.StyleBean;
import style.model.StyleDao;

@Controller
public class StyleDetailController {

	private final String command = "detail.style";
	private final String viewPage = "styleDetailView";
	private final String gotoPage = "redirect:/mainView.style";

	@Autowired
	ServletContext servletContext;

	@Autowired
	private StyleDao styleDao;
	@Autowired
	private HeartDao heartDao;

	@RequestMapping(value = command, method = RequestMethod.GET)
	public String insertForm(HttpSession session, @RequestParam("style_number") int style_number, Model model) {
		styleDao.updateReadCount(style_number);
		StyleBean styleBean = styleDao.getStyleByStyleNumber(style_number);
		model.addAttribute("styleBean", styleBean);
		

		if (session.getAttribute("loginInfo") != null) {
			styleBean.setInfoMemberId(((MemberBean)(session.getAttribute("loginInfo"))).getMember_id());
		} else if (session.getAttribute("kakaoLoginInfo") != null) {
			styleBean.setInfoMemberId(((MemberBean)(session.getAttribute("kakaoLoginInfo"))).getMember_id());
			System.out.println("styleBean.getInfoMemberId():"+styleBean.getInfoMemberId());
		}
		model.addAttribute("heartCount", heartDao.countHeart(styleBean.getStyle_number()));
		model.addAttribute("heartFlag", heartDao.searchHeart(styleBean));
		return viewPage;
	}

	@RequestMapping(value = command, method = RequestMethod.POST)
	public String insert(@Valid StyleBean styleBean, BindingResult result, HttpServletResponse response,
			HttpServletRequest request) {
		response.setContentType("text/html; charset=UTF-8");
		if (result.hasErrors()) {
			return viewPage;
		}

		String path = servletContext.getRealPath("/resources/styleImage");

		File directory = new File(path);
		if (!directory.exists()) {
			directory.mkdirs(); //
		}

		List<MultipartFile> images = styleBean.getImages();
		for (int i = 1; i < images.size() + 1; i++) {
			String imageName = null;
			MultipartFile image = null;
			switch (i) {
			case 1:
				imageName = styleBean.getImage1();
				image = styleBean.getMImage1();
				break;
			case 2:
				imageName = styleBean.getImage2();
				image = styleBean.getMImage2();
				break;
			case 3:
				imageName = styleBean.getImage3();
				image = styleBean.getMImage3();
				break;
			case 4:
				imageName = styleBean.getImage4();
				image = styleBean.getMImage4();
				break;
			case 5:
				imageName = styleBean.getImage5();
				image = styleBean.getMImage5();
				break;
			default:
				break;
			}

			File uploadImage = new File(path + File.separator + imageName);
			try {
				image.transferTo(uploadImage);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		styleDao.insertStyle(styleBean);
		return gotoPage;
	}

}
