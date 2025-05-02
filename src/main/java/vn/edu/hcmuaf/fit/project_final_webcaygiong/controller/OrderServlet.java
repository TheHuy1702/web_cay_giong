package vn.edu.hcmuaf.fit.project_final_webcaygiong.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import org.json.JSONArray;
import org.json.JSONObject;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.CustomerDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.OrderDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.OrderItemsDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.QLDHDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.cart.Cart;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.cart.CartProduct;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.Customer;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.Order;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.OrderItems;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.User;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.diaChi.GHNApiClient;

import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Map;

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
        try {
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
            JSONObject params = new JSONObject();
            params.put("payment_type_id", 2);
            // Thông tin người nhận.
            params.put("required_note", "KHONGCHOXEMHANG");
            params.put("to_name", customer.getNameCustomer());
            params.put("to_phone", customer.getPhone());
            params.put("to_address", customer.getAddress());
            String address = customer.getAddress();
            int lastCommaIndex = address.lastIndexOf(",");
            String wardName = address.substring(lastCommaIndex + 1).trim();
            params.put("to_ward_name", wardName);
            params.put("to_district_name", customer.getDistrict());
            params.put("to_province_name", customer.getCity());
            params.put("weight", 2000);
            params.put("service_type_id", 2);
            // Thêm thông tin hàng hóa
            JSONArray items = new JSONArray();
            for (CartProduct cartProduct : cart.getList()) { // Iterate through the order items
                JSONObject item = new JSONObject();
                item.put("name", cartProduct.getName()); // Thay bằng tên hàng hóa thực tế
                item.put("code", cartProduct.getProductID() + ""); // Mã hàng hóa
                item.put("quantity", cartProduct.getQuantity());
                items.put(item);
            }
            params.put("items", items);
            // Gọi API để tạo đơn hàng
            JSONObject result = GHNApiClient.callGHNApi("v2/shipping-order/create", "POST", params);
            String tgdk = result.getJSONObject("data").getString("expected_delivery_time");
            orderDao.updateOrderTggh(oID, tgdk);
            // Xóa giỏ hàng sau khi đặt hàng thành công
            session.removeAttribute("cart");
            // Chuyển hướng đến trang xác nhận đơn hàng
            response.sendRedirect("orderConfirmation?status=success");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}