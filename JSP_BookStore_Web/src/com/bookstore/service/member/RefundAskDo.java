package com.bookstore.service.member;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bookstore.dao.Impl.MemberDaoImpl;
import com.bookstore.service.Service;

public class RefundAskDo implements Service{

	@Override
	public void run(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String order_code = request.getParameter("order_code");
		MemberDaoImpl dao = new MemberDaoImpl();
		
		try {
			if(dao.refundAskDo(order_code) > 0) {
				request.getSession().setAttribute("message", "'"+order_code+"' 환불요청 완료.");
			}else {
				request.getSession().setAttribute("message", "Error!!  "
						+ "'"+order_code+"' 환불요청 실패.");
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		
		response.sendRedirect(request.getHeader("referer"));
	}
}
