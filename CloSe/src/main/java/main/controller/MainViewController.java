package main.controller;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import product.model.ProductBean;
import product.model.ProductDao;
import style.model.StyleDao;

@Controller
public class MainViewController {

	private final String command = "view.main";
	private final String viewPage = "main";
	
	@Autowired
	ProductDao productDao; 
	@Autowired
	StyleDao styledao; 
	
	@RequestMapping(command)
	public String view(Model model) {
		List<ProductBean> plists = productDao.getPopularProduct();
		model.addAttribute("plists", plists);
		model.addAttribute("mainStyleList", styledao.getMainStyleList());
		model.addAttribute("popList", productDao.getPop());
		return viewPage;
	}
	
}
