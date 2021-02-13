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

public class ChangePass extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("GET request at changepass servlet");
		
		// Redirect to landing page
		response.sendRedirect("/");
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		User user = (User)session.getAttribute("user");
		
		if ( request.getParameter("current")==null || request.getParameter("current").equals("") || request.getParameter("new")==null || request.getParameter("new").equals("") ) {
			session.setAttribute("fail_message", "Invalid fields.");
			response.sendRedirect("/changepassword");
			return;
		}
		
		if ( Password.validate(user.hash, request.getParameter("current")) ) {
			System.out.println("Password change accepted.");
			Database.setHash(user.username, Password.hash(request.getParameter("new")));
		} else {
			System.out.println("Password change rejected.");
			session.setAttribute("fail_message", "Wrong password.");
			response.sendRedirect("/changepassword");
			return;
		}
		
		// Redirect to landing page
		response.sendRedirect("/");
	}
}
