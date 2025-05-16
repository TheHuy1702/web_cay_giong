package vn.edu.hcmuaf.fit.project_final_webcaygiong.login;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.UserDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.User;

import java.io.IOException;
@WebServlet(name = "ActivationServlet", value = "/activation")
public class ActivationServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String token = request.getParameter("token");
        UserDao userDao = new UserDao();

        // Tìm user theo token
        User user = userDao.findUserByToken(token);

        if (user == null) {
            // Token không hợp lệ
            request.setAttribute("error", "Link kích hoạt không hợp lệ hoặc đã hết hạn");
            request.getRequestDispatcher("activation_result.jsp").forward(request, response);
            return;
        }

        if (user.isActive()) {
            // Tài khoản đã kích hoạt
            request.setAttribute("message", "Tài khoản đã được kích hoạt trước đó");
            request.getRequestDispatcher("activation_result.jsp").forward(request, response);
            return;
        }

        // Kích hoạt tài khoản
        boolean activated = userDao.activateAccount(user.getPhone());
        if (activated) {
            userDao.markActivationTokenAsUsed(token);
            request.setAttribute("success", "Tài khoản đã được kích hoạt thành công!");
        } else {
            request.setAttribute("error", "Có lỗi xảy ra khi kích hoạt tài khoản");
        }

        request.getRequestDispatcher("activation_result.jsp").forward(request, response);
    }
}