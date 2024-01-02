package category.model;

public class CategoryBean {
	private String smallcategory_name; 
	private String bigcategory_name;
	
	public CategoryBean() {
		super();
	}
	public CategoryBean(String smallcategory_name, String bigcategory_name) {
		super();
		this.smallcategory_name = smallcategory_name;
		this.bigcategory_name = bigcategory_name;
	}
	public String getSmallcategory_name() {
		return smallcategory_name;
	}
	public void setSmallcategory_name(String smallcategory_name) {
		this.smallcategory_name = smallcategory_name;
	}
	public String getBigcategory_name() {
		return bigcategory_name;
	}
	public void setBigcategory_name(String bigcategory_name) {
		this.bigcategory_name = bigcategory_name;
	} 
	
	
}
