package wiicar.member.controller;

import java.io.File;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Map;
import org.apache.http.protocol.ResponseDate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import wiicar.member.dto.MemberDTO;
import wiicar.member.service.MemberServiceImpl;

@Controller
@RequestMapping("/member/*")
public class MemberController {

	@Autowired
	private MemberServiceImpl memberService = null;

	// 개인정보 조회
	@RequestMapping("personalInformation.do")
	public String personalInformation(Model model) throws SQLException {
		MemberDTO dto = memberService.getMemberInfo();
		model.addAttribute("member", dto);
		return "member/personalInformation";
	}
	
	// 비밀번호 확인
	@RequestMapping("checkUserPw.do")
	public ResponseEntity<String> checkPw(String pw) throws SQLException {
		HttpHeaders respHeader = new HttpHeaders();
		respHeader.add("Content-type", "test/html;charset=utf-8");
		return new ResponseEntity<String>(memberService.checkUserPw(pw) + "", respHeader, HttpStatus.OK);
	}

	// 개인정보 수정 페이지
	@RequestMapping("modifyPersonalInformation.do")
	public String modifyPersonalInformation(Model model) throws SQLException {
		MemberDTO dto = memberService.getMemberInfo();
		model.addAttribute("member", dto);		
		return "member/modifyPersonalInformation";
	}
	
	// 개인정보 수정 Ajax
	@RequestMapping("ajaxUpdateMember.do")
	public void ajaxUpdateMember(MemberDTO dto) throws SQLException {
		System.out.println(dto.getBankNo());
		memberService.updateMemberInfo(dto);
	}
	
	// 파일 수정
	@RequestMapping(value="ajaxUpdateImage", method=RequestMethod.POST)
	public String uploadImage(MultipartHttpServletRequest request) throws SQLException {
		System.out.println("파일 업로드");
		String type = "";
		if(request.getFile("profileImageMR") != null) {
			type = "profileImageMR";
		} else {
			type = "licenseImageMR";
		}
		System.out.println(request.getFile(type));
		String newName = "";
		try {
			MultipartFile mf = request.getFile(type);
			String path = request.getRealPath("imgs");
			// **************** realPath 이상해서 수정
			path = path.substring(0, path.lastIndexOf("\\")) + "\\resources" + path.substring(path.lastIndexOf('\\'));
			// ***************************************
			String orgName = mf.getOriginalFilename();
			String imgName = orgName.substring(0, orgName.lastIndexOf("."));
			String ext = orgName.substring(orgName.lastIndexOf("."));
			long millis = System.currentTimeMillis();
			newName = imgName + millis + ext;
			String imgPath = path + "\\" + newName;
			File f = new File(imgPath);
			mf.transferTo(f);
		} catch(Exception e) {
			e.printStackTrace();
		}
		System.out.println(newName);
		
		memberService.updateImage(newName, type.substring(0, type.length() - 2));
		return newName;
	}
	

	// 운전자 예약리스트
	@RequestMapping("driverReserv.do")
	public String DriverReserv(String pageNum, Model model) throws SQLException{

		Map<String, Object> result = memberService.getDriversReservation(pageNum);
		model.addAttribute("reservationList", result.get("reservationList"));
		model.addAttribute("carpoolInfo", result.get("carpoolInfo"));
		model.addAttribute("pageSize", result.get("pageSize"));
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("currentPage", result.get("currentPage"));
		model.addAttribute("startRow", result.get("startRow"));
		model.addAttribute("endRow", result.get("endRow"));
		model.addAttribute("listSize",result.get("listSize"));
		model.addAttribute("rate", result.get("rate"));
		model.addAttribute("passangerNickname", result.get("passangerNickname"));
		model.addAttribute("passengerIamges", result.get("passengerIamges"));				
		model.addAttribute("roomNum", result.get("roomNum"));		
		System.out.println("RoomNum : " + result.get("roomNum"));

		return "myCarpool/driverReservationList";
	}
	

