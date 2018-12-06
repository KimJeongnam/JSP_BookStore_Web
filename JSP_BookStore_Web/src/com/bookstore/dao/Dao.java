package com.bookstore.dao;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class Dao {
	private static Dao instance = new Dao();
	public static Dao getInstance() { return instance; } 
	
	private DataSource dataSource = null;
	private Context context = null;
	
	private Dao() {
		try {
			context = new InitialContext();
			dataSource = (DataSource)context.lookup("java:comp/env/jdbc/Oracle11g_bookstore");
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

	public DataSource getDataSource() {return dataSource;}
}
