package com.bookstore.dao.Impl;

import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.bookstore.dao.AbstractAdmin;
import com.bookstore.dao.OrderStatus;
import com.bookstore.model.BoardVO;
import com.bookstore.model.Order;
import com.bookstore.model.Result;
import com.bookstore.model.Stat;

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


	@Override
	public List<Order> orderList(String status) throws SQLException {
		init();
		
		List<Order> dtos = null;
		
		sql = "SELECT order_code\n" + 
				"    , order_date\n" + 
				"    , user_id\n" + 
				"    , (SELECT COUNT(*) FROM order_info WHERE order_code=o.order_code) as cnt\n" + 
				"    , total_price\n" + 
				"    , status\n" + 
				"    FROM orders o \n" + 
				"	 WHERE status = ?" +
				"    group by order_code, order_date, user_id, total_price, status";
		
		pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, status);
		
		rs = pstmt.executeQuery();
		
		if(rs.next()) {
			dtos = new ArrayList<Order>();
			do {
				Order dto = new Order();
				dto.setOrder_code(rs.getString("order_code"));
				dto.setOrder_date(rs.getTimestamp("order_date"));
				dto.setUser_id(rs.getString("user_id"));
				dto.setOrder_cnt(rs.getInt("cnt"));
				dto.setTotal_price(rs.getInt("total_price"));
				dto.setStatus(OrderStatus.codeToStatus(rs.getString("status")));
				dtos.add(dto);
			}while(rs.next());
		}
		
		close();
		return dtos;
	}


	@Override
	public int buyConfirm(String ...order_code) throws SQLException {
		setSavePoint("savePoint1");
		
		for(String code : order_code) {
			sql = "UPDATE orders \n" + 
					"    SET status='BUY_CONFIRM'\n" + 
					" 	 , order_date = ?"+
					"    WHERE order_code = ?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setTimestamp(1, new Timestamp(System.currentTimeMillis()));
			pstmt.setString(2, code);
			
			result = pstmt.executeUpdate();
			
			if(result==0) {
				rollback("savePoint1");
				break;
			}
		}
		
		commit();
		close();
		return result;
	}
	

	@Override
	public int refundConfirm(String... order_code) throws SQLException {
		setSavePoint("savePoint1");
		
		System.out.println(order_code.length);
		for(String code : order_code) {
			System.out.println("order_code : "+code);
			sql = "DELETE FROM orders where order_code = ?";
			
			System.out.println("conn.prepareStatement() start");
			pstmt = conn.prepareStatement(sql);
			System.out.println("conn.prepareStatement() done");
			
			pstmt.setString(1, code);
			
			result = pstmt.executeUpdate();
			
			System.out.println(result);
			if(result==0) {
				rollback("savePoint1");
				break;
			}
		}
		
		commit();
		close();
		return result;
	}


	@Override
	public Result getResult() throws SQLException {
		Result result = null;
		
		init();
		
		sql = "SELECT (SELECT COUNT(*) FROM orders WHERE status = 'BUY_ASK') buyAskCnt\n" + 
				"    , (SELECT COUNT(*) FROM orders WHERE status = 'REFUND_ASK') refundAskCnt\n" + 
				"    , NVL((SELECT SUM(total_price) \n" + 
				"        FROM orders \n" + 
				"        WHERE status = 'BUY_CONFIRM'\n" + 
				"        AND TO_CHAR(order_date, 'YYYY/MM/DD') = (SELECT \n" + 
				"                            TO_CHAR(SYSDATE-1, 'YYYY/MM/DD') yesterday\n" + 
				"                            FROM DUAL)\n" + 
				"        ), 0) yesterday_totalPrice\n" + 
				"    , NVL((SELECT SUM(total_price) FROM orders\n" + 
				"        WHERE status = 'BUY_CONFIRM'\n" + 
				"        AND TO_CHAR(order_date, 'YYYY/MM/DD') >= (SELECT\n" + 
				"                            TO_CHAR(SYSDATE, 'YYYY/MM/DD') today\n" + 
				"                            FROM DUAL)\n" + 
				"        ), 0) today_totalPrice\n" + 
				"    , NVL((SELECT SUM(total_price) FROM orders WHERE status = 'BUY_CONFIRM'), 0) all_price\n" + 
				"    FROM dual";
		
		pstmt = conn.prepareStatement(sql);
		
		rs = pstmt.executeQuery();
		
		if(rs.next()) {
			result = new Result(); 
			result.setBuyAskCnt(rs.getInt("buyAskCnt"));
			result.setRefundAskCnt(rs.getInt("refundAskCnt"));
			result.setYesterday_totalPrice(rs.getInt("yesterday_totalPrice"));
			result.setToday_totalPrice(rs.getInt("today_totalPrice"));
			result.setAll_price(rs.getInt("all_price"));
		}
		
		close();
		return result;
	}


	@Override
	public List<Stat> getStat() throws SQLException {
		init();
		
		List<Stat> list = null;
		
		sql = "SELECT *  \n" + 
				"    FROM\n" + 
				"    (SELECT ROWNUM as rnum, total, dt\n" + 
				"        FROM\n" + 
				"        (SELECT SUM(total_price) total, TO_CHAR(order_date, 'YYYY-MM') as dt\n" + 
				"            FROM orders\n" + 
				"            WHERE status='BUY_CONFIRM'\n" + 
				"            GROUP BY TO_CHAR(order_date, 'YYYY-MM')\n" + 
				"            ORDER BY TO_CHAR(order_date, 'YYYY-MM') ASC))\n" + 
				"    WHERE rnum >= 1 AND rnum <= 12";
		
		pstmt = conn.prepareStatement(sql);
		
		rs = pstmt.executeQuery();
		
		if(rs.next()) {
			list = new ArrayList<Stat>();
			do {
				Stat data = new Stat();
				data.setDate(rs.getString("dt"));
				data.setTotal_price(rs.getInt("total"));
				System.out.println("Date"+rs.getString("dt"));
				list.add(data);
			}while(rs.next());
		}
		
		close();
		return list;
	}
	
	
}
