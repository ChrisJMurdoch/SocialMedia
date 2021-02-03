package image;

import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.image.BufferedImage;

public class ImageProcessor {
	
	public final static int THUMBNAIL_WIDTH = 1440;
	
	/* Clips and scales image */
	public static BufferedImage thumbnail(BufferedImage original) {
		
		// Get source dimensions
		final int width = original.getWidth(), height = original.getHeight();
		
		System.out.println( "Width: " + width + ", Height: " + height );
		
		// Already small enough
		if ( original.getWidth() <= THUMBNAIL_WIDTH ) {
			System.out.println("Skipping thumbnail generation." );
			return original;
		}
		
		System.out.println( "Generating thumbnail..." );
		
		// Calculate target dimensions
		final double scale = (double)THUMBNAIL_WIDTH / (double)width;
		final int tHeight = (int)(scale*height);

		// Scale and crop using negative margins
		BufferedImage thumbnail = new BufferedImage(THUMBNAIL_WIDTH, tHeight, BufferedImage.TYPE_INT_RGB);
		{
			Graphics2D g2d = thumbnail.createGraphics();
			g2d.drawImage(original.getScaledInstance(THUMBNAIL_WIDTH, tHeight, Image.SCALE_AREA_AVERAGING), 0, 0, null);
			g2d.dispose();
		}
		
		System.out.println( "OutputWidth: " + thumbnail.getWidth() + ", OutputHeight: " + thumbnail.getHeight() );
		
		System.out.println( "Thumbnail generated." );
		
		return thumbnail;
	}
}
