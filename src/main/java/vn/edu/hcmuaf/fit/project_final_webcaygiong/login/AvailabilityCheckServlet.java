package vn.edu.hcmuaf.fit.project_final_webcaygiong.login;

import com.google.gson.Gson;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.UserDao;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "AvailabilityCheckServlet", value = "/AvailabilityCheckServlet")
public class AvailabilityCheckServlet extends HttpServlet {
        private final UserDao userDao = new UserDao();
        private final Gson gson = new Gson();

        @Override
        protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");

            String type = request.getParameter("type");
            String value = request.getParameter("value");
            boolean available = true;

            if ("phone".equals(type)) {
                available = (userDao.findByPhone(value) == null);
            } else if ("email".equals(type)) {
                available = (userDao.emailExists(value) == null);
            }

            PrintWriter out = response.getWriter();
            out.print(gson.toJson(new AvailabilityResponse(available)));
            out.flush();
        }

        private static class AvailabilityResponse {
            private final boolean available;

            public AvailabilityResponse(boolean available) {
                this.available = available;
            }

            public boolean isAvailable() {
                return available;
            }
        }
    }