package main.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import product.model.ProductBean;
import product.model.ProductDao;

@Controller
public class SearchController {
	@Autowired
    private ProductDao productDao;
	
    @RequestMapping(value = "/wordSearchShow.main", method = RequestMethod.GET)
    @ResponseBody
    public void wordSearchShow(@RequestParam("searchWord") String searchWord, HttpServletResponse response) throws IOException {
    	List<ProductBean> productList =  productDao.findProductNames2(searchWord);
        
    	JSONArray jsonArr = new JSONArray(); 
		if(productList != null) {
			for(ProductBean productBean : productList) {
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("product_number", productBean.getProduct_number());			
				jsonObj.put("product_name", productBean.getProduct_name());			
				jsonObj.put("image", productBean.getImage());			
				jsonObj.put("price", productBean.getPrice());		
				jsonObj.put("smallcategory_name", productBean.getSmallcategory_name());		
				jsonArr.add(jsonObj);
			}
		}
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html");
		response.getWriter().append(jsonArr.toString());
    }
    
    @RequestMapping(value = "/wordSearchShow.main", method = RequestMethod.POST)
    @ResponseBody
    public void wordSearchShow2(@RequestParam("searchWord2") String searchWord2, HttpServletResponse response) throws IOException {
    	List<ProductBean> productList =  productDao.findProductNames2(searchWord2);
        
        JSONArray jsonArr = new JSONArray(); 
		if(productList != null) {
			for(ProductBean productBean : productList) {
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("product_number", productBean.getProduct_number());			
				jsonObj.put("product_name", productBean.getProduct_name());			
				jsonObj.put("image", productBean.getImage());			
				jsonObj.put("price", productBean.getPrice());		
				jsonObj.put("smallcategory_name", productBean.getSmallcategory_name());		
				jsonArr.add(jsonObj);
			}
		}
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html");
		response.getWriter().append(jsonArr.toString());
    }
}
