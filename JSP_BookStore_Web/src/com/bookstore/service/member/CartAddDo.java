package com.bookstore.service.member;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bookstore.dao.Impl.MemberDaoImpl;
import com.bookstore.service.Service;

public class CartAddDo implements Service{

	@Override
	public void run(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String user_id = (String)request.getSession().getAttribute("userId");
		int book_code = Integer.parseInt(request.getParameter("book_code"));
		int wish_stock = Integer.parseInt(request.getParameter("wish_stock"));
		
		try {
			if(new MemberDaoImpl().cartAddDo(user_id, book_code, wish_stock) != 0)
				request.getSession().setAttribute("message", "장바구니 추가 성공");
			else
				request.getSession().setAttribute("message", "장바구니 추가 실패! 해당책의 남은 수량이 없습니다.!");
			
			
		}catch(SQLException e) {
			e.printStackTrace();
			request.getSession().setAttribute("message", e.getMessage().trim().replace("\"", "\'"));
		}
		response.sendRedirect(request.getHeader("referer"));
	}
	
}
