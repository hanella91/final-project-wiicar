package wiicar.carpool.service;

import java.sql.SQLException;
import java.util.Map;

import wiicar.carpool.dto.CarpoolDTO;


public interface CarpoolService {
	
	// 카풀 등록 
	public void addCarpool(CarpoolDTO dto) throws SQLException;
	
	public CarpoolDTO getCarpool(CarpoolDTO dto);
	
	public Map<String, Object> getCarpoolList(String pageNum, String orderby);

	public int checkLike(int carpoolNum);
	
	public Map<String, Object> getUserProfile(String id);
	
	public Map<String, Object> getReqeust(int num); 

}
