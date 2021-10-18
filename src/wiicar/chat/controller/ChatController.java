package wiicar.chat.controller;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import wiicar.carpool.dto.CarpoolDTO;
import wiicar.carpool.dto.ReservationsDTO;
import wiicar.chat.dto.ChatDTO;
import wiicar.chat.dto.ChatRoomDTO;
import wiicar.chat.dto.MatchingDTO;
import wiicar.chat.dto.UserInfoDTO;
import wiicar.chat.service.ChatService;
import wiicar.member.dto.MemberDTO;

@Controller
@RequestMapping("/carpool/*")
public class ChatController {
	
	@Autowired
	ChatService chatService = null;

	// 채팅방 메인(유찬)
	@RequestMapping("chatting.do")
	public String chatting(HttpServletRequest request, Model model, String roomnum, String chatId, String carpoolnum) throws SQLException{
		System.out.println("!!! Chatting 호출 !!!");
		
		
		// 사용자 정보 가져오기(유찬)
		MemberDTO memdto = chatService.getMemberInfo();
		model.addAttribute("memdto", memdto);
		model.addAttribute("roomnum", roomnum);
		model.addAttribute("chatId", chatId);
		model.addAttribute("carpoolnum", carpoolnum);
		
		return "chat/chatting";
	}
	// 채팅방 가져오기(유찬)
	@ResponseBody
	@RequestMapping("chatRoom.do")
	public List<ChatRoomDTO> chatRoom(@RequestBody String userId) throws SQLException{
		System.out.println("여기 들어왔으며, userId 는? "+userId);
		List<ChatRoomDTO> chatName = null;
		//채팅방이 있는지 없는지 Check
			chatName = chatService.RoomList(userId);
			System.out.println("controller : " + chatName.size());
		for(ChatRoomDTO dto : chatName) {
			System.out.println(dto.getUnreadCnt());
		}
		return chatName; 
	}

	// chatId와 채팅내역 가져오기(유찬)
	@ResponseBody
	@RequestMapping("chatListView.do")
	public List<ChatDTO> chatListView(HttpServletRequest request,@RequestBody String user_roomnum) throws SQLException{
		HttpSession session = request.getSession();
		String userId = (String)session.getAttribute("sid");
		String roomnum = user_roomnum;
		
//		String chatId = (String)map.get("chatId");
//		String carpoolnum = (String)map.get("carpoolnum");
//		MatchingDTO reserveInfo = chatService.getReserve(chatId, userId);
		List<ChatDTO> dto = chatService.chatList(roomnum, userId);
		
		return dto;
	}
	
	// 채팅입력(유찬)
	@ResponseBody
	@RequestMapping("insertChat.do")
	public int insertChat(HttpServletRequest request,@RequestBody Map<Object, Object> map) throws SQLException{
		
		HttpSession session=request.getSession();
		String userId=(String)session.getAttribute("sid");
		String message = (String)map.get("message");
		String chatId = (String)map.get("chatId");
		String roomnum = (String)map.get("roomnum");
		int result = chatService.insertChat(userId,message,chatId, roomnum);
		
		return result;
	}
	
	// 채팅방 나가기(유찬)
	@ResponseBody
	@RequestMapping("chatRoomDelete.do")
	public int chatRoomDelete(HttpServletRequest request,@RequestBody String user_roomnum) throws SQLException{
		HttpSession session=request.getSession();
		String userId=(String)session.getAttribute("sid");
		String roomnum = user_roomnum;
		int result = chatService.chatRoomDelete(userId,roomnum);
		
		return result;
	}
	
	// ChatUser 정보
	@ResponseBody
	@RequestMapping("chatUser.do")
	public UserInfoDTO chatUser(@RequestBody Map<Object, Object> map) throws SQLException {
		String chatId = (String)map.get("chatId");
		String carpoolnum = (String)map.get("carpoolnum");

		UserInfoDTO user = chatService.chatUser(chatId, carpoolnum);
		
		return user ;
	}
	
	// chat 예약정보 확인
	@ResponseBody
	@RequestMapping("carpoolRes.do")
	public List<ReservationsDTO> carpoolRes(@RequestBody Map<Object, Object> map) throws SQLException {
		String chatId = (String)map.get("chatId");
		String carpoolnum = (String)map.get("carpoolnum");
		List<ReservationsDTO> resdto = chatService.carpoolRes(chatId, carpoolnum);
		return resdto;
	}
	
	// 카풀 정보 확인
	@ResponseBody
	@RequestMapping("getCarpool.do")
	public CarpoolDTO getCarpool(@RequestBody String carpoolnum) throws SQLException{
		
		CarpoolDTO cardto = chatService.getCarpool(carpoolnum);
		return cardto;
	}
	
	@ResponseBody
	@RequestMapping("checkInfo")
	public MatchingDTO checkInfo(HttpServletRequest request, @RequestBody Map<Object, Object> map) throws SQLException {
		// 로그인한 아이디로 가져오기
		HttpSession session=request.getSession();
		String driver=(String)session.getAttribute("sid");
		String passenger = (String)map.get("passenger");
		String carpoolnum = (String)map.get("carpoolnum");

		// 예약 요청 정보 가져오기
		MatchingDTO reserveInfo = chatService.getReserve(passenger, driver, carpoolnum);
		System.out.println("reserveInfoCon == > "+ reserveInfo);
		return reserveInfo;
	}
	// 수락했을경우(윤지)
	@ResponseBody
	@RequestMapping("accept.do")
	public int accept(@RequestBody Map<Object, Object> map) throws SQLException {
		// 카풀리스트 매칭상태 1로 변경, 현재 탑승인원 +1
		// 예약요청테이블 수락(1)
		// 탑승자에게 예약완료 메시지 보내기
		System.out.println("accept.do 실행");
		String driver = (String)map.get("nickname");
		String passenger = (String)map.get("passenger");
		String carpoolnum = (String)map.get("carpoolnum");
		String roomnum = (String)map.get("roomnum");
		
		int result = chatService.acceptReserve(driver, passenger, carpoolnum, roomnum);
		
		return result;
	}
		
	// 거절했을경우(윤지)
	@ResponseBody
	@RequestMapping("refuse.do")
	public int refuse(@RequestBody Map<Object, Object> map) throws SQLException {
		// 예약요청테이블 거절(2) -> 탑승자에게 거절 메세지 보내기(ALERTS 테이블)
		String driver = (String)map.get("nickname");
		String passenger = (String)map.get("passenger");
		String carpoolnum = (String)map.get("carpoolnum");
		String roomnum = (String)map.get("roomnum");
		
		int result = chatService.refuseReserve(driver, passenger, carpoolnum, roomnum);
		
		return result;
	}	
	
	@RequestMapping("reportPopup.do")
	public String reportPopup(String nickname, Model model) {
		model.addAttribute("opponent", nickname);
		return "popup/reportPopup";
	}
}
