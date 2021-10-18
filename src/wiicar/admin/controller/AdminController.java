package wiicar.admin.controller;

import java.sql.SQLException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import wiicar.admin.dto.AdminQnaDTO;
import wiicar.admin.dto.InfoBoardDTO;
import wiicar.admin.dto.RefundDTO;
import wiicar.admin.service.AdminServiceImpl;

@Controller
@RequestMapping("/admin/*")
public class AdminController {
	
	@Autowired
	private AdminServiceImpl adminService = null;
	
	//(윤지) 관리자 카풀조회
	@RequestMapping("carpoolLookup.do")
	public String carpoolLookup(String pageNum,String sel2, String search, Model model) throws SQLException {
		
		Map<String, Object> result =null;
		if(sel2 != null && search !=null) {
			result = adminService.carpoolSearch(pageNum, sel2, search);
			model.addAttribute("sel2", result.get("sel2"));		
			model.addAttribute("search", result.get("search"));
		}
		if(sel2 == null && search ==null) {
			 result = adminService.carpoolLookup(pageNum);
		}
		model.addAttribute("cardto", result.get("cardto"));
		model.addAttribute("pageSize", result.get("pageSize"));
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("count", result.get("count"));
		model.addAttribute("currentPage", result.get("currentPage"));
		model.addAttribute("startRow", result.get("startRow"));
		model.addAttribute("endRow", result.get("endRow"));
		model.addAttribute("listSize",result.get("listSize"));
		
		return "admin/carpoolLookup";
	}
	
	//(유찬) 관리자 운전자 환급 조회
	@RequestMapping("refundLookup.do")
	public String refund(String pageNum,String sel2, String search, String sel, String sort ,Model model) throws SQLException {
		
		Map<String, Object> result =null;
		
		if(sel2 != null && search !=null) {
			if(sel2.equals("content1")) sel2 = "content";
			result = adminService.refundSearch(pageNum, sel2, search);
			model.addAttribute("sel2", result.get("sel2"));		
			model.addAttribute("search", result.get("search"));
		}
		if(sel2 == null && search == null) {
			result = adminService.refundLookup(pageNum, sel, sort);
			model.addAttribute("sel", result.get("sel"));		
			model.addAttribute("sort", result.get("sort"));	
		}
		model.addAttribute("refdto", result.get("refdto"));
		model.addAttribute("pageSize", result.get("pageSize"));
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("count", result.get("count"));
		model.addAttribute("currentPage", result.get("currentPage"));
		model.addAttribute("startRow", result.get("startRow"));
		model.addAttribute("endRow", result.get("endRow"));
		model.addAttribute("listSize",result.get("listSize"));
		
		return "admin/refundLookup";
	}
	
	//(유찬) 관리자 신고목록 정렬 및 검색
	@RequestMapping("reportsLookup.do")
	public String reportsLookup(String pageNum, String sel, String sort, String sel2, String search ,Model model) throws SQLException{		
		// 신고 목록 가져오기
		Map<String, Object> result = null;
		
		if(sel2 != null && search !=null) {
			if(sel2.equals("content1")) sel2 = "content";
			result = adminService.reportSearch(pageNum, sel2, search);
			model.addAttribute("sel2", result.get("sel2"));		
			model.addAttribute("search", result.get("search"));	
		}
		if(sel2 == null && search ==null) {
			result = adminService.reportsLookup(pageNum, sel, sort);
			model.addAttribute("sel", result.get("sel"));		
			model.addAttribute("sort", result.get("sort"));	
		}	

		model.addAttribute("redto", result.get("redto"));
		model.addAttribute("pageSize", result.get("pageSize"));
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("currentPage", result.get("currentPage"));
		model.addAttribute("startRow", result.get("startRow"));
		model.addAttribute("endRow", result.get("endRow"));
		model.addAttribute("count", result.get("count"));
		model.addAttribute("listSize",result.get("listSize"));
		
		return "admin/reportsLookup";
	}
	
	//(유찬) 관리자 신고대상 처리
	@ResponseBody
	@RequestMapping("reportResult.do")
	public int reportResult(@RequestBody Map<Object, Object> map) throws SQLException{
		String value = (String)map.get("value");
		String reportId =(String)map.get("reportId");
		String Id = (String)map.get("Id");
		int result = adminService.reportResult(value, reportId, Id);
		return result;
	}
	
