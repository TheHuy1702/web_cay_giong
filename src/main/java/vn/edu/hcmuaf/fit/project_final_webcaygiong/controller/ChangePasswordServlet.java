package vn.edu.hcmuaf.fit.project_final_webcaygiong.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.UserDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.User;

import java.io.IOException;

@WebServlet(name = "ChangePasswordServlet ", value = "/doiMatKhau")
public class ChangePasswordServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("doiMatKhauUser.jsp");
        dispatcher.forward(request, response);
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
            request.getRequestDispatcher("doiMatKhauUser.jsp").forward(request, response);
            return;
        }

// Kiểm tra độ mạnh của mật khẩu
        if (!isStrongPassword(newPassword)) {
            request.setAttribute("error", "Mật khẩu phải có ít nhất 8 ký tự, bao gồm chữ hoa, chữ thường, số và ký tự đặc biệt.");
            request.getRequestDispatcher("doiMatKhauUser.jsp").forward(request, response);
            return;
        }


        // Kiểm tra mật khẩu hiện tại có khớp không
        if (!currentPassword.equals(currentUser.getPassword())) {
            request.setAttribute("error", "Mật khẩu hiện tại không đúng.");
            request.getRequestDispatcher("doiMatKhauUser.jsp").forward(request, response);
            return;
        }

        // Cập nhật mật khẩu mới
        boolean updated = UserDao.updatePassword(phone, newPassword);

        if (updated) {
            currentUser.setPassword(newPassword); // Cập nhật mật khẩu mới trong session
            session.setAttribute("user", currentUser);

            request.setAttribute("message", "Đổi mật khẩu thành công.");
        } else {
            request.setAttribute("error", "Cập nhật mật khẩu thất bại. Vui lòng thử lại.");
        }

        request.getRequestDispatcher("doiMatKhauUser.jsp").forward(request, response);
    }
    private boolean isStrongPassword(String password) {
        // Chấp nhận nhiều ký tự đặc biệt hơn, ví dụ: dấu chấm, phẩy, ngoặc, gạch dưới, v.v.
        String pattern = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[^A-Za-z\\d])[A-Za-z\\d[^\\s]]{8,}$";
        return password.matches(pattern);
    }


}
