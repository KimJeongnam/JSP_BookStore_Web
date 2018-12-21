package com.bookstore.service.member;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bookstore.dao.Impl.MemberDaoImpl;
import com.bookstore.model.Cart;
import com.bookstore.service.Service;

public class CartList implements Service{

	@Override
	public void run(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MemberDaoImpl dao = new MemberDaoImpl();
		int toalPrice = 0;
		ArrayList<Cart> dtos = null;
		
		String user_id = (String)request.getSession().getAttribute("userId");
		
		
		new getCategorys().run(request, response);
		try {
			toalPrice = dao.cartTotalPrice(user_id);
			dtos = dao.cartList(user_id);
		}catch(SQLException e) {
			e.printStackTrace();
			request.getSession().setAttribute("message", e.getMessage().trim().replace("\"", "\'"));
		}
		
		request.setAttribute("dtos", dtos);
		request.setAttribute("totalPrice", toalPrice);
	}
}
