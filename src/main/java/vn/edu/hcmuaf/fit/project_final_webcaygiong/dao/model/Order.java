package vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.Date;

public class Order implements Serializable {
    private int orderId;
    private int customerId;
    private int userId;
    private Date orderDate;
    private double totalAMount;
    private  String status;
    private  double shippingFee;
    private   Date createAt;
    private LocalDateTime expectedDeliveryTime;
    private  String cancelBy;
    private  Date cancelAt;

    public Order(int orderId, int customerId, int userId, Date orderDate, double totalAMount, String status, double shippingFee, Date createAt) {
        this.orderId = orderId;
        this.customerId = customerId;
        this.userId = userId;
        this.orderDate = orderDate;
        this.totalAMount = totalAMount;
        this.status = status;
        this.shippingFee = shippingFee;
        this.createAt = createAt;
    }

    public Order(int orderId, int customerId, int userId, Date orderDate, double totalAMount, String status, double shippingFee, Date createAt, LocalDateTime expectedDeliveryTime) {
        this.orderId = orderId;
        this.customerId = customerId;
        this.userId = userId;
        this.orderDate = orderDate;
        this.totalAMount = totalAMount;
        this.status = status;
        this.shippingFee = shippingFee;
        this.createAt = createAt;
        this.expectedDeliveryTime = expectedDeliveryTime;
    }

    public Order(int orderId, int customerId, int userId, Date orderDate, double totalAMount, String status, double shippingFee, Date createAt, LocalDateTime expectedDeliveryTime, String cancelBy, Date cancelAt) {
        this.orderId = orderId;
        this.customerId = customerId;
        this.userId = userId;
        this.orderDate = orderDate;
        this.totalAMount = totalAMount;
        this.status = status;
        this.shippingFee = shippingFee;
        this.createAt = createAt;
        this.expectedDeliveryTime = expectedDeliveryTime;
        this.cancelBy = cancelBy;
        this.cancelAt = cancelAt;
    }

    public Order() {
    }

    public String getCancelBy() {
        return cancelBy;
    }

    public void setCancelBy(String cancelBy) {
        this.cancelBy = cancelBy;
    }

    public Date getCancelAt() {
        return cancelAt;
    }

    public void setCancelAt(Date cancelAt) {
        this.cancelAt = cancelAt;
    }

    @Override
    public String toString() {
        return "Order{" +
                "orderId=" + orderId +
                ", customerId=" + customerId +
                ", userId=" + userId +
                ", orderDate=" + orderDate +
                ", totalAMount=" + totalAMount +
                ", status='" + status + '\'' +
                ", shippingFee=" + shippingFee +
                ", createAt=" + createAt +
                ", expectedDeliveryTime=" + expectedDeliveryTime +
                ", cancelBy='" + cancelBy + '\'' +
                ", cancelAt=" + cancelAt +
                '}';
    }

    public LocalDateTime getExpectedDeliveryTime() {
        return expectedDeliveryTime;
    }

    public void setExpectedDeliveryTime(LocalDateTime expectedDeliveryTime) {
        this.expectedDeliveryTime = expectedDeliveryTime;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public double getTotalAMount() {
        return totalAMount;
    }

    public void setTotalAMount(double totalAMount) {
        this.totalAMount = totalAMount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public double getShippingFee() {
        return shippingFee;
    }

    public void setShippingFee(double shippingFee) {
        this.shippingFee = shippingFee;
    }

    public Date getCreateAt() {
        return createAt;
    }

    public void setCreateAt(Date createAt) {
        this.createAt = createAt;
    }
}
