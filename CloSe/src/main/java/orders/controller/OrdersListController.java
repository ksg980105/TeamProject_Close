package orders.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import member.model.MemberBean;
import member.model.MemberDao;
import orders.model.OrdersBean;
import orders.model.OrdersDao;
import utility.Paging_orderDetail;

@Controller
public class OrdersListController {

	private final String command = "/list.orders";
	private final String command2 = "/list2.orders";
	private final String viewPage = "ordersList";
	private final String gotoPage = "";

	@Autowired
	OrdersDao ordersDao;

	@Autowired
	MemberDao memberDao;

	@RequestMapping(value = command)
	public String ordersDetailForm(@RequestParam(value = "startDate", required = false) String startDate,
			@RequestParam(value = "endDate", required = false) String endDate,
			@RequestParam(value = "pageNumber", required = false) String pageNumber,
			@RequestParam(value = "activeTab", required = false) String activeTab,
			@RequestParam(value = "referer", required = false) String referer, HttpSession session,
			HttpServletRequest request, Model model) {

		if (referer != null) {
			return "redirect:" + referer;
		}

		if (startDate != null) {
			if (startDate.equals("null")) {
				startDate = "";
			}
		}
		if (endDate != null) {
			if (endDate.equals("null")) {
				endDate = "";
			}
		}
		String member_id = "";
		if (session.getAttribute("loginInfo") != null) {
			MemberBean mb = (MemberBean) session.getAttribute("loginInfo");
			member_id = mb.getMember_id();
		} else if (session.getAttribute("kakaoLoginInfo") != null) {
			MemberBean mb = (MemberBean) session.getAttribute("kakaoLoginInfo");
			member_id = mb.getMember_id();
		}

		Map<String, String> map = new HashMap<String, String>();
		map.put("member_id", member_id);
		map.put("startDate", startDate);
		map.put("endDate", endDate);

		int totalCount = ordersDao.getTotalCount(map);
		String url = request.getContextPath() + command;

		System.out.println("totalCount개수" + totalCount);
 
		Paging_orderDetail pageInfo = new Paging_orderDetail(pageNumber, "2", totalCount, url, startDate, endDate, activeTab);
		map.put("begin", String.valueOf(pageInfo.getBeginRow()));
		map.put("end", String.valueOf(pageInfo.getEndRow()));

		List<OrdersBean> olists = ordersDao.getOrderByMember_Id(pageInfo, map);

		MemberBean mb = memberDao.getMember(member_id);
		model.addAttribute("mb", mb);

		// List<OrdersBean> olists = ordersDao.getOrderByMember_Id(member_id);
		model.addAttribute("olists", olists);
		model.addAttribute("pageInfo", pageInfo);

		return viewPage;
	}
 
	@RequestMapping(value = command2)
	public String ordersDetailForm(HttpServletRequest request) {

		String referer = request.getHeader("Referer");
		return "redirect:" + referer;
	}

}