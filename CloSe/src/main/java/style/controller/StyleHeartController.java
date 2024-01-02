package style.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import style.model.HeartBean;
import style.model.HeartDao;

@Controller
public class StyleHeartController {
	private final String command = "heart.style";
	private final String gotoPage = "redirect:detail.style";
	
	@Autowired
	private HeartDao heartDao;
	
	@RequestMapping(command)
	public String heart(@RequestParam("style_number") int style_number, @RequestParam("member_id") String member_id) {
		HeartBean heartBean = new HeartBean();
		heartBean.setMember_id(member_id);
		heartBean.setStyle_number(style_number);
		
		heartDao.heart(heartBean);
		
		return gotoPage + "?style_number=" + style_number;
	}
	
}
