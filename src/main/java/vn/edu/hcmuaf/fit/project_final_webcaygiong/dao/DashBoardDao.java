package vn.edu.hcmuaf.fit.project_final_webcaygiong.dao;

import org.jdbi.v3.core.mapper.reflect.BeanMapper;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.db.JDBIConnect;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.Order;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.Product;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.Week;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DashBoardDao {
    List<Product> products;
    List<Order> orders;

    public DashBoardDao() {
        products = new ArrayList<>();
        orders = new ArrayList<>();
    }

    public int getSLProducts() {
        return JDBIConnect.get().withHandle(handle ->
                handle.createQuery("SELECT count(*) FROM products")
                        .mapTo(Integer.class).one());
    }

    public int getSLOrders() {
        return JDBIConnect.get().withHandle(handle ->
                handle.createQuery("SELECT COUNT(*) AS count_order FROM orders WHERE MONTH(orderDate) = MONTH(CURRENT_DATE)  AND  YEAR(orderDate) = YEAR(CURRENT_DATE) ")
                        .mapTo(Integer.class)
                        .one());
    }

    public int getNewOrders() {
        return JDBIConnect.get().withHandle(handle ->
                handle.createQuery("SELECT COUNT(*) AS new_orders FROM orders WHERE status = 'Chờ xác nhận' and orderDate >= NOW() - INTERVAL 1   DAY")
                        .mapTo(Integer.class)
                        .one());
    }

    public int getSLUsers() {
        return JDBIConnect.get().withHandle(handle ->
                handle.createQuery("SELECT COUNT(*) AS count_customer FROM users WHERE MONTH(createAt) = MONTH(CURRENT_DATE) AND YEAR(createAt) = YEAR(CURRENT_DATE)")
                        .mapTo(Integer.class)
                        .one());
    }

    public double getRevenue() {
        return JDBIConnect.get().withHandle(handle ->
                handle.createQuery("SELECT SUM(totalAmount) AS total_revenue FROM orders WHERE MONTH(orderDate) = MONTH(CURRENT_DATE) AND YEAR(orderDate) = YEAR(CURRENT_DATE) and status ='Đã xác nhận'")
                        .mapTo(Double.class)
                        .findOne()
                        .orElse(0.0));// trả về 0.0 nếu không tìm thấy.
    }

    public String getProductBestSelling() {
        return JDBIConnect.get().withHandle(handle ->
                handle.createQuery("SELECT name, SUM(oi.quantity * p.price) AS total_quantity FROM products p JOIN orderitems oi ON p.productID = oi.productID JOIN orders o ON oi.orderID = o.orderID GROUP BY p.productID,p.name ORDER BY total_quantity DESC LIMIT 1")
                        .mapTo(String.class)
                        .one());
    }

    public List<Integer> getWeeklyRevenue() {
        return JDBIConnect.get().withHandle(handle ->
                handle.createQuery(
                                "WITH RECURSIVE temp_weeks AS (" +
                                        "    WITH first_monday AS (" +
                                        "        SELECT DATE_ADD(" +
                                        "            DATE_SUB(DATE(CONCAT(YEAR(CURDATE()), '-', MONTH(CURDATE()), '-01')), " +
                                        "            INTERVAL DAYOFWEEK(DATE(CONCAT(YEAR(CURDATE()), '-', MONTH(CURDATE()), '-01'))) - 2 DAY), " +
                                        "            INTERVAL IF(DAYOFWEEK(DATE(CONCAT(YEAR(CURDATE()), '-', MONTH(CURDATE()), '-01'))) = 1, 7, 0) DAY" +
                                        "        ) AS start_of_week" +
                                        "    )" +
                                        "    SELECT 1 AS week_number, start_of_week AS week_start, " +
                                        "    DATE_ADD(start_of_week, INTERVAL 6 DAY) AS week_end " +
                                        "    FROM first_monday " +
                                        "    UNION ALL " +
                                        "    SELECT week_number + 1, DATE_ADD(week_start, INTERVAL 7 DAY), DATE_ADD(week_end, INTERVAL 7 DAY) " +
                                        "    FROM temp_weeks " +
                                        "    WHERE week_number < 4" +
                                        ")" +
                                        "SELECT " +
                                        "    w.week_number, " +
                                        "    w.week_start, " +
                                        "    w.week_end, " +
                                        "    COALESCE(SUM(o.totalAmount), 0) AS weekly_revenue " +
                                        "FROM temp_weeks w " +
                                        "LEFT JOIN orders o ON  o.orderDate BETWEEN w.week_start AND w.week_end and o.status='Đã xác nhận'" +
                                        "GROUP BY w.week_number, w.week_start, w.week_end " +
                                        "ORDER BY w.week_number;"
                        ).map((rs, ctx) -> rs.getInt("weekly_revenue"))
                        .list()
        );
    }

    public Map<String, Integer> getProductSalesData() {
        return JDBIConnect.get().withHandle(handle ->
                handle.createQuery(
                        "SELECT c.nameCategory AS category, COUNT(oi.quantity) AS sales_count " +
                                "FROM orderitems oi " +
                                "JOIN products p ON oi.productID = p.productID " +
                                "JOIN categories c ON p.categoryID = c.categoryID " +
                                "GROUP BY c.nameCategory"
                ).map((rs, ctx) -> {
                    Map<String, Integer> salesData = new HashMap<>();
                    do {
                        salesData.put(rs.getString("category"), rs.getInt("sales_count"));
                    } while (rs.next());
                    return salesData;
                }).one()
        );
    }

    public List<Week> test() {
        return JDBIConnect.get().withHandle(handle -> {
            handle.registerRowMapper(BeanMapper.factory(Week.class));
            return handle.createQuery("SELECT  YEAR(orderDate) AS year,WEEK(orderDate, 1) AS week ,SUM(totalAmount) AS total_price FROM orders WHERE status = 'Đã xác nhận' AND orderDate >= DATE_SUB(CURDATE(), INTERVAL 4 WEEK) GROUP BY YEAR(orderDate), WEEK(orderDate, 1) ORDER BY year DESC, week DESC").mapTo(Week.class).list();
        });
    }

    public static void main(String[] args) {
        System.out.println(new DashBoardDao().getSLProducts());
        System.out.println(new DashBoardDao().getSLOrders());
        System.out.println(new DashBoardDao().getNewOrders());
        System.out.println(new DashBoardDao().getSLUsers());
        System.out.println(new DashBoardDao().getRevenue());
        System.out.println(new DashBoardDao().getProductBestSelling());
        System.out.println(new DashBoardDao().getWeeklyRevenue());
        System.out.println(new DashBoardDao().getProductSalesData());
        System.out.println(new DashBoardDao().test());
    }
}
