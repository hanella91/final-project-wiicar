package wiicar.home.controller;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import wiicar.home.dto.RecommendDTO;
import wiicar.home.service.HomeServiceImpl;
import wiicar.member.dto.MemberDTO;

@Controller
public class HomeController {
	
	@Autowired
	private HomeServiceImpl homeService = null;
	
	@RequestMapping("/index")
	public void aaaa() {
		System.out.println("asdf");
	}

	@RequestMapping("home.do")
	public String main(Model model) throws SQLException {
		
		// 사용자 정보 가져오기(유찬)
		MemberDTO memdto = homeService.getMemberInfo();
		// 추천경로 가져오기
		List<RecommendDTO> recomdto =null;
		recomdto = homeService.getRecommend();
		
		model.addAttribute("memdto", memdto);
		model.addAttribute("recomdto", recomdto);
		return "main";
	}
	
	@RequestMapping(value = "/error.do")
	public String error(ModelMap modelmap, HttpSession session, HttpServletRequest req, HttpServletResponse res) {
		modelmap.addAttribute("Data", "error code : " + res.getStatus());
		return "error";
	}
}
