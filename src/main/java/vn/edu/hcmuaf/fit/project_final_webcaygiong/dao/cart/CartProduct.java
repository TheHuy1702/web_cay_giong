package vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.cart;

import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.Product;

import java.io.Serializable;

public class CartProduct implements Serializable {
    private int productID;
    private String name;
    private double price;
    private String imageMain;
    private int stock;
    private int categoryID;
    private String introduce;
    private String infoPro;
    private int quantity;

    public CartProduct(int productID, String name, double price, String imageMain, int stock, int categoryID, String introduce, String infoPro, int quantity) {
        this.productID = productID;
        this.name = name;
        this.price = price;
        this.imageMain = imageMain;
        this.stock = stock;
        this.categoryID = categoryID;
        this.introduce = introduce;
        this.infoPro = infoPro;
        this.quantity = quantity;
    }

    public CartProduct(int productID, String name, String imageMain, double price, int i) {
        this.productID = productID;
        this.name = name;
        this.imageMain = imageMain;
        this.price = price;
        this.stock = i;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getImageMain() {
        return imageMain;
    }

    public void setImageMain(String imageMain) {
        this.imageMain = imageMain;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    public String getIntroduce() {
        return introduce;
    }

    public void setIntroduce(String introduce) {
        this.introduce = introduce;
    }

    public String getInfoPro() {
        return infoPro;
    }

    public void setInfoPro(String infoPro) {
        this.infoPro = infoPro;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public CartProduct() {
    }

    @Override
    public String toString() {
        return "CartProduct{" +
                "productID=" + productID +
                ", name='" + name + '\'' +
                ", price=" + price +
                ", imageMain='" + imageMain + '\'' +
                ", stock=" + stock +
                ", categoryID=" + categoryID +
                ", introduce='" + introduce + '\'' +
                ", infoPro='" + infoPro + '\'' +
                ", quantity=" + quantity +
                '}';
    }

    public static void main(String[] args) {
        CartProduct product = new CartProduct(1, "Hoa lan", 20, "image", 100, 2, "gioi thieu", "thong tin san pham", 12);
        System.out.println(product);
    }
}