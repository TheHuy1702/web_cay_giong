package vn.edu.hcmuaf.fit.project_final_webcaygiong.controller.accountManagerAdmin;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.CustomerDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.UserDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.Customer;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.User;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@WebServlet(name = "QuanLiTaiKhoanUserServlet", value = "/QuanLiTaiKhoanUser")
public class QuanLiTaiKhoanUserServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserDao userDao = new UserDao();
        List<User> users;
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
        request.setAttribute("keyword", keyword);
        request.setAttribute("users", users);
        request.setAttribute("sortBy", sortBy);


        RequestDispatcher dispatcher = request.getRequestDispatcher("QuanLiTaiKhoanNguoiDung.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }
}