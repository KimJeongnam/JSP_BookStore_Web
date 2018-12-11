package com.bookstore.service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bookstore.service.admin.BookInfo;
import com.bookstore.service.admin.BookList;
import com.bookstore.service.member.CheckIdDo;
import com.bookstore.service.member.EmailCheck;
import com.bookstore.service.member.LoginDo;
import com.bookstore.service.member.LogoutDo;
import com.bookstore.service.member.MainDo;
import com.bookstore.service.member.SignUpDo;

public class Services {
	private static Services instance = new Services();
	public static Services getInstance() {return instance;}
	
	private Services() {}
	
	// Member 서비스
	public void runMemberService(HttpServletRequest request, HttpServletResponse response, int code) throws ServletException, IOException {
		Service service = null;
		
		switch(code) {
		case Code.MAIN_DO:
			service = new MainDo(); break;
		case Code.LOGIN:
			service = new LoginDo(); break;
		case Code.LOGOUT:
			service = new LogoutDo(); break;
		case Code.CHECK_ID:
			service = new CheckIdDo(); break;
		case Code.SIGNUP:
			service = new SignUpDo(); break;
		case Code.EMAILCHECK:
			service = new EmailCheck(); break;
		}
		service.run(request, response);
	}
	
	public void runAdminService(HttpServletRequest request, HttpServletResponse response, int code) throws ServletException, IOException {
		Service service = null;
		
		switch(code) {
		case Code.ADMIN_LOGIN:
			service = new com.bookstore.service.admin.LoginDo(); break;
		case Code.ADMIN_BOOOK_LIST:
			service = new BookList(); break;
		case Code.BOOOK_INFO:
			service = new BookInfo(); break;
		}
		
		service.run(request, response);
	}
}