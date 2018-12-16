package com.bookstore.dao.Impl;

import java.sql.SQLException;
import java.util.ArrayList;

import com.bookstore.dao.AbstractAdmin;
import com.bookstore.model.BoardVO;

public class AdminDaoImpl extends AbstractAdmin{

	@Override
	public int loginDo(String id, String pw) throws SQLException {
		sql = "SELECT user_pw FROM users WHERE user_id=? AND permission='admin'";

		pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, id);
		
		rs = pstmt.executeQuery();
		
		if(rs.next()) {
			result = -1;
			if(rs.getString("user_pw").equals(pw)) {
				result = 1;
			}
		}
		close();
		return result;
	}


	@Override
	public int bookAddDo(BoardVO dto) throws SQLException {
		setSavePoint("save1");
		
		sql = "INSERT INTO books\n" + 
				"    VALUES(book_seq.nextval, ?, ?, ?, ?, ?, ?\n" + 
				"    , TO_DATE(?, 'YYYY-MM-DD'), ?\n" + 
				"    ,0, 0, 0)";
				
		pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, dto.getTitle());
		pstmt.setString(2, dto.getAuthor());
		pstmt.setInt(3, dto.getPrice());
		pstmt.setInt(4, dto.getStock());
		pstmt.setTimestamp(5, dto.getReg_date());
		pstmt.setString(6, dto.getPublisher());
		pstmt.setString(7, dto.getPublish_date());
		pstmt.setString(8, dto.getImage_path());
		
		result = pstmt.executeUpdate();
		
		if(result == 0) {
			rollback("save1");
			return result;
		}
		
		setSavePoint("save2");
		
		sql = "INSERT INTO book_board\n" + 
				"    VALUES(board_seq.nextval, ?, 0, book_seq.currval, ?, 0)";
		
		pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, dto.getContext());
		pstmt.setInt(2, dto.getCategory_id());
		
		result = pstmt.executeUpdate();
		
		if(result == 0) {
			rollback("save1");
			return result;
		}
		
		commit();
		close();
		return result;
	}

	@Override
	public int bookModifyDo(BoardVO dto) throws SQLException {
		setSavePoint("save1");
		
		if(dto.getImage_path()!=null) {
			sql = "UPDATE books SET \n" + 
					"    title=?, author=?\n" + 
					"    , price=?, stock=?, publisher=?\n" + 
					"    , publish_date=?, image_path=?\n" + 
					"    WHERE book_code=?";
		}else {
			sql = "UPDATE books SET \n" + 
					"    title=?, author=?\n" + 
					"    , price=?, stock=?, publisher=?\n" + 
					"    , publish_date=?\n" + 
					"    WHERE book_code=?";
		}
		
		pstmt = conn.prepareStatement(sql);
			
		pstmt.setString(1, dto.getTitle());
		pstmt.setString(2, dto.getAuthor());
		pstmt.setInt(3, dto.getPrice());
		pstmt.setInt(4, dto.getStock());
		pstmt.setString(5, dto.getPublisher());
		pstmt.setString(6, dto.getPublish_date());
		
		if(dto.getImage_path()!=null) {
			pstmt.setString(7, dto.getImage_path());
			pstmt.setInt(8, dto.getBook_code());
		}else
			pstmt.setInt(7, dto.getBook_code());
		
		result = pstmt.executeUpdate();
		
		if(result == 0) {
			rollback("save1");
			return result;
		}
		
		setSavePoint("save2");
		
		sql = "UPDATE book_board SET\n" + 
				"    context=?, category_id=?\n" + 
				"    WHERE board_id=?";
		
		pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, dto.getContext());
		pstmt.setInt(2, dto.getCategory_id());
		pstmt.setInt(3, dto.getBoard_id());
		
		result = pstmt.executeUpdate();
		
		if(result == 0) {
			rollback("save1");
			return result;
		}
		
		commit();
		close();
		return result;
	}

	@Override
	public int bookDeleteDo(int[] book_codes) throws SQLException {
		setSavePoint("save1");
		
		for(int book_code : book_codes) {
			sql = "UPDATE books SET delete_status=1 WHERE book_code=?";
			
			pstmt = conn.prepareStatement(sql);
				
			pstmt.setInt(1, book_code);
			
			result = pstmt.executeUpdate();
			
			if(result == 0) {
				rollback("save1");
				return result;
			}
		}
		
		setSavePoint("save2");
		
		for(int book_code : book_codes) {
			sql = "UPDATE book_board SET delete_status=1 WHERE book_code=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, book_code);
			
			result = pstmt.executeUpdate();
			
			if(result == 0) {
				rollback("save1");
				return result;
			}
		}
		
		commit();
		close();
		return result;
	}
}
