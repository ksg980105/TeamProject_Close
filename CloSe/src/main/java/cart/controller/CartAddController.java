package cart.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cart.model.CartBean;
import cart.model.CartDao;
import cart.model.CartInfoBean;
import member.model.MemberBean;
import product.model.ProductDao;

@Controller
public class CartAddController {

	private final String command = "/cartAdd.cart";
	private final String viewPage = "cartListForm";
	
	@Autowired
	CartDao cartDao;
	
	@Autowired
	ProductDao productDao;
	
	@ResponseBody
	@RequestMapping(value=command,method=RequestMethod.POST)
	public String cartAdd( @RequestParam("product_number")int product_number,
							@RequestParam(value="s_stock", required = false)String s_stock,
							@RequestParam(value="m_stock", required = false)String m_stock,
							@RequestParam(value="l_stock", required = false)String l_stock,
							@RequestParam(value="xl_stock", required = false)String xl_stock,
							HttpSession session) {
		boolean cflag = false;
		String member_id ="";
		if(session.getAttribute("loginInfo") != null) {
			MemberBean mb = (MemberBean) session.getAttribute("loginInfo");
			member_id = mb.getMember_id();
		} else if(session.getAttribute("kakaoLoginInfo") != null) {
			MemberBean mb = (MemberBean) session.getAttribute("kakaoLoginInfo");
			member_id = mb.getMember_id();
		}
		
		String[] size = {"S","M","L","XL"}; 
		String[] size_stock = {s_stock,m_stock,l_stock,xl_stock};
		CartBean cb = null;
		List<CartBean> cartLists = null;
		 
		cartLists = cartDao.getAllCartByMember_Id(member_id); 
		
		for(int i=0;i<size.length;i++) {
			if(size_stock[i] != null) {
				boolean flag = false; 
				
				cb = new CartBean();
				cb.setProduct_number(product_number);
				cb.setMember_id(member_id);
				cb.setProduct_size(size[i]);
				cb.setQty(Integer.parseInt(size_stock[i]));
				
				for(int j=0;j<cartLists.size();j++) {
					CartBean cb0 = cartLists.get(j);
					if(cb0.getProduct_number() == product_number
						&& cb0.getProduct_size().equals(size[i])) { 
						flag = true;
						break;
					} 
				} //for
				if(flag) { //중복임
					
				} else { 
					cflag = true;
					cartDao.addCart(cb);
				}
			}
		}
		
		if(cflag) {
			return "o";
		} else {
			return "x";
		}
	}
	
	@RequestMapping(value=command,method=RequestMethod.GET)
	public String cartForm(HttpSession session, Model model) {
		String member_id = "";
		if(session.getAttribute("loginInfo") != null) {
			MemberBean mb = (MemberBean) session.getAttribute("loginInfo");
			member_id = mb.getMember_id();
		} else if(session.getAttribute("kakaoLoginInfo") != null) {
			MemberBean mb = (MemberBean) session.getAttribute("kakaoLoginInfo");
			member_id = mb.getMember_id();
		}
		List<CartInfoBean> cartInfoLists = cartDao.getAllCartInfoByMember_Id(member_id);
		model.addAttribute("cartInfoLists", cartInfoLists);
		
		
		
		
		
		return viewPage;
	}
}
