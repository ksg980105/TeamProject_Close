package member.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("EventDao")
public class EventDao {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	private String namespace = "event.EventBean";

	public EventDao() {

	}

	public void insertCoupon(EventBean eb) {
		sqlSessionTemplate.insert(namespace + ".insertCoupon", eb);
	}

	public List<EventBean> selectCoupon(String member_id) {
		List<EventBean> lists = sqlSessionTemplate.selectList(namespace + ".selectCoupon", member_id);
		return lists;
	}

	public void useCoupon(String coupon_number) {
		sqlSessionTemplate.delete(namespace + ".useCoupon", coupon_number);
	}

	public void deleteCoupon(String member_id) {
		sqlSessionTemplate.delete(namespace + ".deleteCoupon", member_id);

	}

}