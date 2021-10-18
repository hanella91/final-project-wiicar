package wiicar.alerts.service;

import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Queue;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

import edu.emory.mathcs.backport.java.util.Collections;
import wiicar.alerts.dao.AlertsDAOImpl;
import wiicar.alerts.dto.AlertChatRooms;
import wiicar.alerts.dto.AlertsDTO;

@Service
public class AlertsServiceImpl implements AlertsService {

	@Autowired
	AlertsDAOImpl alertsDAO = null;

	// 노티 가져오기
	@Override
	public HashMap<String, Object> countAllNoti() throws SQLException {
		String sid = (String)RequestContextHolder.getRequestAttributes().getAttribute("sid", RequestAttributes.SCOPE_SESSION);
		List<AlertsDTO> chatList = alertsDAO.countChatNoti(sid);
		int alertCnt = 0;
		Queue<Integer> q = new LinkedList<>();
		HashMap<Integer, AlertChatRooms> map = new HashMap<>();
		HashMap<String, Object> returnMap = new HashMap<>();
		List<AlertChatRooms> alertList = new ArrayList<>();
		
		Collections.sort(chatList, new Comparator<AlertsDTO>() {
			@Override
			public int compare(AlertsDTO dto1, AlertsDTO dto2) {
				return dto2.getReg().compareTo(dto1.getReg());
			}
		});
		
		for(AlertsDTO dto : chatList) {
			int roomN = dto.getRoomNum();
			String chat = dto.getMessage();
			Timestamp reg = dto.getReg();
			int carpoolnum = dto.getCarpoolnum();
			int chatNum = dto.getChatNum();

			String opp = ""; // 아이디 값이 들어간다
			if(dto.getMes_check() == 0 && dto.getReceiver().equals(sid)) {
				if(chat.length() > 15) {
					chat = chat.substring(0, 15) + "...";
				}
				if(dto.getReceiver().equals(sid)) { // 받는사람이 세션아이디라면
					opp = dto.getSender(); // 보낸사람을 opp에 집어 넣어
				}

				alertCnt++; // check=0 이고 receiver가 세션 id 와 같으면 +1
				if(!q.contains(roomN)) { // Queue에 roomnum이 포함되어 있지않으면
					q.add(roomN); // q에 dto에서 꺼낸 roomnum 삽입
					map.put(roomN, new AlertChatRooms(roomN, chat, reg, opp, carpoolnum, chatNum)); // HashMap<Integer, AlertChatRooms> map에 (IntegerKey, AlertChatRooms value)을 담앗다.
				} else { // Queue에 roomnum이 포함되어있으면
					map.get(roomN).setLastChat(chat); // 세팅
					map.get(roomN).setReg(reg);
					map.get(roomN).setChatNum(chatNum);
					map.get(roomN).addUnread(); // +1 시켜줌

				}
			}
		}
		returnMap.put("alertCnt", alertCnt); // HashMap<String, Object> returnMap alertCnt 넣기
		returnMap.put("qSize", q.size()); // Queue 크기
		System.out.println("q size : " + q.size());
		while(!q.isEmpty()) { // Queue가 비어있는게 아니라면 !!!
			alertList.add(map.get(q.poll())); // alertList에 담아!!
		}
		returnMap.put("alertList", alertList);
		return returnMap;
	}
}
