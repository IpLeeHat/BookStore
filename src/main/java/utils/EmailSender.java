package utils;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.util.Properties;

public class EmailSender {

    private static final String FROM_EMAIL = "lephuochat@gmail.com"; // Thay bằng email của bạn
    private static final String PASSWORD = "hmwc apqt hnrp wffg"; // Thay bằng mật khẩu ứng dụng

    public static boolean sendOTP(String toEmail, String subject, String message) {
        try {
            // Cấu hình properties cho email
            Properties props = new Properties();
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "587");

            // Tạo session
            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(FROM_EMAIL, PASSWORD);
                }
            });

            // Tạo email
            Message msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(FROM_EMAIL));
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            msg.setSubject(subject);
            msg.setText(message);

            // Gửi email
            Transport.send(msg);
            return true; // Gửi thành công
        } catch (Exception e) {
            e.printStackTrace();
            return false; // Gửi thất bại
        }
    }
}
