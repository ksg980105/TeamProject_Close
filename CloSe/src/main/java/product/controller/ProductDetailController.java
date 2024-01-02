package product.controller;

import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import category.model.CategoryBean;
import category.model.CategoryDao;
import product.model.ProductBean;
import product.model.ProductDao;
import review.model.ReviewBean;
import review.model.ReviewDao;
import review.model.ReviewItem;
import style.model.StyleBean;
import style.model.StyleDao;
import utility.Paging_review;

@Controller
public class ProductDetailController {

	private final String command = "/detail.product";
	private final String viewPage = "productDetailForm";
	private final String gotoPage = "";

	@Autowired
	ProductDao productDao;

	@Autowired
	ReviewDao reviewDao;
	
	@Autowired
	StyleDao styleDao;
	
	@RequestMapping(value=command, method=RequestMethod.GET)
	public String detailForm(@RequestParam("product_number") String product_number,
							@RequestParam(value="pageNumber", required = false) String pageNumber,
								HttpServletRequest request,
								Model model) {
		List<StyleBean> slists = styleDao.getStyleByProductNum(product_number);
		
		
		ProductBean pb = productDao.getOneProduct(product_number);
		
		int totalCount = reviewDao.getTotalCount(product_number);
		String url = request.getContextPath()+command;
		
		Paging_review pageInfo = new Paging_review(pageNumber, "1", totalCount, url, product_number);
		List<ReviewItem> rlists = reviewDao.getReviewByProduct_number(pageInfo,product_number);

		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("rlists", rlists);
		model.addAttribute("slists", slists);
		model.addAttribute("pb", pb);
		return viewPage;
	}
}
