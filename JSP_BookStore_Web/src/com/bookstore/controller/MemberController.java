package com.bookstore.controller;

import java.io.IOException;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bookstore.service.Code;
import com.bookstore.service.Service;
import com.bookstore.service.Services;

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
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
