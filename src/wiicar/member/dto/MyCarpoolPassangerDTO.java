package wiicar.member.dto;

import java.sql.Timestamp;

public class MyCarpoolPassangerDTO {
	private Integer carpoolNum;
	private String driverId;
	private String depart;
	private String destination;
	private String time;
	private Integer maxPassenger;
	private Integer passangerCount;
	private String tags;
	private Double distance;
	private Integer price;
	private Integer carmatching;
	private Timestamp reg;
	private long dateTime;
	private Integer acceptance;
	public Integer getCarpoolNum() {
		return carpoolNum;
	}
	public void setCarpoolNum(Integer carpoolNum) {
		this.carpoolNum = carpoolNum;
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
	public Integer getPassangerCount() {
		return passangerCount;
	}
	public void setPassangerCount(Integer passangerCount) {
		this.passangerCount = passangerCount;
	}
	public String getTags() {
		return tags;
	}
	public void setTags(String tags) {
		this.tags = tags;
	}
	public Double getDistance() {
		return distance;
	}
	public void setDistance(Double distance) {
		this.distance = distance;
	}
	public Integer getPrice() {
		return price;
	}
	public void setPrice(Integer price) {
		this.price = price;
	}
	public Integer getCarmatching() {
		return carmatching;
	}
	public void setCarmatching(Integer carmatching) {
		this.carmatching = carmatching;
	}
	public Timestamp getReg() {
		return reg;
	}
	public void setReg(Timestamp reg) {
		this.reg = reg;
	}
	public long getDateTime() {
		return dateTime;
	}
	public void setDateTime(long dateTime) {
		this.dateTime = dateTime;
	}
	public Integer getAcceptance() {
		return acceptance;
	}
	public void setAcceptance(Integer acceptance) {
		this.acceptance = acceptance;
	}
	
	
	
}
