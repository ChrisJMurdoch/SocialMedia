package persistence;

import java.io.IOException;

import com.backblaze.b2.client.B2StorageClient;
import com.backblaze.b2.client.B2StorageClientFactory;
import com.backblaze.b2.client.contentSources.B2ByteArrayContentSource;
import com.backblaze.b2.client.contentSources.B2ContentSource;
import com.backblaze.b2.client.contentSources.B2ContentTypes;
import com.backblaze.b2.client.exceptions.B2Exception;
import com.backblaze.b2.client.structures.B2UploadFileRequest;

import credentials.CredentialLoader;

public class Backblaze {
	
	private static final String BUCKET_ID = "8acc86bf7b35a0ea7b6f0c13";
	
	private static B2StorageClient client;
	
	public static void connect() {
		
		System.out.println("Backblaze connecting...");
		
		// Get secret information from environment
		String keyid = CredentialLoader.B2_KEY_ID;
		String appkey = CredentialLoader.B2_APP_KEY;
		
		// No credentials
		if (keyid==null || appkey==null) {
			System.out.println("No credentials set.");
			System.out.println("Backblaze failed to connect.");
			return;
		}
		
		client = B2StorageClientFactory.createDefaultFactory().create(keyid, appkey, "picturn");
		
		System.out.println("Backblaze connected.");
	}
	
	public static void disconnect() {
		System.out.println("Backblaze disconnecting...");
		client.close();
		System.out.println("Backblaze disconnected.");
	}
	
	public static void upload(String filename, byte[] data) throws B2Exception, IOException {
		B2ContentSource source = B2ByteArrayContentSource.build(data);
		B2UploadFileRequest request = B2UploadFileRequest
				.builder(BUCKET_ID, filename, B2ContentTypes.B2_AUTO, source)
				.build();
		client.uploadSmallFile(request);
	}
}
