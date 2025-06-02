package vn.edu.hcmuaf.fit.project_final_webcaygiong.login;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.LogUtil;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.UserDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.TokenForgotPassword;

import java.io.IOException;
import java.util.Date;

@WebServlet(name = "reset_passServlet", value = "/reset_pass")
public class reset_passServlet extends HttpServlet {
    private UserDao userDao = new UserDao();
    private LogUtil logUtil = new LogUtil();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String token = request.getParameter("token");

        if (token == null || token.isEmpty()) {
            logUtil.log(request, "Missing reset token", "WARN", "reset_pass.jsp",
                    "User", "Not logged in", "Attempt to access reset page without token");

            response.sendRedirect("forgot_pass");
            return;
        }

        TokenForgotPassword tokenEntity = userDao.findToken(token);

        // Kiểm tra token hợp lệ và chưa hết hạn
        if (tokenEntity == null || tokenEntity.isUsed() ||
                tokenEntity.getExpiryTime().before(new Date())) {
            String reason = tokenEntity == null ? "Token not found" :
                    tokenEntity.isUsed() ? "Token already used" : "Token expired";

            logUtil.log(request, "Invalid reset token", "WARN", "reset_pass.jsp",
                    "User", "Not logged in", "Invalid token: " + token + ", Reason: " + reason);

            request.setAttribute("errorMessage", "Liên kết không hợp lệ hoặc đã hết hạn");
            request.getRequestDispatcher("invalid-token.jsp").forward(request, response);
            return;
        }

        logUtil.log(request, "Valid reset token accessed", "INFO", "reset_pass.jsp",
                "User", "Not logged in", "Valid token accessed: " + token + ", User ID: " + tokenEntity.getUserID());

        request.setAttribute("token", token);
        request.getRequestDispatcher("reset_pass.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String token = request.getParameter("token");
        String newPassword = request.getParameter("new-password");
        String confirmPassword = request.getParameter("confirm-password");

        try {
            // Kiểm tra mật khẩu trùng khớp
            if (!newPassword.equals(confirmPassword)) {
                logUtil.log(request, "Password mismatch", "WARN", "reset_pass.jsp",
                        "User", "Not logged in", "Password mismatch for token: " + token);

                request.setAttribute("errorMessage", "Mật khẩu không khớp");
                request.setAttribute("token", token);
                request.getRequestDispatcher("reset_pass.jsp").forward(request, response);
                return;
            }

            // Kiểm tra token hợp lệ
            TokenForgotPassword tokenEntity = userDao.findToken(token);
            if (tokenEntity == null || tokenEntity.isUsed() ||
                    tokenEntity.getExpiryTime().before(new Date())) {
                String reason = tokenEntity == null ? "Token not found" :
                        tokenEntity.isUsed() ? "Token already used" : "Token expired";

                logUtil.log(request, "Invalid reset token on submit", "WARN", "reset_pass.jsp",
                        "User", "Not logged in", "Invalid token on submit: " + token + ", Reason: " + reason);

                request.setAttribute("error", "Token không hợp lệ hoặc đã hết hạn");
                request.getRequestDispatcher("forgot_pass.jsp").forward(request, response);
                return;
            }

            // Cập nhật mật khẩu mới
            if (userDao.updatePassword(tokenEntity.getUserID(), newPassword)) {
                // Đánh dấu token đã sử dụng
                userDao.markTokenAsUsed(token);

                logUtil.log(request, "Password reset successful", "INFO", "reset_pass.jsp",
                        "User", "Not logged in", "Password reset for user ID: " + tokenEntity.getUserID());

                response.sendRedirect("login?resetSuccess=true");
            } else {
                logUtil.log(request, "Password update failed", "ERROR", "reset_pass.jsp",
                        "User", "Not logged in", "Password update failed for token: " + token);

                request.setAttribute("errorMessage", "Đặt lại mật khẩu thất bại");
                request.setAttribute("token", token);
                request.getRequestDispatcher("reset_pass.jsp").forward(request, response);
            }
        } catch (Exception e) {
            logUtil.log(request, "Password reset exception", "ERROR", "reset_pass.jsp",
                    "User", "Not logged in", "Exception during password reset: " + e.getMessage() + ", Token: " + token);

            request.setAttribute("errorMessage", "Lỗi hệ thống: " + e.getMessage());
            request.setAttribute("token", token);
            request.getRequestDispatcher("reset_pass.jsp").forward(request, response);
        }
    }
}