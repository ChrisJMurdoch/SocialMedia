package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/** This is a Java servlet that print basic status information when called */
public class Status extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
    /** Standard GET request */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("[STATUS] Served at: ").append(request.getContextPath());
	}

	/** Post should not be called, chain GET */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
