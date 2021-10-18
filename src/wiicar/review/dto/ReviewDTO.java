package wiicar.review.dto;

import java.sql.Timestamp;

public class ReviewDTO {
	private Integer carpoolNum;
	private Integer type;
	private Integer rate;
	private String writer;
	private String id;
	private String content;
	private Timestamp reg;
	
	public Integer getRate() {
		return rate;
	}
	public void setRate(Integer rate) {
		this.rate = rate;
	}
	public Integer getCarpoolNum() {
		return carpoolNum;
	}
	public void setCarpoolNum(Integer carpoolNum) {
		this.carpoolNum = carpoolNum;
	}
	public Integer getType() {
		return type;
	}
	public void setType(Integer type) {
		this.type = type;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Timestamp getReg() {
		return reg;
	}
	public void setReg(Timestamp reg) {
		this.reg = reg;
	}
	
	
}
