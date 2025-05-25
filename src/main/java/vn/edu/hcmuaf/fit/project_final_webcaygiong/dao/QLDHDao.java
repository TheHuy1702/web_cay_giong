package vn.edu.hcmuaf.fit.project_final_webcaygiong.dao;

import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.db.JDBIConnect;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.Order;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.Product;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.User;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class QLDHDao {
    List<Product> products;
    List<Order> orders;
    List<User> users;

    public QLDHDao() {
        products = new ArrayList<>();
        orders = new ArrayList<>();
        users = new ArrayList<>();

    }

    public List<Map<String, Object>> dsOrder(String sortBy) {
        String query = " SELECT DISTINCT  o.orderID, o.customerID, o.userID, o.orderDate, c.nameCustomer, c.phone as cusPhone, p.name as productName,o.totalAmount, o.status FROM orders o JOIN customers c ON o.customerID = c.customerID JOIN orderitems oi ON o.orderID = oi.orderID JOIN products p ON oi.productID = p.productID GROUP BY o.orderID  ORDER BY o.orderDate " + (sortBy.equals("desc") ? "DESC" : "ASC");
        return JDBIConnect.get().withHandle(handle ->
                handle.createQuery(query)
                        .map((rs, ctx) -> {
                            Map<String, Object> result = new HashMap<>();
                            result.put("orderID", rs.getInt("orderID"));
                            result.put("customerID", rs.getInt("customerID"));
                            result.put("userID", rs.getInt("userID"));
                            result.put("orderDate", rs.getDate("orderDate"));
                            result.put("nameCustomer", rs.getString("nameCustomer"));
                            result.put("phone", rs.getString("cusPhone"));
                            result.put("name", rs.getString("productName"));
                            result.put("totalAmount", rs.getDouble("totalAmount"));
                            result.put("status", rs.getString("status"));
                            return result;
                        })
                        .list());
    }

    // Hàm lấy ra danh sách đơn hàng theo trạng thái của khách hàng.
    public List<Map<String, Object>> dsOrderWithStatusOfCus(String status, int cusID) {
        String query = " SELECT DISTINCT  o.orderID,p.productID, p.imageMain,  o.customerID, o.userID, o.orderDate, c.nameCustomer, c.phone as cusPhone, p.name as productName,o.totalAmount, o.status, o.expectedDeliveryTime FROM orders o JOIN customers c ON o.customerID = c.customerID JOIN orderitems oi ON o.orderID = oi.orderID JOIN products p ON oi.productID = p.productID WHERE o.status = ? AND o.customerID = ? GROUP BY o.orderID  ORDER BY o.orderDate DESC";
        return JDBIConnect.get().withHandle(handle ->
                handle.createQuery(query)
                        .bind(0, status)
                        .bind(1, cusID)
                        .map((rs, ctx) -> {
                            Map<String, Object> result = new HashMap<>();
                            result.put("orderID", rs.getInt("orderID"));
                            result.put("productID", rs.getInt("productID"));
                            result.put("imageMain", rs.getString("imageMain"));
                            result.put("customerID", rs.getInt("customerID"));
                            result.put("userID", rs.getInt("userID"));
                            result.put("orderDate", rs.getDate("orderDate"));
                            result.put("nameCustomer", rs.getString("nameCustomer"));
                            result.put("phone", rs.getString("cusPhone"));
                            result.put("name", rs.getString("productName"));
                            result.put("totalAmount", rs.getDouble("totalAmount"));
                            result.put("status", rs.getString("status"));
                            result.put("expectedDeliveryTime", rs.getString("expectedDeliveryTime"));
                            return result;
                        })
                        .list());
    }

    // Hàm lấy ra danh sách đơn hàng của khách hàng.
    public List<Map<String, Object>> dsOrderOfCus(int cusID) {
        String query = " SELECT DISTINCT  o.orderID, p.productID, p.imageMain, o.customerID, o.userID, o.orderDate, c.nameCustomer, c.phone as cusPhone, p.name as productName,o.totalAmount, o.status FROM orders o JOIN customers c ON o.customerID = c.customerID JOIN orderitems oi ON o.orderID = oi.orderID JOIN products p ON oi.productID = p.productID WHERE o.customerID = ? GROUP BY o.orderID  ORDER BY o.orderDate DESC";
        return JDBIConnect.get().withHandle(handle ->
                handle.createQuery(query)
                        .bind(0, cusID)
                        .map((rs, ctx) -> {
                            Map<String, Object> result = new HashMap<>();
                            result.put("orderID", rs.getInt("orderID"));
                            result.put("productID", rs.getInt("productID"));
                            result.put("imageMain", rs.getString("imageMain"));
                            result.put("customerID", rs.getInt("customerID"));
                            result.put("userID", rs.getInt("userID"));
                            result.put("orderDate", rs.getDate("orderDate"));
                            result.put("nameCustomer", rs.getString("nameCustomer"));
                            result.put("phone", rs.getString("cusPhone"));
                            result.put("name", rs.getString("productName"));
                            result.put("totalAmount", rs.getDouble("totalAmount"));
                            result.put("status", rs.getString("status"));
                            return result;
                        })
                        .list());
    }

    public int soluongDHTheoTrangThai(String status, int cus) {
        if (status.equals("all")) {
            return JDBIConnect.get().withHandle(handle ->
                    handle.createQuery("select count(orderID) from orders where customerID = ?")
                            .bind(0, cus)
                            .mapTo(Integer.class).findOne().orElse(0));
        } else {
            return JDBIConnect.get().withHandle(handle ->
                    handle.createQuery("select count(orderID) from orders where status = ? and customerID = ?")
                            .bind(0, status)
                            .bind(1, cus)
                            .mapTo(Integer.class).findOne().orElse(0));
        }
    }


    public Product getAllProduct() {
        return JDBIConnect.get().withHandle(handle ->
                handle.createQuery("select * from products where productID = (select productID from orderitems limit 1) ")
                        .mapToBean(Product.class).one());

    }

    // tìm kiếm
    public List<Map<String, Object>> searchOrders(String keyword) {
        String query = "SELECT DISTINCT o.orderID,o.customerID, o.userID, o.orderDate, c.nameCustomer as customerName, c.phone as cusPhone, p.name as productName, o.totalAmount, o.status " +
                "FROM orders o " +
                "JOIN customers c ON o.customerID = c.customerID " +
                "JOIN orderitems oi ON o.orderID = oi.orderID " +
                "JOIN products p ON oi.productID = p.productID " +
                "WHERE o.orderID LIKE ? OR c.phone LIKE ? GROUP BY o.orderID";
        return JDBIConnect.get().withHandle(handle ->
                handle.createQuery(query)
                        .bind(0, keyword)
                        .bind(1, keyword + "%")
                        .map((rs, ctx) -> {
                            Map<String, Object> result = new HashMap<>();
                            result.put("orderID", rs.getInt("orderID"));
                            result.put("customerID", rs.getInt("customerID"));
                            result.put("userID", rs.getInt("userID"));
                            result.put("orderDate", rs.getDate("orderDate"));
                            result.put("nameCustomer", rs.getString("customerName"));
                            result.put("phone", rs.getString("cusPhone"));
                            result.put("name", rs.getString("productName"));
                            result.put("totalAmount", rs.getDouble("totalAmount"));
                            result.put("status", rs.getString("status"));
                            return result;
                        })
                        .list()
        );
    }

    public Map<String, Object> getOrderDetailsById(String orderID) {
        String query = "SELECT o.orderID, o.orderDate, o.status, c.nameCustomer, c.phone, c.address, p.name as productName, oi.quantity, o.totalAmount " +
                "FROM orders o " +
                "JOIN customers c ON o.customerID = c.customerID " +
                "JOIN orderitems oi ON o.orderID = oi.orderID " +
                "JOIN products p ON oi.productID = p.productID " +
                "WHERE o.orderID = ?";
        return JDBIConnect.get().withHandle(handle ->
                handle.createQuery(query)
                        .bind(0, orderID)
                        .map((rs, ctx) -> {
                            Map<String, Object> result = new HashMap<>();
                            result.put("orderID", rs.getInt("orderID"));
                            result.put("orderDate", rs.getDate("orderDate").toString());
                            result.put("status", rs.getString("status"));
                            result.put("nameCustomer", rs.getString("nameCustomer"));
                            result.put("phone", rs.getString("phone"));
                            result.put("address", rs.getString("address"));
                            result.put("productName", rs.getString("productName"));
                            result.put("quantity", rs.getInt("quantity"));
                            result.put("totalAmount", rs.getDouble("totalAmount"));
                            return result;
                        })
                        .one()
        );
    }


    public static void main(String[] args) {
        QLDHDao dao = new QLDHDao();
        System.out.println(dao.soluongDHTheoTrangThai("all", 2));
        System.out.println(dao.dsOrderOfCus(2).size());
        for (Map<String, Object> order : dao.dsOrderOfCus(2)) {
            System.out.println("Order ID: " + order.get("orderID"));
            System.out.println("Product ID: " + order.get("productID"));
            System.out.println("Image Main: " + order.get("imageMain"));
            System.out.println("Customer ID: " + order.get("customerID"));
            System.out.println("User ID: " + order.get("userID"));
            System.out.println("Order Date: " + order.get("orderDate"));
            System.out.println("Customer Name: " + order.get("nameCustomer"));
            System.out.println("Phone: " + order.get("phone"));
            System.out.println("Product Name: " + order.get("name"));
            System.out.println("Total Amount: " + order.get("totalAmount"));
            System.out.println("Status: " + order.get("status"));
            System.out.println("--------------------------"); // Ngăn cách giữa các đơn hàng
        }
    }

}
