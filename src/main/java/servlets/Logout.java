package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import persistence.Database.User;

/** Servlet to handle user logins */
public class Logout extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		// Validate session user
		User user = (User)session.getAttribute("user");
		if (user==null) {
			System.out.println( "Already logged out." );
			response.sendRedirect("/");
			return;
		}
		
		// Delete session
		System.out.println( "Logging out: " + user.username );
		session.invalidate();
		
		// Redirect to landing page
		response.sendRedirect("/");
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
