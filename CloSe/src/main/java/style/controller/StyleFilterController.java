package style.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import style.model.StyleBean;
import style.model.StyleDao;

@Controller
public class StyleFilterController {

	private final String command = "/styleFilter.style";

	@Autowired
	private StyleDao styleDao;

	@RequestMapping(command)
	@ResponseBody
	public void styleFilter(@RequestParam(value = "seasonArray[]", required = false) List<String> seasonLists,
			@RequestParam(value = "genderArray[]", required = false) List<String> genderLists,
			@RequestParam(value = "styleArray[]", required = false) List<String> styleLists,
			@RequestParam(value = "temp", required = false) String temp, Model model, HttpServletResponse response)
			throws IOException {


		Map<String, Object> map = new HashMap<String, Object>();
		map.put("seasonLists", seasonLists);
		map.put("genderLists", genderLists);
		map.put("styleLists", styleLists);
		map.put("temp", temp);

		List<StyleBean> lists = styleDao.styleFilter(map);

		System.out.println("전체 FilterLists 크기: " + lists.size());
		org.json.simple.JSONArray jsonArr = new org.json.simple.JSONArray();
		for (StyleBean styleBean : lists) {
			org.json.simple.JSONObject jsonObj = new org.json.simple.JSONObject();
			jsonObj.put("style_number", styleBean.getStyle_number());
			jsonObj.put("avg_temperature", styleBean.getAvg_temperature());
			jsonObj.put("image1", styleBean.getImage1());
			jsonObj.put("title", styleBean.getTitle());
			jsonObj.put("style", styleBean.getStyle());
			jsonObj.put("member_id", styleBean.getMember_id());
			jsonObj.put("nickname", styleBean.getNickname());
			jsonObj.put("gender", styleBean.getGender());
			jsonArr.add(jsonObj);
		}

		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html");
		response.getWriter().append(jsonArr.toString());

	}
}