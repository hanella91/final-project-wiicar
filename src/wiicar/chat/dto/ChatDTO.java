package wiicar.chat.dto;

import java.sql.Timestamp;

public class ChatDTO {

	private int chatnum, roomnum, mes_check, carpoolnum;
	private String sender, receiver, message;
	private Timestamp reg;
	
	public int getCarpoolnum() {
		return carpoolnum;
	}
	public void setCarpoolnum(int carpoolnum) {
		this.carpoolnum = carpoolnum;
	}
	
	public int getChatnum() {
		return chatnum;
	}
	public void setChatnum(int chatnum) {
		this.chatnum = chatnum;
	}
	public int getRoomnum() {
		return roomnum;
	}
	public void setRoomnum(int roomnum) {
		this.roomnum = roomnum;
	}
	public int getMes_check() {
		return mes_check;
	}
	public void setMes_check(int mes_check) {
		this.mes_check = mes_check;
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
	public Timestamp getReg() {
		return reg;
	}
	public void setReg(Timestamp reg) {
		this.reg = reg;
	}
}
