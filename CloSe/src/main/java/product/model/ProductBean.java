package product.model;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.web.multipart.MultipartFile;

public class ProductBean {
   private int product_number;
   
   @NotEmpty(message = "상품명을 입력해 주세요.")
   @Pattern(regexp = "^.{1,}/.{1,}$", message = "형식에 맞게 입력해주세요.(브랜드명/상품명)")
   private String product_name;
   
   @NotEmpty(message = "상품 사진을 등록해주세요.")
   private String image;
    
   @NotNull(message = "가격을 입력해 주세요.")
   private Integer price;
   
   @NotEmpty(message = "상품상세사진을 등록해 주세요.")
   private String content;
   
   @NotNull(message = "적정추천온도를 선택해 주세요.")
   private Integer temperature;
   
   private int s_stock;
   
   private int m_stock;
   
   private int l_stock;
   
   private int xl_stock;
   
   @NotEmpty(message = "카테고리를 선택해 주세요.")
   private String smallcategory_name;
   
   private MultipartFile pImage; //상품사진
   private MultipartFile pContent; //설명사진
   
   private String keyword;
   private int count;
   
   public MultipartFile getpImage() {
      return pImage;
   }
   public void setpImage(MultipartFile pImage) {
      this.pImage = pImage;
      if(!this.pImage.isEmpty()) { // 
         image = pImage.getOriginalFilename();
      }
   }
   public MultipartFile getpContent() {
      return pContent;
   }
   public void setpContent(MultipartFile pContent) {
      this.pContent = pContent;
      if(!this.pContent.isEmpty()) { 
         content = pContent.getOriginalFilename();
      }
   }
   
   private double average_rating;
   
   
   public ProductBean() {
      super();
   }
   public int getProduct_number() {
      return product_number;
   }
   public void setProduct_number(int product_number) {
      this.product_number = product_number;
   }
   public String getProduct_name() {
      return product_name;
   }
   public void setProduct_name(String product_name) {
      this.product_name = product_name;
   }
   public String getImage() {
      return image;
   }
   public void setImage(String image) {
      this.image = image;
   }
   public String getContent() {
      return content;
   }
   public void setContent(String content) {
      this.content = content;
   }
   public Integer getPrice() {
      return price;
   }
   public void setPrice(Integer price) {
      this.price = price;
   }
   public Integer getTemperature() {
      return temperature;
   }
   public void setTemperature(Integer temperature) {
      this.temperature = temperature;
   }
   public String getSmallcategory_name() {
      return smallcategory_name;
   }
   public void setSmallcategory_name(String smallcategory_name) {
      this.smallcategory_name = smallcategory_name;
   }
   public int getS_stock() {
      return s_stock;
   }
   public void setS_stock(int s_stock) {
      this.s_stock = s_stock;
   }
   public int getM_stock() {
      return m_stock;
   }
   public void setM_stock(int m_stock) {
      this.m_stock = m_stock;
   }
   public int getL_stock() {
      return l_stock;
   }
   public void setL_stock(int l_stock) {
      this.l_stock = l_stock;
   }
   public int getXl_stock() {
      return xl_stock;
   }
   public void setXl_stock(int xl_stock) {
      this.xl_stock = xl_stock;
   }
	public double getAverage_rating() {
		return average_rating;
	}
	public void setAverage_rating(double average_rating) {
		this.average_rating = average_rating;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

}