package vn.edu.hcmuaf.fit.project_final_webcaygiong.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.*;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.*;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet(name = "QLDHServlet", value = "/QuanLyDonHang")
public class QLDHServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Tạo đối tượng DAO
        QLDHDao dao = new QLDHDao();
        //sắp xếp
        List<Map<String, Object>> orders;
        String sortBy = request.getParameter("sortBy");

        //tìm kiếm
        String keyword = request.getParameter("keyword");
        if (keyword != null && !keyword.isEmpty()) {
            orders = dao.searchOrders(keyword); // Tìm kiếm theo từ khóa
        } else {
            if (sortBy == null) {
                orders = dao.dsOrder("desc"); // Mặc định là mới nhất
            } else if (sortBy.equals("asc")) {
                sortBy = "asc";
                orders = dao.dsOrder("asc");
            } else {
                sortBy = "desc";
                orders = dao.dsOrder("desc");
            }
        }
        request.setAttribute("keyword", keyword);
        request.setAttribute("orders", orders);
        request.setAttribute("sortBy", sortBy);

        // Chuyển tiếp dữ liệu đến JSP để hiển thị
        RequestDispatcher dispatcher = request.getRequestDispatcher("QuanLyDonHang.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws
            ServletException, IOException {
        OrderDao orderDao = new OrderDao();
        String sorderID = request.getParameter("orderID");
        int orderID = Integer.parseInt(sorderID);
        String action = request.getParameter("action");
        if (action.equals("xacNhan")) {
            orderDao.updateOrderStatus(orderID, "Đã Xác Nhận");
            response.sendRedirect("QuanLyDonHang?update=daXacNhan");
        } else if (action.equals("huyDon")) {
            orderDao.updateOrderStatus(orderID, "Đã Hủy");
//            request.setAttribute("trangThai", true);
            response.sendRedirect("QuanLyDonHang?update=daHuy");
        } else {
            response.sendRedirect("QuanLyDonHang?update=thatbai");
        }

    }
}
