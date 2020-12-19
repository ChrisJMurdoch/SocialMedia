package listeners;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import persistence.Database;

/** Simple listener class to act upon server startup */
public class Startup implements ServletContextListener {
	
    public Startup() {
        System.out.println("Server starting up...");
        Database.connect();
        System.out.println("Server started.");
    }
    
    public void contextDestroyed(ServletContextEvent arg0)  {}
    
    public void contextInitialized(ServletContextEvent arg0)  {}
}
