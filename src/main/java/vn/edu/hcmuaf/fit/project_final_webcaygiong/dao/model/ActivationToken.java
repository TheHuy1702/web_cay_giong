package vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model;

import java.util.Date;

public class ActivationToken {
    private int id;
    private int userID;
    private String token;
    private Date expiryTime;
    private boolean used;

    public ActivationToken() {
    }

    public ActivationToken(int id, int userID, String token, Date expiryTime, boolean used) {
        this.id = id;
        this.userID = userID;
        this.token = token;
        this.expiryTime = expiryTime;
        this.used = used;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
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

    public boolean isUsed() {
        return used;
    }

    public void setUsed(boolean used) {
        this.used = used;
    }

    @Override
    public String toString() {
        return "ActivationToken{" +
                "id=" + id +
                ", userID=" + userID +
                ", token='" + token + '\'' +
                ", expiryTime=" + expiryTime +
                ", used=" + used +
                '}';
    }
}
