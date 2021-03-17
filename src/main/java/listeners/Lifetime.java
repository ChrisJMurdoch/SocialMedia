package listeners;

import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Enumeration;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import com.backblaze.b2.client.exceptions.B2Exception;

import autonomous.FacialRecognition;
import credentials.CredentialLoader;
import persistence.Backblaze;
import persistence.Database;
import persistence.Database.Post;
import persistence.Database.User;
import persistence.Emailer;

/** Simple listener class to act upon server startup */
public class Lifetime implements ServletContextListener {
	
    public Lifetime() {
    	
        System.out.println("\n=== Server starting ===");
        CredentialLoader.init();
        Database.connect();
		Backblaze.connect();
		Emailer.connect();
        FacialRecognition.init();
        System.out.println("=== Server started ===\n");
        
    }
    
    public void contextDestroyed(ServletContextEvent arg0)  {
    	
    	System.out.println("\n\n=== Server closing ===");
    	
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
		Emailer.disconnect();
		
        System.out.println("=== Server closed ===\n");
    }
    
    public void contextInitialized(ServletContextEvent arg0)  {}
}
