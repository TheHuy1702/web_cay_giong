package vn.edu.hcmuaf.fit.project_final_webcaygiong.controller.payment;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.CustomerDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.Customer;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.User;

import java.io.IOException;

@WebServlet(name = "UpdateAddressServlet", value = "/UpdateAddress")
public class UpdateAddressServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CustomerDao customerDao = new CustomerDao();
        String fullName = request.getParameter("fullname");
        String phoneNumber = request.getParameter("phonenumber");
        String address = request.getParameter("address");
        String email = request.getParameter("email");
        String district = request.getParameter("district");
        String city = request.getParameter("city");

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");


        if (user != null) {

            // Cập nhật địa chỉ cho khách hàng
            customerDao.updateCustomerAddress(user.getUserID(), fullName, phoneNumber, address, district, city);
            response.sendRedirect("thanhtoan?update=success");
        } else {
            response.sendRedirect("login");
        }

    }
}