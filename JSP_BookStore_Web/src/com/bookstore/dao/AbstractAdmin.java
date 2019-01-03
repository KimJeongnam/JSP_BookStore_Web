package com.bookstore.dao;

import java.sql.SQLException;
import java.util.List;

import com.bookstore.model.BoardVO;
import com.bookstore.model.Order;
import com.bookstore.model.Result;
import com.bookstore.model.Stat;

public abstract class AbstractAdmin extends BookStoreDao{
	public abstract int loginDo(String id, String pw)throws SQLException;
	public abstract int bookAddDo(BoardVO dto) throws SQLException;
	public abstract int bookModifyDo(BoardVO dto) throws SQLException;
	public abstract int bookDeleteDo(int[] book_codes) throws SQLException;
	public abstract List<Order> orderList(String status) throws SQLException;
	public abstract int buyConfirm(String ...order_code) throws SQLException;
	public abstract Result getResult()throws SQLException;
	public abstract int refundConfirm(String ...order_code) throws SQLException;
	public abstract List<Stat> getStat() throws SQLException;
}
