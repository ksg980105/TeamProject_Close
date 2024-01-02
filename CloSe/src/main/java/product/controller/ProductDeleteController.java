package product.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import product.model.ProductDao;

@Controller
public class ProductDeleteController {
	
	private final String command = "/delete.product";
	private final String viewPage = "";
	private final String gotoPage = "";
	
	@Autowired
	ProductDao productDao;
	
	@RequestMapping(command)
	public String deleteProduct(@RequestParam("product_number") String product_number,
								HttpServletRequest request) {
		
		System.out.println("삭제할 번호:"+product_number);
		
		String referer = request.getHeader("Referer");
		
		System.out.println("이전페이지:"+referer);
		productDao.deleteProduct(product_number);
		
		return "redirect:"+referer;
	}
}
