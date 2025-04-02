package vn.edu.hcmuaf.fit.project_final_webcaygiong.login;

import com.google.api.client.googleapis.auth.oauth2.GoogleAuthorizationCodeTokenRequest;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.google.api.client.googleapis.auth.oauth2.GoogleTokenResponse;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.gson.GsonFactory;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.UserDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.User;

import java.io.IOException;
import java.util.Collections;
import java.util.Date;

@WebServlet(name = "googleLoginServlet", value = "/google-login")
public class GoogleLoginServlet extends HttpServlet {
    private static final String CLIENT_ID = "579929879000-f6b0veahlid3g4d5n4imdj9q0f6i8s13.apps.googleusercontent.com";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String credential = request.getParameter("credential");

        try {
            GoogleIdTokenVerifier verifier = new GoogleIdTokenVerifier.Builder(
                    new NetHttpTransport(),
                    new GsonFactory())
                    .setAudience(Collections.singletonList(CLIENT_ID))
                    .build();

            GoogleIdToken idToken = verifier.verify(credential);
            if (idToken != null) {
                GoogleIdToken.Payload payload = idToken.getPayload();

                String email = payload.getEmail();
                String name = (String) payload.get("name");
                String googleId = payload.getSubject();

                UserDao userDao = new UserDao();
                User user = userDao.findByEmail(email);

                if (user == null) {
                    user = new User();
                    user.setName(name);
                    user.setEmail(email);
                    user.setGoogleId(googleId);
                    user.setCreateAt(new Date());
                    user.setUpdateAt(new Date());

                    userDao.insertGoogleUser(user);
                    user = userDao.findByEmail(email);
                }

                HttpSession session = request.getSession();
                session.setAttribute("user", user);

                // Chuyển hướng về TrangChu sau khi đăng nhập thành công
                response.sendRedirect(request.getContextPath() + "/TrangChu");
                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Nếu có lỗi, chuyển hướng về trang login với thông báo lỗi
        response.sendRedirect(request.getContextPath() + "/login?error=google_login_failed");
    }
}