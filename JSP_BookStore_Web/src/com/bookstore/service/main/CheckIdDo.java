package com.bookstore.service.main;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bookstore.dao.AbstractMain;
import com.bookstore.dao.main.MainDaoImpl;
import com.bookstore.service.Service;

public class CheckIdDo implements Service{
	@Override
	public void run(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AbstractMain dao = new MainDaoImpl();
		
		String id = request.getParameter("id");
		
		
		try {
			request.setAttribute("selectCnt", dao.checkId(id));
			request.setAttribute("id", id);
		}catch(SQLException e) {
			e.printStackTrace();
			request.setAttribute("message", e.getMessage().trim().replace("\"", "\'"));
		}
	}
}
