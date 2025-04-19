package vn.edu.hcmuaf.fit.project_final_webcaygiong.login;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.UserDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.TokenForgotPassword;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.User;
import java.io.IOException;
import java.util.Date;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "forgot_passServlet", value = "/forgot_pass")
public class forgot_passServlet extends HttpServlet {
    private UserDao userDao = new UserDao();
    private EmailService emailService = new EmailService();
    private static final Logger logger = Logger.getLogger(forgot_passServlet.class.getName());

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("forgot_pass.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");

        // Validate email format first
        if (!isValidEmail(email)) {
            request.setAttribute("error", "Email không hợp lệ");
            request.getRequestDispatcher("forgot_pass.jsp").forward(request, response);
            return;
        }

        User user = userDao.findByEmail(email);

        if (user == null) {
            request.setAttribute("error", "Email không tồn tại trong hệ thống");
            request.getRequestDispatcher("forgot_pass.jsp").forward(request, response);
            return;
        }

        try {
            String token = UUID.randomUUID().toString();
            Date expiryDate = new Date(System.currentTimeMillis() + 24 * 60 * 60 * 1000); // 24 tiếng

            TokenForgotPassword tokenEntity = new TokenForgotPassword(0, user.getUserID(), false, token, expiryDate);
            if (!userDao.savePasswordResetToken(tokenEntity)) {
                throw new Exception("Không thể lưu token vào database");
            }

            String resetLink = request.getScheme() + "://" + request.getServerName() +
                    (request.getServerPort() != 80 ? ":" + request.getServerPort() : "") +
                    request.getContextPath() + "/reset_pass?token=" + token;

            if (!emailService.sendResetPasswordEmail(email, resetLink)) {
                throw new Exception("Gửi email thất bại");
            }

            // Ghi log thành công
            logger.info("Đã gửi email reset mật khẩu đến: " + email);

            // Hiển thị thông báo thành công
            request.setAttribute("success",
                    "<h3>Yêu cầu thành công!</h3>" +
                            "<p>Chúng tôi đã gửi liên kết đặt lại mật khẩu đến <strong>" + email + "</strong></p>" +
                            "<p>Vui lòng <strong>kiểm tra hộp thư đến</strong> và làm theo hướng dẫn.</p>" +
                            "<p>Nếu không thấy email, hãy kiểm tra thư mục <strong>Spam/Junk</strong></p>");

            request.getRequestDispatcher("forgot_pass.jsp").forward(request, response);

        } catch (Exception e) {
            logger.log(Level.SEVERE, "Lỗi trong quá trình reset mật khẩu", e);
            request.setAttribute("error", "Đã xảy ra lỗi: " + e.getMessage());
            request.getRequestDispatcher("forgot_pass.jsp").forward(request, response);
        }
    }

    private boolean isValidEmail(String email) {
        String emailRegex = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
        return email != null && email.matches(emailRegex);
    }
}