package vn.edu.hcmuaf.fit.project_final_webcaygiong.dao;

import com.google.gson.Gson;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.db.JDBIConnect;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.Product;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.QuanLiSanPham;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.SubImage;

import java.util.ArrayList;
import java.util.List;

public class QLSPDao {
    List<Product> products;
    List<SubImage> subImages;
    private String convertProductToJson(Product product) {
        Gson gson = new Gson();
        return gson.toJson(product);
    }



    public QLSPDao() {
        products = new ArrayList<>();
    }

    public List<Product> getAllProducts() {
        products = JDBIConnect.get().withHandle(handle ->
                handle.createQuery("select * from products ")
                        .mapToBean(Product.class).list());
        return products;
    }

    public Product getProduct(int id) {
        return JDBIConnect.get().withHandle(handle ->
                handle.createQuery("select * from products where productID = ?")
                        .bind(0, id)
                        .mapToBean(Product.class).one());
    }

    public Product addProduct(String name, double price, String imageMain, int stock, int categoryId, String introduce, String infoPro) {
        return JDBIConnect.get().withHandle(handle -> {
            int id = handle.createUpdate("INSERT INTO products (name, price, imageMain, stock, categoryID, introduce, infoPro) " +
                            "VALUES (:name, :price, :imageMain, :stock, :categoryId, :introduce, :infoPro)")
                    .bind("name", name)
                    .bind("price", price)
                    .bind("imageMain", imageMain)
                    .bind("stock", stock)
                    .bind("categoryId", categoryId)
                    .bind("introduce", introduce)
                    .bind("infoPro", infoPro)
                    .executeAndReturnGeneratedKeys("productID")
                    .mapTo(int.class)
                    .one();

            return new Product(id, name, price, imageMain, stock, categoryId, introduce, infoPro);
        });
    }

    public void deleteProductById(int productID) {
        JDBIConnect.get().withHandle(handle ->
                handle.createUpdate("DELETE FROM products WHERE productID = ?")
                        .bind(0, productID)
                        .execute() // Kiểm tra xem có xóa được sản phẩm nào không
        );
    }


    public List<SubImage> getSubImage() {
        subImages = JDBIConnect.get().withHandle(handle ->
                handle.createQuery("select * from subimage")
                        .mapToBean(SubImage.class).list());
        return subImages;
    }

    public void update(QuanLiSanPham product, int productID) {
        try {
            JDBIConnect.get().withHandle(handle -> {
                handle.createUpdate("UPDATE products SET name = ?, price = ?, imageMain = ?, stock = ?, categoryId = ?, introduce = ?, infoPro = ? WHERE productID = ?")
                        .bind(0, product.getName())
                        .bind(1, product.getPrice())
                        .bind(2, product.getImageMain())
                        .bind(3, product.getStock())
                        .bind(4, product.getCategoryId())
                        .bind(5, product.getIntroduce())
                        .bind(6, product.getInfoPro())
                        .bind(7, product.getProductID())
                        .execute();
                return null;
            });
        } catch (Exception e) {
            System.err.println("Error updating product: " + e.getMessage());
            e.printStackTrace();
        }
    }


    // Phương thức main để test
    public static void main(String[] args) {
        QLSPDao dao = new QLSPDao();
        System.out.println(dao.getProduct(1));
    }

    public void insertHistory(String actionType, int productId, String productName, String oldData, String userAction) {
        try {
            JDBIConnect.get().withHandle(handle -> {
                handle.createUpdate("INSERT INTO history (actionType, productID, name, oldData, userAction) " +
                                "VALUES (?, ?, ?, ?, ?)")
                        .bind(0, actionType)
                        .bind(1, productId)
                        .bind(2, productName)
                        .bind(3, oldData)
                        .bind(4, userAction)
                        .execute();
                return null;
            });
        } catch (Exception e) {
            System.err.println("Error inserting history: " + e.getMessage());
            e.printStackTrace();
        }
    }


}

