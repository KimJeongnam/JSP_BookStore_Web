package com.bookstore.service.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bookstore.service.Service;

public class LogoutDo implements Service{

	@Override
	public void run(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getSession().invalidate();
		request.getSession().setAttribute("message", "로그아웃");
		
		response.sendRedirect(request.getHeader("referer"));
	}
	
}
