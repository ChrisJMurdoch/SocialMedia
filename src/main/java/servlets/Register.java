package servlets;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import persistence.Database;
import security.Password;

/** Servlet to handle user signups */
public class Register extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

	public enum RegisterResult { SUCCESS, EMAIL_USED, EMAIL_INVALID, USERNAME_USED, USERNAME_INVALID, PASSWORD_INVALID, PASSWORD_MISMATCH }
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("GET request at register servlet");
		
		// Redirect to landing page
		response.sendRedirect("/");
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		// Validate registration
		try {
			RegisterResult result = validate( request.getParameter("email"), request.getParameter("username"), request.getParameter("password"), request.getParameter("check") );
			if ( result == RegisterResult.SUCCESS ) {
				System.out.println( "Registration success." );
				session.removeAttribute("register_failure");
				session.setAttribute("username", request.getParameter("username"));
				
				// Register user in database
				register( request.getParameter("email"), request.getParameter("username"), request.getParameter("password") );
			} else {
				System.err.println(result);
				session.setAttribute("register_failure", result);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		// Redirect to landing page
		response.sendRedirect("/");
	}
	
	private RegisterResult validate(String email, String username, String password, String check) throws SQLException {
		
		// Validate email
		String[] atSplit = email.split("@");
		if ( atSplit.length!=2 || atSplit[0].length()==0  || atSplit[1].length()==0 )
			return RegisterResult.EMAIL_INVALID;
		String[] dotSplit = atSplit[1].split("\\.");
		if ( dotSplit.length!=2 || dotSplit[0].length()==0  || dotSplit[1].length()==0 )
			return RegisterResult.EMAIL_INVALID;
		
		// Validate username
		if (username.length()==0)
			return RegisterResult.USERNAME_INVALID;
		
		// Validate password
		if (password.length()<5)
			return RegisterResult.PASSWORD_INVALID;
		
		// Match passwords
		if (!password.equals(check))
			return RegisterResult.PASSWORD_MISMATCH;
		
		// Email exists
		if (Database.exists("users", "email", email))
			return RegisterResult.EMAIL_USED;
		
		// Username exists
		if (Database.exists("users", "username", username))
			return RegisterResult.USERNAME_USED;
		
		return RegisterResult.SUCCESS;
	}
	
	private void register(String email, String username, String password) throws SQLException {
		Database.execute("INSERT INTO users VALUES ( '" + username + "', '" + email + "', '" + Password.hash(password) + "' )");
	}
}
