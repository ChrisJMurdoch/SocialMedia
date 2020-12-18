package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/** Servlet to handle user logins */
public class Login extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("GET request at login servlet");
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		System.out.println( "Login attempt, username: " + request.getParameter("username") + " password: " + request.getParameter("password") );
		
		// Validate password
		if ( request.getParameter("password").equals("admin") ) {
			
			System.out.println( "Authentication success." );
			session.setAttribute("username", request.getParameter("username"));
			session.removeAttribute("login_failure");
		} else {
			
			System.out.println( "Authentication failure." );
			session.setAttribute("login_failure", "wrong password.");
		}

		// Redirect to landing page
		response.sendRedirect("/");
	}
}
