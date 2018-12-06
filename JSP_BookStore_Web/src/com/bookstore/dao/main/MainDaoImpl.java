package com.bookstore.dao.main;

import java.sql.SQLException;

import com.bookstore.dao.AbstractMain;
import com.bookstore.model.User;

public class MainDaoImpl extends AbstractMain{

	@Override
	public int loginDo(String id, String pw) throws SQLException{
		sql = "SELECT user_pw, accept_status FROM users WHERE user_id=?";

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
		sql = "UPDATE users SET accept_status=1 WHERE ACCEPT_CODE=?";
		
		pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, accept_code);
		
		result = pstmt.executeUpdate();
		
		close();
		return result;
	}
	
	
}
