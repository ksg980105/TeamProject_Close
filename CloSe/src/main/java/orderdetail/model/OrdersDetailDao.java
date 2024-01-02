package orderdetail.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import cart.model.CartBean;
import cart.model.CartInfoBean;

@Component("OrderDetailDao")
public class OrdersDetailDao {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	private String namespace = "orderdetail.OrderDetailBean";
	public void insertOrderDetail(CartInfoBean cib) {
		sqlSessionTemplate.insert(namespace+".insertOrderDetail", cib);
	}
	public List<OrderItem> getOrderDetailsByOrder_id(String orders_id) {
		return sqlSessionTemplate.selectList(namespace+".getOrderDetailsByOrder_id", orders_id);
	}
	
}
