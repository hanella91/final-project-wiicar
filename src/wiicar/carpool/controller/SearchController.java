package wiicar.carpool.controller;

import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


import wiicar.carpool.service.SearchService;
import wiicar.carpool.service.SearchServiceImpl;

@Controller
@RequestMapping("/carpool/*")
public class SearchController {
	
	@Autowired
	private SearchServiceImpl searchService = null;
	

	@PostMapping("search.do")
	public String search(@RequestParam HashMap<String, String> defaultInput, Model model) throws SQLException{ 
		Map<String, Object> searchResult = searchService.getSearchedCarpoolList(defaultInput); 
		model.addAttribute("searchCount", searchResult.get("searchCount"));
		model.addAttribute("searchList", searchResult.get("searchList")); 
		model.addAttribute("input", defaultInput);
		System.out.println(searchResult.get("searchCouunt"));
		
		return "carpoolpay/carpoolList";
	}
	
	@RequestMapping(value = "/count.do", method = RequestMethod.POST, consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE) 
	@ResponseBody
	public HashMap filterCount(@RequestParam HashMap<String, String> input, Model model) throws SQLException{ //받아 올 값 requestParam으로 매개변수지정
		System.out.println("Ajax call");
		HashMap result = new HashMap();
		result.put("count", searchService.doAdvancedCount(input));
		
		return result;
	}
	
	
	
		
	/*
	//timestamp 테스트용
	@RequestMapping(value = "/timestampTest.do", method = RequestMethod.POST, consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
	public String timestampTest(@RequestParam String time, Model model) throws SQLException {
		 
		model.addAttribute(time);
		searchService.timeTest(time);
		System.out.println(time);
		return "list/searchTest";
	}
	*/
	
}
