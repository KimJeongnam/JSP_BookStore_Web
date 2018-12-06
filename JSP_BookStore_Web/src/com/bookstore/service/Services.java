package com.bookstore.service;

import java.util.HashMap;
import java.util.Map;

import com.bookstore.service.main.CheckIdDo;
import com.bookstore.service.main.EmailCheck;
import com.bookstore.service.main.LoginDo;
import com.bookstore.service.main.LogoutDo;
import com.bookstore.service.main.MainDo;
import com.bookstore.service.main.SignUpDo;

public class Services {
	private static Services instance = new Services();
	public static Services getInstance() {return instance;}
	
	private Map<Integer, Service> services = new HashMap<Integer, Service>();
	public Map<Integer, Service> getServices(){return services;}
	
	private Services() {
		services.put(Code.MAIN_DO, new MainDo()); 
		services.put(Code.LOGIN, new LoginDo()); 
		services.put(Code.LOGOUT, new LogoutDo());
		services.put(Code.CHECK_ID, new CheckIdDo());
		services.put(Code.SIGNUP, new SignUpDo());
		services.put(Code.EMAILCHECK, new EmailCheck());
	}
}