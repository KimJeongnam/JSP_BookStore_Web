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

public class BookModifyDo implements Service {

	@Override
	public void run(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MultipartRequest mr = null;

		int maxSize = 10 * 1024 * 1024; // 업로드할 이미지파일의 최대사이즈 10MB

		String saveDir = request.getSession().getServletContext().getRealPath("/images/books/");
		String realDir = "/home/jeongnam/git/Jsp_BookStore_version1/JSP_BookStore_Web/WebContent/images/books/";
		String encType = "UTF-8";
		
		String old_image_path = null;
		int pageNum = 1;

		try {
			mr = new MultipartRequest(request, saveDir, maxSize, encType, new DefaultFileRenamePolicy());
			
			// 변경한 이미지가 있을 경우
			if(mr.getFilesystemName("image_file")!=null) {
				old_image_path = mr.getParameter("old_image_path");
				System.out.println("Old Image : "+old_image_path);
				FileInputStream fis = new FileInputStream(saveDir + mr.getFilesystemName("image_file"));
				FileOutputStream fos = new FileOutputStream(realDir + mr.getFilesystemName("image_file"));
				
				int data = 0;
	
				while ((data = fis.read()) != -1) {
					fos.write(data);
				}
				fis.close();
				fos.close();
			}
			pageNum = Integer.parseInt(mr.getParameter("pageNum"));
			BoardVO dto = new BoardVO();
			// book
			dto.setBoard_id(Integer.parseInt(mr.getParameter("board_id")));
			dto.setBook_code(Integer.parseInt(mr.getParameter("book_code")));
			dto.setTitle(mr.getParameter("title"));
			dto.setAuthor(mr.getParameter("author"));
			dto.setPrice(Integer.parseInt(mr.getParameter("price")));
			dto.setStock(Integer.parseInt(mr.getParameter("stock")));
			dto.setReg_date(new Timestamp(System.currentTimeMillis()));
			dto.setPublisher(mr.getParameter("publisher"));
			dto.setPublish_date(mr.getParameter("publish_date"));
			if(mr.getFilesystemName("image_file")!= null)
				dto.setImage_path(request.getContextPath() + "/images/books/" + mr.getFilesystemName("image_file"));
			
			// borad
			dto.setContext(mr.getParameter("context"));
			dto.setReadcnt(0);
			dto.setCategory_id(Integer.parseInt(mr.getParameter("category")));

			int result = new AdminDaoImpl().bookModifyDo(dto);
			
			// insert 실패시 업로드한 이미지 삭제
			if (result == 0 && mr.getFilesystemName("image_file")!=null) {
				File savefile = new File(saveDir + mr.getFilesystemName("image_file"));
				File realfile = new File(realDir + mr.getFilesystemName("image_file"));

				if(savefile.exists()) {
					while (!savefile.delete()) {
						System.out.println("임시 파일삭제 성공");
					} 
				}
				
				
				if(realfile.exists()) {
					while (!realfile.delete()) {
						System.out.println("실제경로 파일삭제 성공");
					} 
				}
				
			}
			// update후 이전 이미지 삭제
			if(old_image_path!=null) {
				String filepath = old_image_path.substring((request.getContextPath() + "/images/books/").length()); 
				System.out.println("fullpath : "+filepath);
				File savefile= new File(saveDir+filepath);
				File realfile = new File(realDir+filepath);
				
				if(savefile.exists()) {
					while (!savefile.delete()) {
						System.out.println("이전 이미지 임시 파일삭제 성공");
					}
				}
				
				if(realfile.exists()) {
					while(!realfile.delete())
						System.out.println("이전 이미지 : "+old_image_path+" 삭제 완료");
				}
			}
			
			if(result != 0)
				request.getSession().setAttribute("message", "글 수정 성공!!");
			else
				request.getSession().setAttribute("message", "글 수정 실패!!");
			
		} catch (Exception e) {
			e.printStackTrace();
			request.getSession().setAttribute("message", e.getMessage().trim().replace("\"", "\'"));
		}

		response.sendRedirect("bookManagePage?pageNum=" + pageNum);
	}
}
