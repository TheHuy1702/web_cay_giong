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

@WebServlet(name = "SubCategoryServlet", value = "/subCategory")
public class SubCategoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CategoryDao categoryDao = new CategoryDao();
        List<Categories> listCategory = categoryDao.getAllCategories();
        List<SubCategories> listSubCategory = categoryDao.getAllSubCategoriesOfCategory();
        request.setAttribute("listCategory", listCategory);
        request.setAttribute("listSubCategory", listSubCategory);
        // hiển thị theo danh mục con.
        ProductDao pdao = new ProductDao();
        String subN = request.getParameter("subN");
        List<Product> listPageSub;
        if (subN.equalsIgnoreCase("Giống cây khác")) {
            listPageSub = pdao.getProductKhac();
        } else {
            listPageSub = pdao.getProductBySubCategory(subN);
        }
        request.setAttribute("listP", listPageSub);
        request.setAttribute("actSub", subN);
        // ẩn lọc giá.
        request.setAttribute("hidePriceFilter", true);
        RequestDispatcher dispatcher = request.getRequestDispatcher("Product.jsp");
        dispatcher.forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }
}