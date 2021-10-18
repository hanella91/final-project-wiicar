package wiicar.chat.dto;

import java.sql.Timestamp;

public class MatchingDTO {
	private Integer carpoolnum;
	private String driverid;
	private String depart;
	private String destination;
	private String time; 
	private Integer maxpassenger;
	private Integer passengercount;
	private String tags;
	private String passenger;
	private String message;
	
	public Integer getCarpoolnum() {
		return carpoolnum;
	}
	public void setCarpoolnum(Integer carpoolnum) {
		this.carpoolnum = carpoolnum;
	}
	public String getDriverid() {
		return driverid;
	}
	public void setDriverid(String driverid) {
		this.driverid = driverid;
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
	public Integer getMaxpassenger() {
		return maxpassenger;
	}
	public void setMaxpassenger(Integer maxpassenger) {
		this.maxpassenger = maxpassenger;
	}
	public Integer getPassengercount() {
		return passengercount;
	}
	public void setPassengercount(Integer passengercount) {
		this.passengercount = passengercount;
	}
	public String getTags() {
		return tags;
	}
	public void setTags(String tags) {
		this.tags = tags;
	}
	public String getPassenger() {
		return passenger;
	}
	public void setPassenger(String passenger) {
		this.passenger = passenger;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	
	
}