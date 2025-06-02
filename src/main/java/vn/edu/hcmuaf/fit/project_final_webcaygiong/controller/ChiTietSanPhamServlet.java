package vn.edu.hcmuaf.fit.project_final_webcaygiong.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.CategoryDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.CommentAndReviewDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.ProductDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.SubImageDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.cart.Cart;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ChiTietSanPhamServlet", value = "/ChiTietSanPham")
public class ChiTietSanPhamServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String sid = request.getParameter("pid");
        int id = Integer.parseInt(sid);
        ProductDao productDao = new ProductDao();
        Product p = productDao.getProductByID(id);
        CategoryDao cate = new CategoryDao();
        int cid = p.getCategoryID();// lấy cid.
        String nameCate = cate.getNameCategory(cid);

        // đẩy lên jsp.
        request.setAttribute("detail", p);
        request.setAttribute("cid", cid);
        request.setAttribute("nameCate", nameCate);

        // hiển thị comment và review;
        CommentAndReviewDao commentDao = new CommentAndReviewDao();
        // tất cả bình luận của một sản phẩm.
        List<CommentAndReview> listCommentAndReview = commentDao.getAllCommentOfProduct(id);

        // Kiểm tra tham số showAll
        String showCom = request.getParameter("showAll");
        // nếu null thì set nó là false để thôi nó bị lỗi null.
        if (showCom == null) {
            showCom = "false";
        }
        if (showCom.equalsIgnoreCase("true")) {
            request.setAttribute("listCommentAndReviewAll", listCommentAndReview);
            request.setAttribute("showAll", true); // Thêm thuộc tính để xác định trạng thái
        } else {
            // Nếu không có tham số showAll, chỉ lấy 5 bình luận.
            List<CommentAndReview> latestComments = listCommentAndReview.stream()
                    .limit(5) // Lấy 5 bình luận.
                    .toList();
            request.setAttribute("listCommentAndReview", latestComments);
            request.setAttribute("showAll", false); // Thêm thuộc tính để xác định trạng thái
        }

        // hiện thị sản phẩm tương tự.
        List<Product> similarProducts = productDao.getProductSame(cid, id);
        request.setAttribute("similarProducts", similarProducts);


        // hiện thị ảnh con.
        SubImageDao imageDao = new SubImageDao();
        List<SubImage> listSubImage = imageDao.getSubImage(id);
        request.setAttribute("listSubImage", listSubImage);

        // tính trung bình sao.
        double tbS = commentDao.trungBinhSoSao(id);
        request.setAttribute("tbSao", tbS);

        RequestDispatcher dispatcher = request.getRequestDispatcher("ChiTietSanPham.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }
}