package vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model;

public class OrderItems {
    private int itemID;
    private int productID;
    private int quantity;
    private int orderID;

    public OrderItems(int itemID, int productID, int quantity, int orderID) {
        this.itemID = itemID;
        this.productID = productID;
        this.quantity = quantity;
        this.orderID = orderID;
    }

    public OrderItems() {
    }

    public int getItemID() {
        return itemID;
    }

    public void setItemID(int itemID) {
        this.itemID = itemID;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    @Override
    public String toString() {
        return "OrderItems{" +
                "itemID=" + itemID +
                ", productID=" + productID +
                ", quantity=" + quantity +
                ", orderID=" + orderID +
                '}';
    }
}
