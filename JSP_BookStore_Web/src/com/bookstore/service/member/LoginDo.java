package com.bookstore.service.member;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bookstore.dao.AbstractMemeber;
import com.bookstore.dao.Impl.MemberDaoImpl;
import com.bookstore.service.Service;

public class LoginDo implements Service{

	@Override
	public void run(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AbstractMemeber dao = new MemberDaoImpl();
		
		if(request.getSession().getAttribute("userId") == null) { 
			String id = request.getParameter("id");
			String pw = request.getParameter("pw");
			
			if(request.getSession().getAttribute("adminId")!=null) {
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
				request.getSession().setAttribute("userId", id);
				request.getSession().setAttribute("message", "로그인 성공! '"+id+"'님 환영합니다.!");
				break;
			case 2:
				request.getSession().setAttribute("message", "이메일 인증 후 다시 시도하세요!");
				break;
			}
			}catch(SQLException e) {
				e.printStackTrace();
				request.getSession().setAttribute("message", e.getMessage().trim().replace("\"", "\'"));
			}
		}
		response.sendRedirect(request.getHeader("referer"));
	}
}
