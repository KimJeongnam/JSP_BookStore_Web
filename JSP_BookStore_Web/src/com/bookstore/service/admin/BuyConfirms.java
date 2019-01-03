package com.bookstore.service.admin;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bookstore.dao.Impl.AdminDaoImpl;
import com.bookstore.service.Service;

public class BuyConfirms implements Service{

	@Override
	public void run(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String[] order_codes = request.getParameterValues("order_codes");
		
		AdminDaoImpl dao = new AdminDaoImpl();
		
		int result=0;
		try {
			result = dao.buyConfirm(order_codes);
		}catch(SQLException e) {
			e.printStackTrace();
		}
		
		if(result != 0)
			request.getSession().setAttribute("message", "'"+order_codes.length+"'건 주문 승인 완료");
		else
			request.getSession().setAttribute("message",  "Error!! 주문 승인 취소");
		
		response.sendRedirect(request.getHeader("referer"));
	}
	
}
