package com.bookstore.service.member;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bookstore.model.Book;
import com.bookstore.service.Code;
import com.bookstore.service.Service;

public class MainDo implements Service{

	@Override
	public void run(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ArrayList<Book> newBookList = new ArrayList<Book>();
		ArrayList<Book> hotBookList = new ArrayList<Book>();
		
		newBookInit(newBookList);
		hotBookInit(hotBookList);
		
		request.setAttribute("hotBooks", hotBookList);
		request.setAttribute("newBooks", newBookList);
	}
	
	public void newBookInit(ArrayList<Book> newBookList) {
		Book book = new Book();
		book.setTitle("종이여자");
		book.setAuthor("기욤 뮈소");
		book.setPrice("30,000");
		book.setImage_path(Code.PROJECT_PATH+"/images/종이여자.jpeg");
		newBookList.add(book);
		
		book = new Book();
		book.setTitle("구해줘");
		book.setAuthor("기욤 뮈소");
		book.setPrice("31,000");
		book.setImage_path(Code.PROJECT_PATH+"/images/구해줘.jpeg");
		newBookList.add(book);
		
		book = new Book();
		book.setTitle("센트럴파크");
		book.setAuthor("기욤 뮈소");
		book.setPrice("31,500");
		book.setImage_path(Code.PROJECT_PATH+"/images/센트럴파크.jpeg");
		newBookList.add(book);
		
		book = new Book();
		book.setTitle("브루클린의_소녀");
		book.setAuthor("기욤 뮈소");
		book.setPrice("30,000");
		book.setImage_path(Code.PROJECT_PATH+"/images/브루클린의_소녀.jpeg");
		newBookList.add(book);
	
		book = new Book();
		book.setTitle("제0호");
		book.setAuthor("움베르토 에코");
		book.setPrice("31,500");
		book.setImage_path(Code.PROJECT_PATH+"/images/제0호.jpeg");
		newBookList.add(book);
	}
	
	public void hotBookInit(ArrayList<Book> hotBookList) {
		Book book = new Book();
		book.setTitle("종이여자");
		book.setAuthor("기욤 뮈소");
		book.setPrice("30,000");
		book.setImage_path(Code.PROJECT_PATH+"/images/종이여자.jpeg");
		hotBookList.add(book);
		
		book = new Book();
		book.setTitle("구해줘");
		book.setAuthor("기욤 뮈소");
		book.setPrice("31,000");
		book.setImage_path(Code.PROJECT_PATH+"/images/구해줘.jpeg");
		hotBookList.add(book);
		
		book = new Book();
		book.setTitle("센트럴파크");
		book.setAuthor("기욤 뮈소");
		book.setPrice("31,500");
		book.setImage_path(Code.PROJECT_PATH+"/images/센트럴파크.jpeg");
		hotBookList.add(book);
		
		book = new Book();
		book.setTitle("브루클린의_소녀");
		book.setAuthor("기욤 뮈소");
		book.setPrice("30,000");
		book.setImage_path(Code.PROJECT_PATH+"/images/브루클린의_소녀.jpeg");
		hotBookList.add(book);
		
		book = new Book();
		book.setTitle("제0호");
		book.setAuthor("움베르토 에코");
		book.setPrice("31,500");
		book.setImage_path(Code.PROJECT_PATH+"/images/제0호.jpeg");
		hotBookList.add(book);
		
		
		book = new Book();
		book.setTitle("12가지 인생의 법칙");
		book.setAuthor("조던 B. 피터슨");
		book.setPrice("15,150");
		book.setImage_path(Code.PROJECT_PATH+"/images/12가지_인생의_법칙.jpg");
		hotBookList.add(book);
		
		book = new Book();
		book.setTitle("트렌드 코리아 2019");
		book.setAuthor("김난도, 이준영 외 7명");
		book.setPrice("15,300");
		book.setImage_path(Code.PROJECT_PATH+"/images/트렌드_코리아_2019.jpg");
		hotBookList.add(book);
		
		book = new Book();
		book.setTitle("걷는 사람, 하정우");
		book.setAuthor("하정우");
		book.setPrice("13,900");
		book.setImage_path(Code.PROJECT_PATH+"/images/걷는_사람_하정우.jpg");
		hotBookList.add(book);
		
		book = new Book();
		book.setTitle("고요할수록 밝아지는 것들");
		book.setAuthor("혜민 저");
		book.setPrice("13,500");
		book.setImage_path(Code.PROJECT_PATH+"/images/고요할수록_밝아지는_것들.jpg");
		hotBookList.add(book);
		
		book = new Book();
		book.setTitle("아가씨와 밤");
		book.setAuthor("기욤 뮈소");
		book.setPrice("13,050");
		book.setImage_path(Code.PROJECT_PATH+"/images/아가씨와_밤.jpg");
		hotBookList.add(book);
		
		book = new Book();
		book.setTitle("당신이 옳다");
		book.setAuthor("정혜신");
		book.setPrice("14,220");
		book.setImage_path(Code.PROJECT_PATH+"/images/당신이_옳다.jpg");
		hotBookList.add(book);
	}
}
