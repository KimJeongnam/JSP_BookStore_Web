package com.bookstore.service.admin;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bookstore.dao.OrderStatus;
import com.bookstore.dao.Impl.AdminDaoImpl;
import com.bookstore.model.Order;
import com.bookstore.service.Service;

public class OrderList implements Service{

	@Override
	public void run(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AdminDaoImpl dao = new AdminDaoImpl();
		String status = OrderStatus.BUY_ASK;
		
		if(request.getParameter("status") != null) 
			status = request.getParameter("status");
		
		try {
			List<Order> dtos = dao.orderList(status);
			request.setAttribute("dtos", dtos);
		}catch(SQLException e) {
			e.printStackTrace();
		}
		request.setAttribute("statusMap", OrderStatus.statusMap);
		request.setAttribute("status", status);
	}
	 
}