	// 운전자 예정 리스트
	@RequestMapping("driverUpComming.do")
	public String DriverUpComming(String pageNum, Model model) throws SQLException{
		
		Map<String, Object> result = memberService.getDriversUpcomeList(pageNum);
		
		model.addAttribute("carpoolList", result.get("carpoolList"));
		model.addAttribute("reservationsList", result.get("reservationsList"));
		model.addAttribute("count", result.get("count"));
		model.addAttribute("driver", result.get("driver"));
		model.addAttribute("reviewCheck", result.get("reviewCheck"));
		model.addAttribute("passengers", result.get("passengers"));
		model.addAttribute("pageSize", result.get("pageSize"));
		model.addAttribute("pageNum", result.get("pageNum"));
		model.addAttribute("currentPage", result.get("currentPage"));
		model.addAttribute("startRow", result.get("startRow"));
		model.addAttribute("endRow", result.get("endRow"));
		
		return "myCarpool/driverUpComeList";
	}
	// 운전자 지난 카풀
	@RequestMapping("driverPast.do")
	public String DriverPast(String pageNum, Model model) throws SQLException{
		
		Map<String, Object> result = memberService.getDriversPastList(pageNum);
		
		model.addAttribute("carpoolList", result.get("carpoolList"));
		model.addAttribute("reservationsList", result.get("reservationsList"));
		model.addAttribute("count", result.get("count"));
		model.addAttribute("driver", result.get("driver"));
		model.addAttribute("reviewCheck", result.get("reviewCheck"));
		model.addAttribute("passengers", result.get("passengers"));
		model.addAttribute("pageSize", result.get("pageSize"));
		model.addAttribute("pageNum", result.get("pageNum"));
		model.addAttribute("currentPage", result.get("currentPage"));
		model.addAttribute("startRow", result.get("startRow"));
		model.addAttribute("endRow", result.get("endRow"));
		
		return "myCarpool/driverPastList";
	}
	
	// 탑승자 카풀리스트 (sort별로 나눠서 실행됨)
	@RequestMapping("passangerMyCarpool.do")
	public String PassangerMyCarpool(String sort, Model model) throws SQLException{
		
		String page = "";
		System.out.println("sort : " + sort);
		Map<String, Object> result = null;
		
		if(sort.equals("reservation")) { 
			page = "myCarpool/passangerReservationList";
			result = memberService.getPassangerReservation();
			System.out.println("탑승자 예약");
			
		}else if(sort.equals("upcomming")){
			page = "myCarpool/passangerUpCommingList";
			System.out.println("탑승자 예정");
			result = memberService.getPassangersCarpoolList(sort);
			
		}else if(sort.equals("past")) {
			page =  "myCarpool/passangerPastList";
			System.out.println("탑승자 지난");
			result = memberService.getPassangersCarpoolList(sort);
		}
	
		
		System.out.println(result.get("carpoolList"));
		model.addAttribute("carpoolList", result.get("carpoolList"));
		model.addAttribute("reservationList", result.get("reservationList"));
		model.addAttribute("listSize", result.get("listSize"));
		model.addAttribute("rate", result.get("rate"));
		model.addAttribute("nickname", result.get("nickname"));
		model.addAttribute("driverImage", result.get("driverImage"));
		model.addAttribute("passengerIamges", result.get("passengerIamges"));
		model.addAttribute("passengerId", result.get("passengerId"));
		model.addAttribute("passengercount", result.get("passengercount"));
		model.addAttribute("like", result.get("like"));
		model.addAttribute("reviewCheck", result.get("reviewCheck"));
		model.addAttribute("roomNumber", result.get("roomNumber"));
		model.addAttribute("tagList", result.get("tagList"));
		
		return page;
	}


	// 회원 탈퇴
	@RequestMapping("deleteMember.do")
	public void deleteMember() throws SQLException {
		System.out.println("회원탈퇴");
		memberService.deleteMember();
	}
	
