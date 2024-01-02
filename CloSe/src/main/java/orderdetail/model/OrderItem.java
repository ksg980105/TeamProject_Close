package orderdetail.model;

import org.hibernate.validator.constraints.NotEmpty;

public class OrderItem {
	
	private String product_name;
	private String image;
	private Integer price;
	private String content;
	private Integer temperature;
	private int s_stock;
	private int m_stock;
	private int l_stock;
	private int xl_stock;
	
	private int orderdetail_number;
	private int product_number;
	private String product_size;
	private int qty;
	
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
	
	private String password;
	private String name;
	private String phone;
	private String email;
	private String address1;
	private String address2;
	private String birth;
	private String gender;
	private String nickname;
	private int height;
	private int weight;
	
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
	public Integer getPrice() {
		return price;
	}
	public void setPrice(Integer price) {
		this.price = price;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Integer getTemperature() {
		return temperature;
	}
	public void setTemperature(Integer temperature) {
		this.temperature = temperature;
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
	public int getOrderdetail_number() {
		return orderdetail_number;
	}
	public void setOrderdetail_number(int orderdetail_number) {
		this.orderdetail_number = orderdetail_number;
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
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getAddress1() {
		return address1;
	}
	public void setAddress1(String address1) {
		this.address1 = address1;
	}
	public String getAddress2() {
		return address2;
	}
	public void setAddress2(String address2) {
		this.address2 = address2;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
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
	public int getHeight() {
		return height;
	}
	public void setHeight(int height) {
		this.height = height;
	}
	public int getWeight() {
		return weight;
	}
	public void setWeight(int weight) {
		this.weight = weight;
	}
	
}
