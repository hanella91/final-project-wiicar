package wiicar.admin.dto;

import java.sql.Timestamp;

public class CarLookDTO {

	private Integer carMatching; // 카풀상태 (0:매칭전 / 1:진행중(인원미달) / 2:예약완료 / 3:취소 / 4:카풀완료(오늘날짜이전)
	private String time; // 카풀시간(일정)
	private String depart; // 출발지
	private String destination; // 도착지
	private String driver; // 운전자 
	private String passenger; // 탑승자
	private Integer maxPassenger; // 최대탑승인원
	private Integer passengerCount; // 현재탑승인원
	private Timestamp carpoolreg; // 카풀 등록 날짜
	private String message; // 탑승자 요청사항
	private Integer acceptance; // 요청 상태 ( 0:대기 / 1:수락 / 2:거절)
	private Timestamp reservereg; // 예약요청날짜
	private String tags; // 운전자 요청사항
	private Integer price; // 인당가격
	public Integer getCarMatching() {
		return carMatching;
	}
	public void setCarMatching(Integer carMatching) {
		this.carMatching = carMatching;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public String getDepart() {
		return depart;
	}
	public void setDepart(String depart) {
		this.depart = depart;
	}
	public String getDestination() {
		return destination;
	}
	public void setDestination(String destination) {
		this.destination = destination;
	}
	public String getDriver() {
		return driver;
	}
	public void setDriver(String driver) {
		this.driver = driver;
	}
	public String getPassenger() {
		return passenger;
	}
	public void setPassenger(String passenger) {
		this.passenger = passenger;
	}
	public Integer getMaxPassenger() {
		return maxPassenger;
	}
	public void setMaxPassenger(Integer maxPassenger) {
		this.maxPassenger = maxPassenger;
	}
	public Integer getPassengerCount() {
		return passengerCount;
	}
	public void setPassengerCount(Integer passengerCount) {
		this.passengerCount = passengerCount;
	}
	public Timestamp getCarpoolreg() {
		return carpoolreg;
	}
	public void setCarpoolreg(Timestamp carpoolreg) {
		this.carpoolreg = carpoolreg;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public Integer getAcceptance() {
		return acceptance;
	}
	public void setAcceptance(Integer acceptance) {
		this.acceptance = acceptance;
	}
	public Timestamp getReservereg() {
		return reservereg;
	}
	public void setReservereg(Timestamp reservereg) {
		this.reservereg = reservereg;
	}
	public String getTags() {
		return tags;
	}
	public void setTags(String tags) {
		this.tags = tags;
	}
	public Integer getPrice() {
		return price;
	}
	public void setPrice(Integer price) {
		this.price = price;
	}
	
	
}
