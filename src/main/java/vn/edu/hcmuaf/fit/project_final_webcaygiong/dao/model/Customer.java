package vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model;

import java.io.Serializable;
import java.util.Date;

public class Customer implements Serializable {
    private int customerID;
    private int userID;
    private String nameCustomer;
    private String phone;
    private String address;
    private String district;
    private String city;
    private Date createAt;
    private String gender;

    public Customer() {
    }

    public Customer(int customerID, int userID, String nameCustomer, String phone, String address, String district, String city, Date createAt, String gender) {
        this.customerID = customerID;
        this.userID = userID;
        this.nameCustomer = nameCustomer;
        this.phone = phone;
        this.address = address;
        this.district = district;
        this.city = city;
        this.createAt = createAt;
        this.gender = gender;
    }

    public int getCustomerID() {
        return customerID;
    }

    public void setCustomerID(int customerID) {
        this.customerID = customerID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getNameCustomer() {
        return nameCustomer;
    }

    public void setNameCustomer(String nameCustomer) {
        this.nameCustomer = nameCustomer;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getDistrict() {
        return district;
    }

    public void setDistrict(String district) {
        this.district = district;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public Date getCreateAt() {
        return createAt;
    }

    public void setCreateAt(Date createAt) {
        this.createAt = createAt;
    }


    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    @Override
    public String toString() {
        return
                customerID +
                        ", " + userID +
                        ", " + nameCustomer +
                        "," + phone +
                        ", " + address +
                        ", " + district +
                        ", " + city +
                        ", " + gender+
                        ", " + createAt;
    }
}
