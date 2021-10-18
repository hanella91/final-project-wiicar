package wiicar.chat.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Queue;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

import wiicar.carpool.dto.CarpoolDTO;
import wiicar.carpool.dto.ReservationsDTO;
import wiicar.chat.dao.ChatDAO;
import wiicar.chat.dto.ChatDTO;
import wiicar.chat.dto.ChatRoomDTO;
import wiicar.chat.dto.MatchingDTO;
import wiicar.chat.dto.UserInfoDTO;
import wiicar.member.dto.MemberDTO;

@Service
public class ChatServiceImp implements ChatService{
	
	@Autowired
	ChatDAO chatdao = null;
	
	// 사용자 정보 가져오기(유찬)
	@Override
	public MemberDTO getMemberInfo() throws SQLException {
		String nickname =  (String)RequestContextHolder.getRequestAttributes().getAttribute("sid", RequestAttributes.SCOPE_SESSION);
		MemberDTO memdto =  chatdao.getMemberInfo(nickname);
		return memdto;
	}
	
	// 세션id가 있는 채팅방 가져오기
	@Override
	public List<ChatRoomDTO> RoomList(String userid) throws SQLException {
		List<ChatDTO> chatRoomListRes = chatdao.RoomList(userid);
		List<ChatRoomDTO> chatRoomList = new ArrayList<>();
		Queue<Integer> q = new LinkedList<>();
		HashMap<Integer, ChatRoomDTO> map = new HashMap<>();
		
		Collections.sort(chatRoomListRes, new Comparator<ChatDTO>(){
			@Override
			public int compare(ChatDTO dto2, ChatDTO dto1) {
				return dto2.getReg().compareTo(dto1.getReg());
			}
		});
		
		for(ChatDTO dto : chatRoomListRes) {
			ChatRoomDTO crDTO = new ChatRoomDTO();
			crDTO.setChatnum(dto.getChatnum());
			crDTO.setRoomnum(dto.getRoomnum());
			crDTO.setMes_check(dto.getMes_check());
			crDTO.setCarpoolnum(dto.getCarpoolnum());
			crDTO.setSender(dto.getSender());
			crDTO.setReceiver(dto.getReceiver());
			crDTO.setMessage(dto.getMessage());
			crDTO.setReg(dto.getReg());
			
			if(!map.containsKey(dto.getRoomnum())) {
				map.put(dto.getRoomnum(), new ChatRoomDTO());
				map.get(dto.getRoomnum()).setUnreadCnt(0);
				q.add(dto.getRoomnum());
			} 
			if(dto.getMes_check() == 0) {
				crDTO.setUnreadCnt(map.get(dto.getRoomnum()).getUnreadCnt() + 1);
			}
			map.put(dto.getRoomnum(), crDTO);
		}
		
		while(!q.isEmpty()) {
			chatRoomList.add(map.get(q.poll()));
		}
		Collections.reverse(chatRoomList);
		System.out.println("service : " + chatRoomList.size());
		return chatRoomList;
	}

	// chatId와 채팅내역 가져오기
	@Override
	public List<ChatDTO> chatList(String roomnum, String userId) throws SQLException {

		List<ChatDTO> dto = chatdao.chatList(roomnum, userId);
		return dto;
	}

	// 채팅 입력
	@Override
	public int insertChat(String userId, String message, String chatId, String roomnum) throws SQLException {
		
		int result = chatdao.insertChat(userId, message, chatId, roomnum);
		return result;
	}

	// 채팅방 나가기(삭제)
	@Override
	public int chatRoomDelete(String userId, String roomnum) throws SQLException {
		int result = chatdao.chatRoomDelete(userId,roomnum);
		return result;
	}
	
	// ChatUser 정보
	@Override
	public UserInfoDTO chatUser(String chatId, String carpoolnum) throws SQLException {
		UserInfoDTO user = chatdao.chatUser(chatId, carpoolnum); 
		return user;
	}
	
	// ChatId 예약정보 확인
	@Override
	public List<ReservationsDTO> carpoolRes(String chatId, String carpoolnum) throws SQLException {
		List<ReservationsDTO> resdto = chatdao.carpoolRes(chatId, carpoolnum);
		return resdto;
	}
	
	// 카풀 정보 확인
	@Override
	public CarpoolDTO getCarpool(String carpoolnum) throws SQLException {
		CarpoolDTO cardto = chatdao.getCarpool(carpoolnum); 
		return cardto;
	}
	
	// 예약요청정보 가져오기
	@Override
	public MatchingDTO getReserve(String passengerid, String driverid,String carpoolnum) throws SQLException {
		MatchingDTO reserveInfo = chatdao.getReserve(passengerid, driverid,carpoolnum);
		System.out.println("reserveInfoService ==> "+ reserveInfo);
		return reserveInfo;
	}
	// 탑승자에게 예약완료 메시지 보내기
	@Override
	public int acceptReserve(String driver, String passenger, String carpoolnum, String roomnum) throws SQLException {
		System.out.println("탑승자에게 예약완료 메세지 보내기 실행");
		int updatePassengerCount = chatdao.updatePassengerCount(carpoolnum);
		int updateCarMatching = chatdao.updateCarMatching(carpoolnum);
		int updateAcceptance = chatdao.updateAcceptance(carpoolnum);
		int acceptChat = chatdao.acceptChat(driver, passenger, carpoolnum, roomnum);
		System.out.println("acceptChat : " + acceptChat);
		return acceptChat;
	}
	// 탑승자에게 예약거절 메시지 보내기
	@Override
	public int refuseReserve(String driver, String passenger, String carpoolnum, String roomnum) throws SQLException {
		int result = chatdao.refuseChat(driver, passenger, carpoolnum, roomnum);
		chatdao.updateRefuse(carpoolnum);
		return result;
	}

}
