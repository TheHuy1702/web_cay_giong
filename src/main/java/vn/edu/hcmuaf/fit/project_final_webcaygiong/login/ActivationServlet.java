package vn.edu.hcmuaf.fit.project_final_webcaygiong.login;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.UserDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.ActivationToken;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.User;

import java.io.IOException;
import java.util.Date;

@WebServlet(name = "ActivationServlet", value = "/activate")
public class ActivationServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String token = request.getParameter("token");
        System.out.println("1234: "+token);

        if (token == null || token.isEmpty()) {
            request.setAttribute("error", "Mã kích hoạt không hợp lệ.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        UserDao userDao = new UserDao();

        User user = userDao.findUserByToken(token);
        if (user == null) {
            request.setAttribute("error", "Mã kích hoạt không hợp lệ hoặc đã hết hạn.");
        } else {
            boolean tokenValid = userDao.isTokenValid(token); // SỬA TỪ ĐÂY.

            if (!tokenValid) {
                request.setAttribute("error", "Mã kích hoạt đã hết hạn hoặc không hợp lệ.");
            } else {
                boolean activated = userDao.activateUserById(user.getUserID(), token);
                if (activated) {
                    userDao.markTokenAsUsed(token);
                    request.setAttribute("success", "Tài khoản của bạn đã được kích hoạt thành công. Vui lòng đăng nhập.");
                } else {
                    request.setAttribute("error", "Không thể kích hoạt tài khoản. Vui lòng thử lại.");
                }
            }
        }

        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
}
