package com.controller;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.model.LoginBean;

public class Mycontroller extends HttpServlet{    //Controller  ���� 

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Client���� Get ������� ��û�� ��� ó���ϴ� ��� 
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Client���� Post ������� ��û�� ��� ó���ϴ� ��� 
		
		response.setContentType("text.html; charset = utf-8"); 
			//client �� �� �������� ������ contentType�� ���� 
		String id = request.getParameter("id"); 
		String password = request.getParameter("passwd"); 
		
		LoginBean bean = new LoginBean(); 
		bean.setId(id);
		bean.setPassword(password);
		
		request.setAttribute("bean", bean); 
		
		boolean status = bean.validate();     //password : "admin" �̸�, status �� true
		
		if (status) {
			RequestDispatcher rd = request.getRequestDispatcher("mvc_success.jsp"); 
			rd.forward(request, response); 
		}else { 
			RequestDispatcher rd = request.getRequestDispatcher("mvc_error.jsp"); 
			rd.forward(request, response); 
		}
		
		
		
		
		
		
		
		
		
		
		
	}  
	
	

}
