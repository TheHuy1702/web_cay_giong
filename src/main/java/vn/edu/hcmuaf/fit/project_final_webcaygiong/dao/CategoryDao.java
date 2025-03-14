package vn.edu.hcmuaf.fit.project_final_webcaygiong.dao;

import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.db.JDBIConnect;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.Categories;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.SubCategories;

import java.util.ArrayList;
import java.util.List;

public class CategoryDao {

    List<Categories> categories;
    List<SubCategories> subCategories;

    public CategoryDao() {
        categories = new ArrayList<>();
        subCategories = new ArrayList<>();
    }

    public List<Categories> getAllCategories() {
        categories = JDBIConnect.get().withHandle(handle ->
                handle.createQuery("select * from categories")
                        .mapToBean(Categories.class).list());
        return categories;
    }

    public List<SubCategories> getAllSubCategoriesOfCategory() {
        subCategories = JDBIConnect.get().withHandle(handle ->
                handle.createQuery("select * from subcategories where categoryId =?")
                        .bind(0, 1)
                        .mapToBean(SubCategories.class).list());
        return subCategories;
    }

    public String getNameCategory(int categoryId) {
        List<Categories> list = getAllCategories();
        for (Categories category : list) {
            if (category.getCategoryID() == categoryId) {
                String name = category.getNameCategory().toLowerCase();
                return Character.toUpperCase(name.charAt(0)) + name.substring(1);
            }
        }
        return null;
    }

    public static void main(String[] args) {
        CategoryDao categoryDao = new CategoryDao();
        List<Categories> categories = categoryDao.getAllCategories();
        for (Categories category : categories) {
            System.out.println(category);
        }
        System.out.println("\nSubcategories of Category 1:");
        List<SubCategories> subCategories = categoryDao.getAllSubCategoriesOfCategory();
        for (SubCategories subCategory : subCategories) {
            System.out.println(subCategory);
        }
        System.out.println(categoryDao.getNameCategory(1));
    }
}
