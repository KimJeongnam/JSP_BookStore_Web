package com.bookstore.dao.Impl;

import java.sql.SQLException;
import java.util.ArrayList;

import com.bookstore.dao.AbstarctShared;
import com.bookstore.model.BoardVO;
import com.bookstore.model.Category;

public class SharedDaoImpl extends AbstarctShared{

	@Override
	public ArrayList<Category> getCategorys() throws SQLException {
		init();
		ArrayList<Category> dtos = null;
		
		sql = "SELECT level, category_id, LPAD(' ', 2*(level-1)) || category_name  as category_name,\n" + 
				"    super_id, CONNECT_BY_ISLEAF ISLEAF\n" + 
				"    FROM categorys\n" + 
				"    START WITH super_id IS NULL\n" + 
				"    CONNECT BY PRIOR category_id = super_id\n" + 
				"    ORDER SIBLINGS BY category_id ASC";

		pstmt = conn.prepareStatement(sql);
		
		rs = pstmt.executeQuery();
		
		if(rs.next()) {
			dtos = new ArrayList<Category>();
			do {
				Category category = new Category();
				category.setLevel(rs.getInt("level"));
				category.setCategory_id(rs.getInt("category_id"));
				category.setCategory_name(rs.getString("category_name"));
				category.setSuper_id(rs.getInt("super_id"));
				dtos.add(category);
			}while(rs.next());
		}
		close();
		return dtos;
	}


	@Override
	public int getTotalBoardCnt(String ...args) throws SQLException {
		init();
		
		String where = "WHERE";
		String keyword = "";
		
		if(args!=null) {
			if(args.length >= 2) {
				keyword = args[1];
				switch(args[0]) {
				case "category_id":
					where = " WHERE board.category_id='"+keyword+"' AND";
				}
			}
		}
		
		sql = "SELECT COUNT(*) as cnt FROM book_board board "+where+" board.delete_status <> 1";

		pstmt = conn.prepareStatement(sql);
		
		rs = pstmt.executeQuery();
		
		if(rs.next()) {
			result  = rs.getInt("cnt");
		}
		close();
		return result;
	}

	@Override
	public ArrayList<BoardVO> getBoardList(int start, int end, String ...args) throws SQLException {
		init();
		ArrayList<BoardVO> dtos = null;
	
		String where = "";
		String keyword = "";
		String hot = "";
		
		if(args!=null) {
			if(args.length >= 2) {
				keyword = args[1];
				switch(args[0]) {
				case "제목/내용":
					where = " WHERE b.title like '"+keyword+"' OR board.context like '"+keyword+"' ";
					break;
				case "category_id":
					where = " WHERE board.category_id='"+keyword+"' ";
				}
			}else if(args.length > 0) {
				switch(args[0]) {
				case "hot":
					hot = "b.rating DESC, board.readcnt DESC,";
					break;
				}
			}
		}
		
		
		sql = "SELECT *\n" + 
				"    FROM(\n" + 
				"    SELECT\n" + 
				"        ROWNUM as rnum\n" + 
				"        , board_id\n" + 
				"        , context\n" + 
				"        , readcnt\n" + 
				"        , book_code\n" + 
				"        , title\n" + 
				"        , author\n" + 
				"        , price\n" + 
				"        , stock\n" + 
				"        , publisher\n" + 
				"        , TO_CHAR(publish_date, 'yyyy-mm-dd') as publish_date\n" + 
				"        , reg_date\n" + 
				"        , image_path\n" + 
				"        , rating\n" + 
				"        , delete_status\n" + 
				"        , category_id\n" + 
				"        , category_name\n" + 
				"        , super_id\n" + 
				"        , super_name\n" + 
				"        FROM(SELECT \n" + 
				"            board_id, board.context, board.readcnt, b.book_code, b.title, b.author, b.price, b.stock, b.publisher, b.publish_date, b.reg_date\n" + 
				"            , b.image_path, b.rating, b.delete_status, c.category_id, c.category_name, c.super_id\n" + 
				"            , super.category_name as super_name\n" + 
				"            FROM (SELECT * FROM book_board\n" + 
				"                WHERE delete_status <> 1\n" + 
				"                ORDER BY board_id DESC \n" + 
				"                ) board \n" + 
				"            JOIN books b ON board.book_code = b.book_code \n" + 
				"            JOIN categorys c ON c.category_id = board.category_id JOIN categorys super ON c.super_id = super.category_id\n" + 
								where+
				"            ORDER BY "+hot+" reg_date DESC, title ASC)\n" + 
				"    )\n" + 
				"    WHERE rnum >= ? AND rnum <= ?";
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, start);
		pstmt.setInt(2, end);
		
