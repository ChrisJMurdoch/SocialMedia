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

/** Servlet to handle and validate user login requests */
public class Login extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	public enum LoginResult { SUCCESS, WRONG_USERNAME, WRONG_PASSWORD }
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("GET request at login servlet");
		
		// Redirect to landing page
		response.sendRedirect("/");
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		// Validate login
		try {
			LoginResult result = validate( request.getParameter("username"), request.getParameter("password") );
			if ( result == LoginResult.SUCCESS ) {
				System.out.println( "Authentication success." );
				session.removeAttribute("login_failure");
				session.setAttribute("username", request.getParameter("username"));
			} else {
				System.out.println(result);
				session.setAttribute("login_failure", result);
				System.err.println(result);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		// Redirect to landing page
		response.sendRedirect("/");
	}
	
	private LoginResult validate(String username, String password) throws SQLException {
		
		// Get hash
		System.out.println("Retrieving hash...");
		String hash = Database.getHash(username);
		
		// No hash found for username
		if (hash==null)
			return LoginResult.WRONG_USERNAME;
		
		System.out.println("1: "+password+", 2: "+hash);
		
		return Password.validate(hash, password) ? LoginResult.SUCCESS : LoginResult.WRONG_PASSWORD;
	}
}
