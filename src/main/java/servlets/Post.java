package servlets;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.backblaze.b2.client.exceptions.B2Exception;

import asynchronous.ImageUploader;
import image.ImageProcessor;
import persistence.Backblaze;
import persistence.Database;
import persistence.Database.User;

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
		
		// Ensure logged in
		String username = ((User)session.getAttribute("user")).username;
		if (username==null) {
			response.sendRedirect("/");
			return;
		}
		
		// Get parameters
		String title = request.getParameter("title");
		String description = request.getParameter("description");
		
		// Validate post data
		if (title==null || description==null) {
			response.sendRedirect("/");
			return;
		}
		
		// Extract filetype and contents
		String filetype;
		BufferedImage original; // Use buffered image to allow for fast image operations
		{
			InputStream is = null;
			try {
				Part file = request.getPart("file");
				filetype = request.getPart("file").getSubmittedFileName().split("\\.", -1)[1];
				is = file.getInputStream();
				original = ImageIO.read(is);
				
			} catch (IndexOutOfBoundsException | NullPointerException | IOException e) {
				response.sendRedirect("/");
				return;
				
			} finally {
				if (is!=null)
					is.close();
			}
		}
		
		// Upload image to database and backblaze asynchronously
		ImageUploader up = new ImageUploader(username, title, description, filetype, original);
		new Thread(up).start();
		
		response.sendRedirect("/");
	}
}
