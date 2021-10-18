package wiicar.alerts.dto;

import java.sql.Timestamp;

public class AlertsDTO {
	private int chatNum;
	private int roomNum;
	private String sender;
	private String receiver;
	private String message;
	private int mes_check;
	private Timestamp reg;
	private int carpoolnum;
	private int chatType;
	public int getChatNum() {
		return chatNum;
	}
	public void setChatNum(int chatNum) {
		this.chatNum = chatNum;
	}
	public int getRoomNum() {
		return roomNum;
	}
	public void setRoomNum(int roomNum) {
		this.roomNum = roomNum;
	}
	public String getSender() {
		return sender;
	}
	public void setSender(String sender) {
		this.sender = sender;
	}
	public String getReceiver() {
		return receiver;
	}
	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public int getMes_check() {
		return mes_check;
	}
	public void setMes_check(int mes_check) {
		this.mes_check = mes_check;
	}
	public Timestamp getReg() {
		return reg;
	}
	public void setReg(Timestamp reg) {
		this.reg = reg;
	}
	public int getCarpoolnum() {
		return carpoolnum;
	}
	public void setCarpoolnum(int carpoolnum) {
		this.carpoolnum = carpoolnum;
	}
	public int getChatType() {
		return chatType;
	}
	public void setChatType(int chatType) {
		this.chatType = chatType;
	}
}
