package vn.edu.hcmuaf.fit.project_final_webcaygiong.controller;

import com.google.gson.Gson;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.CategoryDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.ProductDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.QLSPDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.Categories;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.Product;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.QuanLiSanPham;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.SubImage;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;
import java.util.Map;

@MultipartConfig
@WebServlet(name = "QSLPServlet", value = "/QuanLySanPham")
public class QSLPServlet extends HttpServlet {
    private QLSPDao qlspDao = new QLSPDao();
    private CategoryDao categoryDao = new CategoryDao();
    private ProductDao productDao = new ProductDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


        List<SubImage> subImages = qlspDao.getSubImage();
        request.setAttribute("subImage", subImages);

        // ds sản phẩm
        List<Categories> dsCategories = categoryDao.getAllCategories();
        request.setAttribute("dsCategories", dsCategories);

        // tìm kiếm.
        String search = request.getParameter("search");
        ProductDao productDao = new ProductDao();
        if (search != null && !search.trim().isEmpty()) {
            List<Product> searchProducts = productDao.timKiem(search);
            request.setAttribute("products", searchProducts);
        } else {
            List<Product> products = qlspDao.getAllProducts();
            request.setAttribute("products", products);
        }

        //Lấy danh mục sản phẩm
        RequestDispatcher dispatcher = request.getRequestDispatcher("QuanLySanPham.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


        // nút xoá
        String action = request.getParameter("action");
        if ("them".equals(action)) {
            String name = request.getParameter("addname");
            double price = Double.parseDouble(request.getParameter("addprice"));
            String imageMan = request.getParameter("addimageMan");
            int stock = Integer.parseInt(request.getParameter("addstock"));
            int categoryId = Integer.parseInt(request.getParameter("addcategoryID"));
            String introduce = request.getParameter("addintroduce");
            String infoPro = request.getParameter("addinfoPro");
            // Thêm sản phẩm qua DAO
            QLSPDao dao = new QLSPDao();
            Product product = dao.addProduct(name, price, imageMan, stock, categoryId, introduce, infoPro);
            request.setAttribute("product", product);
            // Chuyển hướng về trang danh sách sản phẩm hoặc thông báo thành công
            response.sendRedirect("QuanLySanPham?them=thanhcong"); // Điều hướng lại để làm mới danh sách sản phẩm
            if (name == null || name.trim().isEmpty() || price <= 0 || stock < 0) {
                request.setAttribute("error", "Dữ liệu không hợp lệ!");
                response.sendRedirect("QuanLySanPham?them=thatBai");
            }else {
//                Product product = dao.addProduct(name, price, imageMan, stock, categoryId, introduce, infoPro);
// ➡️ Thêm log vào History
                qlspDao.insertHistory("them", product.getProductID(), product.getName(), null, "admin"); // hoặc lấy user từ session

                response.sendRedirect("QuanLySanPham?them=thanhcong");
            }
        } else if ("delet".equals(action)) {
            String productId = request.getParameter("productIdXoa");
            Product product = qlspDao.getProduct(Integer.parseInt(productId)); // Lấy dữ liệu cũ để lưu log

            qlspDao.deleteProductById(Integer.parseInt(productId));

            // ➡️ Thêm log vào History
            qlspDao.insertHistory("xoa", product.getProductID(), product.getName(), convertProductToJson(product), "admin");
            response.sendRedirect("QuanLySanPham?pid=" + productId + "&Xoa=thanhCong");
        } else if ("update".equals(action)) {
            String productId = request.getParameter("productIdSua");
            Product product = qlspDao.getProduct(Integer.parseInt(productId));
            List<Categories> dsCategories = categoryDao.getAllCategories(); // <-- Thêm dòng này

            request.setAttribute("product", product);
            request.setAttribute("dsCategories", dsCategories); // <-- Và dòng này

            RequestDispatcher dispatcher = request.getRequestDispatcher("suaSanPham.jsp");
            dispatcher.forward(request, response);
        } else if ("capnhat".equals(action)) {
            // Lấy dữ liệu từ form
            int productID = Integer.parseInt(request.getParameter("productID"));
            String name = request.getParameter("name");
            double price = Double.parseDouble(request.getParameter("price"));
            String imageMain = request.getParameter("oldImage");
            int stock = Integer.parseInt(request.getParameter("stock"));
            int categoryID = Integer.parseInt(request.getParameter("categoryID"));
            String introduce = request.getParameter("introduce");
            String infoPro = request.getParameter("infoPro");

            // ➡️ Lấy thông tin cũ trước khi update
            Product oldProduct = qlspDao.getProduct(productID);

            QuanLiSanPham newProduct = new QuanLiSanPham(productID, name, price, imageMain, stock, categoryID, introduce, infoPro);
            qlspDao.update(newProduct, productID);

            // ➡️ Ghi log vào History
            qlspDao.insertHistory("sua", productID, name, convertProductToJson(oldProduct), "admin");

            response.sendRedirect("QuanLySanPham?capnhat=thanhcong");
        }



    }
    private String convertProductToJson(Product product) {
        Gson gson = new Gson();
        return gson.toJson(product);
    }
}
