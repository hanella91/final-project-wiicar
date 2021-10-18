package wiicar.home.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

import wiicar.home.dao.HomeDAOImpl;
import wiicar.home.dto.RecommendDTO;
import wiicar.member.dto.MemberDTO;

@Service
public class HomeServiceImpl implements HomeService {

	@Autowired
	private HomeDAOImpl homeDao = null;
	
	// 사용자 정보 가져오기(유찬)
	@Override
	public MemberDTO getMemberInfo() throws SQLException {
		String nickname =  (String)RequestContextHolder.getRequestAttributes().getAttribute("sid", RequestAttributes.SCOPE_SESSION);
		MemberDTO memdto =  homeDao.getMemberInfo(nickname);
		return memdto;
	}
	// 추천 경로 가져오기
	@Override
	public List<RecommendDTO> getRecommend() throws SQLException {
		List<RecommendDTO> recomdto = homeDao.getRecommend();
		return recomdto;
	}

	
}
