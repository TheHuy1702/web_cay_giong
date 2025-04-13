package vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model;

import java.io.Serializable;
import java.util.Date;

public class User implements Serializable {
    private int userID;
    private String name;
    private String password;
    private String phone;
    private Date createAt;
    private Date updateAt;
    private String verifiCode;
    private Date verifiExpines;
    private String email;
    private String googleId;
    private String facebookId;

    public User() {
    }

    public User(int userID, String name, String password, String phone, Date createAt, Date updateAt, String verifiCode, Date verifiExpines, String email, String googleId, String facebookId) {
        this.userID = userID;
        this.name = name;
        this.password = password;
        this.phone = phone;
        this.createAt = createAt;
        this.updateAt = updateAt;
        this.verifiCode = verifiCode;
        this.verifiExpines = verifiExpines;
        this.email = email;
        this.googleId = googleId;
        this.facebookId = facebookId;
    }

    public String getEmail() { return email; }

    public void setEmail(String email) { this.email = email; }

    public String getGoogleId() { return googleId; }

    public void setGoogleId(String googleId) { this.googleId = googleId; }

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

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Date getCreateAt() {
        return createAt;
    }

    public void setCreateAt(Date createAt) {
        this.createAt = createAt;
    }

    public Date getUpdateAt() {
        return updateAt;
    }

    public void setUpdateAt(Date updateAt) {
        this.updateAt = updateAt;
    }

    public String getVerifiCode() {
        return verifiCode;
    }

    public void setVerifiCode(String verifiCode) {
        this.verifiCode = verifiCode;
    }

    public Date getVerifiExpines() {
        return verifiExpines;
    }

    public void setVerifiExpines(Date verifiExpines) {
        this.verifiExpines = verifiExpines;
    }

    public String getFacebookId() {
        return facebookId;
    }

    public void setFacebookId(String facebookId) {
        this.facebookId = facebookId;
    }

    @Override
    public String toString() {
        return "User{" +
                "userID=" + userID +
                ", name='" + name + '\'' +
                ", password='" + password + '\'' +
                ", phone='" + phone + '\'' +
                ", createAt=" + createAt +
                ", updateAt=" + updateAt +
                ", verifiCode='" + verifiCode + '\'' +
                ", verifiExpines=" + verifiExpines +
                ", email='" + email + '\'' +
                ", googleId='" + googleId + '\'' +
                ", facebookId='" + facebookId + '\'' +
                '}';
    }
}