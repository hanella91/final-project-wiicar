package wiicar.member.service;

import java.sql.SQLException;
import java.sql.Timestamp;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpSession;
import org.json.simple.JSONObject;
import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;
import wiicar.carpool.dao.CarpoolDAOImpl;
import wiicar.carpool.dto.CarpoolDTO;
import wiicar.member.dao.MemberDAOImpl;
import wiicar.member.dto.MemberDTO;
import wiicar.member.dto.MyCarpoolPassangerDTO;
import wiicar.member.dto.MyReservatitonDriverDTO;
import wiicar.carpool.dto.PayDTO;
import wiicar.carpool.dto.ReservationsDTO;
import wiicar.member.dao.MemberDAOImpl;
import wiicar.member.dto.MemberDTO;
import wiicar.review.dto.ReviewDTO;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDAOImpl memberDAO = null;
	
	@Autowired
	private CarpoolDAOImpl carpoolDAO = null;

	// 회원 확인
	@Override
	public int checkUserId(MemberDTO dto) throws SQLException {
		return memberDAO.checkUserId(dto);
	}

	// 비번 확인
	@Override
	public int checkUserPw(MemberDTO dto) throws SQLException {
		return memberDAO.checkUserPw(dto);
	}

	// 세션 만들기
	@Override
	public void sessionNickname(String id) {
		String nickname = "";
		try {
			nickname = memberDAO.getNickname(id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		RequestContextHolder.getRequestAttributes().setAttribute("sid", nickname, RequestAttributes.SCOPE_SESSION);		
		System.out.println("service id : " + (String)RequestContextHolder.getRequestAttributes().getAttribute("sid", RequestAttributes.SCOPE_SESSION));
	}

	// 회원가입
	@Override
	public void insertUser(MemberDTO dto) throws SQLException {
		dto.setPreference(dto.getPreference().replace("0", ""));
		String preference = "";
		HashSet<Character> set = new HashSet<>();
		for(char c : dto.getPreference().toCharArray()) {
			if(!set.contains(c)) preference += c;
			set.add(c);
		}
		dto.setPreference(preference);
		memberDAO.insertUser(dto);
		sessionNickname(dto.getNickname());
	}

	// 문자 전송 및 4-자리 숫자 코드 생성
	@Override
	public String verifyPhone(String phone) {
		System.out.println("번호 인증");
		String api_key = "NCSKSTRRXOM3YUIA";
		String api_secret = "XHYHS6VDVJKHITENGQVOQGEWKZPVJ2PR";
		Message coolsms = new Message(api_key, api_secret);
		
		String vcode = (int)(Math.random() * 10000) + "";
		if(vcode.length() < 4) {
			while(vcode.length() < 4) {
				vcode += "0";			
			}
		}
		System.out.println("vcode : " + vcode);
	    // 4 params(to, from, type, text) are mandatory. must be filled
	    HashMap<String, String> params = new HashMap<String, String>();
	    params.put("to", phone);
	    params.put("from", "01065170219");
	    params.put("type", "SMS");
	    params.put("text", "4-digit code for phone verification : " + vcode);
	    params.put("app_version", "test app 1.2"); // application name and version
	    System.out.println("params : " + params);
	    try {
	    	JSONObject obj = (JSONObject) coolsms.send(params);
	    	System.out.println(obj.toString());
	    } catch (CoolsmsException e) {
	    	System.out.println(e.getMessage());
	    	System.out.println(e.getCode());
	    }
		return vcode;
	}

	// 회원 1명 정보 가져오기
	@Override
	public MemberDTO getMemberInfo() throws SQLException {
		String nickname = (String)RequestContextHolder.getRequestAttributes().getAttribute("sid", RequestAttributes.SCOPE_SESSION);
		return memberDAO.getMemberInfo(nickname);
	}

	// 비밀번호 확인
	@Override
	public int checkUserPw(String pw) throws SQLException {
		String nickname = (String)RequestContextHolder.getRequestAttributes().getAttribute("sid", RequestAttributes.SCOPE_SESSION);
		MemberDTO dto = new MemberDTO();
		dto.setId(nickname);
		dto.setPw(pw);
		return memberDAO.checkUserPw(dto);
	}

	// 로그인 여부 확인
	@Override
	public int checkLogin() {
		if((String)RequestContextHolder.getRequestAttributes().getAttribute("sid", RequestAttributes.SCOPE_SESSION) != null) {
			return 1;
		} else {
			return 0;			
		}
	}

	// 회원 정보 수정
	@Override
	public void updateMemberInfo(MemberDTO dto) throws SQLException {
		dto.setPreference(dto.getPreference().replace("0", ""));
		String preference = "";
		HashSet<Character> set = new HashSet<>();
		for(char c : dto.getPreference().toCharArray()) {
			if(!set.contains(c)) preference += c;
			set.add(c);
		}
		dto.setPreference(preference);
		memberDAO.updateMemberInfo(dto);
		sessionNickname(dto.getId());
	}

	// 사진 수정
	@Override
	public void updateImage(String img, String type) throws SQLException {
		memberDAO.updateImage(img, type, (String)RequestContextHolder.getRequestAttributes().getAttribute("sid", RequestAttributes.SCOPE_SESSION));
	}

	// 로그아웃
	@Override
	public void logout() {
		HttpSession session = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest().getSession(true);
		session.invalidate();
	}

	// 회원 탈퇴
	@Override
	public void deleteMember() throws SQLException {
		memberDAO.deleteMember((String)RequestContextHolder.getRequestAttributes().getAttribute("sid", RequestAttributes.SCOPE_SESSION));
		logout();
	}
	
	// 닉네임 중복확인
	@Override
	public int checkNickname(String nickname) throws SQLException {
		return memberDAO.checkNickname(nickname);
	}

	@Override
	public Map<String, Object> getMyProfile() throws SQLException {
		
		String id = (String)RequestContextHolder.getRequestAttributes().getAttribute("sid", RequestAttributes.SCOPE_SESSION);
		
		
		List<ReviewDTO> driverReview = new ArrayList<ReviewDTO>();
		List<ReviewDTO> passengerReview = new ArrayList<ReviewDTO>();
		MemberDTO dto = new MemberDTO();
		dto = memberDAO.getMemberInfo(id);
		driverReview = memberDAO.getDriverReview(id);
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
			driverReviewImgs[i] = memberDAO.getMemberInfo(driverReview.get(i).getId()).getProfileImage();
		}
		passengerReview = memberDAO.getPassengerReview(id);
		int passengerReviewCount = passengerReview.size();
		String[] passengerReviewImgs = new String[passengerReviewCount];
		for(int i = 0; i < passengerReviewCount; i++) {
			passengerReviewImgs[i] = memberDAO.getMemberInfo(passengerReview.get(i).getId()).getProfileImage();
		}
		Calendar today = Calendar.getInstance();
		int year = today.get(Calendar.YEAR);
		today.setTime(dto.getBirth());
		int age = year - today.get(Calendar.YEAR);
		int reportcount = memberDAO.getReportCount(id);
		int carpoolrecord = memberDAO.getCarpoolRecord(id);
		int carpoolused = memberDAO.getCarpoolUsed(id);
		Map<String, Object> result = new HashMap<String, Object>();
		String[] preference = null;
		if(dto.getPreference() != null) {
			preference = dto.getPreference().split(",");
			for(int i = 0; i < preference.length; i++ ) {
				if(preference[i].equals("1")) {
					preference[i] = "대화가 없는걸 선호해요";
				} else if(preference[i].equals("2")) {
					preference[i] = "사적인 질문은 피해주세요";
				} else if(preference[i].equals("3")) {
					preference[i] = "적당한 대화가 좋아요";
				} else if(preference[i].equals("4")) {
					preference[i] = "음악 듣는 걸	 좋아해요";
				} else if(preference[i].equals("5")) {
					preference[i] = "반려동물과 같이 가도 괜찮아요";
				} else if(preference[i].equals("6")) {
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
	public Map<String, Object> getLikeCarpoolList(String pageNum, String sel, String sort) throws SQLException {
		
		int pageSize = 5; 
		if(pageNum == null || pageNum == "") pageNum = "1";
		if(sel == null) sel = "reg";
		
		int currentPage = Integer.parseInt(pageNum); 
		int startRow = (currentPage - 1) * pageSize + 1; 
		int endRow = currentPage * pageSize; 
		
		List<CarpoolDTO> carpoolList = null;  	
		int count = 0; 			
		
		String id = (String)RequestContextHolder.getRequestAttributes().getAttribute("sid", RequestAttributes.SCOPE_SESSION);
		
		count = memberDAO.getLikeCarpoolCount(id);   
		int listSize = 0;
		if(count > 0) {
			carpoolList = memberDAO.getLikeCarpoolList(startRow, endRow, sel, sort, id);
			listSize = carpoolList.size();
		}
		
		List<String[]> tagList = new ArrayList<String[]>();
		List<String> passengers = new ArrayList<String>();
		List<String[]> passengerIamges = new ArrayList<String[]>();
		List<String[]> passengerId = new ArrayList<String[]>();
		
		String[] nickname = new String[listSize];
		String[] driverImage = new String[listSize];
		int[] like = new int[listSize];
		double[] rate = new double[listSize];
		int[] passengercount = new int[listSize];
		String[] imgs = null;
		String[] ids = null;
		CarpoolDTO dto = new CarpoolDTO();
		MemberDTO driverdto = new MemberDTO();
		MemberDTO passengerdto = new MemberDTO();
		for(int i = 0; i < listSize; i++) {
			dto = carpoolList.get(i);
			if((driverdto = memberDAO.getMemberInfo(dto.getDriverId())) != null) {
				if(dto.getTags() != null) {
					tagList.add(dto.getTags().split(","));					
				}
				rate[i] = driverdto.getDriverRate();
				nickname[i] = driverdto.getNickname();
				driverImage[i] = driverdto.getProfileImage();
				passengers = carpoolDAO.getPassengers(dto.getCarpoolNum());
				passengercount[i] = passengers.size();
				if(passengers.size() == 0) {
					ids = null;
					imgs = null;
				} else if(passengers.size() != 0) {
					ids = new String[passengers.size()];
					imgs = new String[passengers.size()];
					for(int j = 0; j < passengers.size(); j++) {
						if((passengerdto = memberDAO.getMemberInfo(passengers.get(j))) != null) {
							ids[j] = passengerdto.getId();
							imgs[j] = passengerdto.getProfileImage();
						}
					}
				}
				passengerId.add(ids);
				passengerIamges.add(imgs);
			}
			like[i] = carpoolDAO.getLike(dto.getCarpoolNum(), id);
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
		result.put("sel", sel);
		result.put("sort", sort);
		result.put("like", like);

		return result;
		
	}
	
	@Override
	public Timestamp getMySubscription() throws SQLException {
		
		String id = (String)RequestContextHolder.getRequestAttributes().getAttribute("sid", RequestAttributes.SCOPE_SESSION);
		
		int res = memberDAO.isSubscription(id);
		Timestamp subsciption = null;
		if(res != 0) {			
			PayDTO pdto = memberDAO.getMySubscription(id);
			subsciption = pdto.getExpiredate();
		}
		return subsciption;
	}
	
	// 운전자 예약 현황
	@Override
	public Map<String, Object> getDriversReservation(String pageNum) throws SQLException {
		
		String id = (String)RequestContextHolder.getRequestAttributes().getAttribute("sid", RequestAttributes.SCOPE_SESSION);

		int pageSize = 5; 
		if(pageNum == null || pageNum == "") pageNum = "1";
		int currentPage = Integer.parseInt(pageNum); 
		int startRow = (currentPage - 1) * pageSize + 1; 
		int endRow = currentPage * pageSize; 
		
		List<ReservationsDTO> reservationList = null;  	
		int listSize = 0;
		
		reservationList = memberDAO.driverReservationList(startRow, endRow, id);
		listSize = reservationList.size();
		
		String[] passangerNickname = new String[listSize];
		String[] passangerImage = new String[listSize];
		double[] rate = new double[listSize];
		int[] roomNum = new int[listSize];
		CarpoolDTO[] carpoolInfo = new CarpoolDTO[listSize];
		ReservationsDTO reservationDTO = new ReservationsDTO();
		MemberDTO passangerdto = new MemberDTO();
		for(int i = 0; i < listSize; i++) {
			reservationDTO = reservationList.get(i);
			if((passangerdto = memberDAO.getMemberInfo(reservationDTO.getPassenger())) != null) {
				carpoolInfo[i] = carpoolDAO.getCarpoolInfo(reservationDTO.getCarpoolnum());
				rate[i] = passangerdto.getPassengerRate();
				roomNum[i] = memberDAO.getRoomNum(reservationDTO.getCarpoolnum(), reservationDTO.getDriver(), reservationDTO.getPassenger());
				passangerNickname[i] = passangerdto.getNickname();
				passangerImage[i] = passangerdto.getProfileImage();
			}
		}
		
		
	

		Map<String, Object> result = new HashMap<>();
		result.put("pageSize", pageSize);
		result.put("pageNum", pageNum);
		result.put("currentPage", currentPage);
		result.put("startRow", startRow);
		result.put("endRow", endRow);
		result.put("reservationList", reservationList);
		result.put("listSize",listSize);
		result.put("rate", rate);
		result.put("roomNum", roomNum);
		result.put("passangerNickname", passangerNickname);
		result.put("passangerImage", passangerImage);
		result.put("carpoolInfo", carpoolInfo);

		return result;
	}


	
	@Override
	public Map<String, Object> getDriversUpcomeList(String pageNum) throws SQLException {
		
		int pageSize = 5; 
		if(pageNum == null || pageNum == "") pageNum = "1";
		int currentPage = Integer.parseInt(pageNum); 
		int startRow = (currentPage - 1) * pageSize + 1; 
		int endRow = currentPage * pageSize; 
		
	
		String sid = (String)RequestContextHolder.getRequestAttributes().getAttribute("sid", RequestAttributes.SCOPE_SESSION);
		List<CarpoolDTO> carpoolList = null;  	
		if(memberDAO.driverUpComeList(sid, startRow, endRow) != null) {
		carpoolList = memberDAO.driverUpComeList(sid, startRow, endRow);
		}
		int listSize = carpoolList.size();
		
		List<String[]> tagList = new ArrayList<String[]>();
		List<String> passengers = new ArrayList<String>();
		List<String[]> passengerIamges = new ArrayList<String[]>();
		List<String[]> passengerId = new ArrayList<String[]>();
		
		String[] nickname = new String[listSize];
		String[] driverImage = new String[listSize];
		int[] like = new int[listSize];
		double[] rate = new double[listSize];
		int[] passengercount = new int[listSize];
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
		
		Map<String, Object> result = new HashMap<>();
		result.put("pageSize", pageSize);
		result.put("pageNum", pageNum);
		result.put("currentPage", currentPage);
		result.put("startRow", startRow);
		result.put("endRow", endRow);
		result.put("carpoolList", carpoolList);
		result.put("count",listSize);
		result.put("tagList", tagList);
		result.put("rate", rate);
		result.put("nickname", nickname);
		result.put("driverImage", driverImage);
		result.put("passengerIamges", passengerIamges);
		result.put("passengerId", passengerId);
		result.put("passengercount", passengercount);
		result.put("like", like);
		return result;
	}
	
	@Override
	   public Map<String, Object> getDriversPastList(String pageNum) throws SQLException {
	      String sid = (String)RequestContextHolder.getRequestAttributes().getAttribute("sid", RequestAttributes.SCOPE_SESSION);
	      if(pageNum == null) {
	         pageNum = "1";
	      }
	      int count = 0;    
	      count = memberDAO.getDriverPastCount(sid);
	      int pageSize = 5;
	      int currentPage = Integer.parseInt(pageNum); 
	      int start = (currentPage - 1) * pageSize + 1; 
	      int end = currentPage * pageSize; 
	      int[] reviewCheck = null;
	      if(end > count) {
	         end = count;
	      }
	      List<CarpoolDTO> carpoolList = null;     
	      List<ReservationsDTO> reservationsList = null;
	      MemberDTO driver = new MemberDTO();
	      List<MemberDTO> passengers = new ArrayList<MemberDTO>();
	      int listSize = 0;
	      if(count > 0) {
	         carpoolList = memberDAO.driverPastCarpool(sid, start, end);
	         reservationsList = memberDAO.driverPastReservation(sid, start, end);
	         listSize = carpoolList.size();
	         reviewCheck = new int[listSize];
	         driver = memberDAO.getMemberInfo(sid);
	         for(int i = 0; i < listSize; i++) {
	            passengers.add(memberDAO.getMemberInfo(reservationsList.get(i).getPassenger()));
	            reviewCheck[i] = memberDAO.getReviewCheck(carpoolList.get(i).getCarpoolNum(), sid, 1);
	         }
	      }
	      Map<String, Object> result = new HashMap<>();
	      result.put("carpoolList", carpoolList);
	      result.put("reservationsList", reservationsList);
	      result.put("count", count);
	      result.put("listSize",listSize);
	      result.put("driver",driver);
	      result.put("reviewCheck",reviewCheck);
	      result.put("passengers",passengers);
	      result.put("pageSize",pageSize);
	      result.put("pageNum",pageNum);
	      result.put("currentPage",currentPage);
	      result.put("startRow",start);
	      result.put("endRow",end);
	      
	      return result;
	   }


	   @Override
	   public Map<String, Object> getPassangersCarpoolList(String sort) throws SQLException {
	      System.out.println("getPassangerReservation 실행");
	      int pageSize = 5; 

	      String id = (String)RequestContextHolder.getRequestAttributes().getAttribute("sid", RequestAttributes.SCOPE_SESSION);
	      List<ReservationsDTO> reservationList = null;
	      List<CarpoolDTO> carpoolList = null;     
	         if(sort.equals("upcomming")) {
	            reservationList = memberDAO.passangerUpcommingList(id);
	          }else{
	            reservationList = memberDAO.passangerPastList(id);
	          }
	         
	      
	      int listSize = reservationList.size();
	      int[] carpoolNum = new int[listSize];
	      
	      for(int i = 0; i < listSize; i++) {
	         carpoolNum[i] = (reservationList.get(i).getCarpoolnum());
	         carpoolList = memberDAO.myCarpoolList2(carpoolNum[i]);
	      }

	      
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
	      ReservationsDTO reservationDTO = new ReservationsDTO();
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
	            if(carpoolDAO.checkReservation(dto.getCarpoolNum(), id) == 1) {
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
	         like[i] = carpoolDAO.getLike(dto.getCarpoolNum(), id);
	      }
	      Map<String, Object> result = new HashMap<>();
	      result.put("reservationList", reservationList);
	      result.put("pageSize", pageSize);
	      result.put("carpoolList", carpoolList);
	      result.put("listSize",listSize);
	      result.put("tagList", tagList);
	      result.put("rate", rate);
	      result.put("nickname", nickname);
	      result.put("driverImage", driverImage);
	      result.put("passengerIamges", passengerIamges);
	      result.put("passengerId", passengerId);
	      result.put("passengercount", passengercount);
	      result.put("like", like);
	      result.put("max", max);

	      return result;
	   
	}
	// 마이페이지 내 카풀 탑승자 입장에서 -> 채팅방
	@Override
	public int driverContact(String userId, String chatId) throws SQLException {
		int roomnum = memberDAO.driverContact(userId, chatId);
		return roomnum;
	}

	//탑승자 예약리스트
	@Override
	public Map<String, Object> getPassangerReservation() throws SQLException {
		System.out.println("getPassangerReservation 실행");
		int pageSize = 5; 

		String id = (String)RequestContextHolder.getRequestAttributes().getAttribute("sid", RequestAttributes.SCOPE_SESSION);
		List<ReservationsDTO> reservationList = null;
		List<CarpoolDTO> carpoolList = null;  	
		reservationList = memberDAO.passangerReservationList(id);
		int listSize = reservationList.size();
		int[] carpoolNum = new int[listSize];
		
		for(int i = 0; i < listSize; i++) {
			carpoolNum[i] = (reservationList.get(i).getCarpoolnum());
			carpoolList = memberDAO.myCarpoolList(carpoolNum[i]);
		}
		
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
		ReservationsDTO reservationDTO = new ReservationsDTO();
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
				if(carpoolDAO.checkReservation(dto.getCarpoolNum(), id) == 1) {
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
			like[i] = carpoolDAO.getLike(dto.getCarpoolNum(), id);

		}
		Map<String, Object> result = new HashMap<>();
		result.put("reservationList", reservationList);
		result.put("pageSize", pageSize);
		result.put("carpoolList", carpoolList);
		result.put("listSize",listSize);
		result.put("tagList", tagList);
		result.put("rate", rate);
		result.put("nickname", nickname);
		result.put("driverImage", driverImage);
		result.put("passengerIamges", passengerIamges);
		result.put("passengerId", passengerId);
		result.put("passengercount", passengercount);
		result.put("like", like);
		result.put("max", max);

		return result;
	}
	

	@Override
	public void reviewInsert(String type, String num, String id, int rate, String content) throws SQLException {
		String sid = (String)RequestContextHolder.getRequestAttributes().getAttribute("sid", RequestAttributes.SCOPE_SESSION);
		int t = Integer.parseInt(type);
		ReviewDTO dto = new ReviewDTO();
		dto.setCarpoolNum(Integer.parseInt(num));
		dto.setType(t);
		dto.setId(id);
		dto.setRate(rate);
		dto.setWriter(sid);
		dto.setContent(content);
		memberDAO.reviewInsert(dto);
		double sum = memberDAO.sumRate(sid , t);
		double count = memberDAO.getReviewCount(sid, t);
		double updateRate = Double.parseDouble(String.format("%.1f", sum / count));
		MemberDTO mdto = memberDAO.getMemberInfo(id);
		if(t == 0) {
			mdto.setDriverRate(updateRate);
		} else {
			mdto.setPassengerRate(updateRate);
		}
		memberDAO.updateMemberInfo(mdto);
		
	}


	// 관리자 로그인 처리
	@Override
	public int adminLoginPro(String nickname, String pw) throws SQLException {
		MemberDTO dto = new MemberDTO();
		dto.setNickname(nickname);
		dto.setPw(pw);
		int result = memberDAO.checkUserPw(dto);
		if(result == 1) {
			RequestContextHolder.getRequestAttributes().setAttribute("sid", nickname, RequestAttributes.SCOPE_SESSION);					
		}
		return result;
	}

	// 관리자 여부 확인 
	@Override
	public int checkAdmin() throws SQLException {
		return memberDAO.checkAdmin((String)RequestContextHolder.getRequestAttributes().getAttribute("sid", RequestAttributes.SCOPE_SESSION));
	}
   @Override
   public void sessionSubsription() throws SQLException {
      String id = (String)RequestContextHolder.getRequestAttributes().getAttribute("sid", RequestAttributes.SCOPE_SESSION);
      if(memberDAO.getSubscription(id) != 0) {
         System.out.println("월정액 세션 생성");
         RequestContextHolder.getRequestAttributes().setAttribute("subscription", id, RequestAttributes.SCOPE_SESSION);   
      }
   }

}

