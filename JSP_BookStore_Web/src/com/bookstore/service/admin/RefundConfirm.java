package com.bookstore.service.admin;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bookstore.dao.Impl.AdminDaoImpl;
import com.bookstore.service.Service;

public class RefundConfirm implements Service{

	@Override
	public void run(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AdminDaoImpl dao = new AdminDaoImpl();
		
		String order_code = request.getParameter("order_code");
		System.out.println("[Service] RefundConfirm Start");
		try {
			if(dao.refundConfirm(order_code) > 0) {
				request.getSession().setAttribute("message",  "'"+order_code+"' 환불 완료");
			}else {
				request.getSession().setAttribute("message",  "Error! '"+order_code+"' 환불 취소");
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		
		System.out.println("[Service] RefundConfirm END");
		
		response.sendRedirect(request.getHeader("referer"));
	}
}
