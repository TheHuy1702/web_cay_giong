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
        private UserDao userDao = new UserDao();

        @Override
        protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String facebookId = request.getParameter("facebookId");

            // Check if user exists by facebookId
            User user = userDao.findByFacebookId(facebookId);

            if (user == null) {
                // Check if email exists (for users who might have registered with email)
                if (email != null && !email.isEmpty()) {
                    user = userDao.emailExists(email);
                    if (user != null) {
                        // Update existing user with facebookId
                        user.setFacebookId(facebookId);
                        userDao.updateFacebookId(user.getUserID(), facebookId);
                    }
                }

                if (user == null) {
                    // Create new user
                    user = new User();
                    user.setName(name);
                    user.setEmail(email);
                    user.setFacebookId(facebookId);
                    user.setCreateAt(new Date());
                    user.setUpdateAt(new Date());

                    userDao.insertFacebookUser(user);

                    // Get the newly created user
                    user = userDao.findByFacebookId(facebookId);
                }
            }

            // Store user in session
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            // Redirect to home page or previous page
            response.sendRedirect("TrangChu");
        }
    }