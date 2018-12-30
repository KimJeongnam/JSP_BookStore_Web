package com.bookstore.dao;

import java.sql.SQLException;
import java.util.List;

import com.bookstore.model.BoardVO;
import com.bookstore.model.Order;

public abstract class AbstractAdmin extends BookStoreDao{
	public abstract int loginDo(String id, String pw)throws SQLException;
	public abstract int bookAddDo(BoardVO dto) throws SQLException;
	public abstract int bookModifyDo(BoardVO dto) throws SQLException;
	public abstract int bookDeleteDo(int[] book_codes) throws SQLException;
	public abstract List<Order> orderList(String status) throws SQLException;
	public abstract int buyConfirm(String order_code) throws SQLException;
}
