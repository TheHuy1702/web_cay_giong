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

@WebServlet(name = "CategoryServlet", value = "/category")
public class CategoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Tạo DAO để truy xuất dữ liệu
        CategoryDao categoryDao = new CategoryDao();
        ProductDao productDao = new ProductDao();

        // Lấy danh sách danh mục và danh mục con
        List<Categories> listCategory = categoryDao.getAllCategories();
        List<SubCategories> listSubCategory = categoryDao.getAllSubCategoriesOfCategory();
        request.setAttribute("listCategory", listCategory);
        request.setAttribute("listSubCategory", listSubCategory);

        // Lấy ID danh mục từ tham số yêu cầu
        String cid = request.getParameter("cid");
        request.setAttribute("act", cid);

        // Xử lý lọc sản phẩm theo khoảng giá
        String priceRange = request.getParameter("priceRange");
        if (priceRange != null && !priceRange.isEmpty()) {
            String[] prices = priceRange.split("-");
            int minPrice = Integer.parseInt(prices[0]);
            int maxPrice = prices.length > 1 ? Integer.parseInt(prices[1]) : Integer.MAX_VALUE;

            // Lưu giá vào thuộc tính yêu cầu
            request.setAttribute("minPrice", minPrice);
            request.setAttribute("maxPrice", maxPrice);

            // Lấy danh sách sản phẩm theo khoảng giá
            List<Product> listFilter = productDao.getProductByPrice(Integer.parseInt(cid), minPrice, maxPrice);
            request.setAttribute("listP", listFilter);

            // Ẩn các nút phân trang
            request.setAttribute("hidePagination", true);
        } else {
            // Nếu không có lọc giá, xử lý phân trang
            String page = request.getParameter("page");
            if (page == null) {
                page = "1"; // Mặc định trang 1
            }
            int index = Integer.parseInt(page);

            // Tính toán tổng số sản phẩm và số trang
            int totalRows = productDao.totalRows(Integer.parseInt(cid));
            int endPage = (totalRows / 16) + (totalRows % 16 == 0 ? 0 : 1);

            // Lấy danh sách sản phẩm cho trang hiện tại
            List<Product> listPage = productDao.getProductOfPageByCategory(Integer.parseInt(cid), index);
            request.setAttribute("listP", listPage);
            request.setAttribute("endP", endPage);
            request.setAttribute("tag", index);
        }

        // Chuyển tiếp đến trang JSP để hiển thị kết quả
        RequestDispatcher dispatcher = request.getRequestDispatcher("Product.jsp");
        dispatcher.forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }
}