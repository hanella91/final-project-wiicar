package wiicar.admin.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;

import wiicar.admin.dao.AdminDAOImpl;
import wiicar.admin.dto.AdminQnaDTO;
import wiicar.admin.dto.CarLookDTO;
import wiicar.admin.dto.InfoBoardDTO;
import wiicar.admin.dto.MemberInfoDTO;
import wiicar.admin.dto.RefundDTO;
import wiicar.admin.dto.ReportDTO;
import wiicar.carpool.dto.CarpoolDTO;
import wiicar.member.dto.MemberDTO;

@Service
public class AdminServiceImpl implements AdminService{
	@Autowired
	private AdminDAOImpl adminDAO = null;
	
	@Override
	public Map<String, Object> carpoolLookup(String pageNum) throws SQLException {
		
		int pageSize = 5; 
		if(pageNum == null || pageNum == "") pageNum = "1";
		
		int currentPage = Integer.parseInt(pageNum); 
		int startRow = (currentPage - 1) * pageSize + 1; 
		int endRow = currentPage * pageSize; 
		int count =0;
		List<CarLookDTO> cardto =null;
		count = adminDAO.getCarpoolCount();
		if(count > 0)
			cardto = adminDAO.carpoolLookup(startRow, endRow);

		int listSize = cardto.size();
		
		Map<String, Object> result = new HashMap<>();
		result.put("pageSize", pageSize);
		result.put("pageNum", pageNum);
		result.put("currentPage", currentPage);
		result.put("startRow", startRow);
		result.put("endRow", endRow);
		result.put("count", count);
		result.put("listSize",listSize);
		result.put("cardto", cardto);
		
		return result;
	}
	// 카풀 검색 (유찬)
	@Override
	public Map<String, Object> carpoolSearch(String pageNum, String sel2, String search) throws SQLException {

		int pageSize = 5; 
		if(pageNum == null || pageNum == "") pageNum = "1";
		
		int currentPage = Integer.parseInt(pageNum); 
		int startRow = (currentPage - 1) * pageSize + 1; 
		int endRow = currentPage * pageSize; 
		int count =0;
		List<CarLookDTO> cardto =null;
		count = adminDAO.getsearchCount(sel2, search);
		if(count > 0)
			cardto = adminDAO.carpoolSearch(sel2, search, startRow, endRow);
		
		int listSize = cardto.size();
		
		Map<String, Object> result = new HashMap<>();
		result.put("pageSize", pageSize);
		result.put("pageNum", pageNum);
		result.put("currentPage", currentPage);
		result.put("startRow", startRow);
		result.put("endRow", endRow);
		result.put("count", count);
		result.put("listSize",listSize);
		result.put("sel2", sel2);
		result.put("search", search);
		result.put("cardto", cardto);
		
		return result;
	}
	// 환급 조회 (유찬)
	@Override
	public  Map<String, Object> refundLookup(String pageNum, String sel, String sort) throws SQLException {
		
		int pageSize = 5; 
		if(pageNum == null || pageNum == "") pageNum = "1";
		if(sel == null) 
			sel ="time";
		int currentPage = Integer.parseInt(pageNum); 
		int startRow = (currentPage - 1) * pageSize + 1; 
		int endRow = currentPage * pageSize; 
		int count =0;
		List<RefundDTO> refdto =null;
		count = adminDAO.getrefundCount();   
		if(count > 0)
			refdto = adminDAO.refundLookup(startRow, endRow,sel,sort);
		
		int listSize = refdto.size();
		
		Map<String, Object> result = new HashMap<>();
		result.put("pageSize", pageSize);
		result.put("pageNum", pageNum);
		result.put("currentPage", currentPage);
		result.put("startRow", startRow);
		result.put("endRow", endRow);
		result.put("count", count);
		result.put("listSize",listSize);
		result.put("sel", sel);
		result.put("sort", sort);
		result.put("refdto", refdto);
		
		return result;
	}
	// 환급 검색(유찬)
	@Override
	public Map<String, Object> refundSearch(String pageNum, String sel2, String search) throws SQLException {
		int pageSize = 5; 
		if(pageNum == null || pageNum == "") pageNum = "1";
		
		int currentPage = Integer.parseInt(pageNum); 
		int startRow = (currentPage - 1) * pageSize + 1; 
		int endRow = currentPage * pageSize; 
		int count =0;
		List<RefundDTO> refdto =null;
		count = adminDAO.getrefundSaerchCount(sel2, search);
		if(count > 0)
			refdto = adminDAO.refundSearch(sel2, search, startRow, endRow);
		
		int listSize = refdto.size();
		
		Map<String, Object> result = new HashMap<>();
		result.put("pageSize", pageSize);
		result.put("pageNum", pageNum);
		result.put("currentPage", currentPage);
		result.put("startRow", startRow);
		result.put("endRow", endRow);
		result.put("count", count);
		result.put("listSize",listSize);
		result.put("sel2", sel2);
		result.put("search", search);
		result.put("refdto", refdto);
		
		return result;
	}
	// 신고 목록 조회 (유찬)
	@Override
	public Map<String, Object> reportsLookup(String pageNum, String sel, String sort) throws SQLException {
		
		int pageSize = 5; 
		if(pageNum == null || pageNum == "") pageNum = "1";
		if(sel == null) sel = "reg";
		
		int currentPage = Integer.parseInt(pageNum); 
		int startRow = (currentPage - 1) * pageSize + 1; 
		int endRow = currentPage * pageSize; 
		int count =0;
		List<ReportDTO> redto =null;
		count = adminDAO.getReportsCount();   
		if(count > 0)
		redto = adminDAO.reportsLookup(startRow, endRow,sel,sort);
		
		int listSize = redto.size();
		
		Map<String, Object> result = new HashMap<>();
		result.put("pageSize", pageSize);
		result.put("pageNum", pageNum);
		result.put("currentPage", currentPage);
		result.put("startRow", startRow);
		result.put("endRow", endRow);
		result.put("count", count);
		result.put("listSize",listSize);
		result.put("sel", sel);
		result.put("sort", sort);
		result.put("redto", redto);
		
		return result;
	}
	// 관리자 신고대상 처리 (유찬)
	@Override
	public int reportResult(String value, String reportId, String Id) throws SQLException {
		int result = adminDAO.reportResult(value, reportId, Id);
		return result;
	}
	// 검색
	@Override
	public Map<String, Object> reportSearch(String pageNum, String sel2, String search) throws SQLException {

		int pageSize = 5; 
		if(pageNum == null || pageNum == "") pageNum = "1";
		
		int currentPage = Integer.parseInt(pageNum); 
		int startRow = (currentPage - 1) * pageSize + 1; 
		int endRow = currentPage * pageSize; 
		int count =0;
		List<ReportDTO> redto =null;
		count = adminDAO.getReportsSearchCount(sel2, search);
		if(count > 0)
			redto = adminDAO.reportSearch(sel2, search, startRow, endRow);
		
		int listSize = redto.size();
		
		Map<String, Object> result = new HashMap<>();
		result.put("pageSize", pageSize);
		result.put("pageNum", pageNum);
		result.put("currentPage", currentPage);
		result.put("startRow", startRow);
		result.put("endRow", endRow);
		result.put("count", count);
		result.put("listSize",listSize);
		result.put("sel2", sel2);
		result.put("search", search);
		result.put("redto", redto);
		
		return result;
	}

