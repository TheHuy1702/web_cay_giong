package vn.edu.hcmuaf.fit.project_final_webcaygiong.login;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.UserDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.User;

import java.io.IOException;
import java.util.Date;
import java.util.UUID;

@WebServlet(name = "ResendActivationServlet", value = "/resendActivation")
public class ResendActivationServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        UserDao userDao = new UserDao();
        User user = userDao.emailExists(email);

        if (user == null) {
            request.setAttribute("error", "Email không tồn tại trong hệ thống");
            request.getRequestDispatcher("activation_result.jsp").forward(request, response);
            return;
        }

        if (user.isActive()) {
            request.setAttribute("message", "Tài khoản đã được kích hoạt trước đó");
            request.getRequestDispatcher("activation_result.jsp").forward(request, response);
            return;
        }

        // Tạo token mới
        String token = UUID.randomUUID().toString();
        Date expiryDate = new Date(System.currentTimeMillis() + 24 * 60 * 60 * 1000);

        boolean tokenUpdated = userDao.createNewActivationToken(user.getUserID(), token, expiryDate);

        if (tokenUpdated) {
            String activationLink = request.getRequestURL().toString()
                    .replace("resendActivation", "activation?token=" + token);

            boolean emailSent = EmailUtility.sendActivationEmail(email, activationLink);

            if (emailSent) {
                request.setAttribute("success", "Đã gửi lại link kích hoạt thành công!");
            } else {
                request.setAttribute("error", "Gửi email thất bại, vui lòng thử lại");
            }
        } else {
            request.setAttribute("error", "Tạo link kích hoạt mới thất bại");
        }

        request.getRequestDispatcher("activation_result.jsp").forward(request, response);
    }
}