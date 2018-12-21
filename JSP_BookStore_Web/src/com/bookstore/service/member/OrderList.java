package com.bookstore.service.member;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bookstore.dao.Impl.MemberDaoImpl;
import com.bookstore.model.Order;
import com.bookstore.service.Service;

public class OrderList implements Service{

	@Override
	public void run(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MemberDaoImpl dao = new MemberDaoImpl();
		
		String user_id = (String)request.getSession().getAttribute("userId");
		ArrayList<Order> dtos = null;
		
		new getCategorys().run(request, response);
		try {
			dtos = dao.orderList(user_id);
		}catch(SQLException e) {
			e.printStackTrace();
		}
		
		request.setAttribute("dtos", dtos);
	}

}
