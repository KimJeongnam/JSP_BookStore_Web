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
			service.runAdminService(request, response, Code.BOOOK_LIST);
			
			viewPage = "/view/admin/bookManage.jsp";
			break;
		case "/bookAddForm":
			if(!sessionCheck(request, response)) return;
			
			service.runAdminService(request, response, Code.ADMIN_BOOK_ADD_FROM);
			
			viewPage = "/view/admin/bookAddForm.jsp";
			break;
		case "/bookAddDo":
			if(!sessionCheck(request, response)) return;
			
			service.runAdminService(request, response, Code.ADMIN_BOOK_ADD_DO);
			
			return;
		case "/bookInfo":
			if(!sessionCheck(request, response)) return;
			
			service.runAdminService(request, response, Code.BOOOK_INFO);
			viewPage = "/view/admin/bookInfo.jsp";
			break;
		case "/bookModifyForm":
			if(!sessionCheck(request, response)) return;
			
			service.runAdminService(request, response, Code.ADMIN_BOOK_ADD_FROM);
			service.runAdminService(request, response, Code.BOOOK_INFO);
			
			viewPage = "/view/admin/bookModifyForm.jsp";
			break;
		case "/bookModifyDo":
			if(!sessionCheck(request, response)) return;
			
			service.runAdminService(request, response, Code.ADMIN_BOOK_MODIFY_DO);
			
			return;
		case "/bookDeleteDo":
			if(!sessionCheck(request, response)) return;
			
			service.runAdminService(request, response, Code.ADMIN_BOOK_DELETE_DO);
			
			return;
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
