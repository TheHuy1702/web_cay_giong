package vn.edu.hcmuaf.fit.project_final_webcaygiong.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.CategoryDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.ProductDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.Categories;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.Product;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.SubCategories;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ProductSevrlet", value = "/TrangChu")
public class ProductServlet extends HttpServlet {
    private ProductDao productDao = new ProductDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // tìm kiem.
//        String searchName = request.getParameter("search");
//        List<Product> productsSearch;
//        // Nếu có từ khóa tìm kiếm, gọi phương thức timKiem
//        if (searchName != null && !searchName.isEmpty()) {
//            productsSearch = productDao.timKiem(searchName);
//        } else {
//            productsSearch = null;
//        }
//        request.setAttribute("ser", searchName);
//        request.setAttribute("productsSearch", productsSearch);
        // Lấy tất cả sản phẩm
        List<Product> products = productDao.getAllProducts();
        request.setAttribute("products", products);
        // ban chay
        List<Product> productSell = productDao.getSellProducts();
        request.setAttribute("productSell", productSell);
        //
        List<Product> productFruit = productDao.getfruitProducts();
        request.setAttribute("productFruit", productFruit);
        //
        List<Product> productBonsai = productDao.getBonsaiProducts();
        request.setAttribute("productBonsai", productBonsai);
        //
        List<Product> productMedicinal = productDao.getmedicinalProducts();
        request.setAttribute("productMedicinal", productMedicinal);
        //
        List<Product> productFlower = productDao.getFlowerProducts();
        request.setAttribute("productFlower", productFlower);
        //
        List<Product> productIndustrial = productDao.getIndustrialProducts();
        request.setAttribute("productIndustrial", productIndustrial);
        //
        List<Product> productNew = productDao.getNewProducts();
        request.setAttribute("productNew", productNew);


        // Chuyển tiếp đến trang JSP
        RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
        dispatcher.forward(request, response);


    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}