		rs = pstmt.executeQuery();
		
		
		if(rs.next()) {
			dtos = new ArrayList<BoardVO>(); 	
			
			do {
				BoardVO data = new BoardVO();
				
				data.setBoard_id(rs.getInt("board_id"));
				data.setContext(rs.getString("context"));
				data.setReadcnt(rs.getInt("readcnt"));
				data.setBook_code(rs.getInt("book_code"));
				data.setTitle(rs.getString("title"));
				data.setAuthor(rs.getString("author"));
				data.setPrice(rs.getInt("price"));
				data.setStock(rs.getInt("stock"));
				data.setPublisher(rs.getString("publisher"));
				data.setPublish_date(rs.getString("publish_date"));
				data.setReg_date(rs.getTimestamp("reg_date"));
				data.setImage_path(rs.getString("image_path"));
				data.setRating(rs.getInt("rating"));
				data.setDelete_status(rs.getInt("delete_status"));
				data.setCategory_id(rs.getInt("category_id"));
				data.setCategory_name(rs.getString("category_name"));
				data.setSuper_id(rs.getInt("super_id"));
				data.setSuper_name(rs.getString("super_name"));
				
				dtos.add(data);
			}while(rs.next());
		}
		
		close();
		return dtos;
	}

	@Override
	public BoardVO getBookInfo(int board_id) throws SQLException {
		init();
		BoardVO data = null;
		
		sql = "SELECT\n" + 
				"        ROWNUM as rnum\n" + 
				"        , board_id      -- 게시판 id\n" + 
				"        , context       -- 내용\n" + 
				"        , readcnt       -- 조회수\n" + 
				"        , book_code     -- 책코드\n" + 
				"        , title         -- 책 제목\n" + 
				"        , author        -- 저자\n" + 
				"        , price         -- 가격\n" + 
				"        , stock         -- 수량\n" + 
				"        , publisher     -- 출판사\n" + 
				"        , TO_CHAR(publish_date, 'yyyy-mm-dd') as publish_date  -- 출판일\n" + 
				"        , reg_date      -- 등록일\n" + 
				"        , image_path    -- 이미지 경로\n" + 
				"        , rating        -- 평점\n" + 
				"        , delete_status -- 삭제여부\n" + 
				"        , category_id   -- 카테고리 id\n" + 
				"        , category_name -- 카테고리 이름\n" + 
				"        , super_id      -- 상위 카테고리 id\n" + 
				"        , super_name    -- 상위 카테고리 이름\n" + 
				"        FROM(SELECT \n" + 
				"            board_id, board.context, board.readcnt, b.book_code, b.title, b.author, b.price, b.stock, b.publisher, b.publish_date, b.reg_date\n" + 
				"            , b.image_path, b.rating, b.delete_status, c.category_id, c.category_name, c.super_id\n" + 
				"            , super.category_name as super_name\n" + 
				"            FROM (SELECT * FROM book_board\n" + 
				"                WHERE delete_status <> 1\n" + 
				"                ORDER BY board_id DESC                \n" + 
				"                ) board \n" + 
				"            JOIN books b ON board.book_code = b.book_code \n" + 
				"            JOIN categorys c ON c.category_id = board.category_id JOIN categorys super ON c.super_id = super.category_id\n" + 
				"            WHERE board.board_id = ?\n" + 
				"            ORDER BY reg_date DESC, title ASC)";
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, board_id);
		
		rs = pstmt.executeQuery();
		
		
		if(rs.next()) {
			do {
				data = new BoardVO();
				
				data.setBoard_id(rs.getInt("board_id"));
				data.setContext(rs.getString("context"));
				data.setReadcnt(rs.getInt("readcnt"));
				data.setBook_code(rs.getInt("book_code"));
				data.setTitle(rs.getString("title"));
				data.setAuthor(rs.getString("author"));
				data.setPrice(rs.getInt("price"));
				data.setStock(rs.getInt("stock"));
				data.setPublisher(rs.getString("publisher"));
				data.setPublish_date(rs.getString("publish_date"));
				data.setReg_date(rs.getTimestamp("reg_date"));
				data.setImage_path(rs.getString("image_path"));
				data.setRating(rs.getInt("rating"));
				data.setDelete_status(rs.getInt("delete_status"));
				data.setCategory_id(rs.getInt("category_id"));
				data.setCategory_name(rs.getString("category_name"));
				data.setSuper_id(rs.getInt("super_id"));
				data.setSuper_name(rs.getString("super_name"));
				
			}while(rs.next());
		}
		
		close();
		return data;
	}
	
	@Override
	public ArrayList<BoardVO> getHotBooks() throws SQLException {
		return getBoardList(1,15, "hot");
	}

	@Override
	public ArrayList<BoardVO> getNewBooks() throws SQLException {
		return getBoardList(1,30);
	}
}
