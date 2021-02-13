package servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import persistence.Database;
import persistence.Database.User;
import security.Password;
import persistence.Emailer;

public class SetPass extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("GET request at setpass servlet");
		
		// Redirect to landing page
		response.sendRedirect("/");
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		User user = Database.getUser(request.getParameter("user"));
		if (user==null || !user.reset.equals(request.getParameter("code"))) {
			System.out.println("Password set failed.");
			response.sendRedirect("/");
			return;
		}
		
		System.out.println("Password set.");
		Database.setHash(request.getParameter("user"), Password.hash(request.getParameter("password")));
		
		// Redirect to landing page
		response.sendRedirect("/");
	}
}
