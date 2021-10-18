package wiicar.carpool.dao;

import java.sql.SQLException;
import java.util.List;

import wiicar.carpool.dto.CarpoolDTO;
import wiicar.carpool.dto.ReservationsDTO;
import wiicar.member.dto.MemberDTO;
import wiicar.review.dto.ReviewDTO;

public interface CarpoolDAO {

	// 카풀 등록
	public void insertCarpool(CarpoolDTO dto) throws SQLException;

	public CarpoolDTO getCarpool(CarpoolDTO dto);
	
	public CarpoolDTO getCarpoolInfo(int carpoolNum) throws SQLException;
	
	public MemberDTO getMember(String id);
	
	public List<CarpoolDTO> getCarpoolList(int start, int end, String sel, String sort);
	
	public int getCarpoolCount();
	
	public List<String> getPassengers(int carpoolNum);
	
	public int getLike(int carpoolNum, String sid);
	
	public int checkLike(int carpoolNum, String sid);
	
	public List<ReviewDTO> getDriverReview(String id);
	
	public List<ReviewDTO> getPassengerReview(String id);
	
	public int getReportCount(String id);
	
	public int getCarpoolRecord(String id);
	
	public int getCarpoolUsed(String id);
	
	public void insertReservation(ReservationsDTO dto);
	
	public int checkReservation(int carpoolNum, String sid); 

}
 

