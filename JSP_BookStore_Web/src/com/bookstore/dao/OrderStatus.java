package com.bookstore.dao;

import java.util.LinkedHashMap;
import java.util.Map;

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
	public static Map<String, String> statusMap = new LinkedHashMap<String, String>();
	
	static {
		statusMap.put("BUY_ASK", "주문요청");
		statusMap.put("BUY_CONFIRM", "주문완료");
		statusMap.put("BUY_CANCLE", "주문요청 취소");
		statusMap.put("REFUND_ASK", "환불요청");
		statusMap.put("REFUND_CONFIRM", "환불완료");
		statusMap.put("REFUND_CANCLE", "환불요청 취소");
		
	}

	public static String codeToStatus(String status) {
		String result = "";

		switch (status) {
		case BUY_ASK:
			result = "주문요청";
			break;
		case BUY_CONFIRM:
			result = "주문완료";
			break;
		case BUY_CANCLE:
			result = "주문요청 취소";
			break;
		case REFUND_ASK:
			result = "환불요청";
			break;
		case REFUND_CONFIRM:
			result = "환불완료";
			break;
		case REFUND_CANCLE:
			result = "환불요청 취소";
			break;
		}

		return result;
	}
	
	public static String statusToCode(String status) {
		String result = "";

		switch (status) {
		case "주문요청":
			result = BUY_ASK;
			break;
		case "주문완료":
			result = BUY_CONFIRM;
			break;
		case "주문요청 취소":
			result = BUY_CANCLE;
			break;
		case "환불요청":
			result = REFUND_ASK;
			break;
		case "환불완료":
			result = REFUND_CONFIRM;
			break;
		case "환불요청 취소":
			result = REFUND_CANCLE;
			break;
		}

		return result;
	}
}
