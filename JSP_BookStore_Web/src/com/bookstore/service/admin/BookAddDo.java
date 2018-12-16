package com.bookstore.service.admin;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bookstore.dao.Impl.AdminDaoImpl;
import com.bookstore.model.BoardVO;
import com.bookstore.service.Service;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class BookAddDo implements Service {

	@Override
	public void run(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MultipartRequest mr = null;

		int maxSize = 10 * 1024 * 1024; // 업로드할 이미지파일의 최대사이즈 10MB

		String saveDir = request.getSession().getServletContext().getRealPath("/images/books/");
		String realDir = "/home/jeongnam/git/Jsp_BookStore_version1/JSP_BookStore_Web/WebContent/images/books/";
		String encType = "UTF-8";

		int pageNum = 1;

		try {
			mr = new MultipartRequest(request, saveDir, maxSize, encType, new DefaultFileRenamePolicy());

			FileInputStream fis = new FileInputStream(saveDir + mr.getFilesystemName("image_file"));
			FileOutputStream fos = new FileOutputStream(realDir + mr.getFilesystemName("image_file"));

			int data = 0;

			while ((data = fis.read()) != -1) {
				fos.write(data);
			}
			fis.close();
			fos.close();

			pageNum = Integer.parseInt(mr.getParameter("pageNum"));
			BoardVO dto = new BoardVO();
			// book
			dto.setTitle(mr.getParameter("title"));
			dto.setAuthor(mr.getParameter("author"));
			dto.setPrice(Integer.parseInt(mr.getParameter("price")));
			dto.setStock(Integer.parseInt(mr.getParameter("stock")));
			dto.setReg_date(new Timestamp(System.currentTimeMillis()));
			dto.setPublisher(mr.getParameter("publisher"));
			dto.setPublish_date(mr.getParameter("publish_date"));
			dto.setImage_path(request.getContextPath() + "/images/books/" + mr.getFilesystemName("image_file"));

			// borad
			dto.setContext(mr.getParameter("context"));
			dto.setReadcnt(0);
			dto.setCategory_id(Integer.parseInt(mr.getParameter("category")));

			// insert 실패시 업로드한 이미지 삭제
			if (new AdminDaoImpl().bookAddDo(dto) == 0) {
				File savefile = new File(saveDir + mr.getFilesystemName("image_file"));
				File realfile = new File(realDir + mr.getFilesystemName("image_file"));

				while(!savefile.exists()) {
					if (savefile.delete()) {
						System.out.println("임시 파일삭제 성공");
					} else {
						System.out.println("파일삭제 실패");
					}
				}
				
				
				while(!realfile.exists()) {
					if (realfile.delete()) {
						System.out.println("실제경로 파일삭제 성공");
					} else {
						System.out.println("파일삭제 실패");
					}
				}
				request.getSession().setAttribute("message", "글작성 실패!!");
			}else {
				request.getSession().setAttribute("message", "글작성 성공!!");
			}
		} catch (Exception e) {
			e.printStackTrace();
			request.getSession().setAttribute("message", e.getMessage().trim().replace("\"", "\'"));
		}

		response.sendRedirect("bookManagePage?pageNum=" + pageNum);
	}
}
