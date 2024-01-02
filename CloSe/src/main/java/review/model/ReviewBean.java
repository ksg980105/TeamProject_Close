package review.model;

public class ReviewBean {
	private int review_number;
	private int rating;
	private String text;
	private int orderdetail_number;
	private String member_id;
	private String write_date;
	
	public int getReview_number() {
		return review_number;
	}
	public void setReview_number(int review_number) {
		this.review_number = review_number;
	}
	public int getRating() {
		return rating;
	}
	public void setRating(int rating) {
		this.rating = rating;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public int getOrderdetail_number() {
		return orderdetail_number;
	}
	public void setOrderdetail_number(int orderdetail_number) {
		this.orderdetail_number = orderdetail_number;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getWrite_date() {
		return write_date;
	}
	public void setWrite_date(String write_date) {
		this.write_date = write_date;
	}
}
