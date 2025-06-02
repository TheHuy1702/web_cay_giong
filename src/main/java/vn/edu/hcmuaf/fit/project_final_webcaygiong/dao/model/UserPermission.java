package vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model;

import java.io.Serializable;

public class UserPermission implements Serializable {
    private int userPermissionID;
    private int userID;
    private int pageID;
    private int permissionID;

    public UserPermission(int userPermissionID, int userID, int pageID, int permissionID) {
        this.userPermissionID = userPermissionID;
        this.userID = userID;
        this.pageID = pageID;
        this.permissionID = permissionID;
    }

    public UserPermission() {
    }

    public UserPermission(int userID, int pageID, int permissionID) {
        this.userID = userID;
        this.pageID = pageID;
        this.permissionID = permissionID;
    }

    public int getUserPermissionID() {
        return userPermissionID;
    }

    public void setUserPermissionID(int userPermissionID) {
        this.userPermissionID = userPermissionID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public int getPageID() {
        return pageID;
    }

    public void setPageID(int pageID) {
        this.pageID = pageID;
    }

    public int getPermissionID() {
        return permissionID;
    }

    public void setPermissionID(int permissionID) {
        this.permissionID = permissionID;
    }

    @Override
    public String toString() {
        return "UserPermission{" +
                "userPermissionID=" + userPermissionID +
                ", userID=" + userID +
                ", pageID=" + pageID +
                ", permissionID=" + permissionID +
                '}';
    }
}
