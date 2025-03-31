package vn.edu.hcmuaf.fit.project_final_webcaygiong.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.CustomerDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.UserDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.Customer;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.User;

import java.io.IOException;
import java.util.Calendar;
import java.util.Date;

@WebServlet(name = "MyAccountServlet", value = "/taiKhoanCuaToi")
public class myAccountServlet extends HttpServlet {
    String emailDis;
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CustomerDao customerDao = new CustomerDao();
        String fullName = request.getParameter("name");

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        // Kiểm tra xem đã đăng nhập hay chưa
        if (user != null) {
            // Cập nhật địa chỉ cho khách hàng

                customerDao.updateInfoCustomer(user.getUserID(), fullName);


            response.sendRedirect("taiKhoanCuaToi?update=success");
        } else {
            response.sendRedirect("login");
        }

    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Customer customer;
        CustomerDao customerDao = new CustomerDao();
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user!= null) {
            customer = customerDao.getCustomerWithUID(user.getUserID());

//            System.out.println(customer.getCustomerID());
//            System.out.println(customer.getNameCustomer());
//            System.out.println(customer.getPhone());
//            System.out.println(customer.getGender());
            request.setAttribute("customer", customer);
//            String emailDis = user.getEmail();
            request.setAttribute("user", user);
//            System.out.println(emailDis);




            UserDao userDao=new UserDao();
            User user2=userDao.findUserID(user.getUserID());
            request.setAttribute("u",user2);


        }
        else {
            response.sendRedirect("login");
        }
        RequestDispatcher dispatcher = request.getRequestDispatcher("myAccount.jsp");
        dispatcher.forward(request, response);
    }
}
