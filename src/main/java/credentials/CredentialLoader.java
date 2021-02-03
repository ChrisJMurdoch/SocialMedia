package credentials;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;

public class CredentialLoader {
	
	public static String DB_USER, DB_PASS, B2_KEY_ID, B2_APP_KEY;
	
	public static void init() {
		
		File file = new File("credentials.txt");
		
		if(file.exists() && !file.isDirectory())
			loadFromFile(file);
		else
			loadFromEnv();
	}
	
	private static void loadFromEnv() {
		
		System.out.println("Getting credentials from environment...");
		
		DB_USER = System.getenv("db_user");
		DB_PASS = System.getenv("db_pass");
		B2_KEY_ID = System.getenv("b2_key_id");
		B2_APP_KEY = System.getenv("b2_app_key");
		
		// No credentials
		if (DB_USER==null || DB_PASS==null || B2_KEY_ID==null || B2_APP_KEY==null) {
			System.out.println("No credentials found.  Please get credential .bat or .txt file.");
			return;
		}
		
		System.out.println("Credentials set.");
		
	}
	
	private static void loadFromFile(File file) {
		
		System.out.println("Getting credentials from file...");
		
		try {
			Scanner scanner = new Scanner(file);
			DB_USER = scanner.nextLine();
			DB_PASS = scanner.nextLine();
			B2_KEY_ID = scanner.nextLine();
			B2_APP_KEY = scanner.nextLine();
			scanner.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
		
		System.out.println("Credentials set.");
		
	}
}
