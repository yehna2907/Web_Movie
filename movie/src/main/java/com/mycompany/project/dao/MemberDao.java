package com.mycompany.project.dao;

import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.mycompany.project.model.Member;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
public class MemberDao extends EgovAbstractMapper {

	private static final Logger LOGGER = LoggerFactory.getLogger(MemberDao.class);

	public int insert(Member member) {
		LOGGER.info("실행");
		int result = insert("member.insert", member);
		return result;
	}

	public Member selectByMid(String mid) {
		LOGGER.info("실행");
		return selectOne("member.selectByMid", mid);
	}

	public String selectMid(Member member) {
		return selectOne("member.selectMid", member);
	}

	public String selectMpassword(Member member) {
		String password = selectOne("member.selectMpassword", member);
		return password;
	}
	
	public int update(Member member) {
		int result = update("member.update", member);
		return result;
	}
	
	public int searchMpoint(String mid) {
		Member member = selectOne("member.selectByMid", mid);
		int point = member.getMpoint();
		LOGGER.info(point+"");
		return point;
	}

	public void updateMpoint(int mpoint, String mid) {
		HashMap map = new HashMap();
		map.put("mpoint", mpoint);
		map.put("mid", mid);
		update("member.updateMpoint", map);	
	}
	
	public int delete(String mid) {
		LOGGER.info("실행");
		int rows = delete("member.delete", mid);
		return rows;
	}
}
