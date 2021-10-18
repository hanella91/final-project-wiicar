package wiicar.carpool.dto;

import java.util.Date;

public class ReservationsDTO {
	private int carpoolnum,acceptance;
	private String passenger, driver, message;
	private Date reg;
	
	public int getCarpoolnum() {
		return carpoolnum;
	}
	public void setCarpoolnum(int carpoolnum) {
		this.carpoolnum = carpoolnum;
	}
	public int getAcceptance() {
		return acceptance;
	}
	public void setAcceptance(int acceptance) {
		this.acceptance = acceptance;
	}
	public String getPassenger() {
		return passenger;
	}
	public void setPassenger(String passenger) {
		this.passenger = passenger;
	}
	public String getDriver() {
		return driver;
	}
	public void setDriver(String driver) {
		this.driver = driver;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public Date getReg() {
		return reg;
	}
	public void setReg(Date reg) {
		this.reg = reg;
	}
	
	
}
