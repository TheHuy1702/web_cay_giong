package vn.edu.hcmuaf.fit.project_final_webcaygiong.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.CustomerDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.UserDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.Customer;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.User;

import java.io.IOException;

@WebServlet(name = "myAddressServlet", value = "/diaChi")
public class myAddressServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Customer customer;
        CustomerDao customerDao = new CustomerDao();
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user!= null) {
            customer = customerDao.getCustomerWithUID(user.getUserID());
            System.out.println(customer);


            request.setAttribute("customer", customer);

            request.setAttribute("user", user);

        }
        else {
            response.sendRedirect("login");
        }
        RequestDispatcher dispatcher = request.getRequestDispatcher("myAddress.jsp");
        dispatcher.forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CustomerDao customerDao = new CustomerDao();
        Customer customer;
        String address = request.getParameter("address");
        String district = request.getParameter("districtName");
        String city = request.getParameter("provinceName");
        String ward = request.getParameter("wardName");


        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");


        if (user != null) {

            customer = customerDao.getCustomerWithUID(user.getUserID());
            System.out.println("bjvhv111g"+customer);

            if(customer == null){
                System.out.println("bjvhvg"+customer);

                customerDao.createAddress(user.getUserID(), address,district,city,ward);
                response.sendRedirect("diaChi?update=success");
            }else{

            // Cập nhật địa chỉ cho khách hàng
            customerDao.updateCustomerAddressForAccount(user.getUserID(), address + ", " + ward, district, city);
            }
        } else {
            response.sendRedirect("login");
        }

    }
}
