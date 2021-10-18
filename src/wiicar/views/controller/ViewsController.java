package wiicar.views.controller;

import java.io.File;
import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import wiicar.member.dto.MemberDTO;
import wiicar.member.service.MemberServiceImpl;

@Controller
@RequestMapping("/*")
public class ViewsController {

	@Autowired
	private MemberServiceImpl memberService = null;
	
	// 로그인 팝업
	@RequestMapping("loginPopup.do")
	public String loginPopup() {
		System.out.println("로그인 팝업");
		return "loginPopup";
	}
		
	// 카카오 로그인
	@RequestMapping("kakaoLogin.do")
	public String kakaoLogin() throws SQLException {
		System.out.println("카카오 로그인");
		return "kakaoLogin";
	}
	
	// AJAX 회원 조회
	@RequestMapping("ajaxKakaoLoginIdPwCheck.do")
	public ResponseEntity<String> ajaxKakaoLoginIdPwCheck(MemberDTO dto) throws SQLException {
		System.out.println("AJAX 회원 조회");
		HttpHeaders respHeaders = new HttpHeaders();
		respHeaders.add("Content-type", "test/html;charset=utf-8");
		return new ResponseEntity<String>(memberService.checkUserId(dto) + "", respHeaders, HttpStatus.OK); 
	}
	
	// 로그인
	@RequestMapping("login.do")
	public String login() {
		System.out.println("로그인");
		return "login";
	}
	
	// 세션 아이디
	@RequestMapping("sessionId.do") 
	public String sessionId(String id) throws SQLException {
		System.out.println("세션 닉네임 만들기");
		memberService.sessionNickname(id);
		memberService.sessionSubsription();
		return "home";
	}
	
	// 회원가입 폼
	@RequestMapping("signupForm.do")
	public String signupForm(Model model) throws SQLException {
		System.out.println("회원가입 폼");
		if(memberService.checkLogin() == 1) {
			model.addAttribute("member", memberService.getMemberInfo());
		} 
		return "signupForm";
	}
	
	// 회원가입 처리
	@RequestMapping("signupPro.do")
	public String signupPro(MemberDTO dto, MultipartHttpServletRequest request) throws SQLException {
		System.out.println("회원가입 처리");
		if(!request.getFile("profileImageMR").getOriginalFilename().equals("")) {
			dto.setProfileImage(uploadFile("profileImageMR", request));
		}
		if(!request.getFile("licenseImageMR").getOriginalFilename().equals("")) {
			dto.setLicenseImage(uploadFile("licenseImageMR", request));
		}
		memberService.insertUser(dto);
		return "redirect:home.do";
	}

	// 파일 업로드
	public String uploadFile(String img, MultipartHttpServletRequest request) {
		System.out.println("파일 업로드");
		String newName = "";
		try {
			MultipartFile mf = request.getFile(img);
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
		return newName;
	}
	
	// 전화번호 인증
	@RequestMapping("verifyPhone.do")
	public ResponseEntity<String> verifyPhone(String phone) {
		HttpHeaders respHeaders = new HttpHeaders();
		respHeaders.add("Content-type", "test/html;charset=utf-8");
		return new ResponseEntity<String>(memberService.verifyPhone(phone), respHeaders, HttpStatus.OK); 
	}
	
	// 로그아웃
	@RequestMapping("logout.do")
	public void logout() {
		System.out.println("로그아웃");
		memberService.logout();
	}
	
	// 닉네임 중복확인
	@RequestMapping("checkNickname.do")
	public ResponseEntity<String> checkNickname(String nickname) throws SQLException {
		HttpHeaders respHeader = new HttpHeaders();
		respHeader.add("Content-type", "test/html;charset=utf-8");
		return new ResponseEntity<String>(memberService.checkNickname(nickname) + "", respHeader, HttpStatus.OK);		
	}
	
	// 관리자 로그인 팝업
	@RequestMapping("adminLoginPopup.do")
	public String adminLoginPopup() {
		return "adminLoginPopup";
	}
	
	// 관리자 로그인 처리
	@RequestMapping("loginPro.do")
	public ResponseEntity<Integer> adminLoginPro(String nickname, String pw) throws SQLException {
		HttpHeaders respHeader = new HttpHeaders();
		respHeader.add("Content-type", "test/html;charset=utf-8");
		return new ResponseEntity<Integer>(memberService.adminLoginPro(nickname, pw), respHeader, HttpStatus.OK);		
	}
	
	// 관리자 여부 확인
	@RequestMapping("checkAdmin.do")
	public ResponseEntity<Integer> checkAdmin() throws SQLException {
		HttpHeaders respHeader = new HttpHeaders();
		respHeader.add("Content-type", "test/html;charset=utf-8");
		return new ResponseEntity<Integer>(memberService.checkAdmin(), respHeader, HttpStatus.OK);		
	}
	
	// 일반 로그인 확인
	@RequestMapping("loginPage.do")
	public String loginPage() {
		return "loginPage";		
	}
	
	// **************************testNickname
	@RequestMapping("sessionTest.do")
	public void sessionTest(String nickname) {
		RequestContextHolder.getRequestAttributes().setAttribute("sid", nickname, RequestAttributes.SCOPE_SESSION);		
	}
}
