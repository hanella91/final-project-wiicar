package wiicar.carpool.dto;

import java.sql.Timestamp;

public class PayDTO {
	private Integer paynum;
	private String id;
	private Integer price;
	private Integer type;
	private Timestamp paydate;
	private Timestamp expiredate;
	private Integer paymentstate;
	private Integer carpoolNum;
	private String message;
	
	public Integer getCarpoolNum() {
		return carpoolNum;
	}
	public void setCarpoolNum(Integer carpoolNum) {
		this.carpoolNum = carpoolNum;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public Integer getPaynum() {
		return paynum;
	}
	public void setPaynum(Integer paynum) {
		this.paynum = paynum;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Integer getPrice() {
		return price;
	}
	public void setPrice(Integer price) {
		this.price = price;
	}
	public Integer getType() {
		return type;
	}
	public void setType(Integer type) {
		this.type = type;
	}
	public Timestamp getPaydate() {
		return paydate;
	}
	public void setPaydate(Timestamp paydate) {
		this.paydate = paydate;
	}
	public Timestamp getExpiredate() {
		return expiredate;
	}
	public void setExpiredate(Timestamp expiredate) {
		this.expiredate = expiredate;
	}
	public Integer getPaymentstate() {
		return paymentstate;
	}
	public void setPaymentstate(Integer paymentstate) {
		this.paymentstate = paymentstate;
	}
	
}
