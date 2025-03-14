package vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model;

import java.io.Serializable;

public class Product implements Serializable {
    private int productID;
    private String name;
    private double price;
    private String imageMain;
    private int stock;
    private int categoryID;
    private String introduce;
    private String infoPro;


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

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true; // So sánh tham chiếu
        }
        if (obj == null || getClass() != obj.getClass()) {
            return false; // Kiểm tra null và kiểu lớp
        }
        Product other = (Product) obj; // Ép kiểu
        return productID == other.productID; // So sánh productID
    }

    public Product(int productID, String name, double price, String imageMain, int stock, int categoryID, String introduce, String infoPro) {
        this.productID = productID;
        this.name = name;
        this.price = price;
        this.imageMain = imageMain;
        this.stock = stock;
        this.categoryID = categoryID;
        this.introduce = introduce;
        this.infoPro = infoPro;
    }

    public Product() {
    }

    public String toString() {
        return productID + "\t" + name + "\t" + price + "\t" + imageMain + "\t" + stock + "\t" + categoryID + "\t" + introduce + "\t" + infoPro;
    }

    public static void main(String[] args) {
        System.out.println();
    }
}
