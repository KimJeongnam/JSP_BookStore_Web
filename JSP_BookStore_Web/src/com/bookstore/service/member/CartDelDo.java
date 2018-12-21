package com.bookstore.service.member;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bookstore.dao.Impl.MemberDaoImpl;
import com.bookstore.service.Service;

public class CartDelDo implements Service{

	@Override
	public void run(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MemberDaoImpl dao = new MemberDaoImpl();
		
		String user_id = (String)request.getSession().getAttribute("userId");
		String[] code = new String[1];
		code[0] = request.getParameter("book_code");
		
		try {
			if(dao.cartsDelDo(user_id, code)==0) {
				request.getSession().setAttribute("message", "Error 예기치 못한 오류<br> 장바구니 삭제 실패!!");
			}
		}catch(SQLException e) {
			e.printStackTrace();
			request.getSession().setAttribute("message", e.getMessage().trim().replace("\"", "\'"));
		}
		
		response.sendRedirect(request.getHeader("referer"));
	}
}
