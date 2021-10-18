package wiicar.carpool.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.util.MultiValueMap;


public interface SearchService {

	// 카풀 검색 메서드!
	//public Map<String,Object> doSearch(Map<String, String> input) throws SQLException; //searchResult랑 searchCount들어있음
	//public void timeTest(String time) throws SQLException;
	
	// 카풀 상세검색 메서드
	public Map<String,Object> getSearchedCarpoolList(Map<String, String> input) throws SQLException;

	// 카풀 카운트만 해주는 메서드 (필터 표기용)
	 public int doAdvancedCount(Map<String, String> input) throws SQLException;
	
	
	
	
	
	
	
	
	
}
