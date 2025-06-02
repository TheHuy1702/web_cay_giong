package vn.edu.hcmuaf.fit.project_final_webcaygiong.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.CustomerDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.UserDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.Customer;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.User;

import java.io.IOException;

@WebServlet(name = "UpdateEmailServlet", value = "/UpdateEmail")
public class UpdateEmailServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CustomerDao customerDao = new CustomerDao();
        String email = request.getParameter("nameEmail");

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        int userId = user.getUserID();
        Customer customer = customerDao.getCustomerWithUID(userId);

        if (customer == null) {
            customerDao.createCusEmail(userId, email);
        } else {
            customerDao.updateInfoCustomerEmail(userId, email);
        }

        // Update email trong session user nếu cần
        user.setEmail(email);
        session.setAttribute("user", user);

        // Kiểm tra quyền để điều hướng về đúng trang
        String type = request.getParameter("type");
        if ("admin".equals(type)) {
            response.sendRedirect("QuanLiTaiKhoanCuaToi?updateMail=success");
        } else {
            response.sendRedirect("taiKhoanCuaToi?updateMail=success");
        }
    }
}
