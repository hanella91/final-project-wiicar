package wiicar.carpool.service;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

import wiicar.carpool.dao.CarpoolDAOImpl;
import wiicar.carpool.dao.SearchDAOImpl;
import wiicar.carpool.dto.CarpoolDTO;
import wiicar.member.dto.MemberDTO;
import wiicar.review.dto.ReviewDTO;

@Service
public class CarpoolServiceImpl implements CarpoolService{

	@Autowired
	private CarpoolDAOImpl carpoolDAO = null;
	@Autowired
	private SearchDAOImpl searchDAO = null;
	 
	// 카풀 등록
	@Override
	public void addCarpool(CarpoolDTO dto) throws SQLException{
	      long requestDateTime = 0;
	      SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	      dateFormat.setTimeZone(java.util.TimeZone.getTimeZone("GMT+9"));
	      
	      try {
	         Date requestDate = dateFormat.parse(dto.getTime());
	         System.out.println(dto.getTime());
	         requestDateTime = requestDate.getTime() / 1000;
	         dto.setDateTime(requestDateTime);
	         carpoolDAO.insertCarpool(dto);
	   
	      } catch (Exception e) {
	         e.printStackTrace();   
	      }

	   }
	
	
	@Override
	public CarpoolDTO getCarpool(CarpoolDTO dto) {
		System.out.println("getCarpool실행");
		return carpoolDAO.getCarpool(dto);
	}
	
	@Override
	public Map<String, Object> getCarpoolList(String pageNum, String orderby){
		
		int pageSize = 5; 
		if(pageNum == null || pageNum == "") pageNum = "1";
		
		if (orderby == null) {orderby = "reg_asc";}
		String[] orderbyParts = orderby.split("_");
		String sel = orderbyParts[0];
		String sort = orderbyParts[1];
		
		
		int currentPage = Integer.parseInt(pageNum); 
		int startRow = (currentPage - 1) * pageSize + 1; 
		int endRow = currentPage * pageSize; 
		
		List<CarpoolDTO> carpoolList = null;  	
		int count = 0; 			
		
		
		count = carpoolDAO.getCarpoolCount();   
		if(count > 0)
			carpoolList = carpoolDAO.getCarpoolList(startRow, endRow, sel, sort); // 전체 리스트

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
							ids[j] = passengerdto.getNickname();
							imgs[j] = passengerdto.getProfileImage();
						}
					}
				}
				passengerId.add(ids);
				passengerIamges.add(imgs);
			}
			like[i] = carpoolDAO.getLike(dto.getCarpoolNum(), sid);
		}
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
		result.put("orderby", orderby);
		result.put("like", like);
		result.put("max", max);

		return result;
	}

	@Override
	public int checkLike(int carpoolNum) {
		String sid = (String)RequestContextHolder.getRequestAttributes().getAttribute("sid", RequestAttributes.SCOPE_SESSION);
		return carpoolDAO.checkLike(carpoolNum, sid);
	}
	
	@Override
	public Map<String, Object> getUserProfile(String id) {
		
		List<ReviewDTO> driverReview = new ArrayList<ReviewDTO>();
		List<ReviewDTO> passengerReview = new ArrayList<ReviewDTO>();
		MemberDTO dto = new MemberDTO();
		dto = carpoolDAO.getMember(id);
		driverReview = carpoolDAO.getDriverReview(id);
		String carModel = "";
		if(dto.getCarModel() != null) {
			if(dto.getCarModel().equals("1")) {
				carModel = "소형";
			} else if(dto.getCarModel().equals("2")){
				carModel = "중형";
			} else if(dto.getCarModel().equals("3")) {
				carModel = "대형";
			}
		} else {
			carModel ="없음";
		}
		int driverReviewCount = driverReview.size();
		String[] driverReviewImgs = new String[driverReviewCount];
		for(int i = 0; i < driverReviewCount; i++) {
			driverReviewImgs[i] = carpoolDAO.getMember(driverReview.get(i).getId()).getProfileImage();
		}
		passengerReview = carpoolDAO.getPassengerReview(id);
		int passengerReviewCount = passengerReview.size();
		String[] passengerReviewImgs = new String[passengerReviewCount];
		for(int i = 0; i < passengerReviewCount; i++) {
			passengerReviewImgs[i] = carpoolDAO.getMember(passengerReview.get(i).getId()).getProfileImage();
		}
		Calendar today = Calendar.getInstance();
		int year = today.get(Calendar.YEAR);
		today.setTime(dto.getBirth());
		int age = year - today.get(Calendar.YEAR);
		int reportcount = carpoolDAO.getReportCount(id);
		int carpoolrecord = carpoolDAO.getCarpoolRecord(id);
		int carpoolused = carpoolDAO.getCarpoolUsed(id);
		Map<String, Object> result = new HashMap<String, Object>();
		String[] preference = null;
		if(dto.getPreference() != null) {
			preference = dto.getPreference().split(",");
			for(int i = 0; i < preference.length; i++ ) {
				if(preference[i].equals("1")) {
					preference[i] = "대화가 없는걸 선호해요";
				} else if(preference[i].equals("1")) {
					preference[i] = "사적인 질문은 피해주세요";
				} else if(preference[i].equals("2")) {
					preference[i] = "적당한 대화가 좋아요";
				} else if(preference[i].equals("3")) {
					preference[i] = "음악 듣는 걸 좋아해요";
				} else if(preference[i].equals("4")) {
					preference[i] = "반려동물과 같이 가도 괜찮아요";
				} else if(preference[i] .equals("5")) {
					preference[i] = "반려동물과 같이 가고싶지 않아요";
				}
			}
		}
		
		result.put("carModel",carModel);
		result.put("preference",preference);
		result.put("carpoolrecord",carpoolrecord);
		result.put("carpoolused",carpoolused);
		result.put("reportcount",reportcount);
		result.put("age",age);
		result.put("dto", dto);
		result.put("driverReview", driverReview);
		result.put("driverReviewCount", driverReviewCount);
		result.put("driverReviewImgs", driverReviewImgs);
		result.put("passengerReview", passengerReview);
		result.put("passengerReviewCount", passengerReviewCount);
		result.put("passengerReviewImgs", passengerReviewImgs);
		
		return result;
	}
	
	@Override
	public Map<String, Object> getReqeust(int num) {
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		CarpoolDTO dto = new CarpoolDTO();
		dto.setCarpoolNum(num);
		dto = carpoolDAO.getCarpool(dto);
		
		if(dto.getTags() != null) {
			String[] tags = dto.getTags().split(",");
			result.put("tags",tags);
		}
		result.put("dto", dto);
		
		
		return result; 
	}

}
