package com.bookstore.service.admin;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bookstore.dao.Impl.AdminDaoImpl;
import com.bookstore.model.Stat;
import com.bookstore.service.Service;

public class GetStat implements Service{

	@Override
	public void run(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AdminDaoImpl dao = new AdminDaoImpl();
		
		List<Stat> statList = null;
		
		try {
			statList = dao.getStat();
		}catch(SQLException e) {
			e.printStackTrace();
		}
		request.setAttribute("statList", statList);
	}
}
