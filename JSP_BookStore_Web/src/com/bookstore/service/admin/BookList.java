package com.bookstore.service.admin;

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


public class BookList implements Service{

	@Override
	public void run(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		SharedDaoImpl dao = new SharedDaoImpl();
		
		int pageSize = 5;		// 한 페이지당 출력할 글 갯수
		int pageBlock = 3; 		// 한블럭당 페이지 갯수 
		
		int cnt = 0; 			// 총 글 갯수
		int start = 0;			// 현재 페이지 시작 글번호
		int end = 0;			// 현재 페이지 마지막 글 번호
		int number = 0;			// 출력용 글번호
		String pageNum = "";	// 페이지 번호
		int currentPage = 0; 	// 현재 페이지
		int pageCount = 0;		// 페이지 갯수
		int startPage = 0;		// 시작 페이지
		int endPage = 0;		// 마지막 페이지
		
		
		 
		try {
			ArrayList<Category> categorys = new SharedDaoImpl().getCategorys();
			request.setAttribute("categorys", categorys);
			cnt = dao.getTotalBoardCnt();
		}catch(SQLException e) {
			e.printStackTrace();
		}
		
		System.out.println("글 갯수 : "+cnt);
		
		pageNum = request.getParameter("pageNum");
		
		if(pageNum == null) pageNum = "1";
		
		currentPage = Integer.parseInt(pageNum);
		

		// 글 30건 기준
		currentPage = Integer.parseInt(pageNum);
		System.out.println("currentPage : "+currentPage);
		
		
		//페이지 갯수  6 = (30 / 5) + (0)   나머지가 0보다크면 1페이지 증가
		pageCount = cnt/pageSize+(cnt%pageSize>0 ? 1 : 0);
		
		// 현재 페이지 시작 글 번호 1 (페이지별)
		// 1 = (1 - 1)*5 + 1
		start = (currentPage -1)*pageSize+1;
		
		// 현재 페이지 마지막 글 번호(페이지별)
		// 5 = 1 + 5 -1;
		end = start+pageSize-1;
		
		System.out.println("start  : "+start);
		System.out.println("end  : "+end);
		if(end > cnt) end = cnt;
		
		// 출력용 글번호
		// 30 = 30 - (1 - 1) * 5
		number = cnt - (currentPage-1)*pageSize; 	// 출력용 글번호
		System.out.println("number : "+number);
		System.out.println("pageSize : "+pageSize);
		
		if(cnt > 0 ) {
			// 5-2 게시글 목록 조회
			try {
				ArrayList<BoardVO> list = dao.getBoardList(start, end);
				request.setAttribute("list", list);
			}catch(SQLException e) {
				e.printStackTrace();
				request.setAttribute("message", e.getMessage().trim().replace("\"", "\'"));
			}
		}
		
		// 6단계 request나 session 객체에 처리 결과를 저장 (jsp에 전달하기 위함)
		// 1 = (1 / 3) * 3 + 1;
		startPage = (currentPage / pageBlock) * pageBlock +1;
		
		if(currentPage % pageBlock == 0) startPage -= pageBlock;
		System.out.println("StartPage : "+startPage);
		
		// 3 = 1 + 3 - 1;
		endPage = startPage + pageBlock -1;
		if(endPage > pageCount) endPage = pageCount;
		System.out.println("endPage : "+endPage);
		System.out.println("==================");
		
		request.setAttribute("cnt", cnt);
		request.setAttribute("number", number);
		request.setAttribute("pageNum", pageNum);

		if(cnt > 0) {
			request.setAttribute("startPage", startPage);		// 시작 페이지
			request.setAttribute("endPage", endPage);		// 마지막 페이지
			request.setAttribute("pageBlock", pageBlock);	// 출력할 페이지 갯수
			request.setAttribute("pageCount", pageCount);	// 페이지 갯수
			request.setAttribute("currentPage", currentPage); 	// 현재 페이지
			request.setAttribute("pageSize", pageSize);
		}
	}

}
