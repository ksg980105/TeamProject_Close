package notice.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import utility.Paging;

@Component("NoticeDao")
public class NoticeDao {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	private String namespace = "notice.NoticeBean";
	
	public NoticeDao() {
		
	}

	public int getTotalCount(Map<String, String> map) {
		int cnt = sqlSessionTemplate.selectOne(namespace+".getTotalCount", map);
		return cnt;
	}

	public List<NoticeBean> getAllNotice(Map<String, String> map, Paging pageInfo) {
		RowBounds rowbounds = new RowBounds(pageInfo.getOffset(), pageInfo.getLimit());
		List<NoticeBean> lists = sqlSessionTemplate.selectList(namespace+".getAllNotice", map, rowbounds);
		System.out.println("lists : " + lists.size());
		return lists;
	}

	public int insertNotice(NoticeBean noticeBean) {
		int cnt = -1;
		try {
			cnt = sqlSessionTemplate.insert(namespace+".insertNotice", noticeBean);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cnt;
	}

	public NoticeBean detailNotice(String notice_number) {
		NoticeBean noticeBean = sqlSessionTemplate.selectOne(namespace+".detailNotice", notice_number);
		return noticeBean;
	}

	public void deleteNotice(Integer notice_number) {
		sqlSessionTemplate.delete(namespace+".deleteNotice", notice_number);
	}

	public NoticeBean getNoticeByNumber(String notice_number) {
		NoticeBean noticeBean = sqlSessionTemplate.selectOne(namespace+".getNoticeByNumber", notice_number);
		return noticeBean;
	}

	public int updateNotice(NoticeBean noticeBean) {
		int cnt = -1;
		try {
			cnt = sqlSessionTemplate.update(namespace+".updateNotice",noticeBean);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cnt;
	}

	public NoticeBean selectNotice(Integer notice_number) {
		NoticeBean noticeBean = sqlSessionTemplate.selectOne(namespace+".selectNotice", notice_number);
		return noticeBean;
	}

}
