package com.bookstore.dao.Impl;

import java.sql.SQLException;
import java.util.ArrayList;

import com.bookstore.dao.AbstarctShared;
import com.bookstore.model.Category;

public class SharedDaoImpl extends AbstarctShared{

	@Override
	public ArrayList<Category> getCategorys() throws SQLException {
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
			}while(rs.next());
		}
		close();
		return dtos;
	}

}
