package autonomous;

import java.awt.image.BufferedImage;
import java.awt.image.DataBufferByte;

import org.opencv.core.CvType;
import org.opencv.core.Mat;
import org.opencv.core.MatOfRect;
import org.opencv.core.Size;
import org.opencv.objdetect.CascadeClassifier;
import org.opencv.objdetect.Objdetect;

import nu.pattern.OpenCV;

/**
 *  OpenCV detection class with pre-trained frontal-face classifier.
 */
public class FacialRecognition {
	
	// Filesystem compatibility
	private static final String ECL_PRE = "Eclipse/SocialMedia/", MAV_PRE = "", PRE = MAV_PRE;
	
	// Classifier options
	static final float SCALE_DOWN = 1.1f;
	static final int MIN_NEIGHBOURS = 3;
	
	// Trained image-classifier
	private static CascadeClassifier classifier;
	
	public static void init() {
		
		System.out.println("Image recognition engine initialising...");
		
		// Load OpenCV
		OpenCV.loadLocally();
		
		// Load front-face classifier
		classifier = new CascadeClassifier();
		classifier.load(PRE+"classifier_data/haarcascade_frontalface_alt.xml");
		
		System.out.println("Image recognition engine initialised.");
	}
	
	public static boolean detectFaces(BufferedImage img) {
		
		// Create matrix from buffered image
		Mat matrix = new Mat(img.getHeight(), img.getWidth(), CvType.CV_8UC3);
		matrix.put(0, 0, ((DataBufferByte)img.getRaster().getDataBuffer()).getData());
		
		// Detect
		final int MIN = (int)(matrix.rows() / 10.0f);
		MatOfRect output = new MatOfRect();
		classifier.detectMultiScale( matrix, output, SCALE_DOWN, MIN_NEIGHBOURS, Objdetect.CASCADE_SCALE_IMAGE, new Size(MIN, MIN) );
		
		return output.total()>0;
	}
}
