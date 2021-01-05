package image;

import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.image.BufferedImage;

public class ImageProcessor {
	
	private final static int THUMBNAIL_SIZE = 480;
	
	/* Clips and scales image */
	public static BufferedImage thumbnail(BufferedImage original) {
		
		System.out.println( "Generating thumbnail..." );
		
		// Get source dimensions
		final int width = original.getWidth(), height = original.getHeight();
		final double ratio = (double)width / (double)height;
		
		// Calculate target dimensions
		final int tWidth = (ratio>1) ? (int)(THUMBNAIL_SIZE*ratio) : THUMBNAIL_SIZE;
		final int tHeight = (ratio<1) ? (int)(THUMBNAIL_SIZE/ratio) : THUMBNAIL_SIZE;
		final int xMargin = (tWidth-THUMBNAIL_SIZE)/2;
		final int yMargin = (tHeight-THUMBNAIL_SIZE)/2;
		
		// Scale and crop using negative margins
		BufferedImage thumbnail = new BufferedImage(THUMBNAIL_SIZE, THUMBNAIL_SIZE, BufferedImage.TYPE_INT_ARGB);
		{
			Graphics2D g2d = thumbnail.createGraphics();
			g2d.drawImage(original.getScaledInstance(tWidth, tHeight, Image.SCALE_AREA_AVERAGING), -xMargin, -yMargin, null);
			g2d.dispose();
		}
		
		System.out.println( "Thumbnail generated." );
		
		return thumbnail;
	}
}
