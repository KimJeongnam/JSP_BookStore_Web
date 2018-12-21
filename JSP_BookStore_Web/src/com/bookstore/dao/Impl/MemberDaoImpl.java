package com.bookstore.dao.Impl;

import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Map;
import java.util.UUID;

import com.bookstore.dao.AbstractMemeber;
import com.bookstore.dao.OrderStatus;
import com.bookstore.model.Cart;
import com.bookstore.model.Order;
import com.bookstore.model.User;

public class MemberDaoImpl extends AbstractMemeber{

	@Override
	public int loginDo(String id, String pw) throws SQLException{
		init();
		sql = "SELECT user_pw, accept_status FROM users WHERE user_id=? AND permission='customer'";

		pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, id);
		
		rs = pstmt.executeQuery();
		
		if(rs.next()) {
			result = -1;
			if(rs.getString("user_pw").equals(pw)) {
				result = 1;
				if(rs.getInt("accept_status")==0) {
					result = 2;
				}
			}
		}
		close();
		return result;
	}
	
	@Override
	public int checkId(String id) throws SQLException {
		init();
		sql = "SELECT COUNT(*) as cnt FROM users WHERE user_id=?";

		pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, id);
		
		rs = pstmt.executeQuery();
		
		if(rs.next()) {
			result = rs.getInt("cnt");
		}
		
		close();
		return result;
	}

	@Override
	public int signUpDo(User newUser) throws SQLException {
		init();
		sql = "insert into users(\n" + 
				"    USER_ID\n" + 
				"    , USER_PW\n" + 
				"    , NAME\n" + 
				"    , SSN\n" + 
				"    , EMAIL\n" + 
				"    , ZIPCODE\n" + 
				"    , ADDRESS1\n" +
				"    , ADDRESS2\n" +
				"    , PHONE_NUMBER\n" + 
				"    , HIRE_DATE\n" +
				"    , ACCEPT_CODE\n" +
				"    , DELETE_STATUS\n" + 
				"    , PERMISSION)\n" + 
				"    values(?, ?, ?, ?,\n" + 
				"    ?, ?, ?, ?, ?, ?, ?, 0, 'customer')";
		
		pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, newUser.getUser_id());
		pstmt.setString(2, newUser.getUser_pw());
		pstmt.setString(3, newUser.getName());
		pstmt.setString(4, newUser.getSsn());
		pstmt.setString(5, newUser.getEmail());
		pstmt.setString(6, newUser.getZipcode());
		pstmt.setString(7, newUser.getAddress1());
		pstmt.setString(8, newUser.getAddress2());
		pstmt.setString(9, newUser.getPhone_number());
		pstmt.setTimestamp(10, newUser.getHire_date());
		pstmt.setString(11, newUser.getAccept_code());
		
		result = pstmt.executeUpdate();
		
		close();
		return result;
	}

	@Override
	public int emailCheck(String accept_code) throws SQLException {
		init();
		sql = "UPDATE users SET accept_status=1 WHERE ACCEPT_CODE=?";
		
		pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, accept_code);
		
		result = pstmt.executeUpdate();
		
		close();
		return result;
	}

	@Override
	public int cartAddDo(String user_id, int book_code, int wish_stock) throws SQLException {
		init();
		sql = "MERGE INTO carts c\n" + 
				"USING ( SELECT ? user_id, ? book_code, ? wish_stock   -- USING절에 뷰가 올수 있다.\n" + 
				"        FROM dual) s\n" + 
				"ON ( c.user_id = s.user_id \n" + 
				"    AND c.book_code = s.book_code)\n" + 
				"WHEN MATCHED THEN\n" + 
				"  UPDATE SET c.wish_stock = c.wish_stock + s.wish_stock\n" + 
				"  WHERE c.wish_stock+s.wish_stock <= (SELECT stock FROM books WHERE book_code = s.book_code)\n" + 
				"WHEN NOT MATCHED THEN\n" + 
				"    INSERT (c.user_id, c.book_code, c.wish_stock)\n" + 
				"    VALUES (s.user_id, s.book_code, s.wish_stock)\n" + 
				"    WHERE s.wish_stock <= (SELECT stock FROM books WHERE book_code = s.book_code)";
		
		pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, user_id);
		pstmt.setInt(2, book_code);
		pstmt.setInt(3, wish_stock);
		
		result = pstmt.executeUpdate();
		
		close();
		return result;
	}
	
	@Override
	public int cartTotalPrice(String user_id) throws SQLException {
		init();
		
		sql = "SELECT SUM(b.price*c.wish_stock ) as total_price\n" + 
				"    FROM carts c JOIN books b\n" + 
				"    ON c.book_code = b.book_code \n" + 
				"    WHERE c.user_id = ?";
		
		pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, user_id);
		
		rs = pstmt.executeQuery();
		
		if(rs.next())
			result = rs.getInt("total_price");
		
		return result;
	}

	@Override
	public ArrayList<Cart> cartList(String user_id) throws SQLException {
		init();
		
		ArrayList<Cart> dtos = null;
		
		sql = "SELECT c.book_code\n" + 
				"    , board.board_id\n" + 
				"    , b.image_path\n" + 
				"    , b.title \n" + 
				"    , b.author\n" + 
				"    , b.price\n" + 
				"    , c.wish_stock\n" + 
				"    , b.price*c.wish_stock as total_price\n" + 
				"    FROM carts c JOIN books b\n" + 
				"    ON c.book_code = b.book_code \n" + 
				"    JOIN book_board board\n" + 
				"    ON b.book_code = board.book_code\n" + 
				"    WHERE c.user_id = ?";
		
		pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, user_id);
		
		rs = pstmt.executeQuery();
		
		if(rs.next()) {
			dtos = new ArrayList<Cart> ();
			do {
				Cart dto = new Cart();
				dto.setBook_code(rs.getInt("book_code"));
				dto.setBoard_id(rs.getInt("board_id"));
				dto.setImage_path(rs.getString("image_path"));
				dto.setTitle(rs.getString("title"));
				dto.setAuthor(rs.getString("author"));
				dto.setPrice(rs.getInt("price"));
				dto.setWish_stock(rs.getInt("wish_stock"));
				dto.setTotal_price(rs.getInt("total_price"));
				dtos.add(dto);
			}while(rs.next());
		}
		
		close();
		return dtos;
	}

	@Override
	public int cartDelDo(String user_id, int book_code) throws SQLException {
		init();
		sql = "DELETE FROM carts WHERE user_id=? AND book_code=?";
		
		pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, user_id);
		pstmt.setInt(2, book_code);
		
		result = pstmt.executeUpdate();
		
		close();
		return result;
	}

	@Override
	public int cartsDelDo(String user_id, String[] book_codes) throws SQLException {
		setSavePoint("savePoint1");
		
		for(String code: book_codes) {
			if(cartDelDo(user_id, Integer.parseInt(code))==0) {
				rollback("savePoint1");
				commit();
				close();
				return 0;
			}
		}
		commit();
		close();
		return 1;
	}

	@Override
	public int buy(String user_id, ArrayList<Map<String, Integer>> orders) throws SQLException {
		setSavePoint("savePoint1");
		String uuid = "";
		
		while(result==0) {
			sql = "INSERT INTO orders(\n" + 
					"    order_code\n" + 
					"    , user_id\n" + 
					"    , status\n" + 
					"    , order_date\n" + 
					"    , total_price)\n" + 
					"    VALUES(?, ? , ? , ?, 0)";
			
			pstmt = conn.prepareStatement(sql);
			
			uuid = UUID.randomUUID().toString();
			
			pstmt.setString(1, uuid);
			pstmt.setString(2, user_id);
			pstmt.setString(3, OrderStatus.BUY_ASK);
			pstmt.setTimestamp(4, new Timestamp(System.currentTimeMillis()));
			
			result = pstmt.executeUpdate();
		}
		setSavePoint("savePoint2");
		
		for(Map<String, Integer> cart : orders) {
			sql = "INSERT INTO order_info(\n" + 
					"    order_code\n" + 
					"    , book_code\n" + 
					"    , buy_stock)\n" + 
					"    VALUES(?, ?, ?)";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, uuid);
			pstmt.setInt(2, cart.get("book_code"));
			pstmt.setInt(3, cart.get("wish_stock"));
			
			if((result = pstmt.executeUpdate())==0) {
				rollback("savePoint1");
			}
		}
		
		commit();
		close();
		return result;
	}

	@Override
	public ArrayList<Order> orderList(String user_id) throws SQLException {
		ArrayList<Order> dtos = null;
		
		init();
		
		sql = "SELECT order_code\n" + 
				"    , order_date\n" + 
				"    , (SELECT COUNT(*) FROM order_info WHERE order_code=o.order_code) as cnt\n" + 
				"    , total_price\n" + 
				"    , status\n" + 
				"    FROM orders o \n" + 
				"    WHERE user_id=?\n" + 
				"    group by order_code, order_date, total_price, status\n" + 
				"    ORDER BY o.order_date DESC";
		
		pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, user_id);
		
		rs = pstmt.executeQuery();
		
		if(rs.next()) {
			dtos = new ArrayList<Order>();
			do {
				Order dto = new Order();
				dto.setOrder_code(rs.getString("order_code"));
				dto.setOrder_date(rs.getTimestamp("order_date"));
				dto.setOrder_cnt(rs.getInt("cnt"));
				dto.setTotal_price(rs.getInt("total_price"));
				dto.setStatus(OrderStatus.parseStatus(rs.getString("status")));
				dtos.add(dto);
			}while(rs.next());
		}
		
		return dtos;
	}
}
