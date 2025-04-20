package vn.edu.hcmuaf.fit.project_final_webcaygiong.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.CustomerDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.Customer;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.User;

import java.io.IOException;

@WebServlet(name = "UpdatePhoneServlet", value = "/UpdatePhone")
public class UpdatePhoneServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CustomerDao customerDao = new CustomerDao();
        Customer customer;
        String phone = request.getParameter("phone");
        System.out.println("Phone: " + phone);
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        // Kiểm tra xem đã đăng nhập hay chưa
        if (user != null) {
            customer = customerDao.getCustomerWithUID(user.getUserID());
            System.out.println("bjvhv111g"+customer);

            if(customer == null){
                System.out.println("bjvhvg"+customer);

                customerDao.createCusPhone(user.getUserID(), phone);
            }else{

            customerDao.updateInfoCustomerPhone(user.getUserID(), phone);

            response.sendRedirect("taiKhoanCuaToi?updatePhone=success");}
        } else {
            response.sendRedirect("login");
        }
    }
}
