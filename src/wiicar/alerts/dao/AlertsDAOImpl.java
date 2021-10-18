package wiicar.alerts.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Queue;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import edu.emory.mathcs.backport.java.util.Collections;
import wiicar.alerts.dto.AlertChatRooms;
import wiicar.alerts.dto.AlertsDTO;

@Repository
public class AlertsDAOImpl implements AlertsDAO {

	@Autowired
	private SqlSessionTemplate sqlSession = null;

	// 노티 가져오기
	@Override
	public List<AlertsDTO> countChatNoti(String nickname) throws SQLException {
		return sqlSession.selectList("alerts.countChatNoti", nickname);
	}
}
