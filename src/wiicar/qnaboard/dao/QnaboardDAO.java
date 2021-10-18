package wiicar.qnaboard.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import wiicar.qnaboard.dto.QnaboardDTO;

public interface QnaboardDAO {

	// qna리스트 가져오기
	public List getQnaList(HashMap<String, Object> map) throws SQLException;
	
	// qna리스트 카운트
	public int cntQnaList(HashMap<String, Object> map) throws SQLException;
	
	// qna Content 불러오기
	public QnaboardDTO getQnaContent(int qnaNum) throws SQLException;
	
	// qna 저장하기
	public void insertQna(QnaboardDTO dto) throws SQLException;
	
	// qna 삭제하기
	public int deleteQna(int num, String pw) throws SQLException;
	
	// qna 수정하기
	public void modifyQna(QnaboardDTO dto) throws SQLException;
}
