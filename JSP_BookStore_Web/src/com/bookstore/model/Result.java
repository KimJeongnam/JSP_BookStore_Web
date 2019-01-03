package com.bookstore.model;

public class Result {
	private int buyAskCnt;					// 구매 요청 건수
	private int refundAskCnt;				// 환불 요청 건수
	private int yesterday_totalPrice;		// 어제 판매액
	private int today_totalPrice;			// 금일 판매액
	private int all_price;					// 총 판매액
	
	public int getBuyAskCnt() {
		return buyAskCnt;
	}
	public void setBuyAskCnt(int buyAskCnt) {
		this.buyAskCnt = buyAskCnt;
	}
	public int getRefundAskCnt() {
		return refundAskCnt;
	}
	public void setRefundAskCnt(int refundAskCnt) {
		this.refundAskCnt = refundAskCnt;
	}
	public int getYesterday_totalPrice() {
		return yesterday_totalPrice;
	}
	public void setYesterday_totalPrice(int yesterday_totalPrice) {
		this.yesterday_totalPrice = yesterday_totalPrice;
	}
	public int getToday_totalPrice() {
		return today_totalPrice;
	}
	public void setToday_totalPrice(int today_totalPrice) {
		this.today_totalPrice = today_totalPrice;
	}
	public int getAll_price() {
		return all_price;
	}
	public void setAll_price(int all_price) {
		this.all_price = all_price;
	}
}
