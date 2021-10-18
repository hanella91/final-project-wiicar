package wiicar.admin.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;

import wiicar.admin.dto.AdminQnaDTO;
import wiicar.admin.dto.CarLookDTO;
import wiicar.admin.dto.InfoBoardDTO;
import wiicar.admin.dto.RefundDTO;
import wiicar.carpool.dto.CarpoolDTO;
import wiicar.member.dto.MemberDTO;

public interface AdminService {
	// 카풀 조회
	public Map<String, Object> carpoolLookup(String pageNum) throws SQLException;
	// 카풀 검색 (유찬)
	public Map<String, Object> carpoolSearch(String pageNum, String sel2, String search) throws SQLException;
	// 환급 조회 (유찬)
	public Map<String, Object> refundLookup(String pageNum, String sel, String sort) throws SQLException;
	// 환급 검색 (유찬)
	public Map<String, Object> refundSearch(String pageNum, String sel2, String search) throws SQLException;
	// 신고 목록(유찬)
	public Map<String, Object> reportsLookup(String pageNum, String sel, String sort) throws SQLException;
	// 관리자 신고대상 처리 (유찬)
	public int reportResult(String value, String reportId, String Id) throws SQLException;
	// 관리자 신고 검색 (유찬)
	public Map<String, Object> reportSearch(String pageNum,String sel2, String search) throws SQLException;
	// 공지사항 (유찬)
	public Map<String, Object> getInfoBoard(String pageNum) throws SQLException;
	// 공지사항 content(유찬)
	public InfoBoardDTO getInfoContent(int num) throws SQLException;
	// 공지사항 글쓰기 pro (유찬)
	public void addInfo(InfoBoardDTO infodto) throws SQLException;
	// 공지사항 글쓰기 update (유찬)
	public void updateInfo(InfoBoardDTO infodto) throws SQLException;
	// 공지사항 삭제 (유찬)
	public int deleteInfo(int num1) throws SQLException;
	
	// 회원 목록(혜선)
	public Map<String, Object> memberInfo(String pageNum, String sel, String sort) throws SQLException;
	
	// 회원목록 검색
	public Map<String, Object> memberInfoSearch(String pageNum,String sel2, String search) throws SQLException;
	
	// qna 목록(혜선)
	public Map<String, Object> adminQna(String pageNum, String sel, String sort) throws SQLException;
	
	// qna 검색(헤선)
	public Map<String, Object> adminQnaSearch(String pageNum,String sel2, String search) throws SQLException;
	
	// qna 게시글 1개 가져오기(혜선)
	public AdminQnaDTO qnaReplyForm(int num) throws SQLException;

	// qna 답변 내용 저장 (혜선)
	public int writeQnaReply(AdminQnaDTO dto) throws SQLException;
	
	// 회원정보 subadminupdate(유찬)
	public int subAdminUpdate(String userId, String subAdmin) throws SQLException;
	// 관리자 회원정보 조회(민수)
	public MemberDTO getMemberInfo(String nickname) throws SQLException;
	
	// 관리자 운전자 승인(민수)
	public int acceptDriver(String nickname) throws SQLException;
		
	// 관리자 운전자 반려(민수)
	public int denyDriver(String nickname) throws SQLException;	
	
	// 관리자 카풀 조회(민수)
	public RefundDTO getCarpoolInfo(int carpoolnum) throws SQLException;	
	
	// 관리자 환급 처리(민수)
	public int refundCarpool(int carpoolnum) throws SQLException;
}
