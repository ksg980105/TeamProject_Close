package style.model;

import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.web.multipart.MultipartFile;

public class StyleBean {
	private int style_number;
	private String image1;
	private String image2;
	private String image3;
	private String image4;
	private String image5;
	private String title;
	private String content;
	private String style;
	private int read_count;
	private int recommend_count;
	private Date write_date;
	private Integer product_number1;
	private Integer product_number2;
	private Integer product_number3;
	private Integer product_number4;
	private String member_id;
	private List<MultipartFile> images;
	private MultipartFile MImage1;
	private MultipartFile MImage2;
	private MultipartFile MImage3;
	private MultipartFile MImage4;
	private MultipartFile MImage5;

	private String nickname;
	private String member_image;

	private String product_name1;
	private String product_name2;
	private String product_name3;
	private String product_name4;

	private String price1;
	private String price2;
	private String price3;
	private String price4;

	private String pimage1;
	private String pimage2;
	private String pimage3;
	private String pimage4;

	private double avg_temperature;

	private String gender;
	private String height;
	private String weight;
	private String birth;

	private Double temperature;

	private String prevImage1;
	private String prevImage2;
	private String prevImage3;
	private String prevImage4;
	private String prevImage5;
	private String compareImage1;
	private String compareImage2;
	private String compareImage3;
	private String compareImage4;
	private String compareImage5;

	private int heart_id;
	private String infoMemberId;

	public String getInfoMemberId() {
		return infoMemberId;
	}

	public void setInfoMemberId(String infoMemberId) {
		this.infoMemberId = infoMemberId;
	}

	public int getHeart_id() {
		return heart_id;
	}

	public void setHeart_id(int heart_id) {
		this.heart_id = heart_id;
	}

	public StyleBean() {
	}

	public String getMember_image() {
		return member_image;
	}

	public void setMember_image(String member_image) {
		this.member_image = member_image;
	}

	public String getCompareImage1() {
		return compareImage1;
	}

	public void setCompareImage1(String compareImage1) {
		this.compareImage1 = compareImage1;
	}

	public String getCompareImage2() {
		return compareImage2;
	}

	public void setCompareImage2(String compareImage2) {
		this.compareImage2 = compareImage2;
	}

	public String getCompareImage3() {
		return compareImage3;
	}

	public void setCompareImage3(String compareImage3) {
		this.compareImage3 = compareImage3;
	}

	public String getCompareImage4() {
		return compareImage4;
	}

	public void setCompareImage4(String compareImage4) {
		this.compareImage4 = compareImage4;
	}

	public String getCompareImage5() {
		return compareImage5;
	}

	public void setCompareImage5(String compareImage5) {
		this.compareImage5 = compareImage5;
	}

	public String getPrevImage1() {
		return prevImage1;
	}

	public void setPrevImage1(String prevImage1) {
		this.prevImage1 = prevImage1;
	}

	public String getPrevImage2() {
		return prevImage2;
	}

	public void setPrevImage2(String prevImage2) {
		this.prevImage2 = prevImage2;
	}

	public String getPrevImage3() {
		return prevImage3;
	}

	public void setPrevImage3(String prevImage3) {
		this.prevImage3 = prevImage3;
	}

	public String getPrevImage4() {
		return prevImage4;
	}

	public void setPrevImage4(String prevImage4) {
		this.prevImage4 = prevImage4;
	}

	public String getPrevImage5() {
		return prevImage5;
	}

	public void setPrevImage5(String prevImage5) {
		this.prevImage5 = prevImage5;
	}

	public String getProduct_name1() {
		return product_name1;
	}

	public int getRecommend_count() {
		return recommend_count;
	}

	public void setRecommend_count(int recommend_count) {
		this.recommend_count = recommend_count;
	}

	public void setMImage5(MultipartFile mImage5) {
		MImage5 = mImage5;
	}

	public void setProduct_name1(String product_name1) {
		this.product_name1 = product_name1;
	}

	public String getProduct_name2() {
		return product_name2;
	}

	public void setProduct_name2(String product_name2) {
		this.product_name2 = product_name2;
	}

	public String getProduct_name3() {
		return product_name3;
	}

	public void setProduct_name3(String product_name3) {
		this.product_name3 = product_name3;
	}

	public String getProduct_name4() {
		return product_name4;
	}

	public void setProduct_name4(String product_name4) {
		this.product_name4 = product_name4;
	}

	public String getPrice1() {
		return price1;
	}

	public void setPrice1(String price1) {
		this.price1 = price1;
	}

	public String getPrice2() {
		return price2;
	}

	public void setPrice2(String price2) {
		this.price2 = price2;
	}

	public String getPrice3() {
		return price3;
	}

	public void setPrice3(String price3) {
		this.price3 = price3;
	}

	public String getPrice4() {
		return price4;
	}

