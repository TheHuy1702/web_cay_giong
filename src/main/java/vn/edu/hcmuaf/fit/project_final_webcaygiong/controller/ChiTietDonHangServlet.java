package vn.edu.hcmuaf.fit.project_final_webcaygiong.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.OrderDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.ProductDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.QLDHDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.Customer;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.Order;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.OrderItems;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.Product;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet(name = "ChiTietDonHangServlet", value = "/ChiTietDonHang")
public class ChiTietDonHangServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy orderId từ tham số yêu cầu
        String orderId = request.getParameter("orderID");
        // Tổng số lượng sản phẩm.
        int totalQuantity=0;

        // Tạo đối tượng DAO để truy xuất thông tin đơn hàng
        OrderDao orderDao = new OrderDao();
        Order order = orderDao.getOrderById(Integer.parseInt(orderId));
        List<OrderItems> orderItems = orderDao.getOrderItemsByOrderId(Integer.parseInt(orderId));
        for(OrderItems oi: orderItems){
            totalQuantity+=oi.getQuantity();
        }
        Customer customer = orderDao.getCustomerById(order.getCustomerId());

        ProductDao productDao = new ProductDao();
        List<Product> product = productDao.getAllProducts();

        // Đặt thông tin vào request
        request.setAttribute("products", product);
        request.setAttribute("order", order);
        request.setAttribute("orderItems", orderItems);
        request.setAttribute("customer", customer);
        request.setAttribute("totalQuantity", totalQuantity);

        // Chuyển tiếp đến trang chi tiết đơn hàng
        request.getRequestDispatcher("ChiTietDonHang.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }
}
