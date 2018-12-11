package com.bookstore.service.member;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bookstore.dao.AbstractMemeber;
import com.bookstore.dao.Impl.MemberDaoImpl;
import com.bookstore.service.Service;

public class CheckIdDo implements Service{
	@Override
	public void run(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AbstractMemeber dao = new MemberDaoImpl();
		
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
