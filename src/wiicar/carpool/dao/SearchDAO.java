package wiicar.carpool.dao;

import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import org.springframework.util.MultiValueMap;

import wiicar.carpool.dto.CarpoolDTO;

public interface SearchDAO {
	
	
	public int getSearchCount(Map<String, String> input, Long requestDateTime) throws SQLException;
	public List<CarpoolDTO> getSearchList(Map<String, String> input, Long requestDateTime) throws SQLException;
	public int getAdSearchCount(Map<String, String> adSearchInput) throws SQLException;
	public List<CarpoolDTO> getAdSearchList(Map<String, String> adSearchInput) throws SQLException;
	
	
	

}
