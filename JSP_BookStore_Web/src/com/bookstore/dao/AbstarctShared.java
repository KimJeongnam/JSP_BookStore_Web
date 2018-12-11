package com.bookstore.dao;

import java.sql.SQLException;
import java.util.ArrayList;

import com.bookstore.model.Category;

public abstract class AbstarctShared extends BookStoreDao{
	public abstract ArrayList<Category> getCategorys()throws SQLException;
}
