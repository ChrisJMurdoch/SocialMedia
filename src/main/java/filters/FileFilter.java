package filters;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/** Tomcat filter class for modifying requests */
public class FileFilter implements Filter {
	
	// Map page names to file extensions
	private static HashMap<String, String> fileExtensions = new HashMap<>();
	static {
		fileExtensions.put("info", ".jsp");
	}
	
	/** This function intercepts all incoming requests */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		
		try {
			
			// Parse request to HTTP and get URL
			HttpServletRequest httpRequest = (HttpServletRequest)request;
			String url = httpRequest.getRequestURI();
			System.out.println( "\nResponse received: " + url );
			
			// Allow root
			if (url.equals("/")) {
				
				System.out.println("URL passed.");
				chain.doFilter(request, response);
				return;
			}
			
			// File extension
			String[] segments = url.split("/");
			String file = segments[segments.length-1];
			
			// No file extension & relevant extension stored
			if ( !file.contains(".") && fileExtensions.containsKey(file) ) {
				
				// Silently redirect to url + extension
				System.out.println( "Redirecting: " + url + fileExtensions.get(file) );
				request.getRequestDispatcher( url + fileExtensions.get(file) ).forward( request, response );
				return;
			} else {
				
				System.out.println("URL passed.");
				chain.doFilter(request, response);
				return;
			}
			
		} catch (ClassCastException e) {
			
			System.out.println("\nNon-HTTP URL passed.");
			chain.doFilter(request, response);
			return;
		}
	}
	
	public void init(FilterConfig fConfig) throws ServletException {}
	public void destroy() {}
}
