package servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import persistence.Database;
import persistence.Database.User;

public class Verify extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("GET request at verify servlet");
		
		// Redirect to landing page
		response.sendRedirect("/");
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		User user = (User)session.getAttribute("user");
		if (user.verify.equals( request.getParameter("code") )) {
			System.out.println("Email verified.");
			Database.verify(user.username);
			user.verify = "[TRUE]";
		} else {
			System.err.println("CODE_INVALID.");
			session.setAttribute("fail_message", "Code invalid.");
		}
		
		// Redirect to landing page
		response.sendRedirect("/");
	}
}