	// (유찬) 공지사항
	@RequestMapping("infoBoard.do")
	public String infoBoard(Model model, String pageNum) throws SQLException{
		Map<String, Object> result = adminService.getInfoBoard(pageNum);
		
		model.addAttribute("infodto", result.get("infodto"));
		model.addAttribute("pageSize", result.get("pageSize"));
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("currentPage", result.get("currentPage"));
		model.addAttribute("startRow", result.get("startRow"));
		model.addAttribute("endRow", result.get("endRow"));
		model.addAttribute("count", result.get("count"));
		model.addAttribute("listSize",result.get("listSize"));
		
		return "admin/infoBoard";
	}
	
	// (유찬) 공지사항 content
	@RequestMapping("infoContent.do")
	public String infoContent(Model model,int num) throws SQLException{
		
		InfoBoardDTO infodto = adminService.getInfoContent(num);
		model.addAttribute("infodto", infodto);
		return "admin/infoContent";
	}
	
	// (유찬) 공지사항 글쓰기
	@RequestMapping("infoWriteForm.do")
	public String infoWriteBoard() {
		return "admin/infoWriteForm";
	}
	
	// (유찬) 공지사항 글쓰기 pro
	@RequestMapping("infoWritePro.do")
	public String infoWritePro(HttpServletRequest request,InfoBoardDTO infodto) throws SQLException {
		HttpSession session = request.getSession();
		infodto.setWriter((String)session.getAttribute("sid"));
		adminService.addInfo(infodto);
		return "redirect:/admin/infoBoard.do";
	}
	
	// (유찬) 공지사항 수정Form
	@RequestMapping("infoModifyForm.do")
	public String infoModifyForm(Model model,int num) throws SQLException{
		InfoBoardDTO infodto = adminService.getInfoContent(num);
		model.addAttribute("infodto", infodto);
		return "admin/infoModifyForm";
	}
	
	// (유찬) 공지사항 글쓰기 pro
	@RequestMapping("infoModifyPro.do")
	public String infoModifyPro(HttpServletRequest request,InfoBoardDTO infodto) throws SQLException {
		HttpSession session = request.getSession();
		infodto.setWriter((String)session.getAttribute("sid"));
		adminService.updateInfo(infodto);
		return "redirect:/admin/infoBoard.do";
	}
	
	// (유찬) 공지사항 삭제
	@ResponseBody
	@RequestMapping("infoDelete.do")
	public int infoDelete(@RequestBody String num) throws SQLException{
		int num1 = Integer.parseInt(num);
		int result = adminService.deleteInfo(num1);
		return result;
	}

	//(혜선) 관리자 회원 목록 조회 및 정렬
		@RequestMapping("memberInfo.do")
		public String memberInfo(String pageNum, String sel, String sort, String sel2 , String search, Model model) throws SQLException{		
			// 회원 목록 가져오기
			Map<String, Object> result = null;
			
			if(sel2 != null && search !=null) {
				result = adminService.memberInfoSearch(pageNum, sel2, search);
				model.addAttribute("sel2", result.get("sel2"));		
				model.addAttribute("search", result.get("search"));	
			}
			if(sel2 == null && search ==null) {
				result = adminService.memberInfo(pageNum, sel, sort);
				model.addAttribute("sel", result.get("sel"));		
				model.addAttribute("sort", result.get("sort"));	
			}	
			
			model.addAttribute("redto", result.get("redto"));
			model.addAttribute("pageSize", result.get("pageSize"));
			model.addAttribute("pageNum", pageNum);
			model.addAttribute("currentPage", result.get("currentPage"));
			model.addAttribute("startRow", result.get("startRow"));
			model.addAttribute("endRow", result.get("endRow"));
			model.addAttribute("count", result.get("count"));
			model.addAttribute("listSize",result.get("listSize"));
			return "admin/memberInfo";
		}
		
