package com.bookstore.service.member;

import javax.servlet.http.HttpServletRequest;

public class MemberSessionCheck {
	public static boolean check(HttpServletRequest request) {
		if(request.getSession().getAttribute("userId") != null) {
			return true;
		}else
			return false;
	}
}
