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

import image.ImageProcessor;
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
		
		// Ensure logged in
		String username = (String)session.getAttribute("username");
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
		
		// Create thumbnail
		BufferedImage thumbnail = ImageProcessor.thumbnail(original);
		
		// Upload to database and backblaze
		{
			ByteArrayOutputStream originalOS = new ByteArrayOutputStream(), thumbnailOS = new ByteArrayOutputStream();
			try {
				// Create database entry and get reference id for Backblaze
				int id = Database.createPost(username, title, description, filetype);
				
				// Extract image binary data
				ImageIO.write(original, filetype, originalOS);
				ImageIO.write(thumbnail, "png", thumbnailOS);
				
				// Upload original and thumbnail to Backblaze with reference id
				Backblaze.upload(id+"og."+filetype, originalOS.toByteArray());
				Backblaze.upload(id+"tn.png", thumbnailOS.toByteArray());
				
			} catch (B2Exception | IOException e) {
				e.printStackTrace();
				
			} finally {
				if(originalOS!=null)
					originalOS.close();
				if(thumbnailOS!=null)
					thumbnailOS.close();
			}
		}
		
		response.sendRedirect("/");
	}
}
