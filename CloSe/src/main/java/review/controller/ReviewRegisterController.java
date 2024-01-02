package review.controller;


import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import member.model.MemberBean;
import product.model.ProductDao;
import review.model.ReviewBean;
import review.model.ReviewDao;

@Controller
public class ReviewRegisterController {
	private final String command = "/register.review";
	
	@Autowired
	ReviewDao reviewDao;
	
	@ResponseBody
	@RequestMapping(value=command,method=RequestMethod.POST)
	public String reviewRegister(ReviewBean rb,HttpSession session) {
		String member_id = "";
		if(session.getAttribute("loginInfo") != null) {
			MemberBean mb = (MemberBean) session.getAttribute("loginInfo");
			member_id = mb.getMember_id();
		} else if(session.getAttribute("kakaoLoginInfo") != null) {
			MemberBean mb = (MemberBean) session.getAttribute("kakaoLoginInfo");
			member_id = mb.getMember_id();
		}
		rb.setMember_id(member_id);
		System.out.println("별점"+rb.getRating());
		System.out.println("평"+rb.getText());
		System.out.println("오디넘"+rb.getOrderdetail_number());
		System.out.println(rb.getMember_id());
		if(rb.getText() == null || rb.getText().equals("")) {
			rb.setText(" ");
		}
		List<ReviewBean> rlists = reviewDao.getAllReview();
		for(int i=0;i<rlists.size();i++) {
			ReviewBean rb0 = rlists.get(i);
			if(rb0.getOrderdetail_number() == rb.getOrderdetail_number()) {
				return "x";
			}
		}
		reviewDao.registerReview(rb);
		return "o";
	}
}
