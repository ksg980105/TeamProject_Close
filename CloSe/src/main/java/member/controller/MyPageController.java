package member.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import member.model.EventBean;
import member.model.EventDao;
import member.model.MemberBean;
import member.model.MemberDao;
import orders.model.OrdersBean;
import orders.model.OrdersDao;
import utility.Paging_orderDetail;
import style.model.StyleDao;

@Controller
public class MyPageController {

	private final String command = "/mypage.member";

	@Autowired
	private EventDao eventDao;
	@Autowired
	private StyleDao styleDao;

	@Autowired
	OrdersDao ordersDao;
	
	@Autowired
	MemberDao memberDao;
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public void mypage(@RequestParam(value = "startDate", required = false) String startDate,
						@RequestParam(value = "endDate", required = false) String endDate,
						@RequestParam(value = "pageNumber", required = false) String pageNumber,
						@RequestParam(value = "activeTab", required = false) String activeTab,
						@RequestParam(value = "referer", required = false) String referer, HttpSession session,
						HttpServletRequest request, Model model) {
		MemberBean memberBean = (MemberBean) session.getAttribute("loginInfo");
		MemberBean kakaoMemberBean = (MemberBean) session.getAttribute("kakaoLoginInfo");

		List<EventBean> lists = new ArrayList<EventBean>();
		if (memberBean != null) {
			lists = eventDao.selectCoupon(memberBean.getMember_id());
			model.addAttribute("styleList", styleDao.getStyleByMemberId(memberBean.getMember_id()));
			if (!lists.isEmpty()) {
				session.setAttribute("loginLists", lists);
			}
		}

		List<EventBean> kakaoLists = new ArrayList<EventBean>();
		if (kakaoMemberBean != null) {
			kakaoLists = eventDao.selectCoupon(kakaoMemberBean.getMember_id());
			model.addAttribute("styleList", styleDao.getStyleByMemberId(kakaoMemberBean.getMember_id()));
			if (!kakaoLists.isEmpty()) {
				session.setAttribute("kakaoLoginLists", kakaoLists);
			}
		}

		if (lists.isEmpty() && kakaoLists.isEmpty()) {
			System.out.println("쿠폰이 없습니다.");
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
		if(activeTab!=null) {
			if(activeTab.equals("null")) {
				activeTab = "1";
			}
		}
		String member_id = "";
		if (memberBean != null) {
			member_id = memberBean.getMember_id();
		} else if (kakaoMemberBean != null) {
			member_id = kakaoMemberBean.getMember_id();
		}

		Map<String, String> map = new HashMap<String, String>();
		map.put("member_id", member_id);
		map.put("startDate", startDate);
		map.put("endDate", endDate);

		int totalCount = ordersDao.getTotalCount(map);
		String url = request.getContextPath() + command;

		System.out.println("totalCount개수" + totalCount);
		System.out.println("activeTab의값====="+activeTab);
		Paging_orderDetail pageInfo = new Paging_orderDetail(pageNumber, "2", totalCount, url, startDate, endDate, activeTab);
		map.put("begin", String.valueOf(pageInfo.getBeginRow()));
		map.put("end", String.valueOf(pageInfo.getEndRow()));

		List<OrdersBean> olists = ordersDao.getOrderByMember_Id(pageInfo, map);

		MemberBean mb = memberDao.getMember(member_id);
		model.addAttribute("mb", mb);
		
		
		List<EventBean> clists = eventDao.selectCoupon(member_id);
		model.addAttribute("clists", clists);  
		
		// List<OrdersBean> olists = ordersDao.getOrderByMember_Id(member_id);
		model.addAttribute("olists", olists);
		model.addAttribute("pageInfo", pageInfo);
		
	}

}
