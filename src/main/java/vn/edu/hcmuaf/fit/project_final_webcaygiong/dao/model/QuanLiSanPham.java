package vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model;

import java.io.Serializable;
import java.util.List;

public class QuanLiSanPham implements Serializable {
    private int productID;
    private String name;
    private double price;
    private String imageMain;
    private int stock;
    private int categoryId;
    private Categories categories;
    private String introduce;
    private String infoPro;
    private List<SubImage> subImages;

    public QuanLiSanPham(int productID, String name, double price, String imageMain, int stock, int categoryId, Categories categories, String introduce, String infoPro, List<SubImage> subImages) {
        this.productID = productID;
        this.name = name;
        this.price = price;
        this.imageMain = imageMain;
        this.stock = stock;
        this.categoryId = categoryId;
        this.categories = categories;
        this.introduce = introduce;
        this.infoPro = infoPro;
        this.subImages = subImages;
    }

    public QuanLiSanPham(int productID, String name, double price, String imageMain, int stock, int categoryId, String introduce, String infoPro, List<SubImage> subImages) {
        this.productID = productID;
        this.name = name;
        this.price = price;
        this.imageMain = imageMain;
        this.stock = stock;
        this.categoryId = categoryId;
        this.introduce = introduce;
        this.infoPro = infoPro;
        this.subImages = subImages;
    }

    public QuanLiSanPham(int productID, String name, double price, String imageMain, int stock, int categoryId, String introduce, String infoPro) {
        this.productID = productID;
        this.name = name;
        this.price = price;
        this.imageMain = imageMain;
        this.stock = stock;
        this.categoryId = categoryId;
        this.introduce = introduce;
        this.infoPro = infoPro;
    }

    public QuanLiSanPham() {
    }


    @Override
    public String toString() {
        return "QuanLiSanPham{" +
                "productID=" + productID +
                ", name='" + name + '\'' +
                ", price=" + price +
                ", imageMain='" + imageMain + '\'' +
                ", stock=" + stock +
                ", categoryId=" + categoryId +
                ", categories=" + categories +
                ", introduce='" + introduce + '\'' +
                ", infoPro='" + infoPro + '\'' +
                ", subImages=" + subImages +
                '}';
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

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public Categories getCategories() {
        return categories;
    }

    public void setCategories(Categories categories) {
        this.categories = categories;
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

    public List<SubImage> getSubImages() {
        return subImages;
    }

    public void setSubImages(List<SubImage> subImages) {
        this.subImages = subImages;
    }
}
