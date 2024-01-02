package review.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import member.model.MemberBean;
import review.model.ReviewBean;
import review.model.ReviewDao;
import review.model.ReviewItem;

@Controller
public class ReviewDeleteController {
	private final String command = "/delete.review";
	
	@Autowired
	ReviewDao reviewDao;
	
	@ResponseBody
	@RequestMapping(value = command)
	public int reviewRegister(@RequestParam("review_number") String review_number) {
		return reviewDao.deleteReview(review_number);
	}
}