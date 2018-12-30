package com.bookstore.service.member;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bookstore.dao.Impl.MemberDaoImpl;
import com.bookstore.service.Service;

public class CartsBuy implements Service{

	@Override
	public void run(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MemberDaoImpl dao = new MemberDaoImpl();
		String user_id = (String) request.getSession().getAttribute("userId");
		String[] book_codes = request.getParameterValues("chkbox");
		String[] wish_stocks = request.getParameterValues("wish_stock");
		
		ArrayList<Map<String, Integer>> carts = new ArrayList<Map<String, Integer>>();
			/*Map<String, Integer> cart = new HashMap<String, Integer>();
			cart.put("book_code", book_code);
			cart.put("wish_stock", wish_stock);*/
			/*carts.add(cart);*/
		
		for(int i=0; i<book_codes.length; i++) {
			Map<String, Integer> cart = new HashMap<String, Integer>();
			cart.put("book_code", Integer.parseInt(book_codes[i]));
			cart.put("wish_stock", Integer.parseInt(wish_stocks[i]));
			carts.add(cart);
		}
		
		
		try {
			if(dao.buy(user_id, carts)==0) {
				request.getSession().setAttribute("message", "buy() ERROR 구매 실패!!! ㅠㅠ");
			}else {
				for(String book_code : book_codes) {
					if(dao.cartDelDo(user_id, Integer.parseInt(book_code))==0) {
						request.getSession().setAttribute("message", "Error 예기치 못한 오류<br> 장바구니 삭제 실패!!");
						response.sendRedirect(request.getHeader("referer"));
						return;
					}
				}
				request.getSession().setAttribute("message", "구매 완료.");
			}
		}catch(SQLException e) {
			e.printStackTrace();
			request.getSession().setAttribute("message", e.getMessage().trim().replace("\"", "\'"));
		}
		response.sendRedirect(request.getHeader("referer"));
	}
}
