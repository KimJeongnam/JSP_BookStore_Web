package com.bookstore.dao;

import java.sql.SQLException;
import java.util.ArrayList;

import com.bookstore.model.BoardVO;

public abstract class AbstractAdmin extends BookStoreDao{
	public abstract int loginDo(String id, String pw)throws SQLException;
	public abstract int bookAddDo(BoardVO dto) throws SQLException;
	public abstract int bookModifyDo(BoardVO dto) throws SQLException;
	public abstract int bookDeleteDo(int[] book_codes) throws SQLException;
}
