package vn.edu.hcmuaf.fit.project_final_webcaygiong.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.CategoryDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.DashBoardDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.ProductDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.Categories;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.Product;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet(name = "DashBoardServlet", value = "/DashBoard")
public class DashBoardServlet extends HttpServlet {
    private DashBoardDao dashBoardDao = new DashBoardDao();
    private ProductDao productDao = new ProductDao();
    private CategoryDao categoryDao =new CategoryDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int productsSL = dashBoardDao.getSLProducts();
        request.setAttribute("productsSL", productsSL);

        int ordersSL = dashBoardDao.getSLOrders();
        request.setAttribute("ordersSL", ordersSL);

        int newOrders =dashBoardDao.getNewOrders();
        request.setAttribute("newOrders", newOrders);

        int userSL=dashBoardDao.getSLUsers();
        request.setAttribute("userSL", userSL);

        String productBestSelling = dashBoardDao.getProductBestSelling();
        request.setAttribute("productBestSelling", productBestSelling);

        double totalRevenue = dashBoardDao.getRevenue();
        request.setAttribute("totalRevenue", totalRevenue);

       // Biểu đồ 1
        List<Integer> revenueList = dashBoardDao.getWeeklyRevenue();
        request.setAttribute("revenueList", revenueList);
        // Biểu đồ 2
        Map<String, Integer> salesData = dashBoardDao.getProductSalesData();
        request.setAttribute("salesData", salesData);

        List<Product> topViewed = productDao.getTopViewedProducts(5); // lấy top 5 sản phẩm
        request.setAttribute("topViewed", topViewed);

        List<Categories> dsCategories = categoryDao.getAllCategories();
        request.setAttribute("dsCategories", dsCategories);

        RequestDispatcher dispatcher = request.getRequestDispatcher("DashBoard.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }
}
