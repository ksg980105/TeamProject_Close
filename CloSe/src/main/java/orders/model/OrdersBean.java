package orders.model;

public class OrdersBean {
	private int orders_number;
	private String orders_id;
	private String orders_date;
	private String receiver;
	private String receiver_phone;
	private String address;
	private String d_message;
	private String member_id;
	private String status;
	private int totalamount;
	
	public int getOrders_number() {
		return orders_number;
	}
	public void setOrders_number(int orders_number) {
		this.orders_number = orders_number;
	}
	public String getOrders_id() {
		return orders_id;
	}
	public void setOrders_id(String orders_id) {
		this.orders_id = orders_id;
	}
	public String getOrders_date() {
		return orders_date;
	}
	public void setOrders_date(String orders_date) {
		this.orders_date = orders_date;
	}
	public String getReceiver() {
		return receiver;
	}
	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}
	public String getReceiver_phone() {
		return receiver_phone;
	}
	public void setReceiver_phone(String receiver_phone) {
		this.receiver_phone = receiver_phone;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getD_message() {
		return d_message;
	}
	public void setD_message(String d_message) {
		this.d_message = d_message;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public int getTotalamount() {
		return totalamount;
	}
	public void setTotalamount(int totalamount) {
		this.totalamount = totalamount;
	}
	
}
