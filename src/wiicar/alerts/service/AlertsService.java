package wiicar.alerts.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

public interface AlertsService {

	// 노티 가져오기
	public HashMap<String, Object> countAllNoti() throws SQLException;

}
