package reset;

import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

public class MailUtils {
    public static void sendEmail(String to, String subject, String messageText) throws Exception {
        final String fromEmail = "nguyendhlam11@gmail.com";
        final String password = "ruugucqdfgmhhlsi"; // App Password Gmail của bạn

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });

        Message msg = new MimeMessage(session);
        msg.setFrom(new InternetAddress(fromEmail, "FishingHub App"));
        msg.setRecipient(Message.RecipientType.TO, new InternetAddress(to));
        msg.setSubject(subject);
        msg.setText(messageText);

        Transport.send(msg);
    }
}

  