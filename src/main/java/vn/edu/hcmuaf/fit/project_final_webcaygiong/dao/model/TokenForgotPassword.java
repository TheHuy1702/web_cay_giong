package vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model;
// TokenForgotPassword.java

import java.util.Date;

public class TokenForgotPassword {
    private int id;
    private int userID;
    private boolean used;
    private String token;
    private Date expiryTime;

    // Constructor, getters và setters
    public TokenForgotPassword(int id, int userID, boolean used, String token, Date expiryTime) {
        this.id = id;
        this.userID = userID;
        this.used = used;
        this.token = token;
        this.expiryTime = expiryTime;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    // Các phương thức getter và setter
    public boolean isUsed() {
        return used;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public void setUsed(boolean used) {
        this.used = used;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public Date getExpiryTime() {
        return expiryTime;
    }

    public void setExpiryTime(Date expiryTime) {
        this.expiryTime = expiryTime;
    }
}