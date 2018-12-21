package com.bookstore.service.member;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bookstore.dao.Impl.MemberDaoImpl;
import com.bookstore.service.Service;

public class CartsDelDo implements Service{

	@Override
	public void run(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String[] checkeds = request.getParameterValues("chkbox");
		String user_id = (String) request.getSession().getAttribute("userId");
		MemberDaoImpl dao = new MemberDaoImpl();
		
		try {
			if(dao.cartsDelDo(user_id, checkeds)==0)
				request.getSession().setAttribute("message", "Error 예외발생<br> 장바구니 삭제에 실패하였습니다.");
		}catch(SQLException e) {
			e.printStackTrace();
			request.getSession().setAttribute("message", e.getMessage().trim().replace("\"", "\'"));
		}
		
		response.sendRedirect(request.getHeader("referer"));
	}
}
