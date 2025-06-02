package vn.edu.hcmuaf.fit.project_final_webcaygiong.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.EmailSender;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.UserPermissionDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.User;

import java.io.IOException;
import java.util.Random;

@WebServlet(name = "SendEmailOtpServlet", value = "/send-otp-email")
public class SendEmailOtpServlet extends HttpServlet {
    private static final int MAX_OTP_SEND_PER_SESSION = 3;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserPermissionDao permissionDao = new UserPermissionDao();

        // Lấy user từ session
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = user.getUserID();

        // Lấy thông tin quyền từ URL
        String type = request.getParameter("type"); // "admin" hoặc "user" - để phân biệt mục đích
        String action = request.getParameter("action"); // updateEmail, updatePhone, changePassword
        if (type == null) type = "user";
        if (action == null) action = "changePassword";

        // Gán pageID = 10 và permissionID = 4 (Xem trang thay đổi thông tin bằng OTP)
        // Bạn có thể tuỳ chỉnh pageID phù hợp với page đang phân quyền trong hệ thống
        int pageID = 10;
        int permissionID = 2; // 4 = quyền "truy cập", bạn điều chỉnh theo hệ thống của bạn

        if (!permissionDao.hasPermission(userId, pageID, permissionID)) {
            request.setAttribute("error", "Bạn không có quyền thực hiện thao tác này.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        // Kiểm tra số lần gửi OTP
        Long lastSentTime = (Long) session.getAttribute("otpLastSent");
        Integer otpSentCount = (Integer) session.getAttribute("otpSentCount");
        if (otpSentCount == null) otpSentCount = 0;

        long now = System.currentTimeMillis();
        if (otpSentCount >= MAX_OTP_SEND_PER_SESSION) {
            request.setAttribute("error", "Bạn đã gửi quá số lần cho phép. Vui lòng thử lại sau.");
            request.getRequestDispatcher("otpVerify.jsp").forward(request, response);
            return;
        }

        if (lastSentTime != null && now - lastSentTime < 60 * 1000) {
            request.setAttribute("error", "Bạn chỉ có thể gửi lại OTP sau 1 phút.");
            request.getRequestDispatcher("otpVerify.jsp").forward(request, response);
            return;
        }

        // Tạo mã OTP
        String otp = String.valueOf(new Random().nextInt(900000) + 100000);

        // Lưu vào session
        session.setAttribute("otp", otp);
        session.setAttribute("otpTime", now);
        session.setAttribute("otpLastSent", now);
        session.setAttribute("otpAction", action);
        session.setAttribute("otpType", type);
        session.setAttribute("otpSentCount", otpSentCount + 1);

        try {
            EmailSender.sendEmail(
                    user.getEmail(),
                    "Mã OTP xác nhận " + getFriendlyActionText(action),
                    "Mã OTP của bạn là: " + otp + "\nMã có hiệu lực trong 3 phút."
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
