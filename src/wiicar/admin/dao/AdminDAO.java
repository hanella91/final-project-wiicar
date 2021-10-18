package wiicar.admin.dao;

import java.sql.SQLException;
import java.util.List;

import wiicar.admin.dto.AdminQnaDTO;
import wiicar.admin.dto.CarLookDTO;
import wiicar.admin.dto.InfoBoardDTO;
import wiicar.admin.dto.MemberInfoDTO;
import wiicar.admin.dto.RefundDTO;
import wiicar.admin.dto.ReportDTO;
import wiicar.carpool.dto.CarpoolDTO;
import wiicar.member.dto.MemberDTO;

public interface AdminDAO {
	
	// 카풀 목록 개수 확인 (유찬)
	public int getCarpoolCount();	
	// 카풀 검색 개수 확인 (유찬)
	public int getsearchCount(String sel2, String search);	
	// 카풀 조회
	public List<CarLookDTO> carpoolLookup(int StartRow, int endRow) throws SQLException;	
	// 카풀 검색 (유찬)
	public List<CarLookDTO> carpoolSearch(String sel2, String search, int startRow, int endRow) throws SQLException;
	// 환급 조회
	public List<RefundDTO> refundLookup(int startRow, int endRow, String sel, String sort) throws SQLException;
	// 환급 전체 개수 (유찬)
	public int getrefundCount();
	// 환급 검색 개수 확인 (유찬)
	public int getrefundSaerchCount(String sel2, String search);
	// 환급 검색 조회 (유찬)
	public List<RefundDTO> refundSearch(String sel2, String search, int startRow, int endRow) throws SQLException;
	// 신고 목록(유찬)
	public List<ReportDTO> reportsLookup(int startRow, int endRow, String sel, String sort) throws SQLException;
	// 관리자 신고대상 처리 (유찬)
	public int reportResult(String value, String reportId, String Id) throws SQLException;
	// 신고 목록 카운트(유찬)
	public int getReportsCount();
	// 신고 검색 카운트 (유찬)
	public int getReportsSearchCount(String sel2, String search);
	// 신고 목록 검색(유찬)
	public List<ReportDTO> reportSearch(String sel2, String search, int startRow, int endRow) throws SQLException;
	// 공지사항 (유찬)
	public List<InfoBoardDTO> getInfoBoard(int startRow, int endRow) throws SQLException;
	// 공지사항 content(유찬)
	public InfoBoardDTO getInfoContent(int num) throws SQLException;
	// 공지사항 글쓰기 pro (유찬)
	public void addInfo(InfoBoardDTO infodto) throws SQLException;
	// 공지사항 글쓰기 update (유찬)
	public void updateInfo(InfoBoardDTO infodto) throws SQLException;
	// 공지사항 삭제 (유찬)
	public int deleteInfo(int num1) throws SQLException;
	// 공지 개수(유찬)
	public int getInfoBoardCount() throws SQLException;
	
	// 회원 목록(정렬 포함)(혜썬)
	public List<MemberInfoDTO> memberInfo(int startRow, int endRow, String sel, String sort) throws SQLException;
	// 회원 목록 카운트 (혜썬)
	public int getMemberInfoCount();
	// 회원 검색 카운트 (유찬)
	public int getMemberSearchCount(String sel2, String search);
	// 회원목록 검색(혜썬)
	public List<MemberInfoDTO> memberInfoSearch(String sel2, String search, int startRow, int endRow) throws SQLException;
	// qna 목록(정렬 포함)(혜썬)
	public List<AdminQnaDTO> adminQna(int startRow, int endRow, String sel, String sort) throws SQLException;
	// qna 목록 카운트 (혜썬)
	public int getAdminQnaCount();
	// qna 검색 카운트 (유찬)
	public int getAdminQnaSearchCount(String sel2, String search);
	// qna 검색(혜썬)
	public List<AdminQnaDTO> adminQnaSearch(String sel2, String search, int startRow, int endRow) throws SQLException;
	// qna 답변 content페이지 qna 1개에 해당하는 페이지 정보 가져오기
	public AdminQnaDTO qnaReplyForm(int num) throws SQLException;
	// qna 답변후 답변 내용 저장(혜선)
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
