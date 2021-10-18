package wiicar.member.dao;

import java.sql.SQLException;
import java.util.List;

import wiicar.carpool.dto.CarpoolDTO;
import wiicar.member.dto.MyCarpoolPassangerDTO;
import wiicar.member.dto.MyReservatitonDriverDTO;
import wiicar.carpool.dto.PayDTO;
import wiicar.carpool.dto.ReservationsDTO;
import wiicar.member.dto.MemberDTO;
import wiicar.review.dto.ReviewDTO;

public interface MemberDAO {

	// 처음 로그인하는 회원인지 확인 
	public int checkUserId(MemberDTO dto) throws SQLException;

	// 비밀번호 확인
	public int checkUserPw(MemberDTO dto) throws SQLException;
	
	// 회원가입 
	public void insertUser(MemberDTO dto) throws SQLException;
	
	// 회원 1명 정보 가져오기
	public MemberDTO getMemberInfo(String id) throws SQLException;
	
	// 회원 정보 수정
	public void updateMemberInfo(MemberDTO dto) throws SQLException;
	
	// 사진 수정
	public void updateImage(String img, String type, String id) throws SQLException;
	
	// 운전자 예약현황 리스트(대기중/거절)
	public List<ReservationsDTO> driverReservationList(int startRow, int endRow, String id) throws SQLException;	
	
	// 운전자 예정카풀
	public List<CarpoolDTO> driverUpComeList(String id, int startRow, int endRow) throws SQLException;
	
	// 운전자 지난카풀
	public List<CarpoolDTO> driverPastList(String id) throws SQLException;
	
	// 탑승자 예약 리스트
	public List<ReservationsDTO> passangerReservationList(String id) throws SQLException;
	
	// 탑승자 에약 카풀리스트
	public List<CarpoolDTO> myCarpoolList(int carpoolNum) throws SQLException;
	
	public List<CarpoolDTO> myCarpoolList2(int carpoolNum) throws SQLException;
	
	public List<ReservationsDTO> passangerUpcommingList(String id) throws SQLException;
	
	public List<ReservationsDTO> passangerPastList(String id) throws SQLException;

	// 회원탈퇴
	public void deleteMember(String id) throws SQLException;
	
	// 닉네임 중복확인
	public int checkNickname(String nickname) throws SQLException;
	
	// 아이디로 닉네임 가져오기
	public String getNickname(String id) throws SQLException;
	
	// 운전자 리뷰 가져오기
	public List<ReviewDTO> getDriverReview(String id);
	
	// 탑승자 리뷰 가져오기
	public List<ReviewDTO> getPassengerReview(String id);
	
	// 신고 수 가져오기
	public int getReportCount(String id);
	
	// 카풀 운행 수 가져오기
	public int getCarpoolRecord(String id);
	
	// 카풀 탑승 수 가져오기
	public int getCarpoolUsed(String id);
	
	// 관심카풀 수 가져오기
	public int getLikeCarpoolCount(String id);
	
	// 관심카풀 리스트 가져오기
	public List<CarpoolDTO> getLikeCarpoolList(int start, int end, String sel, String sort, String id);

	// 내 월정액 확인
	public int isSubscription(String id) throws SQLException;
	
	// 내 월정액 기간 가져오기
	public PayDTO getMySubscription(String id) throws SQLException;

	// 마이페이지 내 카풀 탑승자 입장에서 -> 채팅방
	public int driverContact(String userId, String chatId) throws SQLException;
	
	// 채팅 룸 넘버 가져오기
	public int getRoomNum(int carpoolNum, String driver, String passanger) throws SQLException;
	
	public void reviewInsert(ReviewDTO dto) throws SQLException;
	
	public int getReviewCheck(int num, String id, int type) throws SQLException;
	
	public int getDriverPastCount(String id) throws SQLException;
	
	public List<CarpoolDTO> driverPastCarpool(String id, int start, int end) throws SQLException;

	public List<ReservationsDTO> driverPastReservation(String id, int start, int end) throws SQLException;
	
	public int sumRate(String id, int type) throws SQLException;
	
	public int getReviewCount(String id, int type) throws SQLException;
	

	// 관리자 여부 확인
	public int checkAdmin(String nickname) throws SQLException;


	public int getSubscription(String id) throws SQLException;

}
