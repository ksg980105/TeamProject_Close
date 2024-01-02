package admin.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import orders.model.OrdersBean;
import orders.model.OrdersDao;

@Controller
public class AdminMemberOrderDetailController {

	private final String command = "/adminMemberOrderDetail.member";
	private final String viewPage = "adminMemberOrderDetail";
	
	@Autowired
	OrdersDao ordersDao;
	
	@RequestMapping(value = command)
	public String adminMemberOrderDetail(@RequestParam("member_id") String member_id,
										Model model) {

		List<OrdersBean> lists = ordersDao.selectOrderByMember(member_id);
		
		
		model.addAttribute("lists", lists);
		return viewPage;
	}
	
}
