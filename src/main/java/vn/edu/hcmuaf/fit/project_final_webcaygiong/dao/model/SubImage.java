package vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model;

import java.io.Serializable;

public class SubImage implements Serializable {
    private int imageID;
    private int productID;
    private String imageSub;

    public SubImage() {
    }

    public SubImage(int productID, int imageID, String imageSub) {
        this.productID = productID;
        this.imageID = imageID;
        this.imageSub = imageSub;
    }

    public int getImageID() {
        return imageID;
    }

    public void setImageID(int imageID) {
        this.imageID = imageID;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public String getImageSub() {
        return imageSub;
    }

    public void setImageSub(String imageSub) {
        this.imageSub = imageSub;
    }

    @Override
    public String toString() {
        return
                imageID +
                        ", " + productID +
                        ", " + imageSub;
    }
}
