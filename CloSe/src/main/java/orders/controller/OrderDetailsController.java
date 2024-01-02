package orders.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import orderdetail.model.OrderItem;
import orderdetail.model.OrdersDetailDao;
import orders.model.OrdersDao;

//주문상세내역
@Controller
public class OrderDetailsController {

	private final String command = "/detail.orders";

	@Autowired
	OrdersDao ordersDao;

	@Autowired
	OrdersDetailDao ordersDetailDao;

	@ResponseBody 
	@RequestMapping(value = command, produces = "application/json; charset=utf8")
	public List<OrderItem> orderDetails(@RequestParam("orders_id") String orders_id, HttpServletRequest request, Model model) {

		List<OrderItem> olists = ordersDetailDao.getOrderDetailsByOrder_id(orders_id);
		return olists;
	}
}