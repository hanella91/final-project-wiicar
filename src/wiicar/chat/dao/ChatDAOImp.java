package wiicar.chat.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import wiicar.carpool.dto.CarpoolDTO;
import wiicar.carpool.dto.ReservationsDTO;
import wiicar.chat.dto.ChatDTO;
import wiicar.chat.dto.MatchingDTO;
import wiicar.chat.dto.RoomDTO;
import wiicar.chat.dto.UserInfoDTO;
import wiicar.member.dto.MemberDTO;

@Repository
public class ChatDAOImp implements ChatDAO{

	@Autowired
	SqlSessionTemplate sqlSession=null;
	
	// 사용자 정보 가져오기(유찬)
	@Override
	public MemberDTO getMemberInfo(String nickname) throws SQLException {
		MemberDTO memdto = sqlSession.selectOne("member.getMemberInfo", nickname);
		return memdto;
	}
	
	// 세션id가 있는 채팅방 가져오기
	@Override
	public List<ChatDTO> RoomList(String userid) throws SQLException {
		
		List<ChatDTO> chatName = sqlSession.selectList("chat.RoomList", userid);
		return chatName;
	}

	// chatId와 채팅내역 가져오기
	@Override
	public List<ChatDTO> chatList(String roomnum, String userId) throws SQLException {
		Map map = new HashMap();
		map.put("roomnum", roomnum);
		map.put("userId", userId);
		
		List<ChatDTO> dto = sqlSession.selectList("chat.chatList", map);
		// 읽음 여부 update
		sqlSession.update("chat.readCheck", map);
		return dto;
	}

	// 채팅 입력
	@Override
	public int insertChat(String userId, String message, String chatId, String roomnum) throws SQLException {
		Map map = new HashMap();
		map.put("userId", userId);
		map.put("chatId", chatId);
		map.put("message", message);
		map.put("roomnum", roomnum);
		int result = sqlSession.insert("chat.insertChat", map);
		return result;
	}

	// 채팅방 나가기(삭제)
	@Override
	public int chatRoomDelete(String userId, String roomnum) throws SQLException {
		Map map = new HashMap();
		map.put("userId", userId);
		map.put("roomnum", roomnum);
		int result =-1;
		RoomDTO roomdto =null;
		roomdto = sqlSession.selectOne("chat.deletUser", map); // deluser1 값 찾기 위해서
		if(userId.equals(roomdto.getUser1())) {
			result = sqlSession.update("chat.chatRoomDelete1",map); // session id = user1 이면, deluser1에 1 업데이트
		}else {
			result = sqlSession.update("chat.chatRoomDelete2",map); // session id != user1 이면, deluser2에 업데이트
		}
		roomdto = sqlSession.selectOne("chat.deletUser", map); // deluser1 값 찾기 위해서
		if(roomdto.getDeluser1()==1 && roomdto.getDeluser2()==1) { // 둘다 1일때 
			sqlSession.delete("chat.DeleteRoom", map); // 채팅방 삭제
			sqlSession.delete("chat.DelChatList", map); // 채팅내역 삭제
		}
		return result;
	}
	
	// ChatUser 정보
	@Override
	public UserInfoDTO chatUser(String chatId, String carpoolnum) throws SQLException { 
		Map map = new HashMap();
		map.put("chatId", chatId);
		map.put("carpoolnum", carpoolnum);
		
		// 운전자인지 탑승자인지 확인
		String type = sqlSession.selectOne("chat.checkType", map);
		if(type == null) {
			map.put("type", "passenger");
		} else {
			map.put("type", "driver");
		}
			UserInfoDTO user = sqlSession.selectOne("chat.chatUser", map);			
		return user;
	}
	
	// ChatId 예약정보 확인
	@Override
	public List<ReservationsDTO> carpoolRes(String chatId, String carpoolnum) throws SQLException {
		Map map = new HashMap();
		map.put("chatId", chatId);
		map.put("carpoolnum", carpoolnum);
		List<ReservationsDTO> resdto = sqlSession.selectList("chat.carpoolres", map);
		return resdto;
	}
	
