package vn.edu.hcmuaf.fit.project_final_webcaygiong.login;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.UserDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.User;

import java.io.IOException;
import java.util.Date;

@WebServlet(name = "FacebookLoginServlet", value = "/facebook_login")
public class FacebookLoginServlet extends HttpServlet {
        @Override
        protected void doGet(HttpServletRequest request, HttpServletResponse response)
                throws ServletException, IOException {
            String code = request.getParameter("code");

            if (code == null || code.isEmpty()) {
                response.sendRedirect("login");
                return;
            }

            try {
                FacebookLogin FB = new FacebookLogin();
                String accessToken = FB.getToken(code);
                User fbUser = FB.getUserInfo(accessToken);

                UserDao userDao = new UserDao();
                User existingUser = userDao.findByFacebookId(fbUser.getFacebookId());

                if (existingUser == null) {
                    // Kiểm tra email đã tồn tại chưa
                    if (fbUser.getEmail() != null) {
                        existingUser = userDao.findByEmail(fbUser.getEmail());
                        if (existingUser != null) {
                            // Cập nhật facebookId cho user đã tồn tại
                            userDao.updateFacebookId(existingUser.getUserID(), fbUser.getFacebookId());
                        }
                    }

                    if (existingUser == null) {
                        // Tạo user mới nếu không tìm thấy
                        userDao.insertFacebookUser(fbUser);
                        existingUser = userDao.findByFacebookId(fbUser.getFacebookId());
                    }
                }

                // Tạo session
                HttpSession session = request.getSession();
                session.setAttribute("user", existingUser);

                // Chuyển hướng về trang chủ
                response.sendRedirect("TrangChu");

            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("login?error=facebook_login_failed");
            }
        }
    }
