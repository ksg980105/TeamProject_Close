package admin.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import report.model.ReportBean;
import report.model.ReportDao;
import style.model.StyleDao;

@Controller
public class ReportController {

	private final String command = "styleReport.report";
	private final String viewPage = "reportForm";
	private final String gotoPage = "redirect:/detail.style";

	@Autowired
	StyleDao styleDao;

	@Autowired
	ReportDao reportDao;

	@Autowired
	ServletContext servletcontext;

	@RequestMapping(value = command, method = RequestMethod.GET)
	public String reportForm(@RequestParam("style_number") int style_number, Model model) {

		String reported_user_id = styleDao.selectMember(style_number);

		System.out.println("reported_user_id : " + reported_user_id);

		model.addAttribute("style_number", style_number);
		model.addAttribute("reported_user_id", reported_user_id);

		return viewPage;
	}

	@RequestMapping(value = command, method = RequestMethod.POST)
	public String report(@Valid ReportBean reportBean, BindingResult bResult, HttpServletResponse response, Model model)
			throws IOException {

		System.out.println("reporter_id : " + reportBean.getReporter_id());
		System.out.println("reported_user_id : " + reportBean.getReported_user_id());
		System.out.println("style_number : " + reportBean.getStyle_number());
		System.out.println("report_category : " + reportBean.getReport_category());
		System.out.println("content : " + reportBean.getContent());

		PrintWriter out = response.getWriter();
		response.setContentType("text/html; charset=UTF-8");

		if (bResult.hasErrors()) {
			model.addAttribute("style_number", reportBean.getStyle_number());
			return viewPage;
		}

		reportBean.setWrite_date(new Timestamp(System.currentTimeMillis()));
		String uploadPath = servletcontext.getRealPath("/resources/uploadReport");

		File directory = new File(uploadPath);
		if (!directory.exists()) {
			directory.mkdirs();
		}

		String imageName = reportBean.getImage();
		File destination = new File(uploadPath + File.separator + imageName);

		try {
			reportBean.getUpload().transferTo(destination);
		} catch (Exception e) {
			e.printStackTrace();
		}

		int cnt = reportDao.insertReport(reportBean);

		model.addAttribute("style_number", reportBean.getStyle_number());
		return gotoPage;
	}

}
