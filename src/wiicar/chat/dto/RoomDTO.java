package wiicar.chat.dto;

public class RoomDTO {

	private int roomnum, carpoolnum, deluser1, deluser2;
	private String user1, user2;
	
	public int getRoomnum() {
		return roomnum;
	}
	public void setRoomnum(int roomnum) {
		this.roomnum = roomnum;
	}
	public int getCarpoolnum() {
		return carpoolnum;
	}
	public void setCarpoolnum(int carpoolnum) {
		this.carpoolnum = carpoolnum;
	}
	public String getUser1() {
		return user1;
	}
	public void setUser1(String user1) {
		this.user1 = user1;
	}
	public String getUser2() {
		return user2;
	}
	public void setUser2(String user2) {
		this.user2 = user2;
	}
	public int getDeluser1() {
		return deluser1;
	}
	public void setDeluser1(int deluser1) {
		this.deluser1 = deluser1;
	}
	public int getDeluser2() {
		return deluser2;
	}
	public void setDeluser2(int deluser2) {
		this.deluser2 = deluser2;
	}
	
	
}
