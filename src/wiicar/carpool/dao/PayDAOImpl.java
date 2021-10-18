package wiicar.carpool.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import wiicar.carpool.dto.PayDTO;

@Repository
public class PayDAOImpl implements PayDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession = null;
	
	@Override
	public void insertPay(PayDTO dto) throws SQLException{
		sqlSession.insert("pay.insertPay", dto);
	};
	
	@Override
	public PayDTO getPayment(PayDTO dto) throws SQLException {
		return sqlSession.selectOne("pay.getPayment",dto);
	}
	
	@Override
	public void successPay(int paynum, int type) throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paynum", paynum);
		map.put("type", type);
		sqlSession.update("pay.successPay", map);
	}
	
	@Override
	public void cancelPay(int paynum) throws SQLException {
		sqlSession.delete("pay.cancelPay", paynum);
	}

	@Override
	public void failPay(int paynum) throws SQLException {
		sqlSession.update("pay.failPay", paynum);
	}
	
	@Override
	public void updatePay(PayDTO dto) throws SQLException {
		sqlSession.update("pay.updatePay", dto);
	}
	
	@Override
	public int getPayType(int paynum) throws SQLException {
		return sqlSession.selectOne("pay.getPayType", paynum);
	}
	
	@Override
	public void rollback(PayDTO dto) throws SQLException {
		sqlSession.update("pay.rollback", dto);
	}
}