	// 공지사항(유찬)
	@Override
	public Map<String, Object> getInfoBoard(String pageNum) throws SQLException {
		
		int pageSize = 5; 
		if(pageNum == null || pageNum == "") pageNum = "1";
		
		int currentPage = Integer.parseInt(pageNum); 
		int startRow = (currentPage - 1) * pageSize + 1; 
		int endRow = currentPage * pageSize; 
		int count =0;
		count = adminDAO.getInfoBoardCount();
		
		List<InfoBoardDTO> infodto = adminDAO.getInfoBoard(startRow, endRow);
		int listSize = infodto.size();
		
		Map<String, Object> result = new HashMap<>();		
		result.put("pageSize", pageSize);
		result.put("pageNum", pageNum);
		result.put("currentPage", currentPage);
		result.put("startRow", startRow);
		result.put("endRow", endRow);
		result.put("count", count);
		result.put("listSize",listSize);
		result.put("infodto", infodto);
		
		return result;
	}
	// 공지사항 content (유찬)
	@Override
	public InfoBoardDTO getInfoContent(int num) throws SQLException {
		InfoBoardDTO infodto = adminDAO.getInfoContent(num);
		return infodto;
	}
	// 공지사항 글쓰기 pro (유찬)
	@Override
	public void addInfo(InfoBoardDTO infodto) throws SQLException {
		adminDAO.addInfo(infodto);	
	}
	// 공지사항 수정 (유찬)
	@Override
	public void updateInfo(InfoBoardDTO infodto) throws SQLException {
		adminDAO.updateInfo(infodto);
	}
	// 공지사항 삭제(유찬)
	@Override
	public int deleteInfo(int num1) throws SQLException {
		int result = adminDAO.deleteInfo(num1);
		return result;
	}

