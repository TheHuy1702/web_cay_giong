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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        HttpSession session = request.getSession();
//        User user = (User) session.getAttribute("user");
//        if (user!= null) {
//           int users = user.getUserID();
//            request.setAttribute("users", users);
//            String emailDis= user.getEmail();
//            request.setAttribute("emailDis", emailDis);
//            System.out.println("fyadwt27t3grwfvashjf:"+emailDis);
//        }
//        else {
//            response.sendRedirect("login");
//        }
//        String emailDis= "46874781246";
//            request.setAttribute("emailDis", emailDis);
//        System.out.println(emailDis);
//
////        UserDao userDao;
////        User user=userDao.findByUserID();
//        RequestDispatcher dispatcher = request.getRequestDispatcher("myAccount.jsp");
//        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CustomerDao customerDao = new CustomerDao();
        String email = request.getParameter("nameEmail");
        System.out.println("Email: " + email);
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        // Kiểm tra xem đã đăng nhập hay chưa
        if (user != null) {

                customerDao.updateInfoCustomerEmail(user.getUserID(), email);

                response.sendRedirect("taiKhoanCuaToi?updateMail=success");
        } else {
            response.sendRedirect("login");
        }

    }
    }

