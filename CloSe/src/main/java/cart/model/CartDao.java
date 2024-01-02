package cart.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("CartDao") 
public class CartDao {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	private String namespace = "cart.CartBean";
	
	
	public void addCart(CartBean cb) {
		sqlSessionTemplate.insert(namespace+".addCart", cb);
	}
	public List<CartBean> getAllCartByMember_Id(String member_id) {
		return sqlSessionTemplate.selectList(namespace+".getAllCartByMember_Id", member_id);
	}
	public List<CartInfoBean> getAllCartInfoByMember_Id(String member_id) {
		return sqlSessionTemplate.selectList(namespace+".getAllCartInfoByMember_Id", member_id);
	}

	public void updateCart(CartBean cb) {
		sqlSessionTemplate.update(namespace+".updateCart", cb);
	}

	public void qtyUpdate(Map<String, String> qtyMap) {
		sqlSessionTemplate.update(namespace+".qtyUpdate", qtyMap);
	}

	public void deleteCarts(String[] cnums) {
		sqlSessionTemplate.delete(namespace+".deleteCarts", cnums);
	}

	public void deleteCart(String cnum) {
		sqlSessionTemplate.delete(namespace+".deleteCart", cnum);
	}

	public CartInfoBean getCartInfoByNum(String cnum) {
		return sqlSessionTemplate.selectOne(namespace+".getCartInfoByNum", cnum);
	}
	
	public List<CartInfoBean> getCartInfoByNums(String[] cnums) {
		return sqlSessionTemplate.selectList(namespace+".getCartInfoByNums", cnums);
	}



	
}