	// 카풀 정보 확인
	@Override
	public CarpoolDTO getCarpool(String carpoolnum) throws SQLException {
		CarpoolDTO cardto = sqlSession.selectOne("chat.getCarpool", carpoolnum);
		return cardto;
	}
	
	// 예약요청정보 가져오기
	@Override
	public MatchingDTO getReserve(String passengerid, String driverid,String carpoolnum) throws SQLException {
		Map map = new HashMap();
		map.put("passenger", passengerid);
		map.put("driver", driverid);
		map.put("carpoolnum", carpoolnum);
		
		MatchingDTO reserveInfo = sqlSession.selectOne("chat.selectMatch",map);
		System.out.println("reserveInfoDAO ==> "+ reserveInfo);
		return reserveInfo;
	}
	
	@Override
	public int acceptChat(String driver, String passenger, String carpoolnum, String roomnum) throws SQLException {
//  insert into alerts (chatnum, passenger, driver, message) values (1, 'passenger', 'driver', '[알림] 회원님의 예약요청이 수락되었습니다. 예약 완료된 카풀 일정을 확인하세요!')
		HashMap map = new HashMap();
		map.put("driver", driver);
		map.put("passenger", passenger);
		map.put("carpoolnum", Integer.parseInt(carpoolnum));
		map.put("roomnum", Integer.parseInt(roomnum));
		
		int insertChatResult = sqlSession.insert("chat.acceptChat", map);
		//sqlSession.insert("chat.acceptChat2", map);
		
		return insertChatResult;
	}
	
	@Override
	public int updateAcceptance(String carpoolnum) throws SQLException {
//	update reservations set ACCEPTANCE = 1 where carpoolnum = 2;
		int carpoolnum2 = Integer.parseInt(carpoolnum);
		int updateAcceptResult = sqlSession.update("chat.updateAcceptance", carpoolnum2);
				
		return updateAcceptResult;
	}
	
	@Override
	public int updateCarMatching(String carpoolnum) throws SQLException {
//	update carpoollist set carmatching = 1 where carpoolnum = 2;
		int carpoolnum2 = Integer.parseInt(carpoolnum);
		int updateCarMatchResult = sqlSession.update("chat.updateCarMatching", carpoolnum2);
		
		return updateCarMatchResult;
	}
	
	@Override
	public int updatePassengerCount(String carpoolnum) throws SQLException {
		// update carpoollist set passengercount = passengercount+1) where carpoolnum = 2;
		int carpoolnum2 = Integer.parseInt(carpoolnum);
		int updatePassengerCountResult = sqlSession.update("chat.updatePassengerCount", carpoolnum2);
		
		return updatePassengerCountResult;
	}
	
	@Override
	public int refuseChat(String driver, String passenger, String carpoolnum, String roomnum) throws SQLException {
		HashMap map = new HashMap();
		map.put("driver", driver);
		map.put("passenger", passenger);
		map.put("carpoolnum", Integer.parseInt(carpoolnum));
		map.put("roomnum", Integer.parseInt(roomnum));
		
		int refuseChatResult = sqlSession.insert("chat.refuseChat", map);
		
		return refuseChatResult;
	}
	
	@Override
	public int updateRefuse(String carpoolnum) throws SQLException {
		int carpoolnum2 = Integer.parseInt(carpoolnum);
		int updateRefuseResult = sqlSession.update("chat.updateRefuse", carpoolnum2);
		
		return updateRefuseResult;
	}

	@Override
	public int isChatRoom(String id, String driver) throws SQLException {
		Map<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		map.put("driver", driver);
		return sqlSession.selectOne("chat.isChatRoom", map);
	}
	
	@Override
	public void newChatRoom(RoomDTO dto) {
		sqlSession.insert("chat.newChatRoom", dto);
	}
	
	@Override
	public int getRoomNum(String id, String driver) throws SQLException {
		Map<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		map.put("driver", driver);
		return sqlSession.selectOne("chat.getRoomNum", map);
	}
}
