package wiicar.carpool.service;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import wiicar.carpool.dao.CarpoolDAOImpl;
import wiicar.carpool.dao.PayDAOImpl;
import wiicar.carpool.dto.CarpoolDTO;
import wiicar.carpool.dto.PayDTO;
import wiicar.carpool.dto.ReservationsDTO;
import wiicar.chat.dao.ChatDAOImp;
import wiicar.chat.dto.RoomDTO;
import wiicar.member.dao.MemberDAOImpl;

@Service
public class PayServiceImpl implements PayService{

	@Autowired
	private PayDAOImpl payDAO = null;
	
	@Autowired
	private MemberDAOImpl memberDAO = null;
	
	@Autowired
	private CarpoolDAOImpl carpoolDAO = null;
	
	@Autowired
	private ChatDAOImp chatDAO = null;
	
	@Override
	public String kakaoPay(CarpoolDTO dto, String message) throws SQLException {
		try {
			int price = 0;
			PayDTO pdto = new PayDTO();
			pdto.setId((String)RequestContextHolder.getRequestAttributes().getAttribute("sid", RequestAttributes.SCOPE_SESSION));
			pdto.setPaymentstate(2);
			if(dto.getCarpoolNum() != null) {
				dto = carpoolDAO.getCarpool(dto);
				if(dto.getPrice() != null) 
					price = dto.getPrice();
				pdto.setPrice(price);
				pdto.setType(0);
				pdto.setExpiredate(null);
				pdto.setCarpoolNum(dto.getCarpoolNum());
				pdto.setMessage(message);
				payDAO.insertPay(pdto);
				pdto = payDAO.getPayment(pdto);
			} else {
				int is = memberDAO.isSubscription(pdto.getId());
				Calendar cal = Calendar.getInstance();
				pdto.setType(1);
				int total = 0;
				if(is == 0) {
					cal.setTime(new Date());
				} else {
					PayDTO pdto2 = payDAO.getPayment(pdto);
					pdto.setPaynum(pdto2.getPaynum());
					cal.setTime(pdto2.getExpiredate());
					total = pdto2.getPrice();
				}
					
				SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
				Timestamp time = null;
				
				if(dto.getPrice() == 1) {
					price = 1000;
					pdto.setPrice(total + price);
					cal.add(Calendar.DATE, 1);
				} else if(dto.getPrice() == 2) {
					price = 9800;
					pdto.setPrice(total + price);
					cal.add(Calendar.MONTH, 1);
				} else if(dto.getPrice() == 3) {
					price = 27000;
					pdto.setPrice(total + price);
					cal.add(Calendar.MONTH, 3);
				} else if(dto.getPrice() == 4) {
					price = 52000;
					pdto.setPrice(total + price);
					cal.add(Calendar.MONTH, 6);
				} else if(dto.getPrice() == 5) {
					price = 98000;
					pdto.setPrice(total + price);
					cal.add(Calendar.MONTH, 12);
				}
				time = Timestamp.valueOf(format.format(cal.getTime()) + " 00:00:00");
				pdto.setExpiredate(time);
				if(is != 0)
					payDAO.updatePay(pdto);
				else {
					payDAO.insertPay(pdto);
					pdto = payDAO.getPayment(pdto);
				}
			}
			
			int paynum = pdto.getPaynum();
			System.out.println("paynum : " + paynum);
			URL address = new URL("https://kapi.kakao.com/v1/payment/ready");
			HttpURLConnection conn = (HttpURLConnection) address.openConnection();
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Authorization", "KakaoAK bb8520d9fc279cf0855fe41487376f68");
			conn.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
			conn.setDoOutput(true);
			String param = "cid=TC0ONETIME&partner_order_id=partner_order_id&partner_user_id=partner_user_id&item_name=item_name&quantity=100000&total_amount=" + price + "&tax_free_amount=100&approval_url=http://localhost:8080/wiicar/carpoolPay/successPay.do?paynum=" + paynum + "&cancel_url=http://localhost:8080/wiicar/carpoolPay/cancelPay.do?paynum=" + paynum + "&fail_url=http://localhost:8080/wiicar/carpoolPay/failPay.do?paynum=" + paynum;
			OutputStream out = conn.getOutputStream();
			DataOutputStream data = new DataOutputStream(out);
			data.writeBytes(param);
			data.close();
			int res = conn.getResponseCode();
			
			InputStream in;
			if(res == 200) {
				in = conn.getInputStream();	
			} else {
				in = conn.getErrorStream();
			}
			InputStreamReader reader = new InputStreamReader(in);
			BufferedReader buff = new BufferedReader(reader);
			return buff.readLine();
			
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "{\"result\":\"NO\"}";
	}
	
	@Override
	public void successPay(int paynum) throws SQLException {

		int type = payDAO.getPayType(paynum);
		payDAO.successPay(paynum, type);
		String id = (String)RequestContextHolder.getRequestAttributes().getAttribute("sid", RequestAttributes.SCOPE_SESSION);
		if (type == 1) {
			RequestContextHolder.getRequestAttributes().setAttribute("subscription", id, RequestAttributes.SCOPE_SESSION);	
		}
		PayDTO pdto = new PayDTO();
		pdto.setPaynum(paynum);
		pdto = payDAO.getPayment(pdto);
		if(pdto.getCarpoolNum() != null) {
			CarpoolDTO cdto = new CarpoolDTO();
			cdto.setCarpoolNum(pdto.getCarpoolNum());
			cdto = carpoolDAO.getCarpool(cdto);
			ReservationsDTO rdto = new ReservationsDTO();
			rdto.setCarpoolnum(cdto.getCarpoolNum());
			rdto.setMessage(pdto.getMessage());
			rdto.setPassenger(id);
			rdto.setDriver(cdto.getDriverId());
			carpoolDAO.insertReservation(rdto);
			String message = "[예약요청] 회원님이 등록하신 카풀에 새로운 예약 요청이 들어왔습니다!<br /> 요청자 정보를 확인하고 수락 또는 거절을 눌러주세요! <button type=\"button\" class=\"btn check_request\" data-bs-toggle=\"modal\" data-bs-target=\"#requestInfoPopup\">예약 요청 확인하기</button>";
			int is = 0;
			is = chatDAO.isChatRoom(id, rdto.getDriver());
			if(is != 1) {
				RoomDTO room = new RoomDTO();
				room.setUser1(id);
				room.setUser2(rdto.getDriver());
				room.setCarpoolnum(cdto.getCarpoolNum());
				chatDAO.newChatRoom(room);
			}
			int roomnum = chatDAO.getRoomNum(id, rdto.getDriver());
			chatDAO.insertChat(id, message, rdto.getDriver(), "" + roomnum);
		}
	}
	
	@Override
	public void cancelPay(int paynum) throws SQLException {
		int type = payDAO.getPayType(paynum);
		if(type == 0)
			payDAO.cancelPay(paynum);
		else {
			PayDTO dto = new PayDTO();
			dto.setId((String)RequestContextHolder.getRequestAttributes().getAttribute("sid", RequestAttributes.SCOPE_SESSION));
			dto.setType(1);
			dto = payDAO.getPayment(dto);
			payDAO.rollback(dto);
		}
	}
	
	@Override
	public void failPay(int paynum) throws SQLException {
		int type = payDAO.getPayType(paynum);
		if(type == 0)
			payDAO.failPay(paynum);
		else {
			PayDTO dto = new PayDTO();
			dto.setId((String)RequestContextHolder.getRequestAttributes().getAttribute("sid", RequestAttributes.SCOPE_SESSION));
			dto.setType(1);
			dto = payDAO.getPayment(dto);
			payDAO.rollback(dto);
		}
	}
	
}
