package asynchronous;

import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;

import javax.imageio.ImageIO;

import com.backblaze.b2.client.exceptions.B2Exception;

import image.ImageProcessor;
import persistence.Backblaze;
import persistence.Database;

public class ImageUploader implements Runnable {
	
	String username, title, description, filetype;
	BufferedImage original;
	
	public ImageUploader(String username, String title, String description, String filetype, BufferedImage original) {
		this.username = username;
		this.title = title;
		this.description = description;
		this.filetype = filetype;
		this.original = original;
	}
	
	@Override
	public void run() {
		
		System.out.println("Image uploading thread started...");
		
		// Create thumbnail
		BufferedImage thumbnail = ImageProcessor.thumbnail(original);
		
		// Upload to database and backblaze
		{
			ByteArrayOutputStream originalOS = new ByteArrayOutputStream(), thumbnailOS = new ByteArrayOutputStream();
			try {
				
				// Create database entry and get reference id for Backblaze
				System.out.println("Updating database...");
				int id = Database.createPost(username, title, description, filetype);
				System.out.println("Database updated.");
				
				// Extract image binary data
				ImageIO.write(original, filetype, originalOS);
				ImageIO.write(thumbnail, "jpg", thumbnailOS);
				
				// Upload original and thumbnail to Backblaze with reference id
				System.out.println("Uploading original...");
				Backblaze.upload(id+"og."+filetype, originalOS.toByteArray());
				System.out.println("Original uploaded.");
				
				System.out.println("Uploading thumbnail...");
				Backblaze.upload(id+"tn.jpg", thumbnailOS.toByteArray());
				System.out.println("Thumbnail uploaded.");
				
			} catch (B2Exception | IOException e) {
				e.printStackTrace();
				
			} finally {
				try {
					if(originalOS!=null)
							originalOS.close();
					if(thumbnailOS!=null)
						thumbnailOS.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}

		System.out.println("Image uploading thread finished.");
		
	}
}
