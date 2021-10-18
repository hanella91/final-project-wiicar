package wiicar.member.service;

import java.sql.SQLException;

import java.sql.Timestamp;
import java.util.Map;

import wiicar.member.dto.MemberDTO;

public interface MemberService {

	// 처음 로그인하는 회원인지 확인
	public int checkUserId(MemberDTO dto) throws SQLException;

	// 비번 확인
	public int checkUserPw(MemberDTO dto) throws SQLException;
	
	// 비밀번호 확인
	public int checkUserPw(String pw) throws SQLException; 
	
	// 세션 만들기
	public void sessionNickname(String id);
	
	// 회원가입
	public void insertUser(MemberDTO dto) throws SQLException;
	
	// 인증번호 발송
	public String verifyPhone(String phone);
	
	// 회원 1명 정보 가져오기
	public MemberDTO getMemberInfo() throws SQLException;
	
	// 로그인 상태 확인하기
	public int checkLogin();
	
	// 개인정보 수정
	public void updateMemberInfo(MemberDTO dto) throws SQLException;
	
	// 사진 수정
	public void updateImage(String img, String type) throws SQLException;
	

	// 운전자 에약정보 가져오기
	public  Map<String, Object> getDriversReservation(String pageNum) throws SQLException;

	// 운전자 예정된 카풀 
	public Map<String, Object> getDriversUpcomeList(String pageNum) throws SQLException;

	// 운전자 지난 카풀 
	public Map<String, Object> getDriversPastList(String pageNum) throws SQLException;
	
	// 탑승자 예약 리스트 가져오기
	public Map<String, Object> getPassangerReservation() throws SQLException;
 
	
	// 탑승자 카풀 가져오기
	public Map<String, Object> getPassangersCarpoolList(String sort) throws SQLException;

	
	// 로그아웃
	public void logout();
	
	// 회원 탈퇴
	public void deleteMember() throws SQLException;
	
	// 닉네임 중복확인
	public int checkNickname(String nickname) throws SQLException;
	
	// 마이페이지 정보 불러오기
	public Map<String, Object> getMyProfile() throws SQLException;
	
	// 관심카풀 목록 가져오기
	public Map<String, Object> getLikeCarpoolList(String pageNum, String sel, String sort) throws SQLException;

	// 월정액 기간 가져오기
	public Timestamp getMySubscription() throws SQLException;

	// 마이페이지 내 카풀 탑승자 입장에서 -> 채팅방
	public int driverContact(String userId, String chatId) throws SQLException;
	
	public void reviewInsert(String type, String num, String id, int rate, String content) throws SQLException;
	

	// 관리자 로그인 처리
	public int adminLoginPro(String nickname, String pw) throws SQLException;
	
	// 관리자 여부 확인
	public int checkAdmin() throws SQLException;

	public void sessionSubsription() throws SQLException;

}
