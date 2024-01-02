package orderdetail.model;

public class OrderDetailBean {
	private int orderdetail_number;
	private int order_id;
	private int product_number;
	private String product_size;
	private int qty;
	
	public int getOrderdetail_number() {
		return orderdetail_number;
	}
	public void setOrderdetail_number(int orderdetail_number) {
		this.orderdetail_number = orderdetail_number;
	}
	public int getOrder_id() {
		return order_id;
	}
	public void setOrder_id(int order_id) {
		this.order_id = order_id;
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
}
