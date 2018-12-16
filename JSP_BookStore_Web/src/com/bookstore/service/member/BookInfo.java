package com.bookstore.service.member;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bookstore.dao.Impl.SharedDaoImpl;
import com.bookstore.model.BoardVO;
import com.bookstore.model.Category;
import com.bookstore.service.Service;

public class BookInfo implements Service{

	@Override
	public void run(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ArrayList<Category> categorys = null;
		ArrayList<Category> parentCategorys = new ArrayList<Category>();
		ArrayList<Category> childCategorys = new ArrayList<Category>();
		System.out.println("request URI : "+request.getRequestURI());
		
		SharedDaoImpl dao = new SharedDaoImpl();
		String category_id = request.getParameter("category_id");
		
		request.setCharacterEncoding("UTF-8");
		
		int board_id = Integer.parseInt(request.getParameter("board_id"));
		int pageNum = 1;
		if(request.getParameter("pageNum")!=null)
			pageNum = Integer.parseInt(request.getParameter("pageNum"));
		
		if(category_id != null)
			if(category_id.length()!=0)
				request.setAttribute("category_id", Integer.parseInt(category_id));
		
		try {
			categorys = dao.getCategorys();
			
			for(Category category : categorys) {
				if(category.getLevel() == 1) {
					parentCategorys.add(category);
				}else
					childCategorys.add(category);
			}
			
			BoardVO dto = dao.getBookInfo(board_id);
			request.setAttribute("dto", dto);
		}catch(SQLException e) {
			e.printStackTrace();
			request.setAttribute("message", e.getMessage().trim().replace("\"", "\'"));
		}
		
		request.setAttribute("parentCategorys", parentCategorys);
		request.setAttribute("childCategorys", childCategorys);
		request.setAttribute("pageNum", pageNum);
	}
}
