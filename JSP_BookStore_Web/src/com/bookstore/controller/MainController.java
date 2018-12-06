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
@WebServlet("/MainController")
public class MainController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public MainController() {
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
		Map<Integer, Service> service = Services.getInstance().getServices();
		
		System.out.println(url);
		
		switch(url) {
		case "/MainController":
		case "/index":
			service.get(Code.MAIN_DO).run(request, response);
			
			viewPage = "/view/index.jsp";
			break;
		case "/login":
			
			service.get(Code.LOGIN).run(request, response);
			
			return;
		case "/logout":
			
			service.get(Code.LOGOUT).run(request, response);
			
			return;
		case "/signUpForm":
			
			viewPage = "/view/signup.jsp";
			break;
		case "/checkId":
			
			service.get(Code.CHECK_ID).run(request, response);
			
			viewPage = "/view/checkId.jsp";
			break;
		case "/signUpDo":
			
			service.get(Code.SIGNUP).run(request, response);
			
			viewPage = "/view/signUpDo.jsp";
			break;
		case "/emailChk":
			
			service.get(Code.EMAILCHECK).run(request, response);
			
			viewPage = "/view/signUpDo.jsp";
			break;
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
