package vn.edu.hcmuaf.fit.project_final_webcaygiong.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.CustomerDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.Customer;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.User;

import java.io.IOException;

@WebServlet(name = "UpdateGenderServlet", value = "/UpdateGender")
public class UpdateGenderServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CustomerDao customerDao = new CustomerDao();
        Customer customer;

        String gender = request.getParameter("gender");

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        // Kiểm tra xem đã đăng nhập hay chưa
        if (user != null) {
            customer = customerDao.getCustomerWithUID(user.getUserID());
            System.out.println("bjvhv111g"+customer);

            if(customer == null){
                System.out.println("bjvhvg"+customer);

                customerDao.createCusGender(user.getUserID(), gender);
            }else{

            customerDao.updateInfoCustomerGender(user.getUserID(), gender);

            response.sendRedirect("taiKhoanCuaToi?updateGender=success");}
        } else {
            response.sendRedirect("login");
        }

    }
}
