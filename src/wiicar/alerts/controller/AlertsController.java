package wiicar.alerts.controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import wiicar.alerts.dto.AlertChatRooms;
import wiicar.alerts.service.AlertsServiceImpl;

@Controller
@RequestMapping("/alerts/*")
public class AlertsController {
	
	@Autowired
	AlertsServiceImpl alertsService = null;
	
	// 노티 가져오기
	@RequestMapping("countAllNoti.do")
	@ResponseBody
	public HashMap<String, Object> countAllNoti() throws SQLException {
		System.out.println("노티 가져오기");
		HttpHeaders respHeader = new HttpHeaders();
		respHeader.add("Content-type", "test/html;charset=utf-8");
		
		System.out.println("컨트롤러 노티 가져오기");
		HashMap<String, Object> map = alertsService.countAllNoti();
		System.out.println("map =======> "+map);
		return map;
	}
}
