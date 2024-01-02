package admin.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import member.model.MemberDao;
import orders.model.OrdersBean;
import orders.model.OrdersDao;
import report.model.ReportBean;
import report.model.ReportDao;
import utility.Paging;
import utility.Paging_orderDetail;

@Controller
public class AdminListController {

	private final String command = "adminPage.member";
	private final String viewPage = "adminPage";
	
	@Autowired
	MemberDao memberDao;
	
	@Autowired
	ReportDao reportDao;
	
	@Autowired
	OrdersDao ordersDao;
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public String adminPage(@RequestParam(value = "pageNumber", required = false) String pageNumber,
			@RequestParam(value = "keyword", required = false) String keyword,
			@RequestParam(value = "whatColumn", required = false) String whatColumn,
			@RequestParam(value="startDate", required = false) String startDate,
            @RequestParam(value="endDate", required = false) String endDate,
			HttpServletRequest request,
			Model model) {
		
	Map<String, String> map = new HashMap<String, String>();
	map.put("whatColumn", whatColumn);
	map.put("keyword", "%"+keyword+"%");
	
	int totalCount = reportDao.getTotalCount(map);
	String url = request.getContextPath()+command;
	
	Paging pageInfo = new Paging(pageNumber, "10", totalCount, url, whatColumn, keyword);
	
	int number = totalCount - (pageInfo.getPageNumber() -1) * 10;
	
	List<ReportBean> lists = reportDao.getAllReport(map, pageInfo);
	
	model.addAttribute("lists", lists);
	model.addAttribute("pageInfo", pageInfo);
	model.addAttribute("number", number);
	
    if(startDate != null) {
        if(startDate.equals("null")) {
           startDate = "";
        }
     }
     if(endDate != null) {
        if(endDate.equals("null")) {
           endDate = "";
        }
     }
     
     Map<String, String> map2 = new HashMap<String, String>();
     map2.put("startDate", startDate);
     map2.put("endDate", endDate);
     
     int totalCount2 = ordersDao.getAdminTotalCount(map2);
     String url2 = request.getContextPath()+command;
     
     System.out.println("totalCount2 : "+totalCount2);
     
     Paging_orderDetail pageInfo2 = new Paging_orderDetail(pageNumber, "2", totalCount2, url2, startDate, endDate, "1");
     map2.put("begin", String.valueOf(pageInfo.getBeginRow()));
     map2.put("end", String.valueOf(pageInfo.getEndRow()));
     
     List<OrdersBean> orderLists = ordersDao.getOrderList(pageInfo2,map);
     
     model.addAttribute("orderLists", orderLists);
     model.addAttribute("pageInfo2", pageInfo2);
     return viewPage;
	
	}
	
}
