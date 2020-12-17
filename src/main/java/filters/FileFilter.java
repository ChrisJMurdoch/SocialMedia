package filters;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

/** Tomcat filter class for modifying requests */
public class FileFilter implements Filter {

	/** This function intercepts all incoming requests */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		
		try {
			// Parse request to HTTP
			HttpServletRequest httpRequest = (HttpServletRequest)request;
			
			// Log request information
			System.out.println( "HTTP Request received at: " + httpRequest.getRequestURI() );
			
		} catch (ClassCastException e) {
			
			// Can't cast to HTTP
			System.out.println( "Non-HTTP request received");
		}

		// Chain next filter
		chain.doFilter(request, response);
	}
	
	public void init(FilterConfig fConfig) throws ServletException {}
	public void destroy() {}
}
