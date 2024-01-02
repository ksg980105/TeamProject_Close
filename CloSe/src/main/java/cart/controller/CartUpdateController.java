package cart.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import cart.model.CartDao;
import cart.model.CartInfoBean;
import member.model.MemberBean;

@Controller
public class CartUpdateController {
	private final String command = "/qtyUpdate.cart";
	private final String viewPage = "cartListForm";
	
	@Autowired
	CartDao cartDao;
	
	@RequestMapping(command)
	public String qtyUpdate(@RequestParam("cart_number")String cart_number,
							@RequestParam("qty")String qty,
							HttpSession session, Model model) throws IOException {
		boolean flag = false;
		String member_id ="";
		if(session.getAttribute("loginInfo") != null) {
			MemberBean mb = (MemberBean) session.getAttribute("loginInfo");
			member_id = mb.getMember_id();
		} else if(session.getAttribute("kakaoLoginInfo") != null) {
			MemberBean mb = (MemberBean) session.getAttribute("kakaoLoginInfo");
			member_id = mb.getMember_id();
		}
		Map<String,String> qtyMap = new HashMap<String, String>();
		qtyMap.put("cart_number", cart_number);
		qtyMap.put("qty", qty);
		
		CartInfoBean cib = cartDao.getCartInfoByNum(cart_number);
		
		if(cib.getProduct_size().equals("S")) {
			if(cib.getS_stock()<Integer.parseInt(qty)) {
				flag = true;
			}
		} else if(cib.getProduct_size().equals("M")) {
			if(cib.getM_stock()<Integer.parseInt(qty)) {
				flag = true;
			}
		} else if(cib.getProduct_size().equals("L")) {
			if(cib.getL_stock()<Integer.parseInt(qty)) {
				flag = true;
			}
		} else if(cib.getProduct_size().equals("XL")) {
			if(cib.getXl_stock()<Integer.parseInt(qty)) {
				flag = true;
			}
		}
		if(flag) {
			model.addAttribute("qtycheck", true);
		} else {
			cartDao.qtyUpdate(qtyMap);
		}
		List<CartInfoBean> cartInfoLists = cartDao.getAllCartInfoByMember_Id(member_id);
		model.addAttribute("cartInfoLists", cartInfoLists);
		return viewPage;
	}
	
}
