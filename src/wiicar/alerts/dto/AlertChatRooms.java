package wiicar.alerts.dto;

import java.sql.Timestamp;

public class AlertChatRooms {
	public int chatRoom;
	public int unreadMsg;
	public String lastChat;
	public Timestamp reg;
	public int carpoolnum;
	public int chatNum;
	public String opp;
	public AlertChatRooms(int chatRoom, String lastChat, Timestamp reg, String opp, int carpoolnum, int chatNum) {
		this.chatRoom = chatRoom;
		this.unreadMsg = 1;
		this.lastChat = lastChat;
		this.reg = reg;
		this.opp = opp;
		this.chatNum = chatNum;
		this.carpoolnum = carpoolnum;
	}
	public void addUnread() {
		this.unreadMsg += 1;
	}
	public void setLastChat(String msg) {
		this.lastChat = msg;
	}
	public void setReg(Timestamp reg) {
		this.reg = reg;
	}
	public void setChatNum(int chatNum) {
		this.chatNum = chatNum;
	}
}
