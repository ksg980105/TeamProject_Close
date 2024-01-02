package admin.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import report.model.ReportBean;
import report.model.ReportDao;

@Controller
public class AdminDetailController {

	private final String command = "reportDetail.member";
	private final String viewPage = "adminDetail";
	
	@Autowired
	ReportDao reportDao;
	
	@RequestMapping(command)
	public String detail(@RequestParam("report_number") String report_number,
							@RequestParam("pageNumber") String pageNumber,
							Model model) {
		
		ReportBean reportBean = reportDao.getDetailReport(report_number);
		
		model.addAttribute("pageNumber",pageNumber);
		model.addAttribute("reportBean",reportBean);
		
		return viewPage;
	}
	
}