	// 회원 목록 조회(혜선)
		@Override
		public Map<String, Object> memberInfo(String pageNum, String sel, String sort) throws SQLException {
			System.out.println(sort);
			int pageSize = 5; 
			if(pageNum == null || pageNum == "") pageNum = "1";
			if(sel == null || sel == "") sel = null;

			int currentPage = Integer.parseInt(pageNum); 
			int startRow = (currentPage - 1) * pageSize + 1; 
			int endRow = currentPage * pageSize; 
			int count =0;
			List<MemberInfoDTO> redto =null;
			count = adminDAO.getMemberInfoCount();   
			if(count > 0)
			redto = adminDAO.memberInfo(startRow, endRow,sel,sort);

			int listSize = redto.size();

			Map<String, Object> result = new HashMap<>();
			result.put("pageSize", pageSize);
			result.put("pageNum", pageNum);
			result.put("currentPage", currentPage);
			result.put("startRow", startRow);
			result.put("endRow", endRow);
			result.put("count", count);
			result.put("listSize",listSize);
			result.put("sel", sel);
			result.put("sort", sort);
			result.put("redto", redto);

			return result;
		}
		//회원목록 검색(혜선)
		@Override
		public Map<String, Object> memberInfoSearch(String pageNum, String sel2, String search) throws SQLException {

			int pageSize = 5; 
			if(pageNum == null || pageNum == "") pageNum = "1";

			int currentPage = Integer.parseInt(pageNum); 
			int startRow = (currentPage - 1) * pageSize + 1; 
			int endRow = currentPage * pageSize; 
			int count =0;
			List<MemberInfoDTO> redto =null;
			count = adminDAO.getMemberSearchCount(sel2, search);   
			if(count > 0)
				redto = adminDAO.memberInfoSearch(sel2, search, startRow, endRow);

			int listSize = redto.size();

			Map<String, Object> result = new HashMap<>();
			result.put("pageSize", pageSize);
			result.put("pageNum", pageNum);
			result.put("currentPage", currentPage);
			result.put("startRow", startRow);
			result.put("endRow", endRow);
			result.put("count", count);
			result.put("listSize",listSize);
			result.put("sel2", sel2);
			result.put("search", search);
			result.put("redto", redto);

			return result;
		}
		