		//(혜선) 관리자 qna 목록 조회 및 검색, 정렬
		@RequestMapping("adminQna.do")
		public String adminQna(String pageNum, String sel, String sort, String sel2 , String search , Model model) throws SQLException{	
		
			// qna 목록 가져오기
			Map<String, Object> result = null;
			
			if(sel2 != null && search !=null) {
				result = adminService.adminQnaSearch(pageNum, sel2, search);
				model.addAttribute("sel2", result.get("sel2"));		
				model.addAttribute("search", result.get("search"));	
			}
			if(sel2 == null && search ==null) {
				result = adminService.adminQna(pageNum, sel, sort);
				model.addAttribute("sel", result.get("sel"));		
				model.addAttribute("sort", result.get("sort"));	
			}	
			
			model.addAttribute("redto", result.get("redto"));
			model.addAttribute("pageSize", result.get("pageSize"));
			model.addAttribute("pageNum", pageNum);
			model.addAttribute("currentPage", result.get("currentPage"));
			model.addAttribute("startRow", result.get("startRow"));
			model.addAttribute("endRow", result.get("endRow"));
			model.addAttribute("count", result.get("count"));
			model.addAttribute("listSize",result.get("listSize"));
			return "admin/adminQna";
			
		}
		
		/* 관리자 qna 관리 페이지 !!!!!!*/
		// 답변하기 버튼을 눌렀을때 qna 1개에 해당되는 데이터들과 함꼐 contents 띄워주기(select)
		@RequestMapping("qnaReplyForm.do")
		public String qnaReplyForm(HttpServletRequest request, Model model) throws SQLException {
			int num = 0;
			if(request.getParameter("num") != null){ // 넘어온 파라미터중 num으로 새글작성인지 답글작성인지 판단 
				// 정보 담기 
				num = Integer.parseInt(request.getParameter("num"));  // 31
			}
			model.addAttribute("num", num);
			AdminQnaDTO qnaboard = adminService.qnaReplyForm(num);
			model.addAttribute("qnaboard",qnaboard);
			
			return "admin/qnaReplyForm";
		}
		
		// 그 contents 안에 답변한 후 reply_content 저장하기(update) qnaReplyPro
		@RequestMapping("qnaReplyPro.do")
		public String modifyPro(AdminQnaDTO dto, Model model) throws SQLException {
			
			int result = adminService.writeQnaReply(dto);
			model.addAttribute("result", result);
			System.out.println(result);
			return "redirect:/admin/adminQna.do";
		}
		// 회원정보 조회 관리자 권한부여 (유찬)
		@ResponseBody
		@RequestMapping("subAdminUpdate.do")
		public int subAdminUpdate(@RequestBody Map<Object, Object> map) throws SQLException{
			String userId = (String)map.get("userId");
			String subAdmin = (String)map.get("subAdmin");
			int result = adminService.subAdminUpdate(userId, subAdmin);
			
			return result;
		}

		// 관리자 회원정보 조회(민수)
		@RequestMapping("authorizeDriverPopup")
		public String authorizeDriverPopup(String nickname, Model model) throws SQLException {
			model.addAttribute("profileImage", adminService.getMemberInfo(nickname).getProfileImage());
			model.addAttribute("nickname", nickname);
			return "admin/authorizeDriver";
		}
		
		// 관리자 운전자 승인(민수)
		@RequestMapping("acceptDriver")
		public ResponseEntity<Integer> acceptDriver(String nickname) throws SQLException {
			HttpHeaders respHeader = new HttpHeaders();
			respHeader.add("Content-type", "test/html;charset=utf-8");
			return new ResponseEntity<Integer>(adminService.acceptDriver(nickname), respHeader, HttpStatus.OK);
		}
		
		// 관리자 운전자 보류(민수)
		@RequestMapping("denyDriver")
		public ResponseEntity<Integer> denyDriver(String nickname) throws SQLException {
			HttpHeaders respHeader = new HttpHeaders();
			respHeader.add("Content-type", "test/html;charset=utf-8");
			return new ResponseEntity<Integer>(adminService.denyDriver(nickname), respHeader, HttpStatus.OK);
		}
		
		// 관리자 환급 팝업(민수)
		@RequestMapping("refundPopup")
		public String refundPopup(int carpoolnum, Model model) throws SQLException {
			model.addAttribute("refund", adminService.getCarpoolInfo(carpoolnum));
			return "admin/refundPopup";
		}
		
		// 관리자 환급 처리(민수)
		@RequestMapping("refundCarpool")
		public ResponseEntity<Integer> refundCarpool(int carpoolnum) throws SQLException {
			HttpHeaders respHeader = new HttpHeaders();
			respHeader.add("Content-type", "test/html;charset=utf-8");
			return new ResponseEntity<Integer>(adminService.refundCarpool(carpoolnum), respHeader, HttpStatus.OK);
		}
		
}
