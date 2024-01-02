package qna.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.UncategorizedSQLException;
import org.springframework.stereotype.Component;

import utility.Paging;

@Component("QnaDao")
public class QnaDao {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	private String namespace = "qna.QnaBean";
	
	public QnaDao() {
		
	}
	
	public int getTotalCount(Map<String, String> map) {
		int cnt = sqlSessionTemplate.selectOne(namespace+".getTotalCount", map);
		System.out.println("getTotalCount cnt : " + cnt);
		return cnt;
	}

	public List<QnaBean> getAllQna(Map<String, String> map, Paging pageInfo) {
		RowBounds rowbounds = new RowBounds(pageInfo.getOffset(), pageInfo.getLimit());
		List<QnaBean> lists = sqlSessionTemplate.selectList(namespace+".getAllQna", map, rowbounds);
		
		System.out.println("QnaDao getAllQna lists.size() : " + lists.size());
		return lists;
	}
	
	public List<QnaBean> getAllQna2(Map<String, String> map, Paging pageInfo) {
		RowBounds rowbounds = new RowBounds(pageInfo.getOffset(), pageInfo.getLimit());
		List<QnaBean> lists2 = sqlSessionTemplate.selectList(namespace+".getAllQna2", map, rowbounds);
		
		System.out.println("QnaDao getAllQna lists2.size() : " + lists2.size());
		return lists2;
	}
	
	public int insertQna(QnaBean qnaBean) {
		int cnt = -1;
		try {
			cnt = sqlSessionTemplate.insert(namespace+".insertQna", qnaBean);
		}catch(Exception e) {
			e.printStackTrace();
		}
		System.out.println("insertQna : " + cnt);
		return cnt;
	}

	public QnaBean selectQna(String qna_number) {
		QnaBean qnaBean = sqlSessionTemplate.selectOne(namespace+".selectQna", qna_number);
		return qnaBean;
	}

	public int updateQna(QnaBean qnaBean) {
		int cnt = -1;
		try {
			cnt = sqlSessionTemplate.update(namespace+".updateQna", qnaBean);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return cnt;
	}


	public void deleteQna(String qna_number) {
		sqlSessionTemplate.delete(namespace+".deleteQna", qna_number);
	}

	public int replyQna(QnaBean qnaBean) {
		int cnt = -1;
		try {
			sqlSessionTemplate.update(namespace+".replyQna1", qnaBean);
			cnt = sqlSessionTemplate.insert(namespace+".replyQna2", qnaBean);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cnt;
	}

	
}
