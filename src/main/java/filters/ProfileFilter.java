package filters;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

public class ProfileFilter implements Filter {
	
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		
		System.out.println("Profile filter engaged.");
		
		// Get URL
		String url = ((HttpServletRequest)request).getRequestURI();
		System.out.println( "\nResponse received: " + url );
		
		// Edit URL to GET
		String profile = url.split("users/")[1];
		
		// Ensure URL is not file
		if ( profile.split("\\.").length!=1 ) {
			System.out.println("URL invalid for redirect.");
			chain.doFilter(request, response);
			return;
		}
		
		// Get redirect URL
		String redirect = "/profile.jsp?profile=" + profile;
		
		// Redirect
		System.out.println( "Redirecting to: " + redirect );
		request.getRequestDispatcher( redirect ).forward( request, response );
	}
	
	public void destroy() {}
	public void init(FilterConfig fConfig) throws ServletException {}
}