	public void setPrice4(String price4) {
		this.price4 = price4;
	}

	public String getPimage1() {
		return pimage1;
	}

	public void setPimage1(String pimage1) {
		this.pimage1 = pimage1;
	}

	public String getPimage2() {
		return pimage2;
	}

	public void setPimage2(String pimage2) {
		this.pimage2 = pimage2;
	}

	public String getPimage3() {
		return pimage3;
	}

	public void setPimage3(String pimage3) {
		this.pimage3 = pimage3;
	}

	public String getPimage4() {
		return pimage4;
	}

	public void setPimage4(String pimage4) {
		this.pimage4 = pimage4;
	}

	public Double getTemperature() {
		return temperature;
	}

	public void setTemperature(Double temperature) {
		this.temperature = temperature;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getHeight() {
		return height;
	}

	public void setHeight(String height) {
		this.height = height;
	}

	public String getWeight() {
		return weight;
	}

	public void setWeight(String weight) {
		this.weight = weight;
	}

	public String getBirth() {
		return birth;
	}

	public void setBirth(String birth) {
		this.birth = birth;
	}

	public double getAvg_temperature() {
		return avg_temperature;
	}

	public void setAvg_temperature(double avg_temperature) {
		this.avg_temperature = avg_temperature;
	}

	public MultipartFile getMImage1() {
		return MImage1;
	}

	public void setMImage1(MultipartFile mImage1) {
		MImage1 = mImage1;
	}

	public MultipartFile getMImage2() {
		return MImage2;
	}

	public void setMImage2(MultipartFile mImage2) {
		MImage2 = mImage2;
	}

	public MultipartFile getMImage3() {
		return MImage3;
	}

	public void setMImage3(MultipartFile mImage3) {
		MImage3 = mImage3;
	}

	public MultipartFile getMImage4() {
		return MImage4;
	}

	public void setMImage4(MultipartFile mImage4) {
		MImage4 = mImage4;
	}

	public MultipartFile getMImage5() {
		return MImage5;
	}

	public List<MultipartFile> getImages() {
		return images;
	}

	public void setImages(List<MultipartFile> images) {
		UUID uuid = UUID.randomUUID();
		this.images = images;
		for (int i = 1; i < images.size() + 1; i++) {
			switch (i) {
			case 1:
				setImage1(uuid.toString() + images.get(i - 1).getOriginalFilename());
				setMImage1(images.get(i - 1));
				break;
			case 2:
				setImage2(uuid.toString() + images.get(i - 1).getOriginalFilename());
				setMImage2(images.get(i - 1));
				break;
			case 3:
				setImage3(uuid.toString() + images.get(i - 1).getOriginalFilename());
				setMImage3(images.get(i - 1));
				break;
			case 4:
				setImage4(uuid.toString() + images.get(i - 1).getOriginalFilename());
				setMImage4(images.get(i - 1));
				break;
			case 5:
				setImage5(uuid.toString() + images.get(i - 1).getOriginalFilename());
				setMImage5(images.get(i - 1));
				break;
			default:
				break;
			}
		}
	}

	public int getStyle_number() {
		return style_number;
	}

	public void setStyle_number(int style_number) {
		this.style_number = style_number;
	}

	public String getImage1() {
		return image1;
	}

	public void setImage1(String image1) {
		this.image1 = image1;
	}

	public String getImage2() {
		return image2;
	}

	public void setImage2(String image2) {
		this.image2 = image2;
	}

	public String getImage3() {
		return image3;
	}

	public void setImage3(String image3) {
		this.image3 = image3;
	}

	public String getImage4() {
		return image4;
	}

	public void setImage4(String image4) {
		this.image4 = image4;
	}

	public String getImage5() {
		return image5;
	}

	public void setImage5(String image5) {
		this.image5 = image5;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getStyle() {
		return style;
	}

	public void setStyle(String style) {
		this.style = style;
	}

	public int getRead_count() {
		return read_count;
	}

	public void setRead_count(int read_count) {
		this.read_count = read_count;
	}

	public Date getWrite_date() {
		return write_date;
	}

	public void setWrite_date(Date write_date) {
		this.write_date = write_date;
	}

	public Integer getProduct_number1() {
		return product_number1;
	}

	public void setProduct_number1(Integer product_number1) {
		this.product_number1 = product_number1;
	}

	public Integer getProduct_number2() {
		return product_number2;
	}

	public void setProduct_number2(Integer product_number2) {
		this.product_number2 = product_number2;
	}

	public Integer getProduct_number3() {
		return product_number3;
	}

	public void setProduct_number3(Integer product_number3) {
		this.product_number3 = product_number3;
	}

	public Integer getProduct_number4() {
		return product_number4;
	}

	public void setProduct_number4(Integer product_number4) {
		this.product_number4 = product_number4;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

}