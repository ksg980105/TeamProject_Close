package member.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import member.model.EventBean;
import member.model.EventDao;

@Controller
public class CouponController {
	
	private final String command = "coupon.member";
	private final String viewPage = "event";
	
	@Autowired
	private EventDao eventDao;
	
	@RequestMapping(value = command)
	public String coupon(@RequestParam("memberId") String memberId,
						@RequestParam("name") String name,
						@RequestParam("discount") int discount) {
		
		EventBean eb = new EventBean();
		eb.setMember_id(memberId);
		eb.setCoupon_name(name);
		eb.setCoupon_discount(discount);
		
		Map<String,String> map = new HashMap<String, String>();
		map.put("member_id", memberId);
		map.put("coupon_name", name);
		
		eventDao.insertCoupon(eb);
		
		return viewPage;
	}
}
