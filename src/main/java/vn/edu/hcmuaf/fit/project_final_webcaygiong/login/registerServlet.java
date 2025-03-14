package vn.edu.hcmuaf.fit.project_final_webcaygiong.login;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.UserDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.User;

import java.io.IOException;
import java.util.Date;

@WebServlet(name = "registerServlet", value = "/register")
public class registerServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        String error = null;

        // Kiểm tra định dạng mật khẩu
        if (!isValidPassword(password)) {
            error = "Mật khẩu phải chứa ít nhất 1 ký tự hoa, 1 ký tự thường và 1 số!";
        }

        // Kiểm tra định dạng số điện thoại
        if (!isValidPhoneNumber(phone)) {
            error = "Số điện thoại phải bắt đầu bằng 0 và gồm 10 chữ số!";
        }

        // Kiểm tra mật khẩu và xác nhận mật khẩu
        if (error == null && !password.equals(confirmPassword)) {
            error = "Mật khẩu và xác nhận mật khẩu không khớp!";
        }

        // Kiểm tra nếu số điện thoại đã tồn tại
        if (error == null) {
            UserDao userDao = new UserDao();
            User existingUser = userDao.findUsername(phone);
            if (existingUser != null) {
                error = "Số điện thoại đã được đăng ký!";
            } else {
                // Tạo đối tượng người dùng mới
                User newUser = new User();
                newUser.setName(name);
                newUser.setPhone(phone);
                newUser.setPassword(password);
                newUser.setCreateAt(new Date());  // Cập nhật thời gian tạo
                newUser.setUpdateAt(new Date());  // Cập nhật thời gian sửa đổi

                // Thêm người dùng vào cơ sở dữ liệu
                userDao.insertUser(newUser);

                // Chuyển hướng đến trang đăng nhập sau khi đăng ký thành công
                response.sendRedirect("login");
                return;
            }
        }

        // Nếu có lỗi, hiển thị lại thông báo lỗi
        request.setAttribute("error", error);
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    private boolean isValidPhoneNumber(String phone) {
        return phone.matches("0\\d{9}");
    }

    private boolean isValidPassword(String password) {
        return password.matches("^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d).+$");
    }
}
