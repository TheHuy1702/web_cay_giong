package vn.edu.hcmuaf.fit.project_final_webcaygiong.dao;

import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.db.JDBIConnect;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.QuanLiCustomers;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.User;

import java.util.ArrayList;
import java.util.List;

public class QuanLiCustomerDao {
    List<QuanLiCustomers> customers;

    public QuanLiCustomerDao() {
        customers = new ArrayList<>();
    }

    // lấy ds cus và thông tin user.
    public List<QuanLiCustomers> getAllCustomerWithUser() {
        customers = JDBIConnect.get().withHandle(handle ->
                handle.createQuery("SELECT c.*, u.phone  AS userPhone,u.name, u.password FROM customers c JOIN users u ON c.userID = u.userID")
                        .map((rs, ctx) -> {
                            QuanLiCustomers customer = new QuanLiCustomers();
                            customer.setCustomerID(rs.getInt("customerID"));
                            customer.setUserID(rs.getInt("userID"));
                            customer.setNameCustomer(rs.getString("nameCustomer"));
                            customer.setPhone(rs.getString("phone"));
                            customer.setAddress(rs.getString("address"));
                            customer.setDistrict(rs.getString("district"));
                            customer.setCity(rs.getString("city"));
                            customer.setCreateAt(rs.getDate("createAt"));

                            User user = new User();
                            user.setUserID(rs.getInt("userID"));
                            user.setName(rs.getString("name"));
                            user.setPhone(rs.getString("userPhone"));
                            user.setPassword(rs.getString("password"));
                            customer.setUser(user);

                            return customer;
                        }).list());
        return customers;
    }

    // lấy ds cus và thông tin user theo mã, tên và sdt.
    public List<QuanLiCustomers> searchCustomers(String query) {
        customers = JDBIConnect.get().withHandle(handle ->
                handle.createQuery("SELECT c.*, u.phone AS userPhone, u.name, u.password FROM customers c JOIN users u ON c.userID = u.userID WHERE c.customerID LIKE ? OR c.nameCustomer LIKE ? OR c.phone LIKE ?")
                        .bind(0, query) // Tìm kiếm theo mã khách hàng
                        .bind(1, "%" + query + "%") // Tìm kiếm theo tên khách hàng
                        .bind(2, query + "%") // Tìm kiếm theo số điện thoại
                        .map((rs, ctx) -> {
                            QuanLiCustomers customer2 = new QuanLiCustomers();
                            customer2.setCustomerID(rs.getInt("customerID"));
                            customer2.setUserID(rs.getInt("userID"));
                            customer2.setNameCustomer(rs.getString("nameCustomer"));
                            customer2.setPhone(rs.getString("phone"));
                            customer2.setAddress(rs.getString("address"));
                            customer2.setDistrict(rs.getString("district"));
                            customer2.setCity(rs.getString("city"));
                            customer2.setCreateAt(rs.getDate("createAt"));

                            User user = new User();
                            user.setUserID(rs.getInt("userID"));
                            user.setName(rs.getString("name"));
                            user.setPhone(rs.getString("userPhone"));
                            user.setPassword(rs.getString("password"));
                            customer2.setUser(user);

                            return customer2;
                        }).list());
        return customers;
    }

    // xóa khách hàng và user.
    public void deleteCustomer(int customerID) {
        int userID = getUserID(customerID);
        // Xóa khách hàng
        JDBIConnect.get().withHandle(handle ->
                handle.createUpdate("DELETE FROM customers WHERE customerID = ?")
                        .bind(0, customerID)
                        .execute());

        // Xóa user liên quan
        xoaUser(userID);
    }

    // lấy ra userID.
    public int getUserID(int customerID) {
        return JDBIConnect.get().withHandle(handle ->
                handle.createQuery("SELECT userID FROM users WHERE userID = (SELECT userID FROM customers WHERE customerID = ?)")
                        .bind(0, customerID)
                        .mapTo(Integer.class)
                        .findOne()
                        .orElse(-1)); // Trả về null nếu không tìm thấy
    }

    // xóa user.
    public void xoaUser(int userID) {
        JDBIConnect.get().withHandle(handle ->
                handle.createUpdate("DELETE FROM users WHERE userID = ?")
                        .bind(0, userID)
                        .execute());
    }

    public static void main(String[] args) {
        QuanLiCustomerDao quanLiCustomerDao = new QuanLiCustomerDao();
        List<QuanLiCustomers> listAll = quanLiCustomerDao.searchCustomers("099");
        for (QuanLiCustomers c : listAll) {
            System.out.println(c);
        }
        quanLiCustomerDao.deleteCustomer(4);
        System.out.println(quanLiCustomerDao.getUserID(5));
        System.out.println(quanLiCustomerDao.getUserID(6));
        System.out.println(quanLiCustomerDao.getUserID(8));
        System.out.println(quanLiCustomerDao.getUserID(10));
        quanLiCustomerDao.xoaUser(1);


    }

    public QuanLiCustomers getCustomerByID(int id) {
        return JDBIConnect.get().withHandle(handle ->
                handle.createQuery("SELECT * FROM customers WHERE customerID = ?")
                        .bind(0, id)
                        .mapToBean(QuanLiCustomers.class)
                        .findOne()
                        .orElse(null)
        );
    }

    public List<String> getDeleteCustomerLogs() {
        return JDBIConnect.get().withHandle(handle ->
                handle.createQuery("SELECT CONCAT('[', createdAt, '] ', userAction, ' - ', oldData) " +
                                "FROM log WHERE actionType = 'Xóa khách hàng' ORDER BY createdAt DESC")
                        .mapTo(String.class)
                        .list()
        );
    }


}
