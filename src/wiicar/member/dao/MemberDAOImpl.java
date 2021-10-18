package wiicar.member.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

import wiicar.carpool.dto.CarpoolDTO;
import wiicar.carpool.dto.PayDTO;
import wiicar.carpool.dto.ReservationsDTO;
import wiicar.member.dto.MemberDTO;
import wiicar.member.dto.MyCarpoolPassangerDTO;
import wiicar.member.dto.MyReservatitonDriverDTO;
import wiicar.review.dto.ReviewDTO;

@Repository
public class MemberDAOImpl implements MemberDAO{

	@Autowired
	private SqlSessionTemplate sqlSession = null;

	// 회원 확인
	@Override
	public int checkUserId(MemberDTO dto) throws SQLException {
		return sqlSession.selectOne("member.checkUserId", dto);
	}

	// 비번확인
	@Override
	public int checkUserPw(MemberDTO dto) throws SQLException {
		System.out.println("dao : " + dto.getNickname());
		System.out.println("pw : " + dto.getPw());
		return sqlSession.selectOne("member.checkUserPw", dto);
	}

	// 회원가입
	@Override
	public void insertUser(MemberDTO dto) throws SQLException {
		sqlSession.insert("member.insertUser", dto);
	}

	// 회원 정보 1명 가져오기
	@Override
	public MemberDTO getMemberInfo(String nickname) throws SQLException {
		return sqlSession.selectOne("member.getMemberInfo", nickname);
	}

	// 개인정보 수정
	@Override
	public void updateMemberInfo(MemberDTO dto) throws SQLException {
		sqlSession.update("member.updateMemberInfo", dto);
	}

	// 사진 수정
	@Override
	public void updateImage(String img, String type, String nickname) throws SQLException {
		HashMap<String, String> map = new HashMap<>();
		map.put("img", img);
		map.put("type", type);
		map.put("nickname", nickname);
		sqlSession.update("member.updateMemberImage", map);		
	}

	
	// 운전자 예약현황
	@Override
	public List<ReservationsDTO> driverReservationList(int startRow, int endRow, String id) throws SQLException {
		HashMap<String, Object> map = new HashMap<>();
		map.put("start",startRow);
		map.put("end",endRow);
		map.put("id", id);
		List<ReservationsDTO> reservationList = sqlSession.selectList("member.driverReservationList", map);
		
		 return reservationList;
		
	}

	// 운전자 예정 카풀
	@Override
	public List<CarpoolDTO> driverUpComeList(String id, int startRow, int endRow) throws SQLException {
		HashMap<String, Object> map = new HashMap<>();
		map.put("id", id);
		map.put("start", startRow);
		map.put("end",  endRow);
		
		return sqlSession.selectList("member.driverUpComeList",map);
	}

	// 운전자 지난 카풀
	@Override
	public List<CarpoolDTO> driverPastList(String id) throws SQLException {
		return sqlSession.selectList("member.driverPastList",id);
	}

	// 탑승자 예약현황
	@Override
	public List<ReservationsDTO> passangerReservationList(String id) throws SQLException {
		
		return sqlSession.selectList("member.passengerReservationList",id);
	}

	public List<CarpoolDTO> myCarpoolList(int carpoolNum) throws SQLException{
		System.out.println("myCarpoolList실행");
		return sqlSession.selectList("member.myCarpoolList", carpoolNum);
	}
	

	public List<CarpoolDTO> myCarpoolList2(int carpoolNum) throws SQLException{
		System.out.println("myCarpoolList2실행");
		return sqlSession.selectList("member.myCarpoolList", carpoolNum);
	}
	
	// 탑승자 카풀예정
	@Override
	public List<ReservationsDTO> passangerUpcommingList(String id) throws SQLException {
		// TODO Auto-generated method stub
		return sqlSession.selectList("member.passengerUpcomeList",id);
	}

	// 탑승자 지난 카풀
	@Override
	public List<ReservationsDTO> passangerPastList(String id) throws SQLException {
		// TODO Auto-generated method stub
		return sqlSession.selectList("member.passengerPastList",id);
	}

	// 회원 탈퇴
	@Override
	public void deleteMember(String nickname) throws SQLException {
		sqlSession.delete("member.deleteMember", nickname);
	}

	// 닉네임 중복확인
	@Override
	public int checkNickname(String nickname) throws SQLException {
		System.out.println("dao nickname : " + nickname);
		return sqlSession.selectOne("member.checkNickname", nickname);
	}

	// 아이디로 닉네임 가져오기
	@Override
	public String getNickname(String id) throws SQLException {
		return sqlSession.selectOne("member.getNickname", id);
	}
	
