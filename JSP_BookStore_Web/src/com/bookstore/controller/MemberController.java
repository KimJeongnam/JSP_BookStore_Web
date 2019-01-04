package com.bookstore.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bookstore.service.Code;
import com.bookstore.service.Services;
import com.bookstore.service.member.MemberSessionCheck;

/**
 * Servlet implementation class MainController
 */
@WebServlet("/MemberController")
public class MemberController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public MemberController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		action(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		action(request, response);
	}

	public void action(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		String viewPage = "";
		
		String uri = request.getRequestURI();
		String contextPath = request.getContextPath();
		String url = uri.substring(contextPath.length());
		Services service = Services.getInstance();
		
		System.out.println("Servlet Controller : MemberController  URL="+url);
		
		switch(url) {
		case "/MemberController":
		case "/index":
			service.runMemberService(request, response, Code.MAIN_DO);
			
			viewPage = "/view/index.jsp";
			break;
		case "/login":
			service.runMemberService(request, response, Code.LOGIN);
			
			return;
		case "/logout":
			
			service.runMemberService(request, response, Code.LOGOUT);
			
			return;
		case "/signUpForm":
			
			viewPage = "/view/signup.jsp";
			break;
		case "/checkId":
			
			service.runMemberService(request, response, Code.CHECK_ID);
			
			viewPage = "/view/checkId.jsp";
			break;
		case "/signUpDo":
			
			service.runMemberService(request, response, Code.SIGNUP);
			
			viewPage = "/view/signUpDo.jsp";
			break;
		case "/emailChk":
			
			service.runMemberService(request, response, Code.EMAILCHECK);
			
			viewPage = "/view/signUpDo.jsp";
			break;
		case "/bookList":
			
			service.runMemberService(request, response, Code.BOOOK_LIST);
			
			viewPage = "/view/bookList.jsp";
			break;
		case "/bookInfo":
			
			service.runMemberService(request, response, Code.BOOOK_INFO);
			
			viewPage = "/view/bookInfo.jsp";
			break;
		case "/cartAddDo":
			if(!sessionCheck(request, response)) return; 
			
			service.runMemberService(request, response, Code.CART_ADD_DO);
			
			return;
		case "/cartList":
			if(!sessionCheck(request, response)) return;
			
			service.runMemberService(request, response, Code.CART_LIST);

			viewPage = "/view/cartList.jsp";
			break;
		case "/cartDel":
			if(!sessionCheck(request, response)) return;
			
			service.runMemberService(request, response, Code.CART_DEL_DO);
			
			return;
		case "/cartsDel":
			if(!sessionCheck(request, response)) return; 
			
			service.runMemberService(request, response, Code.CARTS_DEL_DO);
			
			return;
		case "/nowBuy":
			if(!sessionCheck(request, response)) return; 
			
			service.runMemberService(request, response, Code.NOW_BUY);
			
			return;
		case "/cartsBuy":
			if(!sessionCheck(request, response)) return; 
			
			service.runMemberService(request, response, Code.CART_ITEMS_BUY);
			
			return;
		case "/orders":
			if(!sessionCheck(request, response)) return; 
			
			service.runMemberService(request, response, Code.MEMBER_ORDER_LIST);
			
			viewPage = "/view/orderStatus.jsp";
			break;
		case "/orderInfo":
			if(!sessionCheck(request, response)) return; 
			
			service.runMemberService(request, response, Code.MEMBER_ORDER_INFO); 
			
			viewPage = "/view/orderInfo.jsp";
			break;
		case "/refundAsk":
			if(!sessionCheck(request, response)) return; 
			
			service.runMemberService(request, response, Code.MEMBER_REFUND_ASK);
			
			return;
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
	
	private boolean sessionCheck(HttpServletRequest request, HttpServletResponse response) throws IOException {
		if(!MemberSessionCheck.check(request)) {
			request.getSession().setAttribute("message", "로그인 후 이용할 수 있는 서비스입니다. 로그인 하세요.");
			request.getSession().setAttribute("openLogin", "openLogin");
			response.sendRedirect("index");
			return false;
		}else {
			return true;
		}
	}
}
