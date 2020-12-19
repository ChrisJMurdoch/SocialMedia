package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import security.Password;

/** Servlet to handle user logins */
public class Login extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("GET request at login servlet");
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		// Validate components
		if ( !validateUsername(request.getParameter("username")) ) {
			
			// Invalid username
			System.out.println( "Authentication failure." );
			session.setAttribute("login_failure", "wrong_username");
			
		} else if ( !validatePassword(request.getParameter("username"), request.getParameter("password")) ) {
			
			// Invalid password
			System.out.println( "Authentication failure." );
			session.setAttribute("login_failure", "wrong_password");
		} else {
			
			// Valid
			System.out.println( "Authentication success." );
			session.removeAttribute("login_failure");
			session.setAttribute("username", request.getParameter("username"));
		}

		// Redirect to landing page
		response.sendRedirect("/");
	}

	private boolean validateUsername(String username) {
		return !username.equals("");
	}
	
	private boolean validatePassword(String username, String password) {
		String hash = Password.hash(password);
		return password.equals("admin");
	}
}
