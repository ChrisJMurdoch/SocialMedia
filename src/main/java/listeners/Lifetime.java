package listeners;

import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Enumeration;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import com.backblaze.b2.client.exceptions.B2Exception;

import persistence.Backblaze;
import persistence.Database;
import persistence.Database.Post;
import persistence.Database.User;

/** Simple listener class to act upon server startup */
public class Lifetime implements ServletContextListener {
	
    public Lifetime() {
    	
        System.out.println("\n=== Server starting ===");
        Database.connect();
		Backblaze.connect();
        System.out.println("=== Server started ===\n");
        
        //debug();
    }
    
    public void contextDestroyed(ServletContextEvent arg0)  {
    	
    	System.out.println("\n=== Server closing ===");
    	
    	// Close JDBC drivers
    	System.out.println("Deregistering drivers...");
    	Enumeration<Driver> drivers = DriverManager.getDrivers();
    	while (drivers.hasMoreElements()) {
    		try {
				DriverManager.deregisterDriver( (Driver)drivers.nextElement() );
			} catch (SQLException e) {
				e.printStackTrace();
			}
    	}
    	System.out.println("Drivers deregistered.");

        Database.disconnect();
		Backblaze.disconnect();
		
        System.out.println("=== Server closed ===\n");
    }
    
    public void contextInitialized(ServletContextEvent arg0)  {}
    
    private void debug() {
    	System.out.println("=== Debug ===");
    	System.out.println("Database:");
    	for (User user : Database.getUsers()) {
    		System.out.println(" - " + user.username + ": " + user.email);
    		for (Post post : Database.getUserPosts(user.username))
    			System.out.println("    - " + post.title);
    	}
    	System.out.println("=== Done ===\n");
    }
}
