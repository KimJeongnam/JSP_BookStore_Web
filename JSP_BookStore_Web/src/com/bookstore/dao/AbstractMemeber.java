package com.bookstore.dao;

import java.sql.SQLException;

import com.bookstore.model.User;

public abstract class AbstractMemeber extends BookStoreDao{

	public abstract int loginDo(String id, String pw)throws SQLException;
	public abstract int checkId(String id)throws SQLException;
	public abstract int signUpDo(User newUser)throws SQLException;
	public abstract int emailCheck(String accept_code)throws SQLException;
}
