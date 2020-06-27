package com.mycompany.project.validator;

import javax.servlet.http.HttpSession;

public class LoginValidator {
	
	static public boolean sessionCheck(HttpSession session) {
		String mid = (String) session.getAttribute("sessionMid");
		if (mid == null)
			return false;
		else
			return true;
	}
}
