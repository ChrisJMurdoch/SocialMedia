package persistence;

import java.io.IOException;

import com.sendgrid.Method;
import com.sendgrid.Request;
import com.sendgrid.SendGrid;
import com.sendgrid.helpers.mail.Mail;
import com.sendgrid.helpers.mail.objects.Content;
import com.sendgrid.helpers.mail.objects.Email;

import credentials.CredentialLoader;

public class Emailer {
	
	private static SendGrid sendgrid;
	
	public static void connect() {
		System.out.println("SendGrid connecting...");
		sendgrid = new SendGrid(CredentialLoader.SENDGRID_API);
		System.out.println("SendGrid connected.");
	}
	
	public static void sendEmail(String recipient, String subject, String text) {
		
		System.out.println("Emailing " + recipient + "...");
		
		// Build email
		Email from = new Email("picturnapp@gmail.com");
		Email to = new Email(recipient);
		Content content = new Content("text/plain", text);
		Mail mail = new Mail(from, subject, to, content);
		
		// Send request to SMTP server
		try {
			Request req = new Request();
			req.setMethod(Method.POST);
			req.setEndpoint("mail/send");
			req.setBody(mail.build());
			sendgrid.api(req);
			
			System.out.println("Sent.");
			
		} catch(IOException e) {
			e.printStackTrace();
		}
	}
	
	public static void disconnect() {
		System.out.println("SendGrid disconnecting...");
		// TODO
		System.out.println("SendGrid disconnected.");
	}
}
