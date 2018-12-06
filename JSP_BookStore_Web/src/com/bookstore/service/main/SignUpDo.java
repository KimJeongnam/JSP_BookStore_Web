package com.bookstore.service.main;

import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Properties;
import java.util.UUID;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bookstore.dao.AbstractMain;
import com.bookstore.dao.main.MainDaoImpl;
import com.bookstore.model.User;
import com.bookstore.service.Service;

public class SignUpDo implements Service{
	@Override
	public void run(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AbstractMain dao = new MainDaoImpl();
		
		request.setCharacterEncoding("UTF-8");
		
		User newUser = new User();
		newUser.setUser_id(request.getParameter("id"));
		newUser.setUser_pw(request.getParameter("pw"));
		newUser.setName(request.getParameter("name"));
		newUser.setZipcode(request.getParameter("zipcode"));
		newUser.setAddress1(request.getParameter("address1"));
		newUser.setAddress2(request.getParameter("address2"));
		
		String ssn = request.getParameter("ssn1")+request.getParameter("ssn2");
		newUser.setSsn(ssn);
		
		String hp = "";
		String hp1 = request.getParameter("hp1").trim();
		String hp2 = request.getParameter("hp2").trim();
		String hp3 = request.getParameter("hp3").trim();
		
		if(!hp1.equals("") && !hp2.equals("") && !hp3.equals(""))
			hp = hp1+"-"+hp2+"-"+hp3;
		newUser.setPhone_number(hp);
		
		String email = request.getParameter("email1")+"@"+request.getParameter("email2");
		newUser.setEmail(email);
		
		UUID uuid = UUID.randomUUID();
		String key = uuid.toString();
		newUser.setAccept_code(key);
		
		newUser.setHire_date(new Timestamp(System.currentTimeMillis()));
		
		int result = 0;
		try {
		result = dao.signUpDo(newUser);
		}catch(SQLException e) {
			e.printStackTrace();
			request.setAttribute("message", e.getMessage().trim().replace("\"", "\'"));
		}
		
		if(result == 1) {
			sendEmail(newUser.getEmail(), key);
			request.setAttribute("email", newUser.getEmail());
		}
	}
	
	public void sendEmail(String toEmail, String key) {
		final String username = "kim910712@gmail.com";
		final String password = "qwjdskap!2";

		Properties props = new Properties();
		props.put("mail.smtp.user", username);
		props.put("mail.smtp.password", password);
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "25");
		props.put("mail.debug", "true");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.EnableSSL.enable", "true");
		props.setProperty("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		props.setProperty("mail.smtp.socketFactory.fallback", "false");
		props.setProperty("mail.smtp.port", "465");
		props.setProperty("mail.smtp.socketFactory.port", "465");

		Session session = Session.getInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(username, password);
			}
		});
		try {
			Message message = new MimeMessage(session);

			message.setFrom(new InternetAddress("admin@JBook.com"));

			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));

			String content = "J Book 회원가입 인증 메일 입니다. 링크를 눌러 회원가입을 완료하세요. <br>"
					+ "<a href='http://localhost:8090/BookStore/emailChk?key=" + key + "'> "+key+" </a>"; 
			message.setSubject("J Book 회원가입 인증 메일"); // 메일 제목
			message.setContent(content, "text/html; charset=utf-8"); // 글내용 타입, charset 설정

			System.out.println("send!!!");
			Transport.send(message);
			System.out.println("SEND");

		} catch (Exception e) {
			e.printStackTrace();
		}

	}
}
