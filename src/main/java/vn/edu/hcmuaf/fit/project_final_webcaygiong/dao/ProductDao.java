package vn.edu.hcmuaf.fit.project_final_webcaygiong.dao;

import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.db.JDBIConnect;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.Product;

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

    public static void main(String[] args) {
        // test lấy các sản phẩm cùng loại.
        for (Product product : new ProductDao().getProductSame(1, 1)) {
            System.out.println(product);
        }
        System.out.println(new ProductDao().getProductByID(1));
//        ProductDao productDao = new ProductDao();
//        List<Product> products = productDao.getAllProducts();
//        for (Product product : products) {
//            System.out.println(product);
//        }
//        System.out.println(new ProductDao().totalRows());
//
//        for (Product product : new ProductDao().getProductOfPageHoa(3)) {
//            System.out.println(product);
//        }
//        System.out.println(new ProductDao().getProductOfPageHoa(3).size());

//        // test tìm kiếm.
//        System.out.println("\n\n\n");
//        for (Product p : new ProductDao().timKiem("bơ sáp")) {
//            System.out.println(p);
//        }
//        System.out.println(new ProductDao().getSLProducts());
        ProductDao dao = new ProductDao();
//        List<Product> products = dao.getProductByCategory(1);
//        for (Product product : products) {
//            System.out.println(product);
//        }
//        System.out.println(dao.totalRows(1));
        List<Product> products = dao.getProductByCategory(1);
        System.out.println(products.size());

        List<Product> products2 = dao.getProductKhac();
        System.out.println(products2.size());

        List<Product> productsXoai = dao.getProductBySubCategory("Giống cây xoài");
        System.out.println("Số lượng sản phẩm giống cây xoài: " + productsXoai.size());

        List<Product> productsBuoi = dao.getProductBySubCategory("Giống cây bưởi");
        System.out.println("Số lượng sản phẩm giống cây bưởi: " + productsBuoi.size());

        List<Product> productsCam = dao.getProductBySubCategory("Giống cây cam");
        System.out.println("Số lượng sản phẩm giống cây cam: " + productsCam.size());

        List<Product> productsQuit = dao.getProductBySubCategory("Giống cây quýt");
        System.out.println("Số lượng sản phẩm giống cây quýt: " + productsQuit.size());

        List<Product> productsMan = dao.getProductBySubCategory("Giống cây mận");
        System.out.println("Số lượng sản phẩm giống cây mận: " + productsMan.size());

        List<Product> productsOi = dao.getProductBySubCategory("Giống cây ổi");
        System.out.println("Số lượng sản phẩm giống cây ổi: " + productsOi.size());

        List<Product> productsHong = dao.getProductBySubCategory("Giống cây hồng");
        System.out.println("Số lượng sản phẩm giống cây hồng: " + productsHong.size());

        List<Product> productsMit = dao.getProductBySubCategory("Giống cây mít");
        System.out.println("Số lượng sản phẩm giống cây mít: " + productsMit.size());

        List<Product> productsChanh = dao.getProductBySubCategory("Giống cây chanh");
        System.out.println("Số lượng sản phẩm giống cây chanh: " + productsChanh.size());

        // Tạo một danh sách mới để chứa tất cả sản phẩm
        List<Product> allProducts = new ArrayList<>();

// Thêm tất cả sản phẩm vào danh sách allProducts
        allProducts.addAll(products2);
        allProducts.addAll(productsXoai);
        allProducts.addAll(productsBuoi);
        allProducts.addAll(productsCam);
        allProducts.addAll(productsQuit);
        allProducts.addAll(productsMan);
        allProducts.addAll(productsOi);
        allProducts.addAll(productsHong);
        allProducts.addAll(productsMit);
        allProducts.addAll(productsChanh);

// In ra tổng số lượng sản phẩm trong allProducts
        System.out.println("Tổng số lượng sản phẩm: " + allProducts.size());

        // Tạo một danh sách để chứa các sản phẩm không có trong allProducts
        List<Product> missingProducts = new ArrayList<>();

// So sánh và tìm sản phẩm có trong products nhưng không có trong allProducts
        for (Product product : products) {
            if (!allProducts.contains(product)) {
                missingProducts.add(product);
            }
        }

        // In ra các sản phẩm không có trong allProducts
        System.out.println("Sản phẩm có trong products nhưng không có trong allProducts:");
        for (Product missingProduct : missingProducts) {
            System.out.println(missingProduct); // Giả sử Product đã override phương thức toString()
        }

        // test lọc giá.
        List<Product> productsByPrice = dao.getProductByPrice(1, 100000, 200000);
        System.out.println("Sản phẩm có giá từ 100.000 đến 200.000:");
        for (Product product : productsByPrice) {
            System.out.println(product);
        }
        ProductDao productDao = new ProductDao();
        List<Product> productsd = productDao.getSellProducts();
        for (Product product : productsd) {
            System.out.println(product);
        }

    }
}
