package servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import persistence.Database;
import persistence.Database.User;

public class Comment extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("GET request at comment servlet");
		
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
		String message = request.getParameter("message");
		String post = request.getParameter("post");
		
		// Validate post data
		if (message==null || post==null) {
			System.out.println("Params: "+message+post);
			response.sendRedirect("/");
			return;
		}
		
		Database.comment(username, message, post);
		
		response.sendRedirect("/");
	}
}
