package security;

import java.util.Random;

public class Generation {

	public final static String ALPHANUMERIC =
		"abcdefghijklmnopqrstuvwxyz" + 
		"ABCDEFGHIJKLMNOPQRSTUVWXYZ" + 
		"0123456789"
	;
	
	private final static Random RANDOM = new Random(System.currentTimeMillis());
	
	public static String randomString(int length, String charSet) {
		String s = "";
		for (int i=0; i<length; i++)
			s += charSet.charAt(RANDOM.nextInt(charSet.length()));
		return s;
	}
	
}
