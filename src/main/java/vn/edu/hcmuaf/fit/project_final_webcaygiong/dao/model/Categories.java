package vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model;

import java.io.Serializable;

public class Categories implements Serializable {
    private int categoryID;
    private String nameCategory;

    public Categories() {
    }

    public Categories(int categoryID, String nameCategory) {
        this.categoryID = categoryID;
        this.nameCategory = nameCategory;
    }

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    public String getNameCategory() {
        return nameCategory;
    }

    public void setNameCategory(String nameCategory) {
        this.nameCategory = nameCategory;
    }

    @Override
    public String toString() {
        return
                categoryID +
                        ", " + nameCategory;
    }
}
