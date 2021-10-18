package wiicar.carpool.dto;

import java.sql.Date;
import java.sql.Timestamp;

public class CarpoolDTO {

	private Integer carpoolNum;
	private String driverId;
	private String depart;
	private Double depart_lat;
	private Double depart_lon;
	private String destination;
	private Double destination_lat;
	private Double destination_lon;
	private String time;
	private Integer maxPassenger;
	private Integer passangerCount;
	private String tags;
	private Double distance;
	private Integer price;
	private Integer carmatching;
	private Timestamp reg;
	private long dateTime;
	private Integer refundcheck;
	
	
	public Integer getRefundcheck() {
		return refundcheck;
	}
	public void setRefundcheck(Integer refundcheck) {
		this.refundcheck = refundcheck;
	}
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
	public Double getDepart_lat() {
		return depart_lat;
	}
	public void setDepart_lat(Double depart_lat) {
		this.depart_lat = depart_lat;
	}
	public Double getDepart_lon() {
		return depart_lon;
	}
	public void setDepart_lon(Double depart_lon) {
		this.depart_lon = depart_lon;
	}
	public String getDestination() {
		return destination;
	}
	public void setDestination(String destination) {
		this.destination = destination;
	}
	public Double getDestination_lat() {
		return destination_lat;
	}
	public void setDestination_lat(Double destination_lat) {
		this.destination_lat = destination_lat;
	}
	public Double getDestination_lon() {
		return destination_lon;
	}
	public void setDestination_lon(Double destination_lon) {
		this.destination_lon = destination_lon;
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

	

	
}
