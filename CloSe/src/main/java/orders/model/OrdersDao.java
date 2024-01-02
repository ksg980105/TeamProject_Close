package orders.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import cart.model.CartBean;
import utility.Paging;
import utility.Paging_orderDetail;

@Component("OrdersDao")
public class OrdersDao {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	private String namespace = "orders.OrdersBean";

	public void insertOrders(OrdersBean ob) {
		sqlSessionTemplate.insert(namespace + ".insertOrders", ob);
	}

	public OrdersBean getOrderById(String orders_id) {
		return sqlSessionTemplate.selectOne(namespace + ".getOrderById", orders_id);
	}

//   public List<OrdersBean> getOrderByMember_Id(String member_id) {
//      return sqlSessionTemplate.selectList(namespace+".getOrderByMember_Id", member_id);
//   }

	public List<OrdersBean> getOrderList(Paging_orderDetail pageInfo2, Map<String, String> map) {
		RowBounds rowBounds = new RowBounds(pageInfo2.getOffset(), pageInfo2.getLimit());
		return sqlSessionTemplate.selectList(namespace + ".getOrderList", map, rowBounds);
	}

	public int getAdminTotalCount(Map<String, String> map2) {
		return sqlSessionTemplate.selectOne(namespace + ".getAdminTotalCount", map2);
//	public List<OrdersBean> getOrderByMember_Id(String member_id) {
//		return sqlSessionTemplate.selectList(namespace+".getOrderByMember_Id", member_id);
	}

	public List<OrdersBean> getOrderByMember_Id(Paging_orderDetail pageInfo, Map<String, String> map) {
		RowBounds rowBounds = new RowBounds(pageInfo.getOffset(), pageInfo.getLimit());
		return sqlSessionTemplate.selectList(namespace + ".getOrderByMember_Id", map, rowBounds);
	}

	public int getTotalCount(Map<String, String> map) {

		return sqlSessionTemplate.selectOne(namespace + ".getTotalCount", map);
	}

	public List<OrdersBean> selectOrderByMember(String member_id) {
		List<OrdersBean> lists = sqlSessionTemplate.selectList(namespace + ".selectOrderByMember", member_id);
		return lists;
	}

	public void refundOrder(String orders_id) {
		sqlSessionTemplate.update(namespace+".refundOrder", orders_id);
	}

}