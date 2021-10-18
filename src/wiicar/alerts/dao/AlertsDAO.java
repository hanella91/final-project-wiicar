package wiicar.alerts.dao;

import java.sql.SQLException;
import java.util.List;

import wiicar.alerts.dto.AlertsDTO;

public interface AlertsDAO {

	// 노티 가져오기 
	public List<AlertsDTO> countChatNoti(String nickname) throws SQLException;
	
	
}
