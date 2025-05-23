package vn.edu.hcmuaf.fit.project_final_webcaygiong.login;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.UserDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.TokenForgotPassword;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.User;

import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.LogUtil;

@WebServlet(name = "forgot_passServlet", value = "/forgot_pass")
public class forgot_passServlet extends HttpServlet {
    private static final int TOKEN_EXPIRATION_HOURS = 24;
    private static final int MAX_ATTEMPTS_PER_EMAIL = 5;
    private static final long BLOCK_DURATION_MS = 24 * 60 * 60 * 1000; // 24 giờ

    private UserDao userDao;
    private EmailService emailService;
    private LogUtil logUtil;
    private static final Map<String, Integer> resetAttempts = new HashMap<>();
    private static final Map<String, Long> blockedEmails = new HashMap<>();

    @Override
    public void init() throws ServletException {
        super.init();
        userDao = new UserDao();
        emailService = new EmailService();
        logUtil = new LogUtil();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        if (email != null) {
            request.setAttribute("email", email);
        }

        logUtil.log(request, "Access forgot password page", "INFO", "forgot_pass.jsp",
                "User", "Not logged in", "Accessed forgot password page");

        request.getRequestDispatcher("forgot_pass.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email").trim();
        String ipAddress = request.getRemoteAddr();

        // Kiểm tra email bị block
        if (isEmailBlocked(email)) {
            logUtil.log(request, "Blocked email attempt", "WARN", "forgot_pass.jsp",
                    "User", "Not logged in", "Blocked email attempted: " + email);

            request.setAttribute("error", "Bạn đã yêu cầu reset mật khẩu quá nhiều lần. Vui lòng thử lại sau 24 giờ.");
            request.getRequestDispatcher("forgot_pass.jsp").forward(request, response);
            return;
        }

        // Validate email format
        if (!isValidEmail(email)) {
            logFailedAttempt(request, email, ipAddress, "Invalid email format");
            request.setAttribute("error", "Email không hợp lệ");
            request.setAttribute("email", email);
            request.getRequestDispatcher("forgot_pass.jsp").forward(request, response);
            return;
        }

        User user = userDao.findByEmail(email);
        if (user == null) {
            logFailedAttempt(request, email, ipAddress, "Email not found in system");
            request.setAttribute("error", "Email không tồn tại trong hệ thống");
            request.setAttribute("email", email);
            request.getRequestDispatcher("forgot_pass.jsp").forward(request, response);
            return;
        }

        try {
            // Kiểm tra số lần yêu cầu reset
            int attempts = incrementResetAttempts(email);
            if (attempts > MAX_ATTEMPTS_PER_EMAIL) {
                blockEmail(email);
                logUtil.log(request, "Email blocked for too many attempts", "WARN", "forgot_pass.jsp",
                        "User", "Not logged in", "Email blocked: " + email + ", Attempts: " + attempts);

                request.setAttribute("error", "Bạn đã yêu cầu reset mật khẩu quá nhiều lần. Vui lòng thử lại sau 24 giờ.");
                request.getRequestDispatcher("forgot_pass.jsp").forward(request, response);
                return;
            }

            // Tạo token reset
            String token = UUID.randomUUID().toString();
            Date expiryDate = new Date(System.currentTimeMillis() + TOKEN_EXPIRATION_HOURS * 60 * 60 * 1000);

            // Lưu token vào database
            TokenForgotPassword tokenEntity = new TokenForgotPassword(0, user.getUserID(), false, token, expiryDate);
            if (!userDao.savePasswordResetToken(tokenEntity)) {
                throw new Exception("Không thể lưu token reset mật khẩu");
            }

            // Tạo link reset
            String resetLink = buildResetLink(request, token);

            // Gửi email
            if (!emailService.sendResetPasswordEmail(email, user.getName(), resetLink)) {
                throw new Exception("Gửi email thất bại");
            }

            // Log thành công
            logUtil.log(request, "Password reset email sent", "INFO", "forgot_pass.jsp",
                    "User", "Not logged in", "Reset email sent to: " + email + ", User ID: " + user.getUserID());

            // Hiển thị thông báo thành công
            request.setAttribute("success",
                    "<div class='alert alert-success'>" +
                            "<h4><i class='bi bi-check-circle-fill'></i> Yêu cầu thành công!</h4>" +
                            "<p>Chúng tôi đã gửi liên kết đặt lại mật khẩu đến email của bạn.</p>" +
                            "<ul>" +
                            "<li>Kiểm tra hộp thư đến</li>" +
                            "<li>Nếu không thấy email, kiểm tra thư mục Spam/Junk</li>" +
                            "<li>Liên kết có hiệu lực trong " + TOKEN_EXPIRATION_HOURS + " giờ</li>" +
                            "</ul>" +
                            "</div>");

            request.getRequestDispatcher("forgot_pass.jsp").forward(request, response);

        } catch (Exception e) {
            logUtil.log(request, "Password reset error", "ERROR", "forgot_pass.jsp",
                    "User", "Not logged in", "Error processing reset for email: " + email + ", Error: " + e.getMessage());

            request.setAttribute("error", "Đã xảy ra lỗi: " + e.getMessage());
            request.setAttribute("email", email);
            request.getRequestDispatcher("forgot_pass.jsp").forward(request, response);
        }
    }

    private boolean isValidEmail(String email) {
        if (email == null || email.isEmpty()) return false;
        String emailRegex = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
        return email.matches(emailRegex);
    }

    private String buildResetLink(HttpServletRequest request, String token) {
        return request.getScheme() + "://" +
                request.getServerName() +
                (request.getServerPort() != 80 ? ":" + request.getServerPort() : "") +
                request.getContextPath() + "/reset_pass?token=" + token;
    }

    private synchronized int incrementResetAttempts(String email) {
        int attempts = resetAttempts.getOrDefault(email, 0) + 1;
        resetAttempts.put(email, attempts);
        return attempts;
    }

    private synchronized void blockEmail(String email) {
        blockedEmails.put(email, System.currentTimeMillis());
    }

    private synchronized boolean isEmailBlocked(String email) {
        if (blockedEmails.containsKey(email)) {
            long blockTime = blockedEmails.get(email);
            if (System.currentTimeMillis() - blockTime < BLOCK_DURATION_MS) {
                return true;
            } else {
                blockedEmails.remove(email);
                resetAttempts.remove(email);
                return false;
            }
        }
        return false;
    }

    private void logFailedAttempt(HttpServletRequest request, String email, String ipAddress, String reason) {
        logUtil.log(request, "Failed password reset attempt", "WARN", "forgot_pass.jsp",
                "User", "Not logged in", "Failed attempt for email: " + email + ", IP: " + ipAddress + ", Reason: " + reason);
    }
}