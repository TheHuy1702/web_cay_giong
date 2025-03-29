package vn.edu.hcmuaf.fit.project_final_webcaygiong.login;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.UserDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.User;

import java.io.IOException;
import java.sql.Date;
import java.util.concurrent.TimeUnit;

@WebServlet(name = "forgot_passServlet", value = "/forgot_pass")
public class forgot_passServlet extends HttpServlet {

    private UserDao userDao;

    @Override
    public void init() throws ServletException {
        userDao = new UserDao();  // Tạo đối tượng UserDao để truy cập cơ sở dữ liệu
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("forgot_pass.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String phone = request.getParameter("phone");

        if ("sendCode".equals(action)) {
            handleSendCode(request, response, phone);
        } else if ("validateCode".equals(action)) {
            String code = request.getParameter("code");
            handleValidateCode(request, response, phone, code);
        }
    }

    private void handleSendCode(HttpServletRequest request, HttpServletResponse response, String phone) throws IOException, ServletException {
        User user = userDao.findByPhone(phone);
        if (user == null) {
            request.setAttribute("phoneError", "Số điện thoại không tồn tại, vui lòng nhập lại.");
        } else {
            // Tạo mã xác minh ngẫu nhiên (4 chữ số)
            String verificationCode = String.format("%04d", (int) (Math.random() * 9000) + 1000);

//            // Tạo thời gian hết hạn mã (1 ngày)
            Date expirationDate = new Date(System.currentTimeMillis() + TimeUnit.DAYS.toMillis(1));
            // Tạo thời gian hết hạn mã (1 phút)
//            Date expirationDate = new Date(System.currentTimeMillis() + TimeUnit.MINUTES.toMillis(1));

            // Cập nhật mã xác minh vào cơ sở dữ liệu
            boolean isUpdated = userDao.updateOrInsertVerificationCode(phone, verificationCode, expirationDate);
            if (isUpdated) {
                request.setAttribute("codeMessage", "Mã của bạn là: " + verificationCode);
                request.setAttribute("phone", phone);  // Giữ lại số điện thoại đã nhập
                request.setAttribute("codeError", null);  // Đảm bảo không có lỗi khi gửi mã
            } else {
                request.setAttribute("phoneError", "Có lỗi xảy ra khi gửi mã. Vui lòng thử lại.");
            }
        }
        request.getRequestDispatcher("forgot_pass.jsp").forward(request, response);
    }

    private void handleValidateCode(HttpServletRequest request, HttpServletResponse response, String phone, String code) throws IOException, ServletException {
        // Kiểm tra mã xác minh có hợp lệ không
        if (userDao.isVerificationCodeValid(phone, code)) {
            // Nếu mã hợp lệ, chuyển hướng tới trang đổi mật khẩu
            response.sendRedirect("reset_pass.jsp?phone=" + phone);  // Gửi số điện thoại đến trang reset_pass.jsp
        } else {
            // Nếu mã không hợp lệ, yêu cầu người dùng thử lại
            request.setAttribute("codeError", "Mã code không hợp lệ hoặc đã hết hạn. Vui lòng thử lại.");
            request.setAttribute("phone", phone);  // Giữ lại số điện thoại đã nhập
            request.getRequestDispatcher("forgot_pass.jsp").forward(request, response);
        }
    }
}
