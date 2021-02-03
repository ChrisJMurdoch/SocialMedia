package tests;

import static org.junit.jupiter.api.Assertions.*;

import java.awt.image.BufferedImage;

import org.junit.jupiter.api.Test;

import image.ImageProcessor;

class ImageTest {

	@Test
	void testThumbnail() {
		BufferedImage original = new BufferedImage(2000, 1500, BufferedImage.TYPE_INT_RGB);
		BufferedImage thumbnail = ImageProcessor.thumbnail(original);
		assertEquals(thumbnail.getWidth(), ImageProcessor.THUMBNAIL_WIDTH);
	}

	@Test
	void testThumbnailWithAlpha() {
		BufferedImage original = new BufferedImage(2000, 1500, BufferedImage.TYPE_INT_ARGB);
		BufferedImage thumbnail = ImageProcessor.thumbnail(original);
		assertEquals(thumbnail.getWidth(), ImageProcessor.THUMBNAIL_WIDTH);
	}
	
}
