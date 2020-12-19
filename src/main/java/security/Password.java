package security;

import de.mkammerer.argon2.Argon2;
import de.mkammerer.argon2.Argon2Factory;
import de.mkammerer.argon2.Argon2Factory.Argon2Types;

/** Simple interface into the Argon2 library using Argon2id with custom presets */
public class Password {
	
	// Argon2 presets
	private static final int ITERATIONS = 3;
	private static final int MEMORY = 1024*1024; // 1GB
	private static final int PARALLELS = 2; // TODO - find out how many cores the heroku server will be running
	
	// Use hybrid Argon2 implementation to resist a broader range of attacks
	private static Argon2 argon2 = Argon2Factory.create(Argon2Types.ARGON2id);
	
	/** Take in a String password and return a String hash with salt embedded */
	public static String hash(String password) {
		
		System.out.println( "Hashing..." );
		long start = System.currentTimeMillis();
		
		// This will automatically generate and include salt in hash value
		String hash = argon2.hash(ITERATIONS, MEMORY, PARALLELS, password);
		
		System.out.println( "Done. Process took: " + (System.currentTimeMillis()-start) + " milliseconds." );
		return hash;
	}
	
	/** Verify a password against a hash made with the hash() function */
	public static boolean validate(String hash, String password) {
		return argon2.verify(hash, password);
	}
}
