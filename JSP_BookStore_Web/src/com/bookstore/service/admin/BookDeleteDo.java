package com.bookstore.service.admin;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bookstore.dao.Impl.AdminDaoImpl;
import com.bookstore.service.Service;

public class BookDeleteDo implements Service{

	@Override
	public void run(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String[] str_book_codes = request.getParameterValues("chkbox");
		int[] book_codes = new int[str_book_codes.length];
		try {
			int i=0;
			for(String code: str_book_codes)
				book_codes[i++] = Integer.parseInt(code);
		}catch(Exception e){
			e.printStackTrace();
		}
		int pageNum = 1;
		if(request.getParameter("pageNum").trim().length()>0)
			pageNum = Integer.parseInt(request.getParameter("pageNum"));
		
		try {
			if(new AdminDaoImpl().bookDeleteDo(book_codes)!=0)
				request.getSession().setAttribute("message", "총 "+ str_book_codes.length+"권 삭제 완료.!");
			else
				request.getSession().setAttribute("message", "Book 삭제 오류!!");
		}catch(SQLException e) {
			e.printStackTrace();
			request.getSession().setAttribute("message", e.getMessage().trim().replace("\"", "\'"));
		}
		
		response.sendRedirect("bookManagePage?pageNum"+pageNum);
	}

}
