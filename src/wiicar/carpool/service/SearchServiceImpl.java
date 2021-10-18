package wiicar.carpool.service;

import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.MultiValueMap;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

import wiicar.carpool.dao.CarpoolDAOImpl;
import wiicar.carpool.dao.SearchDAO;
import wiicar.carpool.dao.SearchDAOImpl;
import wiicar.carpool.dto.CarpoolDTO;
import wiicar.member.dto.MemberDTO;

@Service // component-scan 이용해 자동으로 빈으로 등록(객체생성)
public class SearchServiceImpl implements SearchService {

	@Autowired
	private SearchDAOImpl searchDAO = null;
	@Autowired
	private CarpoolDAOImpl carpoolDAO = null;
	
	// 검색한 여정 목록 가져오는 업무 메서드! (Main 검색)
	public Map<String, Object> doSearch(Map<String, String> input) throws SQLException {
		System.out.println("doSearch 실행");
		// DAO에게 넘겨준 다음 결과 받아올 변수 생성
		List<CarpoolDTO> searchList = null; // 검색된 r 담아줄 변수
		int count = 0; // 검색된 여정(카풀)의 개수
		long requestDateTime = 0; //time 변환한 수 담아줄 변수
		List<String> passengers = new ArrayList<String>();
		HashMap adSearchInfo = new HashMap();
		
		adSearchInfo.putAll(input);
		adSearchInfo.put("depart_sw_bound_lat", Double.parseDouble(input.get("depart_sw_bound_lat")));
		adSearchInfo.put("depart_sw_bound_lon", Double.parseDouble(input.get("depart_sw_bound_lon")));
		adSearchInfo.put("depart_ne_bound_lat", Double.parseDouble(input.get("depart_ne_bound_lat")));
		adSearchInfo.put("depart_ne_bound_lon", Double.parseDouble(input.get("depart_ne_bound_lon")));
		adSearchInfo.put("destination_sw_bound_lat", Double.parseDouble(input.get("destination_sw_bound_lat")));
		adSearchInfo.put("destination_sw_bound_lon", Double.parseDouble(input.get("destination_sw_bound_lon")));
		adSearchInfo.put("destination_ne_bound_lat", Double.parseDouble(input.get("destination_ne_bound_lat")));
		adSearchInfo.put("destination_ne_bound_lon", Double.parseDouble(input.get("destination_ne_bound_lon")));
		String orderbyColunm = "datetime";
		String orderbySort = "ASC";
		if (input.get("orderby") != null) {
			String orderby = input.get("orderby");
			String[] orderbyParts = orderby.split("_");
			orderbyColunm = orderbyParts[0];
			orderbySort = orderbyParts[1];
		}

		adSearchInfo.put("orderby_column", orderbyColunm);
		adSearchInfo.put("orderby_sort", orderbySort);
		
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		dateFormat.setTimeZone(java.util.TimeZone.getTimeZone("GMT+9"));
		try {
			Date requestDate = dateFormat.parse(input.get("time")); // 문자열 시간 Date타입으로 parsing
			requestDateTime = requestDate.getTime() / 1000; // 밀리세컨드 자리는 없애주
			System.out.println("변환결과 : " + requestDateTime);
			count = searchDAO.getSearchCount(adSearchInfo, requestDateTime);
			
			if (count > 0) {
				searchList = searchDAO.getSearchList(adSearchInfo, requestDateTime); // 검색 목록 세오는 SQL메서드
				System.out.println("searchList 갯수 :" + searchList.size());
			}
			
		} catch (Exception e) {
			e.printStackTrace();	
		}
		
		
		// Controller에 되돌려줄 값을 HashMap으로 받기
		Map<String, Object> searchResult = new HashMap<>();
		searchResult.put("searchCount", count);
		searchResult.put("searchList", searchList);
		
		return searchResult;
	}
	
	// 필터 검색용
	private HashMap prepareDAOInput(Map<String, String> input) throws SQLException {
		System.out.println(input);
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		dateFormat.setTimeZone(java.util.TimeZone.getTimeZone("GMT+9"));
		
		long requestDateTime = 0; //time 변환한 수 담아줄 변수
		HashMap adSearchInfo = new HashMap();
		adSearchInfo.putAll(input);
		// DAO 보내줄 값 설정

		String orderby = input.get("orderby");
		if (orderby == null) {orderby = "datetime_ASC";}
		String[] orderbyParts = orderby.split("_");
		String sel = orderbyParts[0];
		String sort = orderbyParts[1];
		adSearchInfo.put("orderby", orderby);
		adSearchInfo.put("sel", sel);
		adSearchInfo.put("sort", sort);
		
		try {
			Date requestDate = dateFormat.parse(input.get("time")); // 문자열 시간 Date타입으로 parsing
			requestDateTime = requestDate.getTime() / 1000; // 밀리세컨드 자리는 없애주
			adSearchInfo.put("time", requestDateTime);
			
			if(adSearchInfo.get("before_six_am") == null
				& adSearchInfo.get("six_to_noon") == null
				& adSearchInfo.get("noon_to_six") == null
				& adSearchInfo.get("after_six") == null
			) {
				adSearchInfo.put("default_time", requestDateTime);
			}
		} catch (Exception e) {
			e.printStackTrace();	
		}
		return adSearchInfo;
	}

