package vn.edu.hcmuaf.fit.project_final_webcaygiong.controller.payment;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.CustomerDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.Customer;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.User;

import java.io.IOException;

@WebServlet(name = "thanhtoanServlet", value = "/thanhtoan")
public class thanhtoanServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy thông tin dia chi.
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user != null) {
            CustomerDao customerDao = new CustomerDao();
            Customer customer = customerDao.getCustomerWithUID(user.getUserID());
            // Kiểm tra giá trị của các biến.
            request.setAttribute("customer", customer);
            // Hiện thị phí ship.
            String serviceFeeParam = request.getParameter("serviceFee");
            Integer serviceFee = serviceFeeParam != null ? Integer.parseInt(serviceFeeParam) : 0;
            request.setAttribute("serviceFee", serviceFee);

        }
        RequestDispatcher dispatcher = request.getRequestDispatcher("thanhtoan.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }
}