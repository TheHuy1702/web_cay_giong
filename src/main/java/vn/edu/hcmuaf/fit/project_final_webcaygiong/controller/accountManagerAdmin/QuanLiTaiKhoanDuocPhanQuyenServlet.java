package vn.edu.hcmuaf.fit.project_final_webcaygiong.controller.accountManagerAdmin;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.UserDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.UserPermissionDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.User;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.UserPermission;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

@WebServlet(name = "QuanLiTaiKhoanDuocPhanQuyenServlet", value = "/QuanLiTaiKhoanDuocPhanQuyen")
public class QuanLiTaiKhoanDuocPhanQuyenServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        // Kiểm tra xem đã đăng nhập hay chưa
        if (user != null) {
            UserDao userDao = new UserDao();
            List<User> users;
            UserPermissionDao userPermissionDao = new UserPermissionDao();
            String sortBy = request.getParameter("sortBy");
            //tìm kiếm
            String keyword = request.getParameter("keyword");
            if (keyword != null && !keyword.isEmpty()) {
                users = userDao.searchUser(keyword); // Tìm kiếm theo từ khóa
            } else {
                if (sortBy == null) {
                    users = userDao.getUsers("desc"); // Mặc định là mới nhất
                } else if (sortBy.equals("asc")) {
                    sortBy = "asc";
                    users = userDao.getUsers("asc");
                } else {
                    sortBy = "desc";
                    users = userDao.getUsers("desc");
                }
            }
            for (User user1 : users) {
                List<String> permissions = userPermissionDao.getPermissionsByUserId(user1.getUserID());
                request.setAttribute("permissions_" + user1.getUserID(), permissions);
            }
            request.setAttribute("keyword", keyword);
            request.setAttribute("users", users);
            request.setAttribute("sortBy", sortBy);
            RequestDispatcher dispatcher = request.getRequestDispatcher("QuanLiTaiKhoanDuocPhanQuyen.jsp");
            dispatcher.forward(request, response);
        } else {
            response.sendRedirect("login");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        Map<String, Boolean> permissions = new HashMap<>();

        // Nhận quyền từ các checkbox
        permissions.put("DashBoard_view", request.getParameter("DashBoard_view") != null);

        permissions.put("QuanLySanPham_view", request.getParameter("QuanLySanPham_view") != null);
        permissions.put("QuanLySanPham_add", request.getParameter("QuanLySanPham_add") != null);
        permissions.put("QuanLySanPham_edit", request.getParameter("QuanLySanPham_edit") != null);
        permissions.put("QuanLySanPham_delete", request.getParameter("QuanLySanPham_delete") != null);

        permissions.put("QuanLyDonHang_view", request.getParameter("QuanLyDonHang_view") != null);
        permissions.put("QuanLyDonHang_edit", request.getParameter("QuanLyDonHang_edit") != null);

        permissions.put("QuanLiKhachHang_view", request.getParameter("QuanLiKhachHang_view") != null);
        permissions.put("QuanLiKhachHang_delete", request.getParameter("QuanLiKhachHang_delete") != null);

        permissions.put("QuanLiBinhLuanVaDanhGia_view", request.getParameter("QuanLiBinhLuanVaDanhGia_view") != null);
        permissions.put("QuanLiBinhLuanVaDanhGia_delete", request.getParameter("QuanLiBinhLuanVaDanhGia_delete") != null);

        permissions.put("QuanLiTaiKhoanNguoiDung_view", request.getParameter("QuanLiTaiKhoanNguoiDung_view") != null);
        permissions.put("QuanLiTaiKhoanNguoiDung_edit", request.getParameter("QuanLiTaiKhoanNguoiDung_edit") != null);
        permissions.put("QuanLiTaiKhoanNguoiDung_delete", request.getParameter("QuanLiTaiKhoanNguoiDung_delete") != null);

        permissions.put("QuanLiTaiKhoanDuocPhanQuyen_view", request.getParameter("QuanLiTaiKhoanDuocPhanQuyen_view") != null);
        permissions.put("QuanLiTaiKhoanDuocPhanQuyen_edit", request.getParameter("QuanLiTaiKhoanDuocPhanQuyen_edit") != null);
        permissions.put("QuanLiTaiKhoanDuocPhanQuyen_delete", request.getParameter("QuanLiTaiKhoanDuocPhanQuyen_delete") != null);

        permissions.put("QuanLiTrangGioiThieu_view", request.getParameter("QuanLiTrangGioiThieu_view") != null);
        permissions.put("QuanLiTrangGioiThieu_edit", request.getParameter("QuanLiTrangGioiThieu_edit") != null);

        permissions.put("QuanLyKhoVoucher_view", request.getParameter("QuanLyKhoVoucher_view") != null);
        permissions.put("QuanLyKhoVoucher_add", request.getParameter("QuanLyKhoVoucher_add") != null);
        permissions.put("QuanLyKhoVoucher_edit", request.getParameter("QuanLyKhoVoucher_edit") != null);
        permissions.put("QuanLyKhoVoucher_delete", request.getParameter("QuanLyKhoVoucher_delete") != null);

        // Cập nhật quyền cho người dùng
        updateUserPermissions(userId, permissions);
        response.sendRedirect("QuanLiTaiKhoanDuocPhanQuyen?phanQuyen=thanhcong");
    }

    private void updateUserPermissions(int userId, Map<String, Boolean> permissions) {
        UserPermissionDao dao = new UserPermissionDao();
        // xóa quyền cũ.
        dao.deletePermissionsByUserId(userId);
        for (Map.Entry<String, Boolean> entry : permissions.entrySet()) {
            if (entry.getValue()) {
                int permissionID = getPermissionId(entry.getKey());
                int pageID = getPageId(entry.getKey());
                if (pageID != 0 && permissionID != 0) {
                    UserPermission userPermission = new UserPermission(userId, pageID, permissionID);
                    dao.insertUserPermission(userPermission);
                }
            }
        }
    }

    // Phương Thức Lấy permissionID.
    private int getPermissionId(String permissionKey) {
        String action = "";
        // Sử dụng StringTokenizer để lấy phần cuối cùng của permissionKey
        StringTokenizer tokenizer = new StringTokenizer(permissionKey, "_");
        while (tokenizer.hasMoreTokens()) {
            action = tokenizer.nextToken(); // Lấy phần cuối cùng là action (view, add, edit, delete)
        }
        // Kiểm tra action và trả về permissionID tương ứng
        return switch (action) {
            case "view" -> 4; // view
            case "add" -> 1; // add
            case "edit" -> 2; // edit
            case "delete" -> 3; // delete
            default -> 0; // Không tìm thấy
        };
    }

    // Phương Thức Lấy pageID.
    private int getPageId(String permissionKey) {
        String pageName = "";
        // Sử dụng StringTokenizer để lấy phần đầu tiên của permissionKey
        StringTokenizer tokenizer = new StringTokenizer(permissionKey, "_");
        if (tokenizer.hasMoreTokens()) {
            pageName = tokenizer.nextToken();
        }
        // Kiểm tra pageName và trả về pageID tương ứng
        return switch (pageName) {
            case "DashBoard" -> 1; // ID cho DashBoard
            case "QuanLySanPham" -> 2; // ID cho QuanLySanPham
            case "QuanLyDonHang" -> 3; // ID cho QuanLyDonHang
            case "QuanLiKhachHang" -> 4; // ID cho QuanLiKhachHang
            case "QuanLiBinhLuanVaDanhGia" -> 5; // ID cho QuanLiBinhLuanVaDanhGia
            case "QuanLiTaiKhoanNguoiDung" -> 6; // ID cho QuanLiTaiKhoanNguoiDung
            case "QuanLiTaiKhoanDuocPhanQuyen" -> 7; // ID cho QuanLiTaiKhoanDuocPhanQuyen
            case "QuanLiTrangGioiThieu" -> 8; // ID cho QuanLiTrangGioiThieu
            case "QuanLyKhoVoucher" -> 9; // ID cho QuanLyKhoVoucher
            default -> 0; // Không tìm thấy
        };
    }
}