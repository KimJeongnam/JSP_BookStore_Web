package com.bookstore.service.member;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bookstore.dao.Impl.MemberDaoImpl;
import com.bookstore.service.Service;

public class OrderInfo implements Service{

	@Override
	public void run(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String order_code = request.getParameter("order_code");
		
		MemberDaoImpl dao = new MemberDaoImpl();
		ArrayList<com.bookstore.model.OrderInfo> dtos = null;
		int totalPrice = 0;
		
		try {
			dtos = dao.orderInfo(order_code);
			for(com.bookstore.model.OrderInfo dto : dtos)
				totalPrice += dto.getTotal_price();
		}catch(SQLException e) {
			e.printStackTrace();
			request.getSession().setAttribute("message", e.getMessage().trim().replace("\"", "\'"));
		}
		
		request.setAttribute("totalPrice", totalPrice);
		request.setAttribute("dtos", dtos);
	}

}
