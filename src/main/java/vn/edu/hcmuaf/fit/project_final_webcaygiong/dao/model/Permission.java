package vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model;

import java.io.Serializable;

public class Permission implements Serializable {
    private int permissionID;
    private String name;

    public Permission() {
    }

    public Permission(int permissionID, String name) {
        this.permissionID = permissionID;
        this.name = name;
    }

    public int getPermissionID() {
        return permissionID;
    }

    public void setPermissionID(int permissionID) {
        this.permissionID = permissionID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return "permission{" +
                "permissionID=" + permissionID +
                ", name='" + name + '\'' +
                '}';
    }
}
