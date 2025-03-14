package vn.edu.hcmuaf.fit.project_final_webcaygiong.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.CommentAndReviewDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.ProductDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.CommentAndReview;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.Product;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "QuanLiBinhLuanVaDanhGiaServlet", value = "/QuanLiBinhLuanVaDanhGia")
public class QuanLiBinhLuanVaDanhGiaServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CommentAndReviewDao commentDao = new CommentAndReviewDao();
        ProductDao productDao = new ProductDao();

        // Lấy tất cả sản phẩm
        List<Product> allProducts = productDao.getAllProducts();
        request.setAttribute("allProducts", allProducts);

        String sproductID = request.getParameter("productID");
        String starRating = request.getParameter("starRating");

        List<CommentAndReview> filteredComments;

        // Kiểm tra xem sproductID có null hoặc rỗng không
        if (sproductID == null || sproductID.isEmpty()) {
            // Nếu không có productID, hiển thị tất cả bình luận
            filteredComments = commentDao.getAllCommentAndReview();
            if (starRating != null && !starRating.isEmpty()) {
                int rating = Integer.parseInt(starRating);
                // Lọc bình luận theo số sao
                filteredComments = commentDao.getAllCommentOfProductByRating(rating);
            }
        } else {
            int productID = Integer.parseInt(sproductID);
            // Nếu có productID, lấy bình luận của sản phẩm đó
            filteredComments = commentDao.getAllCommentOfProduct(productID);

            // Kiểm tra số sao
            if (starRating != null && !starRating.isEmpty()) {
                int rating = Integer.parseInt(starRating);
                // Lọc bình luận theo số sao
                filteredComments = commentDao.getAllCommentOfProductByRatingAndIDP(productID, rating);
            }
        }

        request.setAttribute("listCommentAndReview", filteredComments);
        request.setAttribute("selectedProductID", sproductID); // Lưu ID sản phẩm đã chọn
        request.setAttribute("selectedRatingStar", starRating);

        RequestDispatcher dispatcher = request.getRequestDispatcher("QuanLiBinhLuanVaDanhGia.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String sproductID = request.getParameter("productID");
        String action = request.getParameter("action");
        String starRating = request.getParameter("starRating");
        CommentAndReviewDao commentDao = new CommentAndReviewDao();

        if ("delete".equals(action)) {
            int commentId = Integer.parseInt(request.getParameter("commentId"));
            commentDao.deleteCommentAndReview(commentId);
        }

        // Chuyển tiếp lại đến trang quản lý bình luận.
        response.sendRedirect("QuanLiBinhLuanVaDanhGia?starRating=" + starRating + "&productID=" + sproductID + "&Xoa=ThanhCong");

    }
}