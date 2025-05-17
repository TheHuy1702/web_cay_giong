package vn.edu.hcmuaf.fit.project_final_webcaygiong.dao;

import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.db.JDBIConnect;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.Product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;


public class ProductDao {
    private List<Product> products;

    public ProductDao() {
        products = new ArrayList<>();
    }


    public List<Product> getAllProducts() {
        products = JDBIConnect.get().withHandle(handle ->
                handle.createQuery("select * from products")
                        .mapToBean(Product.class).list());
        return products;
    }

    public int totalRows(int cid) {
        List<Product> products = getProductByCategory(cid);
        return products.size();
    }

    public List<Product> timKiem(String name) {
        return JDBIConnect.get().withHandle(handle ->
                handle.createQuery("SELECT * FROM products WHERE name LIKE ?")
                        .bind(0, "%" + name + "%")
                        .mapToBean(Product.class).list());
    }

    public int getSLProducts() {
        return JDBIConnect.get().withHandle(handle -> handle.createQuery("SELECT count(*) FROM products").mapTo(Integer.class).one());
    }

    // lấy sản phẩm theo danh mục của các trang.
    public List<Product> getProductOfPageByCategory(int categoryId, int page) {
        int offset = (page - 1) * 16;// vị trí bắt đầu.
        return JDBIConnect.get().withHandle(handle ->
                handle.createQuery("SELECT * FROM products WHERE categoryID = ? ORDER BY productID LIMIT 16 OFFSET ?")
                        .bind(0, categoryId)
                        .bind(1, offset)
                        .mapToBean(Product.class).list());
    }

    // lấy sản phẩm theo danh mục.
    public List<Product> getProductByCategory(int categoryId) {
        return JDBIConnect.get().withHandle(handle ->
                handle.createQuery("SELECT * FROM products WHERE categoryID = ?")
                        .bind(0, categoryId)
                        .mapToBean(Product.class).list());
    }

    // lấy sản phẩm theo danh mục con.
    public List<Product> getProductBySubCategory(String name) {
        StringTokenizer stk = new StringTokenizer(name);
        String n1 = stk.nextToken();
        String n2 = stk.nextToken();
        String n3 = stk.nextToken();
        return JDBIConnect.get().withHandle(handle ->
                handle.createQuery("SELECT DISTINCT p.*\n" +
                                "FROM products p\n" +
                                "JOIN subCategories sc ON p.categoryID = sc.categoryID\n" +
                                "WHERE p.name like ?")
                        .bind(0, '%' + n2 + " " + '%' + n1 + " " + n3 + " " + "%")
                        .mapToBean(Product.class).list());
    }

    // lấy sản phẩm khác.

    public List<Product> getProductKhac() {
        return JDBIConnect.get().withHandle(handle ->
                handle.createQuery("SELECT DISTINCT p.*\n" +
                                "FROM products p\n" +
                                "JOIN subCategories sc ON p.categoryID = sc.categoryID\n" +
                                "WHERE p.name NOT LIKE ? AND p.name NOT LIKE ? AND p.name NOT LIKE ? " +
                                "AND p.name NOT LIKE ? AND p.name NOT LIKE ? AND p.name NOT LIKE ? " +
                                "AND p.name NOT LIKE ? AND p.name NOT LIKE ? AND p.name NOT LIKE ?")
                        .bind(0, '%' + " " + "xoài" + " " + "%")
                        .bind(1, '%' + " " + "bưởi" + " " + "%")
                        .bind(2, '%' + " " + "cam" + " " + "%")
                        .bind(3, '%' + " " + "quýt" + " " + "%")
                        .bind(4, '%' + " " + "mận" + " " + "%")
                        .bind(5, '%' + " " + "ổi" + " " + "%")
                        .bind(6, '%' + " " + "hồng" + " " + "%")
                        .bind(7, '%' + " " + "mít" + " " + "%")
                        .bind(8, '%' + " " + "chanh" + " " + "%")
                        .mapToBean(Product.class).list());
    }

    // lấy chi tiết của sản phẩm.
    public Product getProductByID(int id) {
        return JDBIConnect.get().withHandle(handle ->
                handle.createQuery("SELECT * FROM products WHERE productID = ?")
                        .bind(0, id)
                        .mapToBean(Product.class).findOne().orElse(null));
    }

