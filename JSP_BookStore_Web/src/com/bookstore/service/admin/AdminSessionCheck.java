package com.bookstore.service.admin;

import javax.servlet.http.HttpServletRequest;

public class AdminSessionCheck {
	public static boolean check(HttpServletRequest request) {
		if(request.getSession().getAttribute("adminId") != null) {
			return true;
		}else
			return false;
	}
}
