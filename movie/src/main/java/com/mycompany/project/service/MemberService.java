package com.mycompany.project.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mycompany.project.dao.MemberDao;
import com.mycompany.project.model.LoginForm;
import com.mycompany.project.model.Member;

@Service
public class MemberService {

	private static final Logger LOGGER = LoggerFactory.getLogger(MemberService.class);
	@Autowired
	MemberDao memberDao;

	public static final int LOGIN_SUCCESS = 0;
	public static final int LOGIN_FAIL_MID = 1;
	public static final int LOGIN_FAIL_MPASSWORD = 2;

	public void join(Member member) {
		memberDao.insert(member);
	}

	public int login(LoginForm loginForm) {
		LOGGER.info("실행");
		Member dbMember = memberDao.selectByMid(loginForm.getMid());
		if (dbMember == null) {
			return LOGIN_FAIL_MID;
		} else if (dbMember.getMpassword().equals(loginForm.getMpassword())) {
			return LOGIN_SUCCESS;
		} else {
			return LOGIN_FAIL_MPASSWORD;
		}
	}

	public Member getMemberInfo(String mid) {
		LOGGER.info("실행");
		return memberDao.selectByMid(mid);
	}

	public String searchMid(Member member) {
		String mid = memberDao.selectMid(member);
		LOGGER.info(mid);
		String result = "NoID";
		if (mid != null) {
			result = mid;
		}
		LOGGER.info(result);
		return result;
	}

	public String searchMpassword(Member member) {
		String password = memberDao.selectMpassword(member);
		if (password == null) {
			return "NoID";
		} else {
			return password;
		}
	}

	public void edit(Member member) {
		memberDao.update(member);
	}

	public void updateMpoint(int point, String mid) {
		memberDao.updateMpoint(point, mid);
	}
	
	public void drop(String mid) {
		memberDao.delete(mid);
	}

	public int searchMpoint(String mid) {
		return memberDao.searchMpoint(mid);
		
	}
}