	// 운전자 리뷰 가져오기
	@Override
	public List<ReviewDTO> getDriverReview(String id) {
		return sqlSession.selectList("review.getDriverReview", id);
	}
	
	// 탑승자 리뷰 가져오기
	@Override
	public List<ReviewDTO> getPassengerReview(String id) {
		return sqlSession.selectList("review.getPassengerReview", id);
	}
	
	// 신고 수 가져오기
	@Override
	public int getReportCount(String id) {
		return sqlSession.selectOne("report.getReportCount", id);
	}
	
	// 운행 수 가져오기
	@Override
	public int getCarpoolRecord(String id) {
		return sqlSession.selectOne("carpool.getCarpoolRecord",id);
	}
	
	// 탑승 수 가져오기
	@Override
	public int getCarpoolUsed(String id) {
		return sqlSession.selectOne("carpool.getCarpoolUsed", id);
	}
	
	@Override
	public int getLikeCarpoolCount(String id) {
		return sqlSession.selectOne("carpool.getLikeCarpoolCount", id);
	}
	
	@Override
	public List<CarpoolDTO> getLikeCarpoolList(int start, int end, String sel, String sort, String id) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("start",start);
		map.put("end",end);
		map.put("sel", sel);
		map.put("sort", sort);
		map.put("id", id);
		return sqlSession.selectList("carpool.getLikeCarpoolList",map);
	}

	// 내 월정액 기간 가져오기
	@Override
	public PayDTO getMySubscription(String id) throws SQLException {
		return sqlSession.selectOne("pay.getMySubscription", id);
	}

	// 내 월정액 확인
	@Override
	public int isSubscription(String id) throws SQLException {
		return sqlSession.selectOne("pay.isSubscription", id);
	}
	// 마이페이지 내 카풀 탑승자 입장에서 -> 채팅방
	@Override
	public int driverContact(String userId, String chatId) throws SQLException {
		Map map = new HashMap();
		map.put("id", userId);
		map.put("driver", chatId);
		int roomnum = sqlSession.selectOne("chat.getRoomNum", map);
		
		return roomnum;
	}

	@Override
	public int getRoomNum(int carpoolNum, String driver, String passanger) throws SQLException {
		HashMap<String, Object> map = new HashMap<>();
		map.put("carpoolNum", carpoolNum);
		map.put("driver", driver);
		map.put("passanger", passanger);
		int roomNum = 0;
		System.out.println("##########################################");
		System.out.println("passanger = " + passanger + " / driver = " + driver + " / carpoolnum = " + carpoolNum);
		System.out.println("##########################################");
		
		if(sqlSession.selectOne("member.getRoomNum", map) != null) {
			roomNum = sqlSession.selectOne("member.getRoomNum", map);
			System.out.println("룸넘: " + roomNum);
		}
		return roomNum;
	}
	
	@Override
	public void reviewInsert(ReviewDTO dto) throws SQLException {
		sqlSession.insert("member.reviewInsert", dto);
	}
	
	@Override
	public int getReviewCheck(int num, String id, int type) throws SQLException {
		HashMap<String, Object> map = new HashMap<>();
		map.put("num", num);
		map.put("id", id);
		map.put("type", type);
		return sqlSession.selectOne("member.reviewCheck", map);
	}

	@Override
	public int getDriverPastCount(String id) throws SQLException {
		return sqlSession.selectOne("member.getDriverPastCount", id);
	}
	
	public List<CarpoolDTO> driverPastCarpool(String id, int start, int end) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("id", id);
		map.put("start", start);
		map.put("end", end);
		return sqlSession.selectList("member.driverPastCarpool", map);
	}
	
	public List<ReservationsDTO> driverPastReservation(String id, int start, int end) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("id", id);
		map.put("start", start);
		map.put("end", end);
		return sqlSession.selectList("member.driverPastReservation", map);
	}
	
	@Override
	public int sumRate(String id, int type) throws SQLException {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("type", type);
		return sqlSession.selectOne("member.sumRate", map);
	}
	
	@Override
	public int getReviewCount(String id, int type) throws SQLException {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("type", type);
		return sqlSession.selectOne("member.getReviewCount", map);
	}
	

	// 관리자 여부 확인 
	@Override
	public int checkAdmin(String nickname) throws SQLException {
		return sqlSession.selectOne("member.checkAdmin", nickname);
	}


	@Override
	public int getSubscription(String id) throws SQLException {
		return sqlSession.selectOne("pay.getSubscription", id);
	}

}