	// 내 프로필
	@RequestMapping("myProfile.do")
	public String myProfile(Model model) throws SQLException {
		
		Map<String, Object> result = null;
		
		result = memberService.getMyProfile();
		
		model.addAttribute("carModel", result.get("carModel"));
		model.addAttribute("preference", result.get("preference"));
		model.addAttribute("carpoolrecord", result.get("carpoolrecord"));
		model.addAttribute("carpoolused", result.get("carpoolused"));
		model.addAttribute("reportcount", result.get("reportcount"));
		model.addAttribute("age", result.get("age"));
		model.addAttribute("dto", result.get("dto"));
		model.addAttribute("passengerReview", result.get("passengerReview"));
		model.addAttribute("passengerReviewCount", result.get("passengerReviewCount"));
		model.addAttribute("passengerReviewImgs", result.get("passengerReviewImgs"));
		model.addAttribute("driverReview", result.get("driverReview"));
		model.addAttribute("driverReviewCount", result.get("driverReviewCount"));
		model.addAttribute("driverReviewImgs", result.get("driverReviewImgs"));
		
		
		return "member/myprofile";
	}
	
	// 관심 카풀
	@RequestMapping("myLikeCarpool.do")
	public String myLikeCarpool(String pageNum, String sel, String sort, Model model) throws SQLException {
		
		Map<String, Object> result = null;
		
		result = memberService.getLikeCarpoolList(pageNum, sel, sort);
		
		model.addAttribute("carpoolList", result.get("carpoolList"));
		model.addAttribute("pageSize", result.get("pageSize"));
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("currentPage", result.get("currentPage"));
		model.addAttribute("startRow", result.get("startRow"));
		model.addAttribute("endRow", result.get("endRow"));
		model.addAttribute("carpoolList", result.get("carpoolList"));
		model.addAttribute("count", result.get("count"));
		model.addAttribute("listSize",result.get("listSize"));
		model.addAttribute("tagList", result.get("tagList"));
		model.addAttribute("rate", result.get("rate"));
		model.addAttribute("nickname", result.get("nickname"));
		model.addAttribute("passengerIamges", result.get("passengerIamges"));		
		model.addAttribute("passengerId", result.get("passengerId"));		
		model.addAttribute("passengercount", result.get("passengercount"));		
		model.addAttribute("sel", result.get("sel"));		
		model.addAttribute("sort", result.get("sort"));		
		model.addAttribute("driverImage", result.get("driverImage"));		
		model.addAttribute("like", result.get("like"));		
		
		return "member/myLikeCarpool";
	}
	
	// 월정액
	@RequestMapping("subscription.do")
	public String subscription(Model model) throws SQLException {
		
		Timestamp subscription = memberService.getMySubscription();
		
		model.addAttribute("subscription",subscription);
		
		return "member/subscription";
	}
	
	// 일반회원, 관리자 회원 체크(유찬)
	@ResponseBody
	@RequestMapping("memberCheck.do")
	public MemberDTO MemberCheck() throws SQLException{
		MemberDTO dto = memberService.getMemberInfo();
		return dto;
	}	
	
	// 마이페이지 내 카풀 탑승자 입장에서 -> 채팅방
	@ResponseBody
	@RequestMapping("driverContact.do")
	public int driverContact(@RequestBody Map<Object, Object> map) throws SQLException{
		String userId = (String)map.get("userId");
		String chatId = (String)map.get("chatId");
		int roomnum = memberService.driverContact(userId, chatId);
		return roomnum;
	}


	@RequestMapping("reviewModal.do")
	public String reviewModal(String type, String num, String id, Model model) {
		model.addAttribute("id",id);
		model.addAttribute("type",type);
		model.addAttribute("num",num);
		return "popup/reviewPopup";
	}
	
	@RequestMapping("reviewInsert.do")
	public void reviewInsert(String type, String num, String id, int rate, String content) throws SQLException {
		memberService.reviewInsert(type, num, id, rate, content);
	}
}

