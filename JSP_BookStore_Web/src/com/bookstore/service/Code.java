package com.bookstore.service;

public class Code {
	public static final String PROJECT_PATH = "/JSP_BookStore_Web";
	
	// Share
	public static final int MAIN_DO = 100;
	public static final int BOOOK_LIST = 101;			// 북 리스트
	public static final int BOOOK_INFO = 102; 					// 책 정보
		
	// Member service
	public static final int LOGIN = 200;				// 로그인
	public static final int LOGOUT = 201;				// 로그아웃
	public static final int CHECK_ID = 202;				// id 중복 체크
	public static final int SIGNUP = 203;				// 회원가입
	public static final int EMAILCHECK = 204;			// 이메일 인증
	public static final int CART_LIST = 205;			// 장바구니 리스트
	public static final int CART_ADD_DO = 206;			// 장바구니 추가
	public static final int CART_DEL_DO = 207;			// 장바구니 삭제(단수 개)
	public static final int CARTS_DEL_DO = 208;			// 장바구니 삭제(복수 개)
	public static final int NOW_BUY = 209;				// 바로구매
	public static final int CART_ITEMS_BUY = 210;		// 장바구니 아이템 여러개 구매
	public static final int MEMBER_ORDER_LIST = 211;			// 고객 주문 내역
	public static final int MEMBER_ORDER_INFO = 212;			// 고객 주문 내역
	public static final int MEMBER_REFUND_ASK = 213;			// 고객 환불 요청
	
	// Admin 관리자 service
	public static final int ADMIN_INDEX = 299;				// 관리자 index
	public static final int ADMIN_LOGIN = 300;				// 관리자 로그인
	public static final int ADMIN_BOOK_MANAGE= 301;			// 재고관리
	public static final int ADMIN_CATEGORY_MANAGE = 302;	// 카테고리 관리
	// 재고관리
	public static final int ADMIN_BOOK_ADD_FROM = 310;		// 책추가 페이지
	public static final int ADMIN_BOOK_ADD_DO = 311;		// 책추가
	public static final int ADMIN_BOOK_MODIFY_FORM = 312;	// 책 수정 페이지
	public static final int ADMIN_BOOK_MODIFY_DO = 313;		// 책 수정
	public static final int ADMIN_BOOK_DELETE_DO = 314;		// 책 삭제	
	
	public static final int ADMIN_ORDER_LIST = 320; 		// 주문 요청 목록
	public static final int ADMIN_ORDER_INFO = 321;			// 고객 주문 내역
	public static final int ADMIN_BUY_CONFIRM = 322;		// 관리자 주문 승인 * 1개
	public static final int ADMIN_BUY_CONFIRMS = 323;		// 관리자 주문 승인 * 복수개
	public static final int ADMIN_REFUND_CONFIRM = 324;

}
