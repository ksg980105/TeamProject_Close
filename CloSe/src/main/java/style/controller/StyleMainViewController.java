package style.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import member.model.MemberBean;
import product.model.ProductBean;
import style.model.HeartDao;
import product.model.ProductBean;
import style.model.StyleBean;
import style.model.StyleDao;

@Controller
public class StyleMainViewController {
	private final String command = "mainView.style";
	private final String viewPage = "styleMain";

	@Autowired
	private StyleDao styleDao;
	@Autowired
	private HeartDao heartDao;

	@RequestMapping(value = command, method = RequestMethod.GET)
	public String mainView(@RequestParam(value = "page", defaultValue = "1") int page,
			@RequestParam(value = "pageSize", defaultValue = "10") int pageSize, Model model) {
		model.addAttribute("styleList", styleDao.getStyleList(page, pageSize));
		return viewPage;
	}

	@RequestMapping(value = command, method = RequestMethod.POST)
	@ResponseBody
	public void mainAjax(@RequestParam(value = "page", defaultValue = "1") int page,
			@RequestParam(value = "pageSize", defaultValue = "12") int pageSize, Model model,
			HttpServletResponse response, HttpSession session) throws IOException {
		List<StyleBean> styleList = styleDao.getStyleList(page, pageSize);

		JSONArray jsonArr = new JSONArray();
		if (styleList != null) {
			for (StyleBean styleBean : styleList) {
				JSONObject jsonObj = new JSONObject();
				if (session.getAttribute("loginInfo") != null) {
					styleBean.setInfoMemberId(((MemberBean) (session.getAttribute("loginInfo"))).getMember_id());
				} else if (session.getAttribute("kakaoLoginInfo") != null) {
					styleBean.setInfoMemberId(((MemberBean) (session.getAttribute("kakaoLoginInfo"))).getMember_id());
				}
				jsonObj.put("style_number", styleBean.getStyle_number());
				jsonObj.put("image1", styleBean.getImage1());
				jsonObj.put("image2", styleBean.getImage2());
				jsonObj.put("title", styleBean.getTitle());
				jsonObj.put("content", styleBean.getContent());
				jsonObj.put("member_image", styleBean.getMember_image());
				jsonObj.put("nickname", styleBean.getNickname());
				jsonObj.put("heartCount", heartDao.countHeart(styleBean.getStyle_number()));
				jsonObj.put("heartFlag", heartDao.searchHeart(styleBean));
				jsonArr.add(jsonObj);
			}
		}
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html");
		response.getWriter().append(jsonArr.toString());
	}

}
