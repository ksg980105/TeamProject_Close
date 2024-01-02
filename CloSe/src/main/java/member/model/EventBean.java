package member.model;

public class EventBean {
	private String member_id;
	private int coupon_number;
	private String coupon_name;
	private int coupon_discount;
	   
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public int getCoupon_number() {
		return coupon_number;
	}
	public void setCoupon_number(int coupon_number) {
		this.coupon_number = coupon_number;
	}
	public String getCoupon_name() {
		return coupon_name;
	}
	public void setCoupon_name(String coupon_name) {
		this.coupon_name = coupon_name;
	}
	public int getCoupon_discount() {
		return coupon_discount;
	}
	public void setCoupon_discount(int coupon_discount) {
		this.coupon_discount = coupon_discount;
	}
}
