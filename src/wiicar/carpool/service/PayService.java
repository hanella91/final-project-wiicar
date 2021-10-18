package wiicar.carpool.service;

import java.sql.SQLException;

import wiicar.carpool.dto.CarpoolDTO;

public interface PayService {

	// 카카오 결제 API
	public String kakaoPay(CarpoolDTO dto, String message) throws SQLException;
	
	public void successPay(int paynum) throws SQLException;
	
	public void cancelPay(int paynum) throws SQLException;
	
	public void failPay(int paynum) throws SQLException;
	
	
	
}
