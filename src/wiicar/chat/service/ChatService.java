package wiicar.chat.service;

import java.sql.SQLException;
import java.util.List;

import wiicar.carpool.dto.CarpoolDTO;
import wiicar.carpool.dto.ReservationsDTO;
import wiicar.chat.dto.ChatDTO;
import wiicar.chat.dto.ChatRoomDTO;
import wiicar.chat.dto.MatchingDTO;
import wiicar.chat.dto.UserInfoDTO;
import wiicar.member.dto.MemberDTO;

public interface ChatService {

	// 사용자 정보 가져오기(유찬)
	public MemberDTO getMemberInfo() throws SQLException;
	
	// 세션id가 있는 채팅방 가져오기
	public List<ChatRoomDTO> RoomList(String userid) throws SQLException;

	// chatId와 채팅내역 가져오기
	public List<ChatDTO> chatList(String roomnum, String userId) throws SQLException;

	// 채팅 입력
	public int insertChat(String userId, String message, String chatId, String roomnum) throws SQLException;

	// 채팅방 나가기(삭제)
	public int chatRoomDelete(String userId, String roomnum) throws SQLException;

	// ChatUser 정보
	public UserInfoDTO chatUser(String chatId, String carpoolnum) throws SQLException;
	
	// chat 예약정보 확인
	public List<ReservationsDTO> carpoolRes(String chatId, String carpoolnum) throws SQLException;
	
	// 카풀 정보 확인
	public CarpoolDTO getCarpool(String carpoolnum) throws SQLException;
	
	/*------------------------유찬--------------------*/
	
	// 예약요청정보 가져오기
	public MatchingDTO getReserve(String passengerid, String driverid,String carpoolnum) throws SQLException;

	// 탑승자에게 예약완료 메시지 보내기
	public int acceptReserve(String driver, String passenger, String carpoolnum, String roomnum) throws SQLException;

	// 탑승자에게 예약거절 메시지 보내기
	public int refuseReserve(String driver, String passenger, String carpoolnum, String roomnum) throws SQLException;

	
}
