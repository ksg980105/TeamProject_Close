package orders.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


import cart.model.CartDao;
import cart.model.CartInfoBean;
import member.model.EventDao;
import orderdetail.model.OrdersDetailDao;
import orders.model.OrdersBean;
import orders.model.OrdersDao;
import product.model.ProductDao;

@Controller
public class OrdersController {

	private final String command = "/order.orders";
	private final String viewPage = "orderComplete";
	private final String gotoPage = "redirect:view.main";
	
	
	@Autowired
	OrdersDao ordersDao;
	
	@Autowired
	OrdersDetailDao ordersDetailDao;
	
	@Autowired
	CartDao cartDao;
	
	@Autowired
	ProductDao productDao;
	
	@Autowired
	EventDao eventDao;
	
	@RequestMapping(value=command)
	public String order(@RequestParam("address1")String address1,
						@RequestParam("address2")String address2,
						@RequestParam(value="cnums",required = false)List<String> cnums,
						@RequestParam(value="cibs",required = false)List<CartInfoBean> cibs,
						@RequestParam(value="coupon_number",required = false)String coupon_number,
						OrdersBean ob, HttpSession session, Model model) {
		
		ob.setAddress(address1+" "+address2);
		
		System.out.println(ob.getOrders_id());
		System.out.println(ob.getReceiver());
		System.out.println(ob.getReceiver_phone());
		System.out.println(ob.getAddress());
		System.out.println(ob.getMember_id());
		System.out.println(ob.getD_message());
		ob.setD_message("없음");
		System.out.println(ob.getD_message());
		System.out.println(ob.getTotalamount());
		
		List<CartInfoBean> nlists = (List<CartInfoBean>)session.getAttribute("clists");
		
		ordersDao.insertOrders(ob); 
		
		if(nlists != null) { 
			for(int i=0;i<nlists.size();i++) {
				CartInfoBean cib = nlists.get(i);
				cib.setContent(ob.getOrders_id()); 
				ordersDetailDao.insertOrderDetail(cib);
				if(cib.getProduct_size().equals("S")) {
					cib.setS_stock(cib.getQty());
				}
				if(cib.getProduct_size().equals("M")) {
					cib.setM_stock(cib.getQty());
				}
				if(cib.getProduct_size().equals("L")) {
					cib.setL_stock(cib.getQty());
				}
				if(cib.getProduct_size().equals("XL")) {
					cib.setXl_stock(cib.getQty());
				}
				System.out.println("바로구매통함");
				System.out.println("s사이즈개수:"+cib.getS_stock());
				System.out.println("M사이즈개수:"+cib.getM_stock());
				System.out.println("l사이즈개수:"+cib.getL_stock());
				System.out.println("xl사이즈개수:"+cib.getXl_stock());
				productDao.updateStock(cib);
			}
			session.removeAttribute("clists");
		}
		
		if(nlists == null) {
			for(int i=0;i<cnums.size();i++) {
				String cnum = cnums.get(i);
				
				CartInfoBean cib = cartDao.getCartInfoByNum(cnum);
				cib.setContent(ob.getOrders_id()); 
				ordersDetailDao.insertOrderDetail(cib);
				if(cib.getProduct_size().equals("S")) {
					cib.setS_stock(cib.getQty());
				} else {
					cib.setS_stock(0);
				}
				if(cib.getProduct_size().equals("M")) {
					cib.setM_stock(cib.getQty());
				} else {
					cib.setM_stock(0);
				}
				if(cib.getProduct_size().equals("L")) {
					cib.setL_stock(cib.getQty());
				} else {
					cib.setL_stock(0);
				}
				if(cib.getProduct_size().equals("XL")) {
					cib.setXl_stock(cib.getQty());
				} else {
					cib.setXl_stock(0);
				}
				System.out.println("장바구니통함");
				System.out.println("s사이즈개수:"+cib.getS_stock());
				System.out.println("M사이즈개수:"+cib.getM_stock());
				System.out.println("l사이즈개수:"+cib.getL_stock());
				System.out.println("xl사이즈개수:"+cib.getXl_stock());
				productDao.updateStock(cib);
				cartDao.deleteCart(cnum);
			}
		}
		System.out.println("쿠폰번호:"+coupon_number);
		if(coupon_number!=null) {
			if(!coupon_number.equals("null") && !coupon_number.equals("")) {
				eventDao.useCoupon(coupon_number);
			}
		}
		 
		OrdersBean orderBean = ordersDao.getOrderById(ob.getOrders_id());
		
		model.addAttribute("orderBean", orderBean);
		model.addAttribute("orders_id", ob.getOrders_id());
		return viewPage;
	}
	
	
}
