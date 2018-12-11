package com.bookstore.dao;

import java.sql.SQLException;
import java.util.ArrayList;

import com.bookstore.model.BoardVO;

public abstract class AbstractAdmin extends BookStoreDao{
	public abstract int loginDo(String id, String pw)throws SQLException;
	public abstract int getTotalBoardCnt()throws SQLException;
	public abstract ArrayList<BoardVO> getBoardList(int start, int end, String ...args) throws SQLException;
	public abstract BoardVO getBookInfo(int board_id) throws SQLException;
}
