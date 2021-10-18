package wiicar.qnaboard.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

import wiicar.qnaboard.dao.QnaboardDAOImpl;
import wiicar.qnaboard.dto.QnaboardDTO;

@Service
public class QnaboardServiceImpl implements QnaboardService {

		@Autowired
		private QnaboardDAOImpl qnaboardDAO = null;

		// qna리스트 가져오기
		@Override
		public HashMap<String, Object> getQnaList(HashMap<String, Object> map) throws SQLException {
			int res = 0;
			int result = 0;
			
			if(map.get("pageNum") == null){ 
				map.put("pageNum", "1");
			}
			if(map.get("filter") == null) {
				map.put("filter", "");
			}
			if(map.get("search") == null) {
				map.put("search", "");
			}
			
			map.put("pageSize", 7);
			map.put("currentPage", Integer.parseInt((String)map.get("pageNum")));
			map.put("startRow", ((int)map.get("currentPage") - 1) * (int)map.get("pageSize") + 1);
			map.put("endRow", (int)map.get("currentPage") * (int)map.get("pageSize"));
			
			if(map.get("myQna") != null) {
				map.put("sid", (String)RequestContextHolder.getRequestAttributes().getAttribute("sid", RequestAttributes.SCOPE_SESSION));
			}
			
			map.put("count", qnaboardDAO.cntQnaList(map));
			List qnaList = qnaboardDAO.getQnaList(map);
			map.put("qnaList", qnaList);				

			map.put("pageBlock", 5);
			res = (int)map.get("count") / (int)map.get("pageSize");
			result = ((int)map.get("currentPage") - 1) / (int)map.get("pageBlock");
			map.put("pageCount", (int)Math.ceil(((Integer)map.get("count")).doubleValue() / ((Integer)map.get("pageSize")).doubleValue()));
			map.put("startPage", result * (int)map.get("pageBlock") + 1);
			map.put("endPage", (int)map.get("startPage") + (int)map.get("pageBlock") - 1);
			if((int)map.get("endPage") > (int)map.get("pageCount")) {
				map.put("endPage", (int)map.get("pageCount"));
			}
			return map;
		}

		// qna 데이터 가져오기
		@Override
		public QnaboardDTO getQnaContent(int qnaNum) throws SQLException {
			return qnaboardDAO.getQnaContent(qnaNum);
		}

		// qna 저장하기
		@Override
		public void insertQna(QnaboardDTO dto) throws SQLException {
			dto.setWriter((String)RequestContextHolder.getRequestAttributes().getAttribute("sid", RequestAttributes.SCOPE_SESSION));
			qnaboardDAO.insertQna(dto);
		}
		
		// qna 삭제하기
		@Override
		public int deleteQna(int num, String pw) throws SQLException {
			return qnaboardDAO.deleteQna(num, pw);
		}

		@Override
		public void modifyQna(QnaboardDTO dto) throws SQLException {
			qnaboardDAO.modifyQna(dto);
		}
}
