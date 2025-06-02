package vn.edu.hcmuaf.fit.project_final_webcaygiong.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.LogUtil;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.QuanLiCustomerDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.QuanLiCustomers;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.UserPermissionDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.User;


import java.io.IOException;
import java.util.List;

@WebServlet(name = "QuanLiKhachHangServlet", value = "/QuanLiKhachHang")
public class QuanLiKhachHangServlet extends HttpServlet {
    private LogUtil logUtil = new LogUtil();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserPermissionDao userPermissionDao = new UserPermissionDao();
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        // Kiểm tra xem đã đăng nhập hay chưa
        if (user != null) {
            int userId = user.getUserID();
            if (!userPermissionDao.hasPermission(userId, 4, 4)) {
                request.setAttribute("errorMessage", "Bạn không có quyền truy cập trang này.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("QuanLiKhachHang.jsp");
                dispatcher.forward(request, response);
                return;
            }
            boolean canDelete = userPermissionDao.hasPermission(userId, 4, 3);
            request.setAttribute("canDelete", canDelete);
        QuanLiCustomerDao customerDao = new QuanLiCustomerDao();
        String searchQuery = request.getParameter("search");
        String action = request.getParameter("action");

        List<QuanLiCustomers> customerList;
        if (searchQuery != null && !searchQuery.isEmpty()) {
            customerList = customerDao.searchCustomers(searchQuery);
        } else {
            customerList = customerDao.getAllCustomerWithUser();
        }

        // Gán danh sách khách hàng vào request
        request.setAttribute("customerList", customerList);

        // Nếu có yêu cầu xem lịch sử xóa, thêm log vào request
        if ("lichSuXoa".equals(action)) {
            List<String> deleteLogs = customerDao.getDeleteCustomerLogs();
            request.setAttribute("deleteLogs", deleteLogs);
        }

        // Chỉ forward một lần
        request.getRequestDispatcher("QuanLiKhachHang.jsp").forward(request, response);
        } else {
            response.sendRedirect("login");
        }
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String action = request.getParameter("action");
        if ("delete".equals(action)) {
            int customerID = Integer.parseInt(request.getParameter("customerID"));

            // Tạo đối tượng DAO để thực hiện xóa
            QuanLiCustomerDao customerDao = new QuanLiCustomerDao();

            // Lấy dữ liệu khách hàng cũ trước khi xóa
            QuanLiCustomers oldCustomer = customerDao.getCustomerByID(customerID);
            String oldData = oldCustomer != null ? oldCustomer.toString() : "Không tìm thấy khách hàng";

            // Ghi log trước khi xóa
            logUtil.log(
                    request,
                    "Xóa khách hàng",
                    "Cảnh báo",
                    "QuanLiKhachHangServlet",
                    "Customer",
                    oldData,
                    null
            );



            // Xóa khách hàng
            customerDao.deleteCustomer(customerID);
            // Chuyển hướng lại đến trang quản lý khách hàng
            response.sendRedirect("QuanLiKhachHang?Xoa=thanhCong");
        }
    }
}