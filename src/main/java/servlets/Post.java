package servlets;

import java.io.IOException;
import java.io.InputStream;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.backblaze.b2.client.exceptions.B2Exception;

import persistence.Backblaze;
import persistence.Database;

@WebServlet("/upload")
@MultipartConfig
public class Post extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("GET request at post servlet");
		
		// Redirect to landing page
		response.sendRedirect("/");
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		// Data
		String username = (String)session.getAttribute("username");
		String title = request.getParameter("title");
		String description = request.getParameter("description");
		
		// File
		InputStream is = request.getPart("file").getInputStream();
		
		// Upload to database and backblaze
		try {
			int id = Database.createPost(username, title, description);
			Backblaze.upload(id+"tn.jpg", is.readAllBytes());
		} catch (B2Exception | IOException e) {
			e.printStackTrace();
		}
		
		response.sendRedirect("/");
	}
}