		// qna 목록 조회(혜선)
		@Override
		public Map<String, Object> adminQna(String pageNum, String sel, String sort) throws SQLException {
			
			int pageSize = 5; 
			if(pageNum == null || pageNum == "") pageNum = "1";
			if(sel == null || sel == "") sel = null;
			
			int currentPage = Integer.parseInt(pageNum); 
			int startRow = (currentPage - 1) * pageSize + 1; 
			int endRow = currentPage * pageSize; 
			int count =0;
			List<AdminQnaDTO> redto =null;
			count = adminDAO.getAdminQnaCount();   
			if(count > 0)
			redto = adminDAO.adminQna(startRow, endRow,sel,sort);
			
			int listSize = redto.size();
			
			Map<String, Object> result = new HashMap<>();
			result.put("pageSize", pageSize);
			result.put("pageNum", pageNum);
			result.put("currentPage", currentPage);
			result.put("startRow", startRow);
			result.put("endRow", endRow);
			result.put("count", count);
			result.put("listSize",listSize);
			result.put("sel", sel);
			result.put("sort", sort);
			result.put("redto", redto);
			
			return result;
		}
	
		//qna 검색(혜선)
		@Override
		public Map<String, Object> adminQnaSearch(String pageNum, String sel2, String search) throws SQLException {

			int pageSize = 5; 
			if(pageNum == null || pageNum == "") pageNum = "1";

			int currentPage = Integer.parseInt(pageNum); 
			int startRow = (currentPage - 1) * pageSize + 1; 
			int endRow = currentPage * pageSize; 
			int count =0;
			List<AdminQnaDTO> redto =null;
			count = adminDAO.getAdminQnaSearchCount(sel2, search);   
			if(count > 0)
				redto = adminDAO.adminQnaSearch(sel2, search, startRow, endRow);

			int listSize = redto.size();

			Map<String, Object> result = new HashMap<>();
			result.put("pageSize", pageSize);
			result.put("pageNum", pageNum);
			result.put("currentPage", currentPage);
			result.put("startRow", startRow);
			result.put("endRow", endRow);
			result.put("count", count);
			result.put("listSize",listSize);
			result.put("sel2", sel2);
			result.put("search", search);
			result.put("redto", redto);

			return result;
		}
		
		// qna 글 1개 정보 가져오기 (혜선)
		@Override
		public AdminQnaDTO qnaReplyForm(int num) throws SQLException {
			// 해당 글 정보 가져오기 
			AdminQnaDTO qnaboard = adminDAO.qnaReplyForm(num); 
			return qnaboard;
			}
		
		// qna 답글(혜선)
		@Override
		public int writeQnaReply(AdminQnaDTO dto) throws SQLException {
			int result = adminDAO.writeQnaReply(dto);
			return result;
		}
		
		
		// 회원정보 subadminupdate(유찬)
		@Override
		public int subAdminUpdate(String userId, String subAdmin) throws SQLException {
			int result = adminDAO.subAdminUpdate(userId, subAdmin);
			return result;
		}
		
		// 관리자 회원정보 조회(민수)
		@Override
		public MemberDTO getMemberInfo(String nickname) throws SQLException {
			return adminDAO.getMemberInfo(nickname);
		}
		
		// 관리자 운전자 승인(민수)
		@Override
		public int acceptDriver(String nickname) throws SQLException {
			return adminDAO.acceptDriver(nickname);
		}
		
		// 관리자 운전자 반려(민수)
		@Override
		public int denyDriver(String nickname) throws SQLException {
			return adminDAO.denyDriver(nickname);
		}
		
		// 관리자 카풀 조회(민수)
		@Override
		public RefundDTO getCarpoolInfo(int carpoolnum) throws SQLException {
			return adminDAO.getCarpoolInfo(carpoolnum);
		}
		
		// 관리자 환급 처리(민수)
		@Override
		public int refundCarpool(int carpoolnum) throws SQLException {
			return adminDAO.refundCarpool(carpoolnum);
		}
}
