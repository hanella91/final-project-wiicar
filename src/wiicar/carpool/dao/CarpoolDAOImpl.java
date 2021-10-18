package wiicar.carpool.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import wiicar.carpool.dto.CarpoolDTO;
import wiicar.carpool.dto.ReservationsDTO;
import wiicar.member.dto.MemberDTO;
import wiicar.review.dto.ReviewDTO;

@Repository
public class CarpoolDAOImpl implements CarpoolDAO {

	@Autowired
	private SqlSessionTemplate sqlSession = null;

	@Override
	public void insertCarpool(CarpoolDTO dto) throws SQLException{
		System.out.println("insertCarpool 실행");
		sqlSession.insert("carpool.insertCarpool", dto);
	}

	@Override
	public CarpoolDTO getCarpool(CarpoolDTO dto) {
		return sqlSession.selectOne("carpool.getCarpool", dto);
	}
	
	@Override
	public MemberDTO getMember(String id) {
		return sqlSession.selectOne("member.getMemberInfo", id);
	}
	
	@Override
	public List<CarpoolDTO> getCarpoolList(int start, int end, String sel, String sort) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("start",start);
		map.put("end",end);
		map.put("sel", sel);
		map.put("sort", sort);
		return sqlSession.selectList("carpool.getCarpoolList",map);
	}
	
	@Override
	public int getCarpoolCount() {
		return sqlSession.selectOne("carpool.getCarpoolCount");
	}
	
	@Override
	public List<String> getPassengers(int carpoolNum) {
		return sqlSession.selectList("chat.getPassengers", carpoolNum);
	}
	
	@Override
	public int getLike(int carpoolNum, String sid) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("carpoolNum",carpoolNum);
		map.put("sid", sid);
		return sqlSession.selectOne("carpool.getLike", map);
	}
	
	@Override
	public int checkLike(int carpoolNum, String sid) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("carpoolNum",carpoolNum);
		map.put("sid", sid);
		int res = 0;
		if(getLike(carpoolNum, sid) == 1) {
			res = sqlSession.delete("carpool.deleteLike", map);
		} else {
			res = sqlSession.insert("carpool.insertLike", map);
		}
		return res;
	}
	
	@Override
	public List<ReviewDTO> getDriverReview(String id) {
		return sqlSession.selectList("review.getDriverReview", id);
	}
	
	@Override
	public List<ReviewDTO> getPassengerReview(String id) {
		return sqlSession.selectList("review.getPassengerReview", id);
	}
	
	@Override
	public int getReportCount(String id) {
		return sqlSession.selectOne("report.getReportCount", id);
	}
	
	@Override
	public int getCarpoolRecord(String id) {
		return sqlSession.selectOne("carpool.getCarpoolRecord",id);
	}
	
	@Override
	public int getCarpoolUsed(String id) {
		return sqlSession.selectOne("carpool.getCarpoolUsed", id);
	}
	
	@Override
	public void insertReservation(ReservationsDTO dto) {
		sqlSession.insert("chat.insertReservation", dto);
	}
	
	@Override
	public int checkReservation(int carpoolNum, String sid) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("carpoolNum",carpoolNum);
		map.put("sid", sid);
		return sqlSession.selectOne("carpool.checkReservation", map);
	}

	@Override
	public CarpoolDTO getCarpoolInfo(int carpoolNum) throws SQLException {
		
		return sqlSession.selectOne("carpool.getCarpoolInfo", carpoolNum);
	}

}

