package servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import persistence.Database;
import persistence.Database.User;

public class Like extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("GET request at like servlet");
		
		// Redirect to landing page
		response.sendRedirect("/");
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		// Ensure logged in
		String username = ((User)session.getAttribute("user")).username;
		if (username==null) {
			response.sendRedirect("/");
			return;
		}
		
		// Get parameters
		String post_id = request.getParameter("post_id");
		
		// Validate post data
		if (post_id==null) {
			response.sendRedirect("/");
			return;
		}
		
		// Update database
		Database.like(username, post_id);
		
		// Redirect to landing page
		response.sendRedirect("/");
	}
}
