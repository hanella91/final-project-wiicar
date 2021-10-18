package wiicar.carpool.controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import wiicar.carpool.dto.CarpoolDTO;
import wiicar.carpool.service.CarpoolServiceImpl;
import wiicar.carpool.service.SearchServiceImpl;
import wiicar.member.dto.MemberDTO;
import wiicar.member.service.MemberServiceImpl;

@Controller
@RequestMapping("/carpool/*")
public class CarpoolController {

	@Autowired
	private CarpoolServiceImpl carpoolService = null;
	@Autowired
	private SearchServiceImpl searchService = null;
	@Autowired 
	private MemberServiceImpl memberService = null;

 
	// 카풀 등록폼 요청 메서드
	@GetMapping("registerForm.do")
	public String registerForm() {
		return "registerForm";
	}
	// 카풀 등록 처리 요청 메서드
	@PostMapping("registerPro.do")
	
	public String registerPro(HttpServletRequest request,CarpoolDTO dto) throws SQLException{
		System.out.println("registerPro요청");
		HttpSession session = request.getSession();
		String driverId = (String)session.getAttribute("sid");
		dto.setDriverId(driverId);
		carpoolService.addCarpool(dto);
		return "redirect:/carpool/carpoolList.do";
	}
	// 카풀 리스트
	@RequestMapping("carpoolList.do")
	public String carpoolList(@RequestParam HashMap<String, String> input, Model model) throws SQLException{
		System.out.println("CarpoolList.do 실행");
		System.out.println("input : " + input.get("depart"));
		Map<String, Object> result = null;
		String pageNum = input.get("pageNum");
		String orderby = input.get("orderby");
		
		if(input.get("orderby") == null)
		orderby = "reg_DESC";

		// 사용자 정보 가져오기
		MemberDTO userdto = memberService.getMemberInfo();
		if(input.get("depart") == null || input.get("destination") == null || input.get("time") == null) {
			System.out.println("getCarpoolList 실행");
			result = carpoolService.getCarpoolList(pageNum, orderby);
		}else {
			System.out.println("getSearchedCarpoolList 실행");
			result = searchService.getSearchedCarpoolList(input);
		}
		
		System.out.println("result : " + result.get("resultSize"));
		model.addAttribute("userdto", userdto);
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
		model.addAttribute("driverImage", result.get("driverImage"));		
		model.addAttribute("like", result.get("like"));		
		model.addAttribute("max", result.get("max"));	
		model.addAttribute("orderby", result.get("orderby"));
		model.addAttribute("input", input);
		return "carpoolpay/carpoolList";
	}
	
	// 검색된 카풀 리스트
	@RequestMapping("searchList.do")
	public String searchList(@RequestParam HashMap<String, String> input, Model model) throws SQLException{
		System.out.println("CarpoolList.do 실행");
		System.out.println("input : " + input.get("depart"));
		Map<String, Object> result = null;
		String pageNum = input.get("pageNum");
		String orderby = input.get("orderby");
		
		if(input.get("orderby") == null)
		orderby = "reg_DESC";

		// 사용자 정보 가져오기
		MemberDTO userdto = memberService.getMemberInfo();
	
		System.out.println("getSearchedCarpoolList 실행");
		result = searchService.getSearchedCarpoolList(input);
		
		System.out.println("result : " + result.get("resultSize"));
		model.addAttribute("userdto", userdto);
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
		model.addAttribute("driverImage", result.get("driverImage"));		
		model.addAttribute("like", result.get("like"));		
		model.addAttribute("max", result.get("max"));	
		model.addAttribute("orderby", result.get("orderby"));
		model.addAttribute("input", input);
		return "carpoolpay/searchList";
	}
	
	
	@RequestMapping("checkLike.do")
	public String checkLike(int carpoolNum) {
		carpoolService.checkLike(carpoolNum);
		return "{\"result\":\"NO\"}";
	}
	
	@RequestMapping("profilePopup.do") 
	public String profilePopup(String id, Model model){
		
		Map<String, Object> result = null;
		
		result = carpoolService.getUserProfile(id);
		
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
		
		return "popup/userProfilePopup";
	}
	
	@RequestMapping("requestPopup.do")
	public String requestPopup(int num, Model model) {
		
		Map<String, Object> result = null;
		result = carpoolService.getReqeust(num);
		
		model.addAttribute("dto", result.get("dto"));
		model.addAttribute("tags", result.get("tags"));
		
		return "carpoolpay/request";
	}

}