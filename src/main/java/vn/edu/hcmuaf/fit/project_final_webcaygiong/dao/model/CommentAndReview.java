package vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model;

import java.io.Serializable;

public class CommentAndReview implements Serializable {
    private int comAndReID;
    private int userID;
    private String name;
    private int productID;
    private String content;
    private int ratingStars;

    public CommentAndReview() {
    }

    public CommentAndReview(int comAndReID, int userID, String name, int productID, String content, int ratingStars) {
        this.comAndReID = comAndReID;
        this.userID = userID;
        this.name = name;
        this.productID = productID;
        this.content = content;
        this.ratingStars = ratingStars;
    }

    public int getComAndReID() {
        return comAndReID;
    }

    public void setComAndReID(int comAndReID) {
        this.comAndReID = comAndReID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getRatingStars() {
        return ratingStars;
    }

    public void setRatingStars(int ratingStars) {
        this.ratingStars = ratingStars;
    }

    @Override
    public String toString() {
        return
                comAndReID +
                        ", " + userID +
                        ", " + name +
                        ", " + productID +
                        ", " + content +
                        ", " + ratingStars
                ;
    }
}
