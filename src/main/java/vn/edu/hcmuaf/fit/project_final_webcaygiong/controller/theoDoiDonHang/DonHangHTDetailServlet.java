package vn.edu.hcmuaf.fit.project_final_webcaygiong.controller.theoDoiDonHang;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.CustomerDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.OrderDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.QLDHDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.Customer;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.Order;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.User;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet(name = "DonHangHTDetailServlet", value = "/DonHangHTDetail")
public class DonHangHTDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        double totalPrice=0;
        CustomerDao customerDao = new CustomerDao();
        OrderDao orderDao = new OrderDao();
        String oId = request.getParameter("oId");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        // Kiểm tra xem đã đăng nhập hay chưa.
        if (user != null) {
            int userID = user.getUserID();
            Customer customer = customerDao.getCustomerWithUID(userID);
            Order order=orderDao.getOrderById(Integer.parseInt(oId));
            List<Map<String, Object>> orderItems = orderDao.getOrderItemsByOrderID(Integer.parseInt(oId));
            for (Map<String, Object> item : orderItems) {
                totalPrice+=((double)item.get("price"))*((int)item.get("quantity"));
                System.out.println(totalPrice);
            }
            request.setAttribute("orderItems", orderItems);
            request.setAttribute("customer", customer);
            request.setAttribute("totalPrice",totalPrice);
            request.setAttribute("order",order);
            RequestDispatcher dispatcher = request.getRequestDispatcher("DonHangHoanThanhDetail.jsp");
            dispatcher.forward(request, response);
        } else {
            response.sendRedirect("login");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }
}