package vn.edu.hcmuaf.fit.project_final_webcaygiong.controller;

import com.google.gson.Gson;
import com.mysql.cj.util.LogUtils;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.*;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.CommentAndReview;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.Product;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.User;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "QuanLiBinhLuanVaDanhGiaServlet", value = "/QuanLiBinhLuanVaDanhGia")
public class QuanLiBinhLuanVaDanhGiaServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserPermissionDao userPermissionDao = new UserPermissionDao();
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        // Kiểm tra xem đã đăng nhập hay chưa.
        if (user != null) {
            int userId = user.getUserID();
            if (!userPermissionDao.hasPermission(userId, 5, 4)) {
                request.setAttribute("errorMessage", "Bạn không có quyền truy cập trang này.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("QuanLiBinhLuanVaDanhGia.jsp");
                dispatcher.forward(request, response);
                return;
            }
            // kiểm tra có quyền xóa bình luận hay không.
            boolean canDelete = userPermissionDao.hasPermission(userId, 5, 3);
            request.setAttribute("canDelete", canDelete);

            CommentAndReviewDao commentDao = new CommentAndReviewDao();
            ProductDao productDao = new ProductDao();

            // Lấy tất cả sản phẩm
            List<Product> allProducts = productDao.getAllProducts();
            request.setAttribute("allProducts", allProducts);

            String sproductID = request.getParameter("productID");
            String starRating = request.getParameter("starRating");
            String khoiPhuc = request.getParameter("khoiPhuc");
            String xoaVinhVien = request.getParameter("xoaVinhVien");
            List<CommentAndReview> filteredComments;
            List<CommentAndReview> historyList = commentDao.getAllCommentAndReviewDeleted();

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
                    // Lọc bình luận theo số sao và sản phẩm
                    filteredComments = commentDao.getAllCommentOfProductByRatingAndIDP(productID, rating);
                }
            }
            request.setAttribute("listCommentAndReview", filteredComments);
            request.setAttribute("historyList", historyList);
            request.setAttribute("selectedProductID", sproductID); // Lưu ID sản phẩm đã chọn
            request.setAttribute("selectedRatingStar", starRating);
            request.setAttribute("showHistory", "ThanhCong".equals(khoiPhuc) || "ThanhCong".equals(xoaVinhVien));

            RequestDispatcher dispatcher = request.getRequestDispatcher("QuanLiBinhLuanVaDanhGia.jsp");
            dispatcher.forward(request, response);
        } else {
            response.sendRedirect("login");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String sproductID = request.getParameter("productID");
        String action = request.getParameter("action");
        String starRating = request.getParameter("starRating");
        CommentAndReviewDao commentDao = new CommentAndReviewDao();
        LogUtil log = new LogUtil();
        if ("delete".equals(action)) {
            int commentId = Integer.parseInt(request.getParameter("commentId"));
            log.log(request, "Xóa bình luận và đánh giá", "Cảnh báo", "QuanLiBinhLuanVaDanhGia.jsp", "Sản Phẩm được đánh giá", convertProductToJson(commentDao.getCommentAndReview(commentId)), "Trống");
            commentDao.deleteCommentAndReview(commentId);
            // Chuyển tiếp lại đến trang quản lý bình luận.
            response.sendRedirect("QuanLiBinhLuanVaDanhGia?starRating=" + starRating + "&productID=" + sproductID + "&Xoa=ThanhCong");
        } else if ("redo".equals(action)) {
            int commentIdHis = Integer.parseInt(request.getParameter("commentIdHis"));
            log.log(request, "Khôi phục bình luận và đánh giá", "Thông báo", "QuanLiBinhLuanVaDanhGia.jsp", "Sản Phẩm được đánh giá", "Trống", convertProductToJson(commentDao.getCommentAndReview(commentIdHis)));
            commentDao.redoCommentAndReview(commentIdHis);
            response.sendRedirect("QuanLiBinhLuanVaDanhGia?khoiPhuc=ThanhCong");
        } else if ("deleteReal".equals(action)) {
            int commentIdHis = Integer.parseInt(request.getParameter("commentIdHis"));
            log.log(request, "Xóa vĩnh viễn bình luận và đánh giá", "Cảnh báo", "QuanLiBinhLuanVaDanhGia.jsp", "Sản Phẩm được đánh giá", convertProductToJson(commentDao.getCommentAndReview(commentIdHis)), "Trống");
            commentDao.deleteCommentAndReviewReal(commentIdHis);
            response.sendRedirect("QuanLiBinhLuanVaDanhGia?xoaVinhVien=ThanhCong");
        }
    }

    private String convertProductToJson(CommentAndReview c) {
        Gson gson = new Gson();
        return gson.toJson(c);
    }
}