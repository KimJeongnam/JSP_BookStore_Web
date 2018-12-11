package com.bookstore.service;

public class Code {
	public static final String PROJECT_PATH = "/JSP_BookStore_Web";
	public static final int MAIN_DO = 100;
	
	// Member service
	public static final int LOGIN = 101;
	public static final int LOGOUT = 102;
	public static final int CHECK_ID = 103;
	public static final int SIGNUP = 104;
	public static final int EMAILCHECK = 105;			// 이메일 인증
	
	// Admin 관리자 service
	public static final int ADMIN_LOGIN = 200;
	public static final int ADMIN_BOOK_MANAGE= 201;			// 재고관리
	public static final int ADMIN_CATEGORY_MANAGE = 203;		// 카테고리 관리
	// 재고관리
	public static final int ADMIN_BOOOK_LIST = 204;
	public static final int ADMIN_BOOK_ADD = 205;
	public static final int ADMIN_BOOK_MODIFY = 206;
	public static final int ADMIN_BOOK_DELETE = 207;
	
	
	public static final int BOOOK_INFO = 208;

	
}