    // lọc giá danh mục cha.
    public List<Product> getProductByPrice(int cid, double tu, double den) {
        return JDBIConnect.get().withHandle(handle ->
                handle.createQuery("SELECT * FROM products WHERE price between ? and ? and categoryID=?")
                        .bind(0, tu)
                        .bind(1, den)
                        .bind(2, cid)
                        .mapToBean(Product.class).list());
    }

    // hiện thị sản phẩm tương tự.
    public List<Product> getProductSame(int cid, int pid) {
        return JDBIConnect.get().withHandle(handle ->
                handle.createQuery("SELECT * FROM products WHERE categoryID=? and productID != ? ORDER BY productID desc limit 5")
                        .bind(0, cid)
                        .bind(1, pid)
                        .mapToBean(Product.class).list());
    }

    public List<Product> getSellProducts() {
        products = JDBIConnect.get().withHandle(handle ->
                handle.createQuery("SELECT p.*, sum(oi.quantity) as soL\n" +
                                "FROM products p\n" +
                                "JOIN orderitems oi ON p.productID = oi.productID\n" +
                                "JOIN orders o ON oi.orderID = o.orderID\n" +
                                "WHERE month(o.orderDate) = MONTH(CURDATE())" +
                                "GROUP BY p.productID, p.name\n" +
                                "ORDER BY soL DESC\n" +
                                "LIMIT 5;\n")
                        .mapToBean(Product.class).list());
        return products;
    }

    public List<Product> getfruitProducts() {
        products = JDBIConnect.get().withHandle(handle ->
                handle.createQuery("select * from products where categoryID=1 limit 10")
                        .mapToBean(Product.class).list());
        return products;
    }

    public List<Product> getBonsaiProducts() {
        products = JDBIConnect.get().withHandle(handle ->
                handle.createQuery("select * from products where categoryID=2 limit 10")
                        .mapToBean(Product.class).list());
        return products;
    }

    public List<Product> getmedicinalProducts() {
        products = JDBIConnect.get().withHandle(handle ->
                handle.createQuery("select * from products where categoryID=3 limit 10")
                        .mapToBean(Product.class).list());
        return products;
    }

    public List<Product> getFlowerProducts() {
        products = JDBIConnect.get().withHandle(handle ->
                handle.createQuery("select * from products where categoryID=4 limit 10")
                        .mapToBean(Product.class).list());
        return products;
    }

    public List<Product> getIndustrialProducts() {
        products = JDBIConnect.get().withHandle(handle ->
                handle.createQuery("select * from products where categoryID=5 limit 10")
                        .mapToBean(Product.class).list());
        return products;
    }

    public List<Product> getNewProducts() {
        products = JDBIConnect.get().withHandle(handle ->
                handle.createQuery("select * from products where categoryID=6 limit 5")
                        .mapToBean(Product.class).list());
        return products;
    }

    // Gợi ý sp tìm được
    public List<String> getSuggestions(String keyword) {
        List<String> suggestions = JDBIConnect.get().withHandle(handle ->
                handle.createQuery("SELECT name FROM products WHERE name LIKE :keyword LIMIT 5")
                        .bind("keyword", "%" + keyword + "%")
                        .mapTo(String.class)
                        .list()
        );
        return suggestions;
    }

    public List<Product> getTopViewedProducts(int limit) {
        String sql = """
                    SELECT 
                        CAST(SUBSTRING_INDEX(newData, ': ', -1) AS UNSIGNED) AS productId,
                        COUNT(*) AS viewCount
                    FROM 
                        log
                    WHERE 
                        actionType = 'Xem sản phẩm'
                        AND resource = 'Product'
                    GROUP BY productId
                    ORDER BY viewCount DESC
                    LIMIT :limit
                """;

        List<Integer> productIds = JDBIConnect.get().withHandle(handle ->
                handle.createQuery(sql)
                        .bind("limit", limit)
                        .mapTo(Integer.class)
                        .list()
        );

        System.out.println("Top Viewed Product IDs: " + productIds);

        if (productIds.isEmpty()) return new ArrayList<>();

        String sqlProducts = "SELECT * FROM products WHERE productID IN (<ids>)";
        return JDBIConnect.get().withHandle(handle ->
                handle.createQuery(sqlProducts)
                        .defineList("ids", productIds)
                        .mapToBean(Product.class)
                        .list()
        );
    }


}