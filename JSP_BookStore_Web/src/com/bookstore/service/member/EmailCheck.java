package com.bookstore.service.member;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bookstore.dao.AbstractMemeber;
import com.bookstore.dao.Impl.MemberDaoImpl;
import com.bookstore.service.Service;

public class EmailCheck implements Service{

	@Override
	public void run(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		AbstractMemeber dao = new MemberDaoImpl();
		
		String accept_code = request.getParameter("key");
		
		try {
			if(dao.emailCheck(accept_code)!=0) {
				request.setAttribute("message", "이메일 인증 완료! 로그인해주세요.");
			}
		}catch(SQLException e) {
			e.printStackTrace();
			request.setAttribute("message", e.getMessage().trim().replace("\"", "\'"));
		}
	}
}
