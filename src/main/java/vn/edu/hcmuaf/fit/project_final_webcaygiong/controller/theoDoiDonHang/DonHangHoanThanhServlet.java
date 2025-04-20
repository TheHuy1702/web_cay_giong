package vn.edu.hcmuaf.fit.project_final_webcaygiong.controller.theoDoiDonHang;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.CommentAndReviewDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.CustomerDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.OrderDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.QLDHDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.*;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.Map;

@WebServlet(name = "DonHangHoanThanhServlet", value = "/DonHangHoanThanh")
public class DonHangHoanThanhServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        QLDHDao dao = new QLDHDao();
        CustomerDao customerDao = new CustomerDao();
        List<Map<String, Object>> orders;
        String status = request.getParameter("status");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        // Kiểm tra xem đã đăng nhập hay chưa.
        if (user != null) {
            int userID = user.getUserID();
            Customer customer = customerDao.getCustomerWithUID(userID);
            if (status != null && !status.isEmpty()  && status.equals("Đã giao")) {
                orders = dao.dsOrderWithStatusOfCus(status, customer.getCustomerID());
                // Lấy danh sách OrderItems cho từng đơn hàng.
                OrderDao orderDao = new OrderDao();
                for (Map<String, Object> order : orders) {
                    int orderId = (int) order.get("orderID");
                    List<Map<String, Object>> orderItems = orderDao.getOrderItemsByOrderID(orderId);
                    order.put("orderItems", orderItems); // Thêm danh sách OrderItems vào từng đơn hàng
                }
                int slHuy=dao.soluongDHTheoTrangThai("Đã hủy", customer.getCustomerID());
                int slChoXN=dao.soluongDHTheoTrangThai("Chờ xác nhận", customer.getCustomerID());
                int slChoGH=dao.soluongDHTheoTrangThai("Đã xác nhận", customer.getCustomerID());
                int slAll=dao.soluongDHTheoTrangThai("all", customer.getCustomerID());

                request.setAttribute("orders", orders);
                request.setAttribute("slDH", orders.size());
                request.setAttribute("slHuy", slHuy);
                request.setAttribute("slChoXN", slChoXN);
                request.setAttribute("slChoGH", slChoGH);
                request.setAttribute("slAll", slAll);
            }
            RequestDispatcher dispatcher = request.getRequestDispatcher("DonHangHoanThanh.jsp");
            dispatcher.forward(request, response);
        } else {
            response.sendRedirect("login");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int productID = Integer.parseInt(request.getParameter("pid"));
        System.out.println("PID: "+productID);
        String name = request.getParameter("nameCus");
        String content = request.getParameter("content");
        int ratingStars = Integer.parseInt(request.getParameter("ratingStars"));
        // Lấy đối tượng User từ session
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user"); // Lấy đối tượng user từ session

        if (user == null) {
            // Xử lý trường hợp user không tồn tại trong session
            response.sendRedirect("Login"); // Chuyển hướng đến trang đăng nhập
            return;
        }

        int userID = user.getUserID();
        CommentAndReview comment = new CommentAndReview();
        comment.setUserID(userID);
        comment.setName(name);
        comment.setProductID(productID);
        comment.setContent(content);
        comment.setRatingStars(ratingStars);

        CommentAndReviewDao commentDao = new CommentAndReviewDao();
        commentDao.addCommentAndReview(comment);
        String status = URLEncoder.encode("Đã giao", StandardCharsets.UTF_8.toString());
        String danhGia = URLEncoder.encode("thanhcong", StandardCharsets.UTF_8.toString());
        response.sendRedirect("DonHangHoanThanh?status=" + status + "&danhgia=" + danhGia);
    }
}