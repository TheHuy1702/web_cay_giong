package vn.edu.hcmuaf.fit.project_final_webcaygiong.controller.theoDoiDonHang;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.CustomerDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.OrderDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.QLDHDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.Customer;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.User;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.Map;

@WebServlet(name = "ChoXacNhanDonHangServlet", value = "/ChoXacNhanDonHang")
public class ChoXacNhanDonHangServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        QLDHDao dao = new QLDHDao();
        CustomerDao customerDao = new CustomerDao();
        List<Map<String, Object>> orders;
        String status = request.getParameter("status");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        // Kiểm tra xem đã đăng nhập hay chưa.
        if (user != null) {
            int userID = user.getUserID();
            Customer customer = customerDao.getCustomerWithUID(userID);
            if (status != null && status.equals("Chờ xác nhận")) {
                orders = dao.dsOrderWithStatusOfCus(status, customer.getCustomerID());
                // Lấy danh sách OrderItems cho từng đơn hàng.
                OrderDao orderDao = new OrderDao();
                for (Map<String, Object> order : orders) {
                    int orderId = (int) order.get("orderID");
                    List<Map<String, Object>> orderItems = orderDao.getOrderItemsByOrderID(orderId);
                    order.put("orderItems", orderItems); // Thêm danh sách OrderItems vào từng đơn hàng
                    String ngay = orderDao.getDatePrepare(orderId);
                    order.put("ngay",ngay);
                }
                int slHuy = dao.soluongDHTheoTrangThai("Đã hủy", customer.getCustomerID());
                int slAll = dao.soluongDHTheoTrangThai("all", customer.getCustomerID());
                int slChoGH = dao.soluongDHTheoTrangThai("Đã xác nhận", customer.getCustomerID());
                int slDaGiao = dao.soluongDHTheoTrangThai("Đã giao", customer.getCustomerID());

                request.setAttribute("slHuy", slHuy);
                request.setAttribute("slAll", slAll);
                request.setAttribute("slChoGH", slChoGH);
                request.setAttribute("slDaGiao", slDaGiao);
                request.setAttribute("orders", orders);
                request.setAttribute("slDH", orders.size());
            }
            RequestDispatcher dispatcher = request.getRequestDispatcher("ChoXacNhanDonHang.jsp");
            dispatcher.forward(request, response);
        } else {
            response.sendRedirect("login");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        OrderDao orderDao = new OrderDao();
        String sorderID = request.getParameter("orderID");
        int orderID = Integer.parseInt(sorderID);
        String actionBy = request.getParameter("actionBy");
        System.out.println(actionBy);
        String action = request.getParameter("action");
        String status = URLEncoder.encode("Chờ xác nhận", StandardCharsets.UTF_8.toString());
        String update;
        if (action.equals("huyDon")) {
            orderDao.updateOrderStatusCancel(orderID, actionBy);
            update = URLEncoder.encode("daHuy", StandardCharsets.UTF_8.toString());
            response.sendRedirect("ChoXacNhanDonHang?status=" + status + "&update=" + update);
        } else {
            update = URLEncoder.encode("thatbai", StandardCharsets.UTF_8.toString());
            response.sendRedirect("ChoXacNhanDonHang?status=" + status + "&update=" + update);
        }
    }
}