package wiicar.admin.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import wiicar.admin.dto.AdminQnaDTO;
import wiicar.admin.dto.CarLookDTO;
import wiicar.admin.dto.InfoBoardDTO;
import wiicar.admin.dto.MemberInfoDTO;
import wiicar.admin.dto.RefundDTO;
import wiicar.admin.dto.ReportDTO;
import wiicar.carpool.dto.CarpoolDTO;
import wiicar.member.dto.MemberDTO;

@Repository
public class AdminDAOImpl implements AdminDAO {
	@Autowired
	private SqlSessionTemplate sqlSession = null;
	
	// 전체 카운트 (유찬)
	@Override
	public int getCarpoolCount() {
		int result = sqlSession.selectOne("admin.getCarpoolCount");
		return result;
	}
	
	// 게시글 검색 카운트 (유찬)
	@Override
	public int getsearchCount(String sel2, String search) {
		Map map = new HashMap();
		map.put("sel2", sel2);
		map.put("search", search);
		int result =  sqlSession.selectOne("admin.getsearchCount",map);
		return result;
	}
	
	@Override
	public List<CarLookDTO> carpoolLookup(int startRow, int endRow) throws SQLException {
		Map map = new HashMap();
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		List<CarLookDTO> carpoollist = sqlSession.selectList("admin.carpoolLookup",map);

		return carpoollist;
	}
	
	// 관리자 카풀 검색(유찬)
	@Override
	public List<CarLookDTO> carpoolSearch(String sel2, String search, int startRow, int endRow) throws SQLException {
		Map map = new HashMap();
		map.put("sel2", sel2);
		map.put("search", search);
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		List<CarLookDTO> cardto = sqlSession.selectList("admin.carpoolSearch", map);
		return cardto;
		}
	// 환급 전체 조회
	@Override
	public List<RefundDTO> refundLookup(int startRow, int endRow, String sel, String sort) throws SQLException {
		Map map = new HashMap();
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		map.put("sel", sel);
		map.put("sort",sort);
		List<RefundDTO> refdto = sqlSession.selectList("admin.refundLookup", map);
		return refdto;
	}
	// 환급 전체 개수 확인 (유찬)
	@Override
	public int getrefundCount() {
		int result =  sqlSession.selectOne("admin.getrefundCount");
		return result;
	}	
	// 환급 검색 개수 확인(유찬)
	@Override
	public int getrefundSaerchCount(String sel2, String search) {
		Map map = new HashMap();
		map.put("sel2", sel2);
		map.put("search", search);
		int result =  sqlSession.selectOne("admin.getrefundSaerchCount",map);
		return result;
	}
	// 환급 검색 조회(유찬)
	@Override
	public List<RefundDTO> refundSearch(String sel2, String search, int startRow, int endRow) throws SQLException {
		Map map = new HashMap();
		map.put("sel2", sel2);
		map.put("search", search);
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		List<RefundDTO> refdto = sqlSession.selectList("admin.refundSearch", map);
		return refdto;
	}
	
	// 신고 목록(유찬)
	@Override
	public List<ReportDTO> reportsLookup(int startRow, int endRow, String sel, String sort) throws SQLException {
		Map map = new HashMap();
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		map.put("sel", sel);
		map.put("sort",sort);
		List<ReportDTO> redto = sqlSession.selectList("admin.reportsLookup", map);

		return redto;
	}
	// 관리자 신고대상 처리 (유찬)
	@Override
	public int reportResult(String value, String reportId, String Id) throws SQLException {
		Map map = new HashMap();
		map.put("result", value);
		map.put("reportId", reportId);
		map.put("Id", Id);
		System.out.println("하이하이!!");
		int result = sqlSession.update("admin.reportResult", map);
		return result;
	}
	// 게시글 카운트 (유찬)
	@Override
	public int getReportsCount() {
		int result =  sqlSession.selectOne("admin.getReportsCount");
		return result;
	}
	// 검색(유찬)
	@Override
	public List<ReportDTO> reportSearch(String sel2, String search, int startRow, int endRow) throws SQLException {
		Map map = new HashMap();
		map.put("sel2", sel2);
		map.put("search", search);
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		List<ReportDTO> redto = sqlSession.selectList("admin.reportSearch", map);
		return redto;
	}
	// 신고 검색 카운트(유찬)
	@Override
	public int getReportsSearchCount(String sel2, String search) {
		Map map = new HashMap();
		map.put("sel2", sel2);
		map.put("search", search);
		int result = sqlSession.selectOne("admin.getReportsSearchCount", map);
		return result;
	}

	// 공지사항(유찬)
	@Override
	public List<InfoBoardDTO> getInfoBoard(int startRow, int endRow) throws SQLException {
		Map map = new HashMap();
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		List<InfoBoardDTO> infodto = sqlSession.selectList("admin.getInfoBoard", map);
		return infodto;
	}
	
	// 공지사항 content (유찬)
	@Override
	public InfoBoardDTO getInfoContent(int num) throws SQLException {
		sqlSession.update("admin.updatHit", num);
		InfoBoardDTO infodto = sqlSession.selectOne("admin.getInfoContent", num);
		return infodto;
	}
	// 공지사항 글쓰기 pro(유찬)
	@Override
	public void addInfo(InfoBoardDTO infodto) throws SQLException {
		sqlSession.insert("admin.addInfo", infodto);
	}
	// 공지사항 수정 (유찬)
	@Override
	public void updateInfo(InfoBoardDTO infodto) throws SQLException {
		sqlSession.update("admin.updateInfo", infodto);
	}
	// 공지사항 삭제(유찬)
	@Override
	public int deleteInfo(int num1) throws SQLException {
		int result = sqlSession.delete("admin.deleteInfo", num1);
		return result;
	}
	// 공지사항 개수 확인 (유찬)
	@Override
	public int getInfoBoardCount() throws SQLException {
		int count = sqlSession.selectOne("admin.getInfoBoardCount");
		return count;
	}
	
	// 회원 목록(혜선)
	@Override
	public List<MemberInfoDTO> memberInfo(int startRow, int endRow, String sel, String sort) throws SQLException {
		
		System.out.println("DAO sel : " + sel + " sort : " + sort);
		Map map = new HashMap();
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		map.put("sel", sel);
		map.put("sort",sort);
		System.out.println(map.get("sel"));
		System.out.println(map.get("sort"));
		List<MemberInfoDTO> redto = sqlSession.selectList("admin.memberInfo", map);

		return redto;
	}
			
	// 회원목록 카운트	
	@Override
	public int getMemberInfoCount() {
		int result =  sqlSession.selectOne("admin.getMemberInfoCount");
		return result;
	}	
	// 회원목록 검색(혜선)
	@Override
	public List<MemberInfoDTO> memberInfoSearch(String sel2, String search, int startRow, int endRow) throws SQLException {
		Map map = new HashMap();
		map.put("sel2", sel2);
		map.put("search", search);
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		List<MemberInfoDTO> redto = sqlSession.selectList("admin.memberInfoSearch", map);
		return redto;
	}
	// 회원 검색 카운트(유찬)
		@Override
		public int getMemberSearchCount(String sel2, String search) {
			Map map = new HashMap();
			map.put("sel2", sel2);
			map.put("search", search);
			int result = sqlSession.selectOne("admin.getMemberSearchCount", map);
			return result;
		}

	// qna 목록(혜선)
	@Override
	public List<AdminQnaDTO> adminQna(int startRow, int endRow, String sel, String sort) throws SQLException {
		Map map = new HashMap();
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		map.put("sel", sel);
		map.put("sort",sort);
		List<AdminQnaDTO> redto = sqlSession.selectList("admin.adminQna", map);

		return redto;
	}
			
	// qna목록 카운트	
	@Override
	public int getAdminQnaCount() {
		int result =  sqlSession.selectOne("admin.getAdminQnaCount");
		return result;
	}
	// qna 검색 카운트
	@Override
	public int getAdminQnaSearchCount(String sel2, String search) {
		Map map = new HashMap();
		map.put("sel2", sel2);
		map.put("search", search);
		int result = sqlSession.selectOne("admin.getAdminQnaSearchCount", map);
		return result;
	}

	// qna 검색(혜선)
	@Override
	public List<AdminQnaDTO> adminQnaSearch(String sel2, String search, int startRow, int endRow) throws SQLException {
		Map map = new HashMap();
		map.put("sel2", sel2);
		map.put("search", search);
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		List<AdminQnaDTO> redto = sqlSession.selectList("admin.adminQnaSearch", map);
		return redto;
	}
	
	// qna 게시글 1개 가져오기 관리자 페이지 답변하기 페이지에서처리(혜선)
	@Override
	public AdminQnaDTO qnaReplyForm(int num) throws SQLException {
		AdminQnaDTO qnaboard = sqlSession.selectOne("admin.getOneqnaForm", num); 
		
	return qnaboard;
	}
	// qna 답변 작성 후 답변 내용 저장(혜선)
	@Override
	public int writeQnaReply(AdminQnaDTO dto) throws SQLException {
		int result = sqlSession.update("admin.writeQnaReply", dto);
		return result;
	}

	
	// 회원정보 subadminupdate(유찬)
	@Override
	public int subAdminUpdate(String userId, String subAdmin) throws SQLException {
		Map map = new HashMap();
		map.put("userId", userId);
		map.put("subAdmin", subAdmin);
		int result = sqlSession.update("admin.subAdminUpdate", map);
		return result;
	}

	// 관리자 회원정보 조회(민수)
	@Override
	public MemberDTO getMemberInfo(String nickname) throws SQLException {
		return sqlSession.selectOne("member.getMemberInfo", nickname);
	}
	// 관리자 운전자 승인(민수)
	@Override
	public int acceptDriver(String nickname) throws SQLException {
		return sqlSession.update("admin.acceptDriver", nickname);
	}
	// 관리자 운전자 반려(민수)
	@Override
	public int denyDriver(String nickname) throws SQLException {
		return sqlSession.update("admin.denyDriver", nickname);
	}


	// 관리자 카풀 조회(민수)
	@Override
	public RefundDTO getCarpoolInfo(int carpoolnum) throws SQLException {
		return sqlSession.selectOne("admin.getCarpoolInfo", carpoolnum);
	}

	// 관리자 환급 처리(민수)
	@Override
	public int refundCarpool(int carpoolnum) throws SQLException {
		return sqlSession.update("admin.refundCarpool", carpoolnum);
	}

}
