package vn.edu.hcmuaf.fit.project_final_webcaygiong.login;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.io.UnsupportedEncodingException;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

public class EmailService {
        private static final String FROM_EMAIL = "22130110@st.hcmuaf.edu.vn";
        private static final String APP_PASSWORD = "vyml vxyw zhzq qqzt";
        private static final Logger logger = Logger.getLogger(EmailService.class.getName());

        public boolean sendResetPasswordEmail(String toEmail, String resetLink) {
            try {
                Properties props = new Properties();
                props.put("mail.smtp.host", "smtp.gmail.com");
                props.put("mail.smtp.port", "587");
                props.put("mail.smtp.auth", "true");
                props.put("mail.smtp.starttls.enable", "true");
                props.put("mail.smtp.ssl.protocols", "TLSv1.2");
                props.put("mail.smtp.ssl.trust", "smtp.gmail.com");

                // Thêm timeout để tránh treo hệ thống
                props.put("mail.smtp.timeout", "5000");
                props.put("mail.smtp.connectiontimeout", "5000");
                props.put("mail.smtp.writetimeout", "5000");

                Session session = Session.getInstance(props, new Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(FROM_EMAIL, APP_PASSWORD);
                    }
                });

                Message message = new MimeMessage(session);
                message.setFrom(new InternetAddress(FROM_EMAIL));
                message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
                message.setSubject("Đặt lại mật khẩu - Cây Giống OneH2K");

                String content = "<html><body>"
                        + "<p>Xin chào,</p>"
                        + "<p>Bạn đã yêu cầu đặt lại mật khẩu. Vui lòng nhấp vào liên kết bên dưới:</p>"
                        + "<p><a href=\"" + resetLink + "\">Đặt lại mật khẩu</a></p>"
                        + "<p>Liên kết có hiệu lực trong 24h.</p>"
                        + "</body></html>";

                message.setContent(content, "text/html; charset=UTF-8");

                Transport.send(message);
                return true;
            } catch (AuthenticationFailedException e) {
                logger.log(Level.SEVERE, "Lỗi xác thực email: " + e.getMessage());
                return false;
            } catch (MessagingException e) {
                logger.log(Level.SEVERE, "Lỗi gửi email: " + e.getMessage());
                return false;
            } catch (Exception e) {
                logger.log(Level.SEVERE, "Lỗi không xác định: " + e.getMessage());
                return false;
            }
        }
    }