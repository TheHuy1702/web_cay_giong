package vn.edu.hcmuaf.fit.project_final_webcaygiong.dao;

import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.db.JDBIConnect;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.Product;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.QuanLiSanPham;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.SubImage;

import java.util.ArrayList;
import java.util.List;

public class QLSPDao {
    List<Product> products;
    List<SubImage> subImages;


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

    // update.
//    public void update(QuanLiSanPham product) {
//        JDBIConnect.get().withHandle(handle -> {
//            // Cập nhật thông tin sản phẩm
//            int updatedRows = handle.createUpdate("UPDATE products SET name = ?, price = ?, imageMain = ?, stock = ?, categoryId = ?, introduce = ?, infoPro = ? WHERE productID = ?")
//                    .bind(0, product.getName())
//                    .bind(1, product.getPrice())
//                    .bind(2, product.getImageMain())
//                    .bind(3, product.getStock())
//                    .bind(4, product.getCategoryId())
//                    .bind(5, product.getIntroduce())
//                    .bind(6, product.getInfoPro())
//                    .bind(7, product.getProductID())
//                    .execute(); // Kiểm tra xem có cập nhật được sản phẩm nào không
//
//            // Cập nhật hình ảnh phụ
//            // Xóa tất cả hình ảnh phụ cũ trước khi thêm mới
//            handle.createUpdate("DELETE FROM subimage WHERE productID = ?")
//                    .bind(0, product.getProductID())
//                    .execute();
//
//            // Thêm hình ảnh phụ mới
//            for (SubImage subImage : product.getSubImages()) {
//                handle.createUpdate("INSERT INTO subimage (productID, imageSub) VALUES (?, ?)")
//                        .bind(0, product.getProductID())
//                        .bind(1, subImage.getImageSub())
//                        .execute();
//            }
//
//            return updatedRows; // Trả về số hàng đã cập nhật
//        });
//    }

    public void update(QuanLiSanPham product) {
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

//        dao.update(2);

        // Dữ liệu mẫu
//        String name = "Cây Hoa Hồng";
//        double price = 150000;
//        String imageMain = "hoa-hong.jpg";
//        int stock = 50;
//        int categoryId = 1; // Giả sử 1 là mã danh mục hợp lệ
//        String introduce = "Cây hoa hồng đẹp, thích hợp trồng tại vườn.";
//        String infoPro = "Cây cao 50cm, dễ chăm sóc, thích hợp với khí hậu ôn đới.";
//
//        // Gọi phương thức addProduct
//        try {
//            Product product = dao.addProduct(name, price, imageMain, stock, categoryId, introduce, infoPro);
//            System.out.println("Thêm sản phẩm thành công: " + product);
//        } catch (Exception e) {
//            System.err.println("Lỗi khi thêm sản phẩm: " + e.getMessage());
//        }
//        Map<Integer, List<SubImage>> subImagesMap = dao.getSubImage();
//
//        // In ra kết quả để kiểm tra
//        for (Map.Entry<Integer, List<SubImage>> entry : subImagesMap.entrySet()) {
//            Integer productId = entry.getKey();
//            List<SubImage> subImages = entry.getValue();
//
//            System.out.println("Product ID: " + productId);
//            for (SubImage subImage : subImages) {
//                System.out.println("\tSubImage ID: " + subImage.getProductID());
//                System.out.println("\tSubImage URL: " + subImage.getImageSub());
//            }
//        }
//        for (SubImage d : dao.getSubImage()) {
//            System.out.println(d);
//        }
    }
}
