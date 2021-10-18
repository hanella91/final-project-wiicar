package wiicar.home.dao;

import java.sql.SQLException;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import wiicar.home.dto.RecommendDTO;
import wiicar.member.dto.MemberDTO;

@Repository
public class HomeDAOImpl implements HomeDAO {

	@Autowired
	private SqlSessionTemplate sqlSession = null;
	
	@Override
	public MemberDTO getMemberInfo(String nickname) throws SQLException {
		MemberDTO memdto = sqlSession.selectOne("member.getMemberInfo", nickname);
		return memdto;
	}
	// 추천 경로 가져오기
	@Override
	public List<RecommendDTO> getRecommend() throws SQLException {
		List<RecommendDTO> recomdto = sqlSession.selectList("member.getRecommend");
		return recomdto;
	}
}
