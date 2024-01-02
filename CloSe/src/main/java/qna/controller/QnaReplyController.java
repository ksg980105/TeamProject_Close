package qna.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.Writer;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import qna.model.QnaBean;
import qna.model.QnaDao;
import utility.Paging;

@Controller
public class QnaReplyController {

	private final String command = "/reply.qna";
	private final String viewPage = "qnaReplyForm";
	private final String gotoPage = "redirect:/list.qna";
	
	@Autowired
	QnaDao qnaDao;

	@RequestMapping(value = command, method = RequestMethod.GET)
	public String replyForm(@RequestParam("ref") int ref,
								@RequestParam("re_level") int re_level,
								@RequestParam("pageNumber") int pageNumber,
								Model model) {
		
		model.addAttribute("ref", ref);
		model.addAttribute("re_level", re_level);
		model.addAttribute("pageNumber", pageNumber);
		
		return viewPage;
	}
	
	@RequestMapping(value = command, method = RequestMethod.POST)
	public String reply(@Valid QnaBean qnaBean,
						BindingResult bResult,
						@RequestParam("pageNumber") String pageNumber,
						HttpServletResponse response,
						Model model) throws IOException {
		
		if(bResult.hasErrors()) {
			model.addAttribute("ref", qnaBean.getRef());
			model.addAttribute("re_level", qnaBean.getRe_level());
			model.addAttribute("pageNumber", pageNumber);
			return viewPage;
		}
		
		qnaBean.setWrite_date(new Timestamp(System.currentTimeMillis()));
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		int cnt = qnaDao.replyQna(qnaBean);
		if(cnt == -1) {
			out.println("<script>alert('올바른 형식이 아닙니다.');</script>");
			out.flush();
			model.addAttribute("ref", qnaBean.getRef());
			model.addAttribute("re_level", qnaBean.getRe_level());
			model.addAttribute("pageNumber", pageNumber);
			return viewPage;
		}
		
		out.println("<script>window.opener.location.reload(); window.close();</script>");
		out.flush();
		
		model.addAttribute("ref", qnaBean.getRef());
		model.addAttribute("re_level", qnaBean.getRe_level());
		model.addAttribute("pageNumber", pageNumber);
		return gotoPage;
	}
	
	
}