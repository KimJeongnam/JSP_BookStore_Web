package com.bookstore.service.admin;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bookstore.dao.Impl.SharedDaoImpl;
import com.bookstore.model.BoardVO;
import com.bookstore.service.Service;

public class BookInfo implements Service{

	@Override
	public void run(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		SharedDaoImpl dao = new SharedDaoImpl();
		
		request.setCharacterEncoding("UTF-8");
		
		int board_id = Integer.parseInt(request.getParameter("board_id"));
		
		int pageNum = 1;
		
		if(request.getParameter("pageNum") != null)
			pageNum = Integer.parseInt(request.getParameter("pageNum"));
		
		try {
			BoardVO dto = dao.getBookInfo(board_id);
			request.setAttribute("dto", dto);
		}catch(SQLException e) {
			e.printStackTrace();
			request.setAttribute("message", e.getMessage().trim().replace("\"", "\'"));
		}
		request.setAttribute("pageNum", pageNum);
	}

}
