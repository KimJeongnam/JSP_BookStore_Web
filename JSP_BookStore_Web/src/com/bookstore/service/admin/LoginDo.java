package com.bookstore.service.admin;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bookstore.dao.AbstractAdmin;
import com.bookstore.dao.Impl.AdminDaoImpl;
import com.bookstore.service.Service;

public class LoginDo implements Service{

	@Override
	public void run(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AbstractAdmin dao = new AdminDaoImpl();
		
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		
		if(request.getSession().getAttribute("userId")!=null) {
			request.getSession().invalidate();
		}
		
		try {
		switch(dao.loginDo(id, pw)) {
		case 0:
			request.getSession().setAttribute("message", "로그인실패! 없는 id 입니다.");
			break;
		case -1:
			request.getSession().setAttribute("message", "로그인 실패! 비밀번호가 다릅니다.");
			break;
		case 1:
			request.getSession().setAttribute("adminId", id);
			request.getSession().setAttribute("message", "로그인 성공! '관리자'님 환영합니다.!");
			break;
		}
		}catch(SQLException e) {
			e.printStackTrace();
			request.getSession().setAttribute("message", e.getMessage().trim().replace("\"", "\'"));
		}
		
		response.sendRedirect("index");
	}
}
