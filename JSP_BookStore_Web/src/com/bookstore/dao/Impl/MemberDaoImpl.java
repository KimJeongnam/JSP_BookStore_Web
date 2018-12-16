package com.bookstore.dao.Impl;

import java.sql.SQLException;

import com.bookstore.dao.AbstractMemeber;
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
	
}