	@Override
	public int doAdvancedCount(Map<String, String> input) throws SQLException {
		HashMap adSearchInfo = this.prepareDAOInput(input);
		return searchDAO.getAdSearchCount(adSearchInfo);
	}
	
	@Override
	public Map<String, Object> getSearchedCarpoolList(Map<String, String> input) throws SQLException {
		int count = 0;
		List<CarpoolDTO> carpoolList = null;
		HashMap adSearchInfo = this.prepareDAOInput(input);
		
		String pageNum = input.get("pageNum");
		System.out.println(pageNum);
		if(pageNum == null || pageNum == "") pageNum = "1";
		int pageSize = 5; 
		int currentPage = Integer.parseInt(pageNum); 
		int startRow = (currentPage - 1) * pageSize + 1; 
		int endRow = currentPage * pageSize; 
		
		adSearchInfo.put("start", startRow);
		adSearchInfo.put("end", endRow);
		count = searchDAO.getAdSearchCount(adSearchInfo);
		carpoolList = searchDAO.getAdSearchList(adSearchInfo);

		int listSize = carpoolList.size();
		
		String sid = (String)RequestContextHolder.getRequestAttributes().getAttribute("sid", RequestAttributes.SCOPE_SESSION);
		List<String[]> tagList = new ArrayList<String[]>();
		List<String> passengers = new ArrayList<String>();
		List<String[]> passengerIamges = new ArrayList<String[]>();
		List<String[]> passengerId = new ArrayList<String[]>();
		
		String[] nickname = new String[listSize];
		String[] driverImage = new String[listSize];
		int[] like = new int[listSize];
		double[] rate = new double[listSize];
		int[] passengercount = new int[listSize];
		int[] max = new int[listSize];
		String[] imgs = null;
		String[] ids = null;
		CarpoolDTO dto = new CarpoolDTO();
		MemberDTO driverdto = new MemberDTO();
		MemberDTO passengerdto = new MemberDTO();
		for(int i = 0; i < listSize; i++) {
			dto = carpoolList.get(i);
			if((driverdto = carpoolDAO.getMember(dto.getDriverId())) != null) {
				if(dto.getTags() != null) {
					tagList.add(dto.getTags().split(","));
				}
				rate[i] = driverdto.getDriverRate();
				nickname[i] = driverdto.getNickname();
				driverImage[i] = driverdto.getProfileImage();
				passengers = carpoolDAO.getPassengers(dto.getCarpoolNum());
				passengercount[i] = passengers.size();
				if(carpoolDAO.checkReservation(dto.getCarpoolNum(), sid) == 1) {
					max[i] = 2;
				}
				else {
					if(passengers.size() >= dto.getMaxPassenger()) {
						max[i] = 1;
					} else {
						max[i] = 0;
					}
				}
				if(passengers.size() == 0) {
					ids = null;
					imgs = null;
				} else if(passengers.size() != 0) {
					ids = new String[passengers.size()];
					imgs = new String[passengers.size()];
					for(int j = 0; j < passengers.size(); j++) {
						if((passengerdto = carpoolDAO.getMember(passengers.get(j))) != null) {
							ids[j] = passengerdto.getId();
							imgs[j] = passengerdto.getProfileImage();
						}
					}
				}
				passengerId.add(ids);
				passengerIamges.add(imgs);
			}
			like[i] = carpoolDAO.getLike(dto.getCarpoolNum(), sid);
		}
		
		String sel = input.get("sel");
		String sort = input.get("sort");
		
		// Controller에 되돌려줄 값을 HashMap으로 받기
		Map<String, Object> result = new HashMap<>();
		result.put("pageSize", pageSize);
		result.put("pageNum", pageNum);
		result.put("currentPage", currentPage);
		result.put("startRow", startRow);
		result.put("endRow", endRow);
		result.put("carpoolList", carpoolList);
		result.put("count", count);
		result.put("listSize",listSize);
		result.put("tagList", tagList);
		result.put("rate", rate);
		result.put("nickname", nickname);
		result.put("driverImage", driverImage);
		result.put("passengerIamges", passengerIamges);
		result.put("passengerId", passengerId);
		result.put("passengercount", passengercount);
		result.put("orderby", adSearchInfo.get("orderby"));
		result.put("max", max);
		result.put("like", like);
		
		return result;
	}
	
	


	/*
	// 타임스탬프 테스트용
	@Override
	public void timeTest(String time) throws SQLException {
		// humanDate => UnixTimestamp

		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		dateFormat.setTimeZone(java.util.TimeZone.getTimeZone("GMT+9"));
		try {
			Date requestDate = dateFormat.parse(time); // 문자열 시간 Date타입으로 parsing
			long requestDateTime = requestDate.getTime() / 1000; // 밀리세컨드 자리는 없애주
			System.out.println(requestDateTime);
			TimeDTO dto = new TimeDTO();
			dto.setDateTime(requestDateTime);
			searchDAO.insertTime(dto);
			
		
			//reverse
			Date date = new java.util.Data(requestDateTime*1000L);
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
			dateFormat.setTimeZone(java.util.TimeZone.getTimeZone("GMT+9"));
			String formattedDate = sdf.format(date);

		}catch(Exception e) {
			e.printStackTrace();	
		}
	}
	*/

}
