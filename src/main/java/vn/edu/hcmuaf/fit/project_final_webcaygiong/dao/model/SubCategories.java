package vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model;

import java.io.Serializable;

public class SubCategories implements Serializable {
    private int subCategoriesID;
    private String subCategoriesName;
    private int categoryID;

    public SubCategories() {
    }

    public SubCategories(int subCategoriesID, String subCategoriesName, int categoryID) {
        this.subCategoriesID = subCategoriesID;
        this.subCategoriesName = subCategoriesName;
        this.categoryID = categoryID;
    }

    public int getSubCategoriesID() {
        return subCategoriesID;
    }

    public void setSubCategoriesID(int subCategoriesID) {
        this.subCategoriesID = subCategoriesID;
    }

    public String getSubCategoriesName() {
        return subCategoriesName;
    }

    public void setSubCategoriesName(String subCategoriesName) {
        this.subCategoriesName = subCategoriesName;
    }

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    @Override
    public String toString() {
        return
                subCategoriesID +
                        ", " + subCategoriesName +
                        ", " + categoryID
                ;
    }
}
