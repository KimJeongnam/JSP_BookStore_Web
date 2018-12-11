package com.bookstore.model;

import java.sql.Timestamp;

public class BoardVO {
	// Board
	private int board_id;
	private String context;
	private int readcnt;
		
/*	
 * book_board table
	BOARD_ID	NUMBER
	CONTEXT	NVARCHAR2(2000 CHAR)
	READCNT	NUMBER
	BOOK_CODE	NUMBER
	CATEGORY_ID	NVARCHAR2(50 CHAR)
	DELETE_STATUS	NUMBER(1,0)
*/
	
	// Books
	private int book_code;
	private String title;
	private String author;
	private int price;
	private int stock;
	private Timestamp reg_date;
	private String publisher;
	private Timestamp publish_date;
	private String image_path;
	private int rating;
	private int delete_status;
	
/*	books table
 * BOOK_CODE	NUMBER
	TITLE	NVARCHAR2(100 CHAR)
	AUTHOR	NVARCHAR2(100 CHAR)
	PRICE	NUMBER
	STOCK	NUMBER
	REG_DATE	TIMESTAMP(6)
	PUBLISHER	NVARCHAR2(100 CHAR)
	PUBLISH_DATE	DATE
	IMAGE_PATH	NVARCHAR2(255 CHAR)
	RATING	NUMBER(2,1)
	RATING_CNT	NUMBER
	DELETE_STATUS	NUMBER(1,0)
 */
	
	// categorys table
	private int category_id;
	private String category_name;
	private int super_id;
	private String super_name;
	
/*	categorys
 * CATEGORY_ID	NUMBER
	CATEGORY_NAME	NVARCHAR2(50 CHAR)
	SUPER_ID	NUMBER
*/

	public int getBoard_id() {
		return board_id;
	}
	public void setBoard_id(int board_id) {
		this.board_id = board_id;
	}
	public String getContext() {
		return context;
	}
	public void setContext(String context) {
		this.context = context;
	}
	public int getReadcnt() {
		return readcnt;
	}
	public void setReadcnt(int readcnt) {
		this.readcnt = readcnt;
	}
	public int getBook_code() {
		return book_code;
	}
	public void setBook_code(int book_code) {
		this.book_code = book_code;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getStock() {
		return stock;
	}
	public void setStock(int stock) {
		this.stock = stock;
	}
	public Timestamp getReg_date() {
		return reg_date;
	}
	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}
	public String getPublisher() {
		return publisher;
	}
	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}
	public Timestamp getPublish_date() {
		return publish_date;
	}
	public void setPublish_date(Timestamp publish_date) {
		this.publish_date = publish_date;
	}
	public String getImage_path() {
		return image_path;
	}
	public void setImage_path(String image_path) {
		this.image_path = image_path;
	}
	public int getRating() {
		return rating;
	}
	public void setRating(int rating) {
		this.rating = rating;
	}
	public int getDelete_status() {
		return delete_status;
	}
	public void setDelete_status(int delete_status) {
		this.delete_status = delete_status;
	}
	public int getCategory_id() {
		return category_id;
	}
	public void setCategory_id(int category_id) {
		this.category_id = category_id;
	}
	public String getCategory_name() {
		return category_name;
	}
	public void setCategory_name(String category_name) {
		this.category_name = category_name;
	}
	public int getSuper_id() {
		return super_id;
	}
	public void setSuper_id(int super_id) {
		this.super_id = super_id;
	}
	public String getSuper_name() {
		return super_name;
	}
	public void setSuper_name(String super_name) {
		this.super_name = super_name;
	}
}
