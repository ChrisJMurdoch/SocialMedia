package tests;

import static org.junit.jupiter.api.Assertions.*;

import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;

import org.junit.jupiter.api.Test;

import autonomous.FacialRecognition;

class AutonomousTest {

	// Filesystem compatibility
	private static final String ECL_PRE = "Eclipse/SocialMedia/", MAV_PRE = "", PRE = MAV_PRE;
	
	static {
		FacialRecognition.init();
	}
	
	@Test
	void testClassifierPositive() {
		try {
			assertTrue( FacialRecognition.detectFaces(ImageIO.read(new File(PRE+"classifier_data/Man.jpg"))) );
			assertTrue( FacialRecognition.detectFaces(ImageIO.read(new File(PRE+"classifier_data/Woman.jpg"))) );
		} catch (IOException e) {
			fail("File not found.");
		}
	}
	
	@Test
	void testClassifierNegative() {
		try {
			assertFalse( FacialRecognition.detectFaces(ImageIO.read(new File(PRE+"classifier_data/Lizard.jpg"))) );
			assertFalse( FacialRecognition.detectFaces(ImageIO.read(new File(PRE+"classifier_data/Beach.jpg"))) );
		} catch (IOException e) {
			fail("File not found.");
		}
	}
}
