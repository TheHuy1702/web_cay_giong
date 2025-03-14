package vn.edu.hcmuaf.fit.project_final_webcaygiong.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.QuanLiCustomerDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.QuanLiCustomers;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "QuanLiKhachHangServlet", value = "/QuanLiKhachHang")
public class QuanLiKhachHangServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        QuanLiCustomerDao customerDao = new QuanLiCustomerDao();
        String searchQuery = request.getParameter("search");

        List<QuanLiCustomers> customerList;
        if (searchQuery != null && !searchQuery.isEmpty()) {
            // Tìm kiếm khách hàng theo tên, số điện thoại hoặc mã khách hàng
            customerList = customerDao.searchCustomers(searchQuery);
        } else {
            // Lấy tất cả khách hàng nếu không có tìm kiếm
            customerList = customerDao.getAllCustomerWithUser();
        }

        request.setAttribute("customerList", customerList);
        RequestDispatcher dispatcher = request.getRequestDispatcher("QuanLiKhachHang.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("delete".equals(action)) {
            int customerID = Integer.parseInt(request.getParameter("customerID"));

            // Tạo đối tượng DAO để thực hiện xóa
            QuanLiCustomerDao customerDao = new QuanLiCustomerDao();

            // Xóa khách hàng
            customerDao.deleteCustomer(customerID);

            // Chuyển hướng lại đến trang quản lý khách hàng
            response.sendRedirect("QuanLiKhachHang?Xoa=thanhCong");
        }
    }
}