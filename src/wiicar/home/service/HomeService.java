package wiicar.home.service;

import java.sql.SQLException;
import java.util.List;

import wiicar.home.dto.RecommendDTO;
import wiicar.member.dto.MemberDTO;

public interface HomeService {

	// 사용자 정보 가져오기(유찬)
	public MemberDTO getMemberInfo() throws SQLException;
	// 추천 경로 가져오기
	public List<RecommendDTO> getRecommend() throws SQLException;
}
