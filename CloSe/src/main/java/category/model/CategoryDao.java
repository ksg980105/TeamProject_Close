package category.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("CategoryDao")
public class CategoryDao {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	private String namespace = "category.CategoryBean";
	public List<CategoryBean> getAllCategory() {
		List<CategoryBean> lists = sqlSessionTemplate.selectList(namespace+".getAllCategory");
		return lists;
	}
	

	
}
