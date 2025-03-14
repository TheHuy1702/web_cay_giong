package vn.edu.hcmuaf.fit.project_final_webcaygiong.dao;

import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.db.JDBIConnect;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.OrderItems;

import java.util.ArrayList;
import java.util.List;

public class OrderItemsDao {
    List<OrderItems> orderItems;

    public OrderItemsDao() {
        orderItems = new ArrayList<>();
    }

    public List<OrderItems> getAllOrderItems() {
        orderItems = JDBIConnect.get().withHandle(handle ->
                handle.createQuery("select * from orderitems ")
                        .mapToBean(OrderItems.class).list());
        return orderItems;
    }

    public void insertOrderItem(OrderItems orderItem, int orderId) {
        JDBIConnect.get().useHandle(handle -> {
            String sql = "INSERT INTO orderitems (productID, quantity, orderID) VALUES (?, ?, ?)";
            handle.createUpdate(sql)
                    .bind(0, orderItem.getProductID())
                    .bind(1, orderItem.getQuantity())
                    .bind(2, orderId)
                    .execute();
        });
    }


    public static void main(String[] args) {
        OrderItemsDao orderItemsDao = new OrderItemsDao();
        List<OrderItems> orderItems = orderItemsDao.getAllOrderItems();
        for (OrderItems item : orderItems) {
            System.out.println(item);
        }
    }
}
