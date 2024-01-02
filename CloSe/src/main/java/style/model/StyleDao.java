package style.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("StyleDao")
public class StyleDao {
   
   @Autowired
   private SqlSessionTemplate sqlSessionTemplate;
   private String namespace = "style.StyleBean";
   
   public int insertStyle(StyleBean styleBean) {
      int cnt = -1;
      try {
         cnt = sqlSessionTemplate.insert(namespace + ".insertStyle", styleBean);
      } catch (Exception e) {
         e.printStackTrace();
      }
      return cnt;
   }

   public List<StyleBean> getStyleList(int page, int pageSize) {
	   int startRow = (page - 1) * pageSize + 1;
	   int endRow = startRow + pageSize - 1;
       Map<String, Integer> params = new HashMap<String, Integer>();
       params.put("startRow", startRow);
       params.put("endRow", endRow);
      return sqlSessionTemplate.selectList(namespace + ".getStyleList", params);
   }

   public StyleBean getStyleByStyleNumber(int style_number) {
      return sqlSessionTemplate.selectOne(namespace + ".getStyleByStyleNumber", style_number);
   }

	public List<StyleBean> getTemperatureAvgByStyle() {
		return sqlSessionTemplate.selectList(namespace+".getTemperatureAvgByStyle");
	}

	public void updateReadCount(int style_number) {
		sqlSessionTemplate.update(namespace + ".updateReadCount", style_number);
	}

	public void deleteByStyleNumber(int style_number) {
		sqlSessionTemplate.delete(namespace + ".deleteByStyleNumber", style_number);
	}

	public List<StyleBean> getTemperatureByStyle(Map<String, Double> map) {
		 List<StyleBean> lists = sqlSessionTemplate.selectList(namespace+".getTemperatureByStyle", map);
		 System.out.println("lists size : " + lists.size());
	     return lists;
	   }

	public String selectMember(int style_number) {
		String reported_user_id = sqlSessionTemplate.selectOne(namespace+".selectMember", style_number);
		return reported_user_id;
	}

	public List<StyleBean> selectTempStyle() {
		List<StyleBean> tempLists = sqlSessionTemplate.selectList(namespace+".selectTempStyle");
		System.out.println("tempLists : " + tempLists);
		return tempLists;
	}

	public List<StyleBean> styleFilter(Map<String, Object> map) {
		List<StyleBean> lists = sqlSessionTemplate.selectList(namespace+".styleFilter", map);
		return lists;
	}

	public void updateStyle(StyleBean styleBean) {
		sqlSessionTemplate.update(namespace + ".updateStyle", styleBean);
	}

	public void updateStyleNoImageUp(StyleBean styleBean) {
		sqlSessionTemplate.update(namespace + ".updateStyleNoImageUp", styleBean);
	}
	
	public List<StyleBean> getStyleByMemberId(String id) {
		return sqlSessionTemplate.selectList(namespace + ".getStyleByMemberId", id);
	}

	public List<StyleBean> getStyleByProductNum(String product_number) {
		return sqlSessionTemplate.selectList(namespace + ".getStyleByProductNum", product_number);
	}

	public List<StyleBean> getMainStyleList() {
		Map<String, Integer> params = new HashMap<String, Integer>();
	       params.put("startRow", 1);
	       params.put("endRow", 4);
		return sqlSessionTemplate.selectList(namespace + ".getStyleList", params);
	}
   
}
