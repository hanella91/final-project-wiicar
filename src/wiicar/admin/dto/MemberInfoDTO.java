package wiicar.admin.dto;

import java.sql.Date;
import java.sql.Timestamp;

public class MemberInfoDTO {
	private String id;
	private String nickname;
	private String name;
	private Date birth;
	private String gender;
	private Integer permit;
	private Integer active;
	private Integer userType;
	private Integer subAdmin;
	private String reportCount;
	private Timestamp reg;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Date getBirth() {
		return birth;
	}
	public void setBirth(Date birth) {
		this.birth = birth;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public Integer getPermit() {
		return permit;
	}
	public void setPermit(Integer permit) {
		this.permit = permit;
	}
	public Integer getActive() {
		return active;
	}
	public void setActive(Integer active) {
		this.active = active;
	}
	public Integer getUserType() {
		return userType;
	}
	public void setUserType(Integer userType) {
		this.userType = userType;
	}
	public Integer getSubAdmin() {
		return subAdmin;
	}
	public void setSubAdmin(Integer subAdmin) {
		this.subAdmin = subAdmin;
	}
	public String getReportCount() {
		return reportCount;
	}
	public void setReportCount(String reportCount) {
		this.reportCount = reportCount;
	}
	public Timestamp getReg() {
		return reg;
	}
	public void setReg(Timestamp reg) {
		this.reg = reg;
	}

	
	
}
