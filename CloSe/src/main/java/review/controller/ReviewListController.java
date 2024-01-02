package review.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import review.model.ReviewDao;
import review.model.ReviewItem;

@Controller
public class ReviewListController {
	private final String command = "/list.review";

	@Autowired
	ReviewDao reviewDao;

	@ResponseBody
	@RequestMapping(value = command, produces = "application/json; charset=utf8")
	public Map<String, Object> reviewRegister(@RequestParam("product_number") String product_number,
			@RequestParam("start") String start, @RequestParam("end") String end) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("start", start);
		map.put("end", end);

		int totalCount = reviewDao.getTotalCount(product_number);
		List<ReviewItem> rlists = reviewDao.getReviewByProduct_number(product_number, map);
		Map<String, Object> reMap = new HashMap<String, Object>();
		reMap.put("totalCount", totalCount);
		reMap.put("rlists", rlists);
		return reMap;
	}
}
