package com.bookstore.dao;

import java.sql.SQLException;
import java.util.ArrayList;

import com.bookstore.model.BoardVO;
import com.bookstore.model.Category;

public abstract class AbstarctShared extends BookStoreDao{
	public abstract ArrayList<Category> getCategorys()throws SQLException;
	
	public abstract int getTotalBoardCnt(String ...args)throws SQLException;
	public abstract ArrayList<BoardVO> getBoardList(int start, int end, String ...args) throws SQLException;
	public abstract BoardVO getBookInfo(int board_id) throws SQLException;
	
	public abstract ArrayList<BoardVO> getHotBooks() throws SQLException;
	public abstract ArrayList<BoardVO> getNewBooks() throws SQLException;
}
