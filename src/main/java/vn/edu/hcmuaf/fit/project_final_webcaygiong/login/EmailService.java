package vn.edu.hcmuaf.fit.project_final_webcaygiong.login;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

public class EmailService {
    private static final String FROM_EMAIL = "22130110@st.hcmuaf.edu.vn";
    private static final String FROM_NAME = "Cây Giống OneH2K";
    private static final String APP_PASSWORD = "vyml vxyw zhzq qqzt";
    private static final Logger logger = Logger.getLogger(EmailService.class.getName());

    private final Session mailSession;

    public EmailService() {
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.ssl.protocols", "TLSv1.2");
        props.put("mail.smtp.ssl.trust", "smtp.gmail.com");

        // Timeout settings
        props.put("mail.smtp.timeout", "5000");
        props.put("mail.smtp.connectiontimeout", "5000");
        props.put("mail.smtp.writetimeout", "5000");

        this.mailSession = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_EMAIL, APP_PASSWORD);
            }
        });
    }

    public boolean sendResetPasswordEmail(String toEmail, String username, String resetLink) {
        String subject = "🌱 Yêu Cầu Đặt Lại Mật Khẩu - Cây Giống OneH2K";
        String content = "<!DOCTYPE html>"
                + "<html>"
                + "<head>"
                + "<meta charset='UTF-8'>"
                + "<style>"
                + "  body { font-family: 'Helvetica Neue', Arial, sans-serif; line-height: 1.6; color: #333; max-width: 600px; margin: 0 auto; padding: 0; }"
                + "  .container { background-color: #ffffff; border-radius: 8px; overflow: hidden; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }"
                + "  .header { background-color: #27ae60; color: white; padding: 25px; text-align: center; }"
                + "  .logo { font-size: 24px; font-weight: 600; margin-bottom: 5px; }"
                + "  .content { padding: 25px; }"
                + "  .button-container { text-align: center; margin: 25px 0;}"
                + "  .button { background-color: #2ecc71; color: white; padding: 14px 28px; text-align: center; "
                + "    text-decoration: none; display: inline-block; border-radius: 6px; font-weight: 600; "
                + "    font-size: 16px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); transition: all 0.3s ease; }"
                + "  .button:hover { background-color: #27ae60; transform: translateY(-2px); box-shadow: 0 4px 8px rgba(0,0,0,0.15); }"
                + "  .notice { background-color: #f8f9fa; border-left: 4px solid #2ecc71; padding: 15px; margin: 20px 0; border-radius: 4px; }"
                + "  .footer { margin-top: 30px; font-size: 13px; color: #7f8c8d; text-align: center; line-height: 1.5; }"
                + "  .highlight { color: #27ae60; font-weight: 600; }"
                + "  .divider { height: 1px; background-color: #ecf0f1; margin: 20px 0; }"
                + "  ul { padding-left: 20px; }"
                + "  li { margin-bottom: 8px; }"
                + "</style>"
                + "</head>"
                + "<body>"
                + "<div class='container'>"
                + "<div class='header'>"
                + "  <div class='logo'>Cây Giống OneH2K</div>"
                + "  <div style='font-size: 18px;'>Đặt lại mật khẩu</div>"
                + "</div>"

                + "<div class='content'>"
                + "<p>Xin chào <strong>" + username + "</strong>,</p>"
                + "<p>Chúng tôi đã nhận được yêu cầu đặt lại mật khẩu cho tài khoản của bạn tại <span class='highlight'>Cây Giống OneH2K</span>.</p>"

                + "<div class='notice'>"
                + "  <p>Vui lòng nhấp vào nút bên dưới để thiết lập mật khẩu mới:</p>"
                + "  <div class='button-container'>"
                + "    <a href='" + resetLink + "' class='button' style='color: white;'>ĐẶT LẠI MẬT KHẨU</a>"
                + "  </div>"
                + "  <p style='text-align: center; font-size: 14px; color: #7f8c8d;'>Liên kết có hiệu lực trong <strong>24 giờ</strong></p>"
                + "</div>"

                + "<div class='divider'></div>"

                + "<p><strong style='color: #27ae60;'>Lưu ý quan trọng:</strong></p>"
                + "<ul>"
                + "  <li>Nếu <strong>không phải bạn</strong> yêu cầu đặt lại mật khẩu, vui lòng bỏ qua email này</li>"
                + "  <li>Để bảo mật tài khoản, <strong>không chia sẻ</strong> liên kết này với bất kỳ ai</li>"
                + "  <li>Liên kết chỉ có hiệu lực <strong>một lần duy nhất</strong></li>"
                + "</ul>"

                + "<div class='footer'>"
                + "  <p>Trân trọng,<br><strong>Đội ngũ hỗ trợ Cây Giống OneH2K</strong></p>"
                + "  <p>Email này được gửi tự động, vui lòng không trả lời.</p>"
                + "  <p>© " + java.time.Year.now().getValue() + " Cây Giống OneH2K. Mọi quyền được bảo lưu.</p>"
                + "</div>"
                + "</div>" // end content
                + "</div>" // end container
                + "</body>"
                + "</html>";

        return sendHtmlEmail(toEmail, subject, content);
    }

    public boolean sendWarningEmail(String toEmail, String username, int failedAttempts) {
        String subject = "⚠️ CẢNH BÁO: Phát hiện đăng nhập không thành công vào tài khoản của bạn";
        String content = "<!DOCTYPE html>"
                + "<html>"
                + "<head>"
                + "<meta charset='UTF-8'>"
                + "<style>"
                + "  body { font-family: 'Segoe UI', Arial, sans-serif; line-height: 1.6; color: #333333; max-width: 600px; margin: 0 auto; padding: 0; }"
                + "  .container { padding: 25px; }"
                + "  .header { color: #ffffff; background-color: #e74c3c; padding: 20px; text-align: center; border-radius: 5px 5px 0 0; }"
                + "  .logo { font-size: 24px; font-weight: bold; }"
                + "  .content { background-color: #f9f9f9; padding: 25px; }"
                + "  .alert-box { background-color: #fff4f4; border: 1px solid #ffd6d6; border-left: 4px solid #e74c3c; padding: 15px; margin: 15px 0; border-radius: 4px; }"
                + "  .footer { margin-top: 30px; font-size: 12px; color: #777777; text-align: center; line-height: 1.4; }"
                + "  .highlight { color: #e74c3c; font-weight: bold; }"
                + "  .steps { margin-left: 20px; }"
                + "  .recommendations { background-color: #f0f0f0; padding: 15px; border-radius: 4px; margin-top: 20px; }"
                + "</style>"
                + "</head>"
                + "<body>"
                + "<div class='header'>"
                + "  <div class='logo'>Cây Giống OneH2K</div>"
                + "  <div style='font-size: 18px; margin-top: 10px;'>Cảnh báo bảo mật</div>"
                + "</div>"
                + "<div class='container'>"
                + "<div class='content'>"
                + "<p>Xin chào <strong>" + username + "</strong>,</p>"

                + "<div class='alert-box'>"
                + "  <p style='margin: 0;'>Hệ thống của chúng tôi vừa ghi nhận <span class='highlight'>" + failedAttempts + " lần đăng nhập không thành công</span> vào tài khoản của bạn.</p>"
                + "</div>"

                + "<p>Nếu đây là hoạt động của bạn, bạn có thể bỏ qua email này.</p>"

                + "<p><strong style='color: #e74c3c;'>Nếu KHÔNG phải bạn thực hiện:</strong></p>"
                + "<div class='steps'>"
                + "  <p>1️⃣ <strong>Thay đổi mật khẩu ngay lập tức</strong> để bảo vệ tài khoản</p>"
                + "  <p>2️⃣ <strong>Kiểm tra hoạt động gần đây</strong> của tài khoản</p>"
                + "  <p>3️⃣ <strong>Báo cáo ngay với chúng tôi</strong> nếu phát hiện hoạt động đáng ngờ</p>"
                + "</div>"

                + "<div class='recommendations'>"
                + "  <p style='margin-top: 0;'><strong>Để tăng cường bảo mật:</strong></p>"
                + "  <ul style='margin-bottom: 0;'>"
                + "    <li>Sử dụng mật khẩu mạnh với ít nhất 8 ký tự, kết hợp chữ hoa, chữ thường, số và ký tự đặc biệt</li>"
                + "    <li>Kích hoạt xác thực 2 lớp (2FA) nếu có</li>"
                + "    <li>Không sử dụng lại mật khẩu cho nhiều tài khoản</li>"
                + "  </ul>"
                + "</div>"
                + "</div>" // end content

                + "<div class='footer'>"
                + "  <p>Đây là email tự động, vui lòng không trả lời.</p>"
                + "  <p>Nếu bạn có bất kỳ câu hỏi nào, vui lòng liên hệ <a href='mailto:support@caygiongoneh2k.com' style='color: #e74c3c;'>support@caygiongoneh2k.com</a></p>"
                + "  <p>© " + java.time.Year.now().getValue() + " Cây Giống OneH2K. Mọi quyền được bảo lưu.</p>"
                + "</div>"
                + "</div>" // end container
                + "</body>"
                + "</html>";

        return sendHtmlEmail(toEmail, subject, content);
    }

    public boolean sendTextEmail(String toEmail, String subject, String textContent) {
        try {
            Message message = new MimeMessage(mailSession);
            message.setFrom(new InternetAddress(FROM_EMAIL, FROM_NAME));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject);
            message.setText(textContent);

            Transport.send(message);
            return true;
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Lỗi khi gửi email văn bản: " + e.getMessage(), e);
            return false;
        }
    }

    public boolean sendHtmlEmail(String toEmail, String subject, String htmlContent) {
        try {
            Message message = new MimeMessage(mailSession);
            message.setFrom(new InternetAddress(FROM_EMAIL, FROM_NAME));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject);
            message.setContent(htmlContent, "text/html; charset=UTF-8");

            Transport.send(message);
            return true;
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Lỗi khi gửi email HTML: " + e.getMessage(), e);
            return false;
        }
    }
}