package wiicar.chat.dto;

public class UserInfoDTO {
	private String profileimage;
	private String nickname;
	private double passengerrate;
	private double driverrate;
	private int fincount;
	public String getProfileimage() {
		return profileimage;
	}
	public void setProfileimage(String profileimage) {
		this.profileimage = profileimage;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public double getPassengerrate() {
		return passengerrate;
	}
	public void setPassengerrate(double passengerrate) {
		this.passengerrate = passengerrate;
	}
	public double getDriverrate() {
		return driverrate;
	}
	public void setDriverrate(double driverrate) {
		this.driverrate = driverrate;
	}
	public int getFincount() {
		return fincount;
	}
	public void setFincount(int fincount) {
		this.fincount = fincount;
	}
	

}
