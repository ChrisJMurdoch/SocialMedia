package security;

import java.security.SecureRandom;

public class Generation {
	
	public final static String ALPHANUMERIC =
		"abcdefghijklmnopqrstuvwxyz" + 
		"ABCDEFGHIJKLMNOPQRSTUVWXYZ" + 
		"0123456789"
	;
	
	private final static SecureRandom RANDOM = new SecureRandom();
	
	public static String randomString(int length, String charSet) {
		String s = "";
		for (int i=0; i<length; i++)
			s += charSet.charAt(RANDOM.nextInt(charSet.length()));
		return s;
	}
	
}
