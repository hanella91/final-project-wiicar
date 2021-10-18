package wiicar.qnaboard.controller;

import java.sql.SQLException;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import wiicar.qnaboard.dto.QnaboardDTO;
import wiicar.qnaboard.service.QnaboardServiceImpl;

@Controller
@RequestMapping("/qnaboard/*")
public class QnaboardController {

	@Autowired
	private QnaboardServiceImpl qnaboardService = null;

//	// qna리스트 가져오기
//	@RequestMapping("qnaList.do")
//	public String qnaList(String pageNum, String filter, String search, String myQna, Model model) throws SQLException {
//		HashMap<String, Object> map = new HashMap<>();
//		if(filter != null && !filter.equals("0")) map.put("filter", filter);
//		if(search != null) map.put("search", search);
//		if(myQna != null) map.put("myQna", myQna);
//		map.put("pageNum", pageNum);
//		map = qnaboardService.getQnaList(map);
//		model.addAttribute("map", map);
//		return "qnaboard/qnaList";
//	}
	
	@GetMapping("qnaList.do")
	public String qnaList() {
		return "qnaboard/qnaList";
	}

	@PostMapping(value="qnaList.do") 
	public String qnaList(String pageNum, String filter, String search, String myQna, Model model) {
		if(pageNum != null) {
			model.addAttribute("pageNum", pageNum);
		}
		if(filter != null) {
			model.addAttribute("filter", filter);
		}
		if(search != null) {
			model.addAttribute("search", search);
		}
		if(myQna != null) {
			model.addAttribute("myQna", myQna);
		}
		return "qnaboard/qnaList";
	}
	
	@RequestMapping("getQnaList.do") 
	public ResponseEntity<?> getQnaList(String pageNum, String filter, String search, String myQna) throws SQLException {
		HashMap<String, Object> map = new HashMap<>();
		HttpHeaders respHeaders = new HttpHeaders();
		respHeaders.add("Content-type", "test/html;charset=utf-8");
		if(filter != null && !filter.equals("0")) map.put("filter", filter);
		if(search != null && !search.equals("")) map.put("search", search);
		if(myQna != null && !myQna.equals("")) map.put("myQna", myQna);
		if(pageNum != null && !pageNum.equals("")) map.put("pageNum", pageNum);
		System.out.println("myqna : " + map.get("myQna"));
		map = qnaboardService.getQnaList(map);
		return ResponseEntity.ok(map);
	}
	
	// qna 하나 가져오기
	@RequestMapping("qnaContent.do")
	public String qnaContent(int qnaNum, Model model, String myQna, String filter, String search, String pageNum) throws SQLException {
		QnaboardDTO dto = qnaboardService.getQnaContent(qnaNum);
		model.addAttribute("qna", dto);
		if(pageNum != null) {
			model.addAttribute("pageNum", pageNum);
		}
		if(filter != null) {
			model.addAttribute("filter", filter);
		}
		if(search != null) {
			model.addAttribute("search", search);
		}
		if(myQna != null) {
			model.addAttribute("myQna", myQna);
		}
		return "qnaboard/qnaContent";
	}
	
	// qna 작성하기
	@RequestMapping("writeQna.do")
	public String writeQna(String qnaNum, Model model) throws NumberFormatException, SQLException {
		if(qnaNum != null) {
			QnaboardDTO dto = qnaboardService.getQnaContent(Integer.parseInt(qnaNum));
			model.addAttribute("qna", dto);
		}
		return "qnaboard/writeQna";
	}
	
	// qna 저장하기
	@RequestMapping("writeQnaPro.do")
	public String writeQnaPro(QnaboardDTO dto) throws SQLException {
		System.out.println("QNA WRITE CLOSED : " + dto.getClosed());
		qnaboardService.insertQna(dto);
		return "redirect:/qnaboard/qnaList.do";
	}
	
	// qna 삭제
	@RequestMapping("deleteQna.do")
	public ResponseEntity<String> deleteQna(int num, String pw) throws SQLException {
		HttpHeaders respHeaders = new HttpHeaders();
		respHeaders.add("Content-type", "test/html;charset=utf-8");
		int res = qnaboardService.deleteQna(num, pw);
		return new ResponseEntity<String>(res + "", respHeaders, HttpStatus.OK);
	}
	
	// qna 수정
	@RequestMapping("modifyQna.do")
	public void modfiyQna(QnaboardDTO dto) throws SQLException {
		HttpHeaders respHeaders = new HttpHeaders();
		respHeaders.add("Content-type", "test/html;charset=utf-8");
		qnaboardService.modifyQna(dto);
	}
}
