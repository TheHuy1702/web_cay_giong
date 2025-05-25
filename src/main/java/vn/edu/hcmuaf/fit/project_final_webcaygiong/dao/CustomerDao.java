package vn.edu.hcmuaf.fit.project_final_webcaygiong.dao;

import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.db.JDBIConnect;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.Customer;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.Product;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

public class CustomerDao {
    List<Customer> customers;

    public CustomerDao() {
        customers = new ArrayList<>();
    }

    // lấy tất cả khách hàng.
    public List<Customer> getAllCustomers() {
        customers = JDBIConnect.get().withHandle(handle ->
                handle.createQuery("select * from customers")
                        .mapToBean(Customer.class).list());
        return customers;
    }

    public Customer getCustomerWithUID(int userID) {
        return JDBIConnect.get().withHandle(handle ->
                handle.createQuery("select * from customers where userID = ?")
                        .bind(0, userID)
                        .mapToBean(Customer.class).findOne()  // trả về Optional<Customer>
                        .orElse(null));
    }


    public void addCustomer(Customer customer) {
        JDBIConnect.get().useHandle(h ->
                h.createUpdate("INSERT INTO customers (name, phone, address, email, city, district) VALUES (:name, :phone, :address, :city, :district)")
                        .bindBean(customer)
                        .execute()
        );
    }

    // Update an existing customer
    public void updateCustomer(Customer customer) {
        JDBIConnect.get().useHandle(h ->
                h.createUpdate("UPDATE customers SET name = :name, phone = :phone, address = :address,email = :email, city = :city, district = :district WHERE cusID = :cusID")
                        .bindBean(customer)
                        .execute()
        );
    }

    public void updateEmailAddress(String email) {
        JDBIConnect.get().useHandle(h ->
                h.createUpdate("UPDATE customers SET email = ?")
                        .bind(0, email).execute());
    }

    public void updateCustomerAddress(int userID, String fullName, String phoneNumber, String address, String district, String city) {
        JDBIConnect.get().useHandle(h ->
                h.createUpdate("UPDATE customers SET nameCustomer = ?, phone = ?, address = ?, district = ?, city = ? WHERE userID = ?")
                        .bind(0, fullName)
                        .bind(1, phoneNumber)
                        .bind(2, address)
                        .bind(3, district)
                        .bind(4, city)
                        .bind(5, userID)
                        .execute()
        );
    }

    public void updateInfoCustomer(int userID, String fullName) {
        JDBIConnect.get().useHandle(h ->
                h.createUpdate("UPDATE customers SET nameCustomer =? WHERE userID =?")
                        .bind(0, fullName)
                        .bind(1, userID)
                        .execute()
        );
    }

    public void updateInfoCustomerPhone(int userID, String phoneNumber) {
        JDBIConnect.get().useHandle(h ->
                h.createUpdate("UPDATE customers SET phone =? WHERE userID =?")
                        .bind(0, phoneNumber)
                        .bind(1, userID)
                        .execute()
        );
    }

    public void updateInfoCustomerEmail(int userID, String email) {
        JDBIConnect.get().useHandle(h ->
                h.createUpdate("UPDATE users SET email =? WHERE userID =?")
                        .bind(0, email)
                        .bind(1, userID)
                        .execute()
        );
    }

    public void updateInfoCustomerGender(int userID, String gender) {
        JDBIConnect.get().useHandle(h ->
                h.createUpdate("UPDATE customers SET gender =? WHERE userID =?")
                        .bind(0, gender)
                        .bind(1, userID)
                        .execute()
        );
    }

    public static void main(String[] args) {
        CustomerDao customerDao = new CustomerDao();
//        customerDao.updateInfoCustomerEmail(2, "thththt@gmail.com");
//        customerDao.createCus(2);
Customer customer=customerDao.getCustomerWithUID(2);
if(customer==null){
    System.out.println("RONG");
}else{
    System.out.println("Khong rong");
}


    }

    public void updateCustomerAddressForAccount(int userID, String address, String district, String city) {
        JDBIConnect.get().useHandle(h ->
                h.createUpdate("UPDATE customers SET address = ?, district = ?, city = ? WHERE userID = ?")
                        .bind(0, address)
                        .bind(1, district)
                        .bind(2, city)
                        .bind(3, userID)
                        .execute()
        );
    }
    public void createCus(int userID, String fullName) {
        JDBIConnect.get().useHandle(h -> {
            String sql = "INSERT INTO customers (userID, nameCustomer, createAt) VALUES (?, ?, now())";
            h.createUpdate(sql)
                    .bind(0, userID)
                    .bind(1,fullName )
                    .execute();
        });
    }



    public void createCusGender(int userID, String gender) {
        JDBIConnect.get().useHandle(h -> {
            String sql = "INSERT INTO customers (userID, gender, createAt) VALUES (?, ?, now())";
            h.createUpdate(sql)
                    .bind(0, userID)
                    .bind(1,gender )
                    .execute();
        });
    }

    public void createCusPhone(int userID, String phone) {
        JDBIConnect.get().useHandle(h -> {
            String sql = "INSERT INTO customers (userID, phone, createAt) VALUES (?, ?, now())";
            h.createUpdate(sql)
                    .bind(0, userID)
                    .bind(1,phone )
                    .execute();
        });
    }

    public void createAddress(int userID, String address, String district, String city, String ward) {
        JDBIConnect.get().useHandle(h -> {
            String sql = "INSERT INTO customers (userID, address,district,city,ward, createAt) VALUES (?,?,?,?, ?, now())";
            h.createUpdate(sql)
                    .bind(0, userID)
                    .bind(1,address )
                    .bind(2,district)
                    .bind(3,city)
                    .bind(4,ward)
                    .execute();
        });
    }

    public void createCusEmail(int userID, String email) {
        JDBIConnect.get().useHandle(h -> {
            String sql = "INSERT INTO customers (userID, email, createAt) VALUES (?, ?, now())";
            h.createUpdate(sql)
                    .bind(0, userID)
                    .bind(1,email )
                    .execute();
        });
    }
}


