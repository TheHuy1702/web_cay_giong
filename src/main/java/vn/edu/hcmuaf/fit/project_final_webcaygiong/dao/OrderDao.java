package vn.edu.hcmuaf.fit.project_final_webcaygiong.dao;

import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.db.JDBIConnect;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.Customer;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.Order;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.OrderItems;

import java.time.Instant;
import java.time.LocalDate;
import java.time.OffsetDateTime;
import java.time.ZoneOffset;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class OrderDao {
    List<Order> order;

    public OrderDao() {
        order = new ArrayList<>();
    }

    public List<Order> getAllOrderItems() {
        order = JDBIConnect.get().withHandle(handle ->
                handle.createQuery("select * from orders ")
                        .mapToBean(Order.class).list());
        return order;
    }

    // Lấy đơn hàng theo ID
    public Order getOrderById(int orderId) {
        return JDBIConnect.get().withHandle(handle ->
                handle.createQuery("SELECT * FROM orders WHERE orderId = ?")
                        .bind(0, orderId)
                        .mapToBean(Order.class)
                        .one());
    }


    // thêm.
    public int insertOrder(Order order) {
        return JDBIConnect.get().withHandle(handle -> {
            String sql = "INSERT INTO orders (customerId, userId, orderDate, totalAmount, status, shippingFee) VALUES (?, ?, ?, ?, ?, ?)";
            return handle.createUpdate(sql)
                    .bind(0, order.getCustomerId())
                    .bind(1, order.getUserId())
                    .bind(2, order.getOrderDate())
                    .bind(3, order.getTotalAMount())
                    .bind(4, order.getStatus())
                    .bind(5, order.getShippingFee())
                    .executeAndReturnGeneratedKeys("orderId") // Lấy ID vừa tạo
                    .mapTo(Integer.class)
                    .one();
        });
    }

    //  cập nhật kho
    public void updateProductStock(int productId, int quantity) {
        JDBIConnect.get().withHandle(handle ->
                handle.createUpdate("UPDATE products SET stock = stock - ? WHERE productID = ?")
                        .bind(0, quantity)
                        .bind(1, productId)
                        .execute());
    }

    // lay ct don hang theo oid.
    public List<OrderItems> getOrderItemsByOrderId(int orderId) {
        return JDBIConnect.get().withHandle(handle ->
                handle.createQuery("SELECT * FROM orderitems WHERE orderID = ?")
                        .bind(0, orderId)
                        .mapToBean(OrderItems.class)
                        .list());
    }

    public List<Map<String, Object>> getOrderItemsByOrderID(int orderId) {
        String query = "SELECT oi.*, p.name AS productName, p.price AS productPrice ,p.imageMain as image " +
                "FROM orderitems oi " +
                "JOIN products p ON oi.productID = p.productID " +
                "WHERE oi.orderID = ?";

        return JDBIConnect.get().withHandle(handle ->
                handle.createQuery(query)
                        .bind(0, orderId)
                        .map((rs, ctx) -> {
                            Map<String, Object> itemDetail = new HashMap<>();
                            itemDetail.put("orderID", rs.getInt("orderID"));
                            itemDetail.put("itemID", rs.getInt("itemID"));
                            itemDetail.put("image", rs.getString("image"));
                            itemDetail.put("productID", rs.getInt("productID"));
                            itemDetail.put("quantity", rs.getInt("quantity"));
                            itemDetail.put("price", rs.getDouble("productPrice"));
                            itemDetail.put("productName", rs.getString("productName"));
                            return itemDetail;
                        })
                        .list());
    }

    // lay thong tin khach hang theo id.
    public Customer getCustomerById(int customerId) {
        return JDBIConnect.get().withHandle(handle ->
                handle.createQuery("SELECT * FROM customers WHERE customerID = ?")
                        .bind(0, customerId)
                        .mapToBean(Customer.class)
                        .one());
    }

    // cập nhật trạng thái đơn hàng.
    public void updateOrderStatus(int orderId, String newStatus) {
        JDBIConnect.get().withHandle(handle ->
                handle.createUpdate("UPDATE orders SET status = ? WHERE orderId =?")
                        .bind(0, newStatus)
                        .bind(1, orderId)
                        .execute());
    }
    // cập nhật trạng thái đơn hàng là đã hủy.
    public void updateOrderStatusCancel(int orderId, String actionBy) {
        JDBIConnect.get().withHandle(handle ->
                handle.createUpdate("UPDATE orders SET status = 'Đã hủy', cancelBy = ?, cancelAt = current_timestamp() WHERE orderId =?")
                        .bind(0, actionBy)
                        .bind(1, orderId)
                        .execute());
    }

    public void updateOrderTggh(int orderId, String tg) {
        OffsetDateTime odt = OffsetDateTime.parse(tg, DateTimeFormatter.ISO_OFFSET_DATE_TIME);
        String mysqlDateTime = odt.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        JDBIConnect.get().withHandle(handle ->
                handle.createUpdate("UPDATE orders SET expectedDeliveryTime = ? WHERE orderId =?")
                        .bind(0, mysqlDateTime)
                        .bind(1, orderId)
                        .execute());
    }

    public String getDatePrepare(int orderId) {
        String sql = "SELECT DATE(orderDate) FROM orders WHERE orderId = ?";

        String dateString = JDBIConnect.get().withHandle(handle ->
                handle.createQuery(sql)
                        .bind(0, orderId)
                        .mapTo(String.class)
                        .findOnly()
        );

        // Chuyển đổi chuỗi ngày thành LocalDate
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate date = LocalDate.parse(dateString, formatter);

        // Cộng thêm 2 ngày
        LocalDate newDate = date.plusDays(2);

        // Trả về ngày mới dưới dạng chuỗi
        return newDate.format(formatter);
    }


    public static void main(String[] args) {
        OrderDao orderDao = new OrderDao();
//        List<Order> orders = orderDao.getAllOrderItems();
//        for (Order order : orders) {
//            System.out.println(order);
//        }
//        List<OrderItems> orderItems = orderDao.getOrderItemsByOrderId(3);
//        for (OrderItems item : orderItems) {
//            System.out.println(item);
//        }
//        Customer customer = orderDao.getCustomerById(2);
//        System.out.println(customer);
//        List<Map<String, Object>> orders2 = orderDao.getOrderItemsByOrderID(1);
//        if (orders.isEmpty()) {
//            System.out.println("Không có đơn hàng nào.");
//        } else {
//            System.out.println("Danh sách đơn hàng:");
//            for (Map<String, Object> order : orders2) {
//                System.out.println("Order ID: " + order.get("orderID"));
//                System.out.println("itemID: " + order.get("itemID"));
//                System.out.println("price: " + order.get("price"));
//                System.out.println("Product Name: " + order.get("productName"));
//                System.out.println("productName: " + order.get("productID"));
//                System.out.println("productName: " + order.get("quantity"));
//                System.out.println("image: " + order.get("image"));
//                System.out.println("-----------------------------------");
//            }
//        }
//        orderDao.updateOrderTggh(26, "2025-05-05T16:59:59Z");
        System.out.println(orderDao.getDatePrepare(1));
    }
}
