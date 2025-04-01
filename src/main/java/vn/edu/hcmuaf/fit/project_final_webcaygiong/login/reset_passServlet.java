package vn.edu.hcmuaf.fit.project_final_webcaygiong.login;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.UserDao;

import java.io.IOException;

@WebServlet(name = "reset_passServlet", value = "/reset_pass")
public class reset_passServlet extends HttpServlet {
    private UserDao userDao;

    @Override
    public void init() throws ServletException {
        userDao = new UserDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, IOException {
        String phone = request.getParameter("phone");
        String newPassword = request.getParameter("new-password");
        String confirmPassword = request.getParameter("confirm-password");

        if (newPassword.equals(confirmPassword)) {
            boolean isUpdated = UserDao.updatePassword(phone, newPassword);
            if (isUpdated) {
                response.sendRedirect("login");
            } else {
                request.setAttribute("errorMessage", "Có lỗi khi cập nhật mật khẩu.");
                request.getRequestDispatcher("reset_pass.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("errorMessage", "Mật khẩu và xác nhận mật khẩu không khớp.");
            request.getRequestDispatcher("reset_pass.jsp").forward(request, response);
        }
    }
}