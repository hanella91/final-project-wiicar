package wiicar.admin.dto;

import java.sql.Timestamp;

public class InfoBoardDTO {

		private int num,hit;
		private String writer, title, content;
		private Timestamp reg;
		
		public int getNum() {
			return num;
		}
		public void setNum(int num) {
			this.num = num;
		}
		public int getHit() {
			return hit;
		}
		public void setHit(int hit) {
			this.hit = hit;
		}
		public String getWriter() {
			return writer;
		}
		public void setWriter(String writer) {
			this.writer = writer;
		}
		public String getTitle() {
			return title;
		}
		public void setTitle(String title) {
			this.title = title;
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
