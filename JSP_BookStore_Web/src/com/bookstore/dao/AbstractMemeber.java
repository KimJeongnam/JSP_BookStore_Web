package com.bookstore.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Map;

import com.bookstore.model.Cart;
import com.bookstore.model.Order;
import com.bookstore.model.OrderInfo;
import com.bookstore.model.User;

public abstract class AbstractMemeber extends BookStoreDao{

	public abstract int loginDo(String id, String pw)throws SQLException;
	public abstract int checkId(String id)throws SQLException;
	public abstract int signUpDo(User newUser)throws SQLException;
	public abstract int emailCheck(String accept_code)throws SQLException;
	public abstract ArrayList<Cart> cartList(String user_id) throws SQLException;
	public abstract int cartAddDo(String user_id, int book_code, int wish_stock)throws SQLException;
	public abstract int cartTotalPrice(String user_id) throws SQLException;
	public abstract int cartDelDo(String user_id, int book_code) throws SQLException;
	public abstract int cartsDelDo(String user_id, String[] book_codes) throws SQLException;
	public abstract int buy(String user_id, ArrayList<Map<String, Integer>> orders)throws SQLException;
	public abstract ArrayList<Order> orderList(String user_id) throws SQLException;
	public abstract ArrayList<OrderInfo> orderInfo(String order_code) throws SQLException;
}
