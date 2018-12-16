package com.bookstore.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Savepoint;
import java.util.HashMap;
import java.util.Map;

public class BookStoreDao {
	protected Connection conn = null;
	protected PreparedStatement pstmt = null;
	protected ResultSet rs = null;
	protected Map<String, Savepoint> savepoint = new HashMap<String, Savepoint>();
	protected String sql = null;
	protected Integer result = 0;

	public BookStoreDao() {
		try {
			conn = Dao.getInstance().getDataSource().getConnection();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public void close() throws SQLException {
		if (rs != null)
			rs.close();
		if (pstmt != null)
			pstmt.close();
		if (conn != null)
			conn.close();
	}
	
	public void init() throws SQLException {
		if (conn != null)
			close();
		conn = Dao.getInstance().getDataSource().getConnection();
	}

	public void setSavePoint(String point) throws SQLException {
		if (conn == null)
			init();
		conn.setAutoCommit(false);
		savepoint.put(point, conn.setSavepoint(point));
	}
	
	public void commit() throws SQLException{
		if(savepoint!=null) {
			conn.commit();
			conn.setAutoCommit(true);
		}
	}
	
	public void rollback(String point) throws SQLException{
		if(savepoint!=null) {
			conn.rollback(savepoint.get(point));
		}
		else
			System.out.println("Savepoint is Null");
	}
	
}
