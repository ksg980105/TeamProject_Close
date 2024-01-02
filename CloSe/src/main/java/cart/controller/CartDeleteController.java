package cart.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import cart.model.CartDao;
import member.model.MemberBean;

@Controller
public class CartDeleteController {
	private final String command = "/delete.cart";
	private final String gotoPage = "redirect:/cartAdd.cart";
	
	@Autowired
	CartDao cartDao;
	
	@RequestMapping(command)
	public String qtyUpdate(@RequestParam(value="cnum",required = false)String cnum,
							@RequestParam(value="cnums",required = false)String[] cnums,
							HttpSession session) {
		
		String member_id ="";
		if(session.getAttribute("loginInfo") != null) {
			MemberBean mb = (MemberBean) session.getAttribute("loginInfo");
			member_id = mb.getMember_id();
		} else if(session.getAttribute("kakaoLoginInfo") != null) {
			MemberBean mb = (MemberBean) session.getAttribute("kakaoLoginInfo");
			member_id = mb.getMember_id();
		}
		
		if(cnums!=null) {
			cartDao.deleteCarts(cnums);
		}
		if(cnum!=null) {
			cartDao.deleteCart(cnum);
		}
		
		return gotoPage+"?member_id="+member_id;
	}
	
}
