package wiicar.carpool.dao;

import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.util.MultiValueMap;

import oracle.sql.TIMESTAMP;
import wiicar.carpool.dto.CarpoolDTO;

@Repository //conponent, 
public class SearchDAOImpl implements SearchDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession = null; 
	
	//검색 게시글 수 가져오기
	@Override
	public int getSearchCount(Map<String, String> input, Long requestDateTime) throws SQLException {
		
		HashMap boundsInfo = new HashMap();
		boundsInfo.put("depart_sw_bound_lat", Double.parseDouble(input.get("depart_sw_bound_lat")));
		boundsInfo.put("depart_sw_bound_lon", Double.parseDouble(input.get("depart_sw_bound_lon")));
		boundsInfo.put("depart_ne_bound_lat", Double.parseDouble(input.get("depart_ne_bound_lat")));
		boundsInfo.put("depart_ne_bound_lon", Double.parseDouble(input.get("depart_ne_bound_lon")));
		boundsInfo.put("destination_sw_bound_lat", Double.parseDouble(input.get("destination_sw_bound_lat")));
		boundsInfo.put("destination_sw_bound_lon", Double.parseDouble(input.get("destination_sw_bound_lon")));
		boundsInfo.put("destination_ne_bound_lat", Double.parseDouble(input.get("destination_ne_bound_lat")));
		boundsInfo.put("destination_ne_bound_lon", Double.parseDouble(input.get("destination_ne_bound_lon")));
		boundsInfo.put("time", requestDateTime);
		
		System.out.println("DAO 실행, 던져주는 값 : " + boundsInfo);
		System.out.println("boundsInfo.time : " + boundsInfo.get("time"));
		int searchCount = sqlSession.selectOne("search.count", boundsInfo);
		
		return searchCount;
	}
	
	//검색 게시글 목록 가져오기
	@Override
	public List<CarpoolDTO> getSearchList(Map<String, String> input, Long requestDateTime) throws SQLException {

		HashMap InfoForSearching = new HashMap();
		InfoForSearching.put("depart_sw_bound_lat", Double.parseDouble(input.get("depart_sw_bound_lat")));
		InfoForSearching.put("depart_sw_bound_lon", Double.parseDouble(input.get("depart_sw_bound_lon")));
		InfoForSearching.put("depart_ne_bound_lat", Double.parseDouble(input.get("depart_ne_bound_lat")));
		InfoForSearching.put("depart_ne_bound_lon", Double.parseDouble(input.get("depart_ne_bound_lon")));
		InfoForSearching.put("destination_sw_bound_lat", Double.parseDouble(input.get("destination_sw_bound_lat")));
		InfoForSearching.put("destination_sw_bound_lon", Double.parseDouble(input.get("destination_sw_bound_lon")));
		InfoForSearching.put("destination_ne_bound_lat", Double.parseDouble(input.get("destination_ne_bound_lat")));
		InfoForSearching.put("destination_ne_bound_lon", Double.parseDouble(input.get("destination_ne_bound_lon")));
		InfoForSearching.put("time", requestDateTime);
		
		List<CarpoolDTO> searchList = sqlSession.selectList("search.list", InfoForSearching);
		
		return searchList;
	}

	@Override
	public int getAdSearchCount(Map<String, String> adSearchInput) throws SQLException {
		return sqlSession.selectOne("search.count", adSearchInput);
	}

	@Override
	public List<CarpoolDTO> getAdSearchList(Map<String, String> adSearchInput) throws SQLException {
		return sqlSession.selectList("search.list", adSearchInput);
	}
}
