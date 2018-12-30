package com.bookstore.service.admin;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bookstore.dao.Impl.AdminDaoImpl;
import com.bookstore.service.Service;

public class BuyConfirm implements Service{

	@Override
	public void run(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String order_code = request.getParameter("order_code");
		int result = 0;
		
		AdminDaoImpl dao = new AdminDaoImpl();
		
		try {
			result = dao.buyConfirm(order_code);
		}catch(SQLException e) {
			e.printStackTrace();
		}
		
		if(result > 0)
			request.getSession().setAttribute("message", "'"+order_code+"' 주문 승인 완료");
		else
			request.getSession().setAttribute("message", "ERROR!!! '"+order_code+"' 주문 승인 실패");
		
		response.sendRedirect(request.getHeader("referer"));
	}
	
}
