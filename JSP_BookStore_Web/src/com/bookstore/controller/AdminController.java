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
import com.bookstore.service.admin.AdminSessionCheck;

/**
 * Servlet implementation class AdminController
 */
@WebServlet("/Admin/AdminController")
public class AdminController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AdminController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		action(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		action(request, response);
	}
	
	public void action(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String viewPage = "";
		
		String uri = request.getRequestURI();
		String contextPath = request.getContextPath()+"/Admin";
		String url = uri.substring(contextPath.length());
		Services service = Services.getInstance();
		
		System.out.println("Servlet Controller : AdminController  URL="+url);
		
		
		switch(url) {
		case "/AdminController":
		case "/index":
			viewPage = "/view/admin/index.jsp";
			break;
		case "/login":
			service.runAdminService(request, response, Code.ADMIN_LOGIN);
			return;
		case "/logout":
			request.getSession().invalidate();
			
			response.sendRedirect("index");
			return;
		case "/bookManagePage":
			if(!sessionCheck(request, response)) return;
			service.runAdminService(request, response, Code.ADMIN_BOOOK_LIST);
			
			viewPage = "/view/admin/bookManage.jsp";
			break;
		case "/bookAdd":
			if(!sessionCheck(request, response)) return;
			
			viewPage = "/view/admin/bookAdd.jsp";
			break;
		case "/bookInfoTest":
			if(!sessionCheck(request, response)) return;
			
			viewPage = "/view/admin/bookInfoTest.jsp";
			break;
		case "/bookInfo":
			if(!sessionCheck(request, response)) return;
			
			service.runAdminService(request, response, Code.BOOOK_INFO);
			viewPage = "/view/admin/bookInfo.jsp";
			break;
		}

		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
	
	private boolean sessionCheck(HttpServletRequest request, HttpServletResponse response) throws IOException {
		if(!AdminSessionCheck.check(request)) {
			request.getSession().setAttribute("message", "Permission Error!");
			response.sendRedirect("index");
			return false;
		}else {
			return true;
		}
	}
}
