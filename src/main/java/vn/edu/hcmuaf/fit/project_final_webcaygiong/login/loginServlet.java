package vn.edu.hcmuaf.fit.project_final_webcaygiong.login;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.UserDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.User;

import java.io.IOException;

@WebServlet(name = "loginServlet", value = "/login")
public class loginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy thông tin người dùng gửi từ form
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        HttpSession session = request.getSession();
        UserDao userDao = new UserDao();

        // Kiểm tra thông tin đăng nhập
        User adminUser = userDao.findByPhone("0123456789");
        if (adminUser != null && adminUser.getPhone().equals(phone)) {
            if (adminUser.getPassword().equals(password)) {
                session.setAttribute("user", adminUser); // Lưu đối tượng admin vào session
                session.setAttribute("au", true); // Đánh dấu là admin
                response.sendRedirect("DashBoard"); // Chuyển đến trang quản trị
                return;
            } else {
                request.setAttribute("phoneError", "Số điện thoại hoặc mật khẩu không đúng.");
                request.setAttribute("passwordError", "Mật khẩu không đúng. Vui lòng nhập lại.");
                request.setAttribute("phone", phone); // Giữ lại số điện thoại trong khung nhập
                RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
                dispatcher.forward(request, response);
                return;
            }
        }

        User user = userDao.findByPhone(phone);
        if (user != null) {
            boolean isLogin = userDao.checkLogin(user.getPhone(), password);
            if (isLogin) {
                session.setAttribute("user", user); // Lưu đối tượng user vào session
                session.setAttribute("au", false); // Đánh dấu không phải admin
                response.sendRedirect("TrangChu"); // Chuyển đến trang người dùng
            } else {
                request.setAttribute("phoneError", "Số điện thoại hoặc mật khẩu không đúng.");
                request.setAttribute("passwordError", "Mật khẩu không đúng. Vui lòng nhập lại.");
                request.setAttribute("phone", phone); // Giữ lại số điện thoại trong khung nhập
                RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
                dispatcher.forward(request, response);
            }
        } else {
            request.setAttribute("phoneError", "Số điện thoại không tồn tại.");
            request.setAttribute("phone", phone); // Giữ lại số điện thoại trong khung nhập
            RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
            dispatcher.forward(request, response);
        }
    }
}