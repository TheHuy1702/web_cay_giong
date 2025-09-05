package vn.edu.hcmuaf.fit.project_final_webcaygiong.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.UserDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.PasswordUtil;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.User;

import java.io.IOException;

@WebServlet(name = "ChangePasswordServlet ", value = "/doiMatKhau")
public class ChangePasswordServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");



        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String otpAction = (String) session.getAttribute("otpAction");
        String targetPage = "changePasswordAdmin".equals(otpAction) ? "doiMatKhauAdmin.jsp" : "doiMatKhauUser.jsp";

        request.getRequestDispatcher(targetPage).forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String phone = currentUser.getPhone();
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Kiểm tra xác nhận mật khẩu
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp.");
            String otpAction = (String) session.getAttribute("otpAction");
            String targetPage = "changePasswordAdmin".equals(otpAction) ? "doiMatKhauAdmin.jsp" : "doiMatKhauUser.jsp";
            request.getRequestDispatcher(targetPage).forward(request, response);

            return;
        }

// Kiểm tra độ mạnh của mật khẩu
        if (!isStrongPassword(newPassword)) {
            request.setAttribute("error", "Mật khẩu phải có ít nhất 8 ký tự, bao gồm chữ hoa, chữ thường, số và ký tự đặc biệt.");
            String otpAction = (String) session.getAttribute("otpAction");
            String targetPage = "changePasswordAdmin".equals(otpAction) ? "doiMatKhauAdmin.jsp" : "doiMatKhauUser.jsp";
            request.getRequestDispatcher(targetPage).forward(request, response);

            return;
        }


        // Kiểm tra mật khẩu hiện tại có khớp không(đã sử dụng mã hoá)
        if (!PasswordUtil.checkPassword(currentPassword, currentUser.getPassword())) {
            request.setAttribute("error", "Mật khẩu hiện tại không đúng.");
            String otpAction = (String) session.getAttribute("otpAction");
            String targetPage = "changePasswordAdmin".equals(otpAction) ? "doiMatKhauAdmin.jsp" : "doiMatKhauUser.jsp";
            request.getRequestDispatcher(targetPage).forward(request, response);

            return;
        }

        // Cập nhật mật khẩu mới(đã mã hoá)
        String hashedNewPassword = PasswordUtil.hashPassword(newPassword);
        int userId = Integer.parseInt(request.getParameter("userId"));
        boolean updated = UserDao.updatePassword(userId, hashedNewPassword);



        if (updated) {
            currentUser.setPassword(hashedNewPassword);// Cập nhật mật khẩu mới trong session(đã mã hoá)
            session.setAttribute("user", currentUser);

            request.setAttribute("message", "Đổi mật khẩu thành công.");
        } else {
            request.setAttribute("error", "Cập nhật mật khẩu thất bại. Vui lòng thử lại.");
        }

        String otpAction = (String) session.getAttribute("otpAction");
        String targetPage = "changePasswordAdmin".equals(otpAction) ? "doiMatKhauAdmin.jsp" : "doiMatKhauUser.jsp";
        request.getRequestDispatcher(targetPage).forward(request, response);

    }
    private boolean isStrongPassword(String password) {
        // Chấp nhận nhiều ký tự đặc biệt hơn, ví dụ: dấu chấm, phẩy, ngoặc, gạch dưới, v.v.
        String pattern = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[^A-Za-z\\d])[A-Za-z\\d[^\\s]]{8,}$";
        return password.matches(pattern);
    }


}
