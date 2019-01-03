package com.bookstore.service.admin;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bookstore.dao.Impl.AdminDaoImpl;
import com.bookstore.model.Result;
import com.bookstore.service.Service;

public class Index implements Service{

	@Override
	public void run(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AdminDaoImpl dao = new AdminDaoImpl();
		Result result = null;
		
		try {
			result = dao.getResult();
		}catch(SQLException e) {
			e.printStackTrace();
		}
		new GetStat().run(request, response); 
		request.setAttribute("result", result);
	}
}
