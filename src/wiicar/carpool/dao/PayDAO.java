package wiicar.carpool.dao;

import java.sql.SQLException;

import wiicar.carpool.dto.PayDTO;

public interface PayDAO {
	
	public void insertPay(PayDTO dto) throws SQLException;

	public PayDTO getPayment(PayDTO dto) throws SQLException;
	
	public void successPay(int paynum, int type) throws SQLException;
	
	public void cancelPay(int paynum) throws SQLException;
	
	public void failPay(int paynum) throws SQLException;
	
	public void updatePay(PayDTO dto) throws SQLException;
	
	public int getPayType(int paynum) throws SQLException;
	
	public void rollback(PayDTO dto) throws SQLException;
	
}
