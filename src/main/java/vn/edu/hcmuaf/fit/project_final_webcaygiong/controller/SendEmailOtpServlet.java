package vn.edu.hcmuaf.fit.project_final_webcaygiong.controller; import jakarta.servlet.*; 
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.EmailSender;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.User;

import java.io.IOException;
import java.util.Random;

@WebServlet(name = "SendEmailOtpServlet", value = "/send-otp-email")
public class SendEmailOtpServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || user.getEmail() == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // ✅ Lấy action từ query parameter
        String action = request.getParameter("action");
        if (action == null) action = "changePassword"; // mặc định

        Long lastSentTime = (Long) session.getAttribute("otpLastSent");
        long now = System.currentTimeMillis();
        if (lastSentTime != null && now - lastSentTime < 60 * 1000) {
            request.setAttribute("error", "Bạn chỉ có thể gửi lại OTP sau 1 phút.");
            request.getRequestDispatcher("otpVerify.jsp").forward(request, response);
            return;
        }

        String otp = String.valueOf(new Random().nextInt(900000) + 100000);
        session.setAttribute("otp", otp);
        session.setAttribute("otpTime", now);
        session.setAttribute("otpLastSent", now);
        session.setAttribute("otpAction", action); // 👈 lưu mục đích dùng OTP

        try {
            EmailSender.sendEmail(
                    user.getEmail(),
                    "Mã OTP xác nhận " + getFriendlyActionText(action),
                    "Mã OTP của bạn là: " + otp
            );
            request.setAttribute("message", "Mã OTP đã được gửi đến email của bạn.");
            request.getRequestDispatcher("otpVerify.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Không thể gửi email. Vui lòng thử lại sau.");
            request.getRequestDispatcher("taiKhoanCuaToi").forward(request, response);
        }
    }

    private String getFriendlyActionText(String action) {
        return switch (action) {
            case "updateEmail" -> "thay đổi Email";
            case "updatePhone" -> "thay đổi số điện thoại";
            default -> "đổi mật khẩu";
        };
    }

}
