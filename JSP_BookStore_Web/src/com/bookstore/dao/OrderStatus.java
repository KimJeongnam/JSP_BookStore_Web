package com.bookstore.dao;

public class OrderStatus {
	// 주문 상태 코드
	public static final String BUY_ASK = "BUY_ASK";
	public static final String BUY_CONFIRM = "BUY_CONFIRM";
	public static final String BUY_CANCLE = "BUY_CANCLE";
	public static final String REFUND_ASK = "REFUND_ASK";
	public static final String REFUND_CONFIRM = "REFUND_CONFIRM";
	public static final String REFUND_CANCLE = "REFUND_CANCLE";

	/*
	 * INSERT INTO order_status values('BUY_ASK'); INSERT INTO order_status
	 * values('BUY_CONFIRM'); INSERT INTO order_status values('BUY_CANCLE'); INSERT
	 * INTO order_status values('REFUND_ASK'); INSERT INTO order_status
	 * values('REFUND_CONFIRM'); INSERT INTO order_status values('REFUND_CANCLE');
	 */
	
	public static String parseStatus(String status) {
		String result = "";
		
		switch(status) {
		case BUY_ASK:
			result = "주문요청"; break;
		case BUY_CONFIRM:
			result = "주문완료"; break;
		case BUY_CANCLE:
			result = "주문요청 취소"; break;
		case REFUND_ASK:
			result = "환불요청"; break;
		case REFUND_CONFIRM:
			result = "환불완료"; break;
		case REFUND_CANCLE:	
			result = "환불요청 취소"; break;
		}
		
		return result;
	}
}
