package vn.edu.hcmuaf.fit.project_final_webcaygiong.controller.voucher;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.CommentAndReviewDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.DiscountDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.LogUtil;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.UserPermissionDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.Discount;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.User;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.List;

@WebServlet(name = "QuanLyVoucherServlet", value = "/QuanLyVoucher")
public class QuanLyVoucherServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserPermissionDao userPermissionDao = new UserPermissionDao();
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        // Kiểm tra xem đã đăng nhập hay chưa
        if (user != null) {
            int userId = user.getUserID();
            if (!userPermissionDao.hasPermission(userId, 9, 4)) {
                request.setAttribute("errorMessage", "Bạn không có quyền truy cập trang này.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("QuanLyKhoVoucher.jsp");
                dispatcher.forward(request, response);
                return;
            }
            boolean canDelete = userPermissionDao.hasPermission(userId, 9, 3);
            boolean canAdd = userPermissionDao.hasPermission(userId, 9, 1);
            boolean canEdit = userPermissionDao.hasPermission(userId, 9, 2);
            request.setAttribute("canDelete", canDelete);
            request.setAttribute("canAdd", canAdd);
            request.setAttribute("canEdit", canEdit);

            DiscountDao dao = new DiscountDao();
            List<Discount> listVoucher = dao.getAllDiscounts();
            List<Discount> listHisVoucher = dao.getAllDiscountsDeleted();
            String khoiPhuc = request.getParameter("khoiPhuc");
            String xoaVinhVien = request.getParameter("xoaVinhVien");
            request.setAttribute("listVoucher", listVoucher);
            request.setAttribute("listHisVoucher", listHisVoucher);
            request.setAttribute("showHistory", "ThanhCong".equals(khoiPhuc) || "ThanhCong".equals(xoaVinhVien));
            RequestDispatcher dispatcher = request.getRequestDispatcher("QuanLyKhoVoucher.jsp");
            dispatcher.forward(request, response);
        } else {
            response.sendRedirect("login");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DiscountDao dao = new DiscountDao();
        String sId = request.getParameter("voucherId");
        int id = sId == null ? 0 : Integer.parseInt(sId);
        String action = request.getParameter("action");
        String actionDelete = request.getParameter("actionDelete");
        if ("delete".equals(actionDelete)) {
            actionDeleteDiscount(id);
            response.sendRedirect("QuanLyVoucher?xoa=ThanhCong");
        }
        if ("add".equals(action)) {
            String code = request.getParameter("code");
            String description = request.getParameter("description");
            String minVal = request.getParameter("minValue");
            double minValue = minVal == null ? 0.0 : Double.parseDouble(minVal);
            String startDate = request.getParameter("startDate");
            String endDate = request.getParameter("endDate");
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
            LocalDateTime startDateConvert = null;
            LocalDateTime endDateConvert = null;
            try {
                startDateConvert = LocalDateTime.parse(startDate, formatter);
                endDateConvert = LocalDateTime.parse(endDate, formatter);
            } catch (DateTimeParseException e) {
                e.printStackTrace(); // Xử lý lỗi nếu chuỗi không hợp lệ
            }
            Discount discount = new Discount();
            discount.setEndDate(endDateConvert);
            discount.setCode(code);
            discount.setDescription(description);
            discount.setMinOrderValue(minValue);
            discount.setStartDate(startDateConvert);
            dao.addDiscount(discount);
            response.sendRedirect("QuanLyVoucher?them=ThanhCong");
        } else if ("edit".equals(action)) {
            String code = request.getParameter("code");
            String description = request.getParameter("description");
            String minVal = request.getParameter("minValue");
            double minValue = minVal == null ? 0.0 : Double.parseDouble(minVal);
            String startDate = request.getParameter("startDate");
            String endDate = request.getParameter("endDate");
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
            LocalDateTime startDateConvert = null;
            LocalDateTime endDateConvert = null;
            try {
                startDateConvert = LocalDateTime.parse(startDate, formatter);
                endDateConvert = LocalDateTime.parse(endDate, formatter);
            } catch (DateTimeParseException e) {
                e.printStackTrace(); // Xử lý lỗi nếu chuỗi không hợp lệ
            }
            Discount discount = new Discount();
            discount.setEndDate(endDateConvert);
            discount.setCode(code);
            discount.setDescription(description);
            discount.setMinOrderValue(minValue);
            discount.setStartDate(startDateConvert);
            dao.updateDiscount(discount, id);
            response.sendRedirect("QuanLyVoucher?capNhat=ThanhCong");
        } else if ("redo".equals(action)) {
            int vID = Integer.parseInt(request.getParameter("vID"));
            dao.redoDiscount(vID);
            response.sendRedirect("QuanLyVoucher?khoiPhuc=ThanhCong");
        } else if ("deleteReal".equals(action)) {
            int vID = Integer.parseInt(request.getParameter("vID"));
            dao.deleteDiscountReal(vID);
            response.sendRedirect("QuanLyVoucher?xoaVinhVien=ThanhCong");
        }
    }

    private void actionDeleteDiscount(int id) {
        DiscountDao dao = new DiscountDao();
        dao.deleteDiscount(id);
    }
}