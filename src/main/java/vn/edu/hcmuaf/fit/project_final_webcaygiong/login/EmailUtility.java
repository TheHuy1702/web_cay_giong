package vn.edu.hcmuaf.fit.project_final_webcaygiong.login;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;

public class EmailUtility {
        private static final String FROM_EMAIL = "22130110@st.hcmuaf.edu.vn";
        private static final String APP_PASSWORD = "vyml vxyw zhzq qqzt";

        public static boolean sendActivationEmail(String toEmail, String activationLink) {
            Properties props = new Properties();
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "587");
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");

            Session session = Session.getInstance(props, new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(FROM_EMAIL, APP_PASSWORD);
                }
            });

            try {
                Message message = new MimeMessage(session);
                message.setFrom(new InternetAddress(FROM_EMAIL));
                message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
                message.setSubject("Kích hoạt tài khoản của bạn");

                String content = "<html><body>"
                        + "<h2>Xin chào!</h2>"
                        + "<p>Cảm ơn bạn đã đăng ký tài khoản. Vui lòng nhấp vào liên kết bên dưới để kích hoạt tài khoản của bạn:</p>"
                        + "<p><a href=\"" + activationLink + "\">" + activationLink + "</a></p>"
                        + "<p>Liên kết sẽ hết hạn sau 24 giờ.</p>"
                        + "</body></html>";

                message.setContent(content, "text/html; charset=utf-8");

                Transport.send(message);
                return true;
            } catch (MessagingException e) {
                e.printStackTrace();
                return false;
            }
        }
    }

