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
import java.util.List;
import java.util.Map;

@WebServlet(name = "DonHangDaHuyServlet", value = "/DonHangDaHuy")
public class DonHangDaHuyServlet extends HttpServlet {

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
            if (status != null && status.equals("Đã hủy")) {
                orders = dao.dsOrderWithStatusOfCus(status, customer.getCustomerID());
                // Lấy danh sách OrderItems cho từng đơn hàng.
                OrderDao orderDao = new OrderDao();
                for (Map<String, Object> order : orders) {
                    int orderId = (int) order.get("orderID");
                    List<Map<String, Object>> orderItems = orderDao.getOrderItemsByOrderID(orderId);
                    order.put("orderItems", orderItems); // Thêm danh sách OrderItems vào từng đơn hàng
                }
                int slAll = dao.soluongDHTheoTrangThai("all", customer.getCustomerID());
                int slChoXN = dao.soluongDHTheoTrangThai("Chờ xác nhận", customer.getCustomerID());
                int slChoGH = dao.soluongDHTheoTrangThai("Đã xác nhận", customer.getCustomerID());
                int slDaGiao = dao.soluongDHTheoTrangThai("Đã giao", customer.getCustomerID());

                request.setAttribute("orders", orders);
                request.setAttribute("slDH", orders.size());
                request.setAttribute("slAll", slAll);
                request.setAttribute("slChoXN", slChoXN);
                request.setAttribute("slChoGH", slChoGH);
                request.setAttribute("slDaGiao", slDaGiao);
            }
            RequestDispatcher dispatcher = request.getRequestDispatcher("DonHangDaHuy.jsp");
            dispatcher.forward(request, response);
        } else {
            response.sendRedirect("login");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }
}