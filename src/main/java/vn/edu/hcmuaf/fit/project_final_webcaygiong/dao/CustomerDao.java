package vn.edu.hcmuaf.fit.project_final_webcaygiong.dao;

import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.db.JDBIConnect;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.Customer;

import java.util.ArrayList;
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
                        .mapToBean(Customer.class).one());
    }


    public void addCustomer(Customer customer) {
        JDBIConnect.get().useHandle(h ->
                h.createUpdate("INSERT INTO customers (name, phone, address, city, district) VALUES (:name, :phone, :address, :city, :district)")
                        .bindBean(customer)
                        .execute()
        );
    }

    // Update an existing customer
    public void updateCustomer(Customer customer) {
        JDBIConnect.get().useHandle(h ->
                h.createUpdate("UPDATE customers SET name = :name, phone = :phone, address = :address, city = :city, district = :district WHERE cusID = :cusID")
                        .bindBean(customer)
                        .execute()
        );
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

    public static void main(String[] args) {
        CustomerDao customerDao = new CustomerDao();
        List<Customer> listAll = customerDao.getAllCustomers();
        for (Customer c : listAll) {
            System.out.println(c);
        }
        System.out.println(customerDao.getCustomerWithUID(2));
    }
}


