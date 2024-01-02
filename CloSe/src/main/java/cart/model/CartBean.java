package cart.model;

public class CartBean {
	private int cart_number;
	private int product_number;
	private String product_size;
	private int qty;
	private String member_id;
	
	public CartBean() {
		super();
	}
	public CartBean(int cart_number, int product_number, int qty, String member_id) {
		super();
		this.cart_number = cart_number;
		this.product_number = product_number;
		this.qty = qty;
		this.member_id = member_id;
	}
	public int getCart_number() {
		return cart_number;
	}
	public void setCart_number(int cart_number) {
		this.cart_number = cart_number;
	}
	public int getProduct_number() {
		return product_number;
	}
	public void setProduct_number(int product_number) {
		this.product_number = product_number;
	}
	public String getProduct_size() {
		return product_size;
	}
	public void setProduct_size(String product_size) {
		this.product_size = product_size;
	}
	public int getQty() {
		return qty;
	}
	public void setQty(int qty) {
		this.qty = qty;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	
	
}
