package vn.edu.hcmuaf.fit.project_final_webcaygiong.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.IntroductionDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.Introduction;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.User;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.UserPermissionDao;


import java.io.IOException;
import java.util.List;

@WebServlet(name = "QuanLiGioiThieuServlet", value = "/QuanLiGioiThieu")
public class QuanLiGioiThieuServlet extends HttpServlet {
    IntroductionDao introductionDao = new IntroductionDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserPermissionDao userPermissionDao = new UserPermissionDao();
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        // Kiểm tra xem đã đăng nhập hay chưa
        if (user != null) {
            int userId = user.getUserID();
            if (!userPermissionDao.hasPermission(userId, 8, 4)) {
                request.setAttribute("errorMessage", "Bạn không có quyền truy cập trang này.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("QuanLiTrangGioiThieu.jsp");
                dispatcher.forward(request, response);
                return;
            }

            boolean canEdit = userPermissionDao.hasPermission(userId, 8, 2);
            request.setAttribute("canEdit", canEdit);
        // Lấy thông tin giới thiệu từ cơ sở dữ liệu
        List<Introduction> introductionList = introductionDao.getIntroduction();

        // Đẩy thông tin lên request
        request.setAttribute("introductionList", introductionList);
        RequestDispatcher dispatcher = request.getRequestDispatcher("QuanLiTrangGioiThieu.jsp");
        dispatcher.forward(request, response);
        } else {
            response.sendRedirect("login");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Cập nhật thông tin giới thiệu
        String[] sectionNames = request.getParameterValues("sectionName");
        String[] contents = request.getParameterValues("content");
        String[] introIDs = request.getParameterValues("introID");

        if (sectionNames != null && contents != null && introIDs != null) {
            for (int i = 0; i < introIDs.length; i++) {
                int introID = Integer.parseInt(introIDs[i]);
                String sectionName = sectionNames[i];
                String content = contents[i];

                // Cập nhật thông tin vào cơ sở dữ liệu
                introductionDao.updateIntroduction(introID, sectionName, content);
            }
        }

        // Chuyển hướng về trang quản lý
        response.sendRedirect("QuanLiGioiThieu");
    }
}