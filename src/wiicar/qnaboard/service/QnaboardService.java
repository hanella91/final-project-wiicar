package wiicar.qnaboard.service;

import java.sql.SQLException;
import java.util.HashMap;

import wiicar.qnaboard.dto.QnaboardDTO;

public interface QnaboardService {
	
	// qna리스트 가져오기
	public HashMap getQnaList(HashMap<String, Object> map) throws SQLException;
	
	// qnaContent 불러오기
	public QnaboardDTO getQnaContent(int qnaNum) throws SQLException;
	
	// qna 저장하기
	public void insertQna(QnaboardDTO dto) throws SQLException;
	
	// qna 삭제하기
	public int deleteQna(int num, String pw) throws SQLException;
	
	// qna 수정
	public void modifyQna(QnaboardDTO dto) throws SQLException;
}
