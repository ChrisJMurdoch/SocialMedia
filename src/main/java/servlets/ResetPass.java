package servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import persistence.Database;
import persistence.Database.User;
import persistence.Emailer;

public class ResetPass extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("GET request at resetpass servlet");
		
		// Redirect to landing page
		response.sendRedirect("/");
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		User user = Database.getUserByEmail(request.getParameter("email"));
		
		if (user==null) {
			System.out.println("Password reset failed.");
			response.sendRedirect("/");
			return;
		} else {
			System.out.println("Password reset passed.");
			Emailer.sendEmail(user.email, "Reset your password", "Hello, "+user.username+".  Your reset link is: "+
				"http://picturn.herokuapp.com/setpassword?code="+user.reset+"&user="+user.username
			);
		}
		
		// Redirect to landing page
		response.sendRedirect("/");
	}
}
