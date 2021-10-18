package wiicar.qnaboard.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import wiicar.qnaboard.dto.QnaboardDTO;

@Repository
public class QnaboardDAOImpl implements QnaboardDAO {

	@Autowired
	private SqlSessionTemplate sqlSession = null;

	// qna리스트 가져오기
	@Override
	public List getQnaList(HashMap<String, Object> map) throws SQLException {
		List qnaList = sqlSession.selectList("qnaboard.getQnaList", map); 
		return qnaList;
	}
	
	// qna리스트 Count
	@Override
	public int cntQnaList(HashMap<String, Object> map) throws SQLException {
		return sqlSession.selectOne("qnaboard.cntQnaList", map);
	}

	// qna Content 불러오기
	@Override
	public QnaboardDTO getQnaContent(int qnaNum) throws SQLException {
		sqlSession.update("qnaboard.qnaAddHit", qnaNum);
		return sqlSession.selectOne("qnaboard.getQnaContent", qnaNum);
	}

	// qna 저장하기
	@Override
	public void insertQna(QnaboardDTO dto) throws SQLException {
		sqlSession.insert("qnaboard.insertQna", dto);
	}

	// qna 삭제하기
	@Override
	public int deleteQna(int num, String pw) throws SQLException {
		HashMap<String, Object> map = new HashMap<>();
		map.put("num", num);
		map.put("pw", pw);
		return sqlSession.delete("qnaboard.deleteQna", map);
	}

	@Override
	public void modifyQna(QnaboardDTO dto) throws SQLException {
		sqlSession.update("qnaboard.modifyQna", dto);
	}
	

}
