package vn.edu.hcmuaf.fit.project_final_webcaygiong.controller.payment;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.CustomerDao;
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
        String fullName = request.getParameter("fullName");
        String phoneNumber = request.getParameter("phoneNumber");
        String address = request.getParameter("address");
        String district = request.getParameter("districtName");
        String city = request.getParameter("provinceName");
        String ward = request.getParameter("wardName");
        int districtId = Integer.parseInt(request.getParameter("districtId"));
        String wardCode = request.getParameter("wardCode");

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");


        if (user != null) {
            // Cập nhật địa chỉ cho khách hàng
            customerDao.updateCustomerAddress(user.getUserID(), fullName, phoneNumber, address + ", " + ward, district, city,districtId,wardCode);
            response.sendRedirect("thanhtoan?update=thanhcong");
        } else {
            response.sendRedirect("login");
        }

    }
}