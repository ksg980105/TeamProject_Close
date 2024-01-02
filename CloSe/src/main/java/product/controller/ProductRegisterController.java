package product.controller;

import java.io.File;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import category.model.CategoryBean;
import category.model.CategoryDao;
import product.model.ProductBean;
import product.model.ProductDao;

@Controller
public class ProductRegisterController {

	private final String command = "/register.product";
	private final String viewPage = "productRegisterForm";
	private final String gotoPage = "redirect:/list.product";

	@Autowired
	ServletContext servletContext;

	@Autowired
	ProductDao productDao;

	@Autowired
	CategoryDao categoryDao;

	@RequestMapping(value=command, method=RequestMethod.GET)
	public String registerForm(Model model) {
		List<CategoryBean> clists = categoryDao.getAllCategory(); 
		model.addAttribute("clists", clists);
		return viewPage;
	}

	@RequestMapping(value=command, method=RequestMethod.POST)
	public String register(@ModelAttribute("productBean") @Valid ProductBean pb,BindingResult bresult,
			@RequestParam(value = "prevImage", required = false) String prevImage,
			@RequestParam(value = "prevContent", required = false) String prevContent,
			Model model) {
		List<ProductBean> plists = productDao.getAllProduct();
		List<CategoryBean> clists = categoryDao.getAllCategory(); 
		model.addAttribute("clists", clists);
		
		if(pb.getImage().equals("")) {
			pb.setImage(prevImage);
		}
		String uploadPath = servletContext.getRealPath("/resources/productImage"); 

		File destination0 = new File(uploadPath+File.separator+prevImage); 
		File destination = new File(uploadPath+File.separator+pb.getImage());
		File destination1 = new File(uploadPath+File.separator+prevContent); 
		File destination2 = new File(uploadPath+File.separator+pb.getContent()); 

		MultipartFile multi = pb.getpImage();
		MultipartFile multi2 = pb.getpContent();
		try {
			
			boolean existsPImage = false;
			for(int i=0;i<plists.size();i++) {
				ProductBean pb0 = plists.get(i);
				if(pb0.getImage().equals(prevImage)) {
					existsPImage = true;
				}
			}
			if(!existsPImage && !prevImage.equals("") && !prevImage.equals(pb.getImage())) {
				if(destination0.exists()) {
					destination0.delete();
				}
			}
			
			boolean existsPContent = false;
			for(int i=0;i<plists.size();i++) {
				ProductBean pb0 = plists.get(i);
				if(pb0.getContent().equals(prevContent)) {
					existsPContent = true;
				}
			}
			if(!existsPContent && !prevContent.equals("") && !prevContent.equals(pb.getContent())) {
				if(destination1.exists()) {
					destination1.delete();
				}
			}
			if(!destination.exists()) {
				multi.transferTo(destination);
			}
			if(!destination2.exists()) {
				multi2.transferTo(destination2);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}

		if(bresult.hasErrors()) { 
			return viewPage;
		}
		for(int i=0;i<plists.size();i++) { 
			ProductBean pb0 = plists.get(i);
			if(pb0.getProduct_name().equals(pb.getProduct_name())) {
				return viewPage;
			}
		}
		System.out.println(pb.getImage());
		productDao.insertProduct(pb);
		return gotoPage;
	}


}
