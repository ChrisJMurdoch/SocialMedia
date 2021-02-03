package tests;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;

import security.Password;

class SecurityTest {
	
	@Test
	void testHash() {
		String password = "qwerty";
		String hash = Password.hash(password);
		assertFalse( password.equals(hash) );
	}
	
	@Test
	void testValidate() {
		String password = "qwerty";
		String hash = Password.hash(password);
		String wrong_password = "wrong";
		assertTrue( Password.validate(hash, password) );
		assertFalse( Password.validate(hash, wrong_password) );
	}
}
