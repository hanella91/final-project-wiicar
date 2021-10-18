package wiicar.member.dto;

import java.sql.Timestamp;
import java.util.Date;

public class MyReservatitonDriverDTO {

	private Integer roomNum;
	private Integer carpoolNum;
	private String passenger;
	private String profileImage;
	private Double passengerRate;
	private String message;
	private Timestamp reg;
	private String driverId;
	private String depart;
	private String destination;
	private String time;
	private Integer maxPassenger;
	private Integer passengerCount;
	private Integer price;
	
	
	
	public Integer getRoomNum() {
		return roomNum;
	}
	public void setRoomNum(Integer roomNum) {
		this.roomNum = roomNum;
	}
	public Integer getCarpoolNum() {
		return carpoolNum;
	}
	public void setCarpoolNum(Integer carpoolNum) {
		this.carpoolNum = carpoolNum;
	}
	public String getPassenger() {
		return passenger;
	}
	public void setPassenger(String passenger) {
		this.passenger = passenger;
	}
	public String getProfileImage() {
		return profileImage;
	}
	public void setProfileImage(String profileImage) {
		this.profileImage = profileImage;
	}
	public Double getPassengerRate() {
		return passengerRate;
	}
	public void setPassengerRate(Double passengerRate) {
		this.passengerRate = passengerRate;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public Timestamp getReg() {
		return reg;
	}
	public void setReg(Timestamp reg) {
		this.reg = reg;
	}
	public String getDriverId() {
		return driverId;
	}
	public void setDriverId(String driverId) {
		this.driverId = driverId;
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
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
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
	public Integer getPrice() {
		return price;
	}
	public void setPrice(Integer price) {
		this.price = price;
	}
	

}
