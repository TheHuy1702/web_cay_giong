package vn.edu.hcmuaf.fit.project_final_webcaygiong.dao;

import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.db.JDBIConnect;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.Customer;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.Order;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.OrderItems;

import java.util.ArrayList;
import java.util.List;

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


    public static void main(String[] args) {
        OrderDao orderDao = new OrderDao();
        List<Order> orders = orderDao.getAllOrderItems();
        for (Order order : orders) {
            System.out.println(order);
        }
        List<OrderItems> orderItems = orderDao.getOrderItemsByOrderId(3);
        for (OrderItems item : orderItems) {
            System.out.println(item);
        }
        Customer customer = orderDao.getCustomerById(2);
        System.out.println(customer);
    }
}
