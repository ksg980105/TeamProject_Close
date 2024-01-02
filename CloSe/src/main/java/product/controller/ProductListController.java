package product.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import category.model.CategoryBean;
import category.model.CategoryDao;
import product.model.ProductBean;
import product.model.ProductDao;
import utility.Paging_productList;

@Controller
public class ProductListController {

   private final String command = "/list.product";
   private final String viewPage = "productList";

   @Autowired
   ProductDao productDao;

   @Autowired
   CategoryDao categoryDao;

   @RequestMapping(value = command)
   public String productList(@RequestParam(value = "bigcategory_name", required = false) String bigcategory_name,
         @RequestParam(value = "smallcategory_name", required = false) String smallcategory_name,
         @RequestParam(value = "brand", required = false) String brand,
         @RequestParam(value = "sort", required = false) String sort,
         @RequestParam(value = "whatColumn", required = false) String whatColumn,
         @RequestParam(value = "searchWord", required = false) String keyword,
         @RequestParam(value = "pageNumber", required = false) String pageNumber, HttpServletRequest request,
         Model model) {
      List<ProductBean> blists = productDao.getAllProduct();
      List<CategoryBean> clists = categoryDao.getAllCategory();
      model.addAttribute("blists", blists);
      model.addAttribute("clists", clists);
      model.addAttribute("searchFlag", false);
      model.addAttribute("keyword", keyword);

      if (sort != null) {
         if (sort.equals("null")) {
            sort = "new";
         }
      }
      if (sort == null) {
         sort = "new";
      }
      Map<String, String> map = new HashMap<String, String>();
      map.put("whatColumn", whatColumn);
      map.put("keyword", "%" + keyword + "%");
      map.put("bigcategory_name", bigcategory_name);
      map.put("smallcategory_name", smallcategory_name);
      map.put("brand", "%" + brand + "%");
      map.put("sort", sort);

      List<ProductBean> plists = null;
      int totalCount = 0;

      String url = request.getContextPath() + command;

      totalCount = productDao.getIFCount(map);
      
//      if(keyword != null) {
//         if (!keyword.equals("null")) {
//            totalCount = productDao.getCountByKeyword(keyword);
//         } 
//      }
//      
//      if (bigcategory_name != null) {
//         if (!bigcategory_name.equals("null")) {
//            totalCount = productDao.getCountByBigcategory(bigcategory_name);
//         }
//      }
//      if (smallcategory_name != null) {
//         if (!smallcategory_name.equals("null")) {
//            totalCount = productDao.getCountBySmallcategory(smallcategory_name);
//         }
//      }
//      if (brand != null) {
//         if (!brand.equals("null")) {
//            String brand1 = "%" + brand + "%";
//            totalCount = productDao.getCountByBrand(brand1);
//         }
//      }

      Paging_productList pageInfo = new Paging_productList(pageNumber, "16", totalCount, url, whatColumn, keyword,
            bigcategory_name, smallcategory_name, brand, sort);

      plists = productDao.getIFProduct(map, pageInfo);

      if (keyword != null && whatColumn != null) {
         model.addAttribute("searchFlag", true);
      }

      System.out.println("bigcategory_name=" + bigcategory_name);
      System.out.println("smallcategory_name=" + smallcategory_name);
      System.out.println("pageNumber=" + pageNumber);
      System.out.println("totalCount=" + totalCount);
      System.out.println("asdadasdaddadasdada+"+map.get("keyword"));
      System.out.println("asdadasdaddadasdada+"+map.get("whatColumn"));
      model.addAttribute("pageInfo", pageInfo);
      model.addAttribute("plists", plists);
      return viewPage;
   }

}