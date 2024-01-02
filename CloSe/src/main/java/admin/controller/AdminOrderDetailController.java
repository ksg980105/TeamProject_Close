package admin.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import orderdetail.model.OrderItem;
import orderdetail.model.OrdersDetailDao;
import orders.model.OrdersDao;

@Controller
public class AdminOrderDetailController {

	   private final String command = "/adminOrderDetail.member";
	   private final String viewPage = "adminOrderDetail";
	   
	   @Autowired
	   OrdersDao ordersDao;
	   
	   @Autowired
	   OrdersDetailDao ordersDetailDao;
	   
	   @RequestMapping(value=command)
	   public String orderDetails(@RequestParam("orders_id")String orders_id,
	                        HttpServletRequest request,Model model) {
	      
	      String referer = request.getHeader("Referer");
	      System.out.println(referer);
	      
	      List<OrderItem> olists = ordersDetailDao.getOrderDetailsByOrder_id(orders_id);
	      
	      model.addAttribute("olists", olists);
	      model.addAttribute("referer", referer);
	      return viewPage;
	   }
	
}
