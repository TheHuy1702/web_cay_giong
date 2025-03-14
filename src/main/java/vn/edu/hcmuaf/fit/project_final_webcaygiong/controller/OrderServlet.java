package vn.edu.hcmuaf.fit.project_final_webcaygiong.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.CustomerDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.OrderDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.OrderItemsDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.cart.Cart;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.cart.CartProduct;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.Customer;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.Order;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.OrderItems;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.User;

import java.io.IOException;
import java.util.Date;

@WebServlet(name = "OrderServlet", value = "/Order")
public class OrderServlet extends HttpServlet {
    private OrderDao orderDao = new OrderDao();
    private OrderItemsDao orderItemsDao = new OrderItemsDao();
    private Order order = new Order();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy thông tin từ request
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login"); // Chuyển hướng đến trang đăng nhập nếu chưa đăng nhập
            return;
        }
        CustomerDao customerDao = new CustomerDao();
        Customer customer = customerDao.getCustomerWithUID(user.getUserID());
        // Tạo đơn hàng mới
        order.setCustomerId(customer.getCustomerID());
        order.setUserId(user.getUserID());
        order.setOrderDate(new Date());
        order.setTotalAMount(cart.getTotal());
        order.setStatus("Chờ xác nhận");
        order.setShippingFee(15000);
        order.setCreateAt(new Date());

        // Lưu đơn hàng vào cơ sở dữ liệu
        int oID = orderDao.insertOrder(order);
        // Lưu chi tiết đơn hàng
        for (CartProduct cartProduct : cart.getList()) {
            OrderItems orderItem = new OrderItems();
            orderItem.setProductID(cartProduct.getProductID());
            orderItem.setQuantity(cartProduct.getQuantity());
            orderItemsDao.insertOrderItem(orderItem, oID);
            // Cập nhật số lượng sản phẩm trong kho
            orderDao.updateProductStock(cartProduct.getProductID(), cartProduct.getQuantity());
        }

        // Xóa giỏ hàng sau khi đặt hàng thành công
        session.removeAttribute("cart");
        // Chuyển hướng đến trang xác nhận đơn hàng
        response.sendRedirect("orderConfirmation?status=success");
    }
}