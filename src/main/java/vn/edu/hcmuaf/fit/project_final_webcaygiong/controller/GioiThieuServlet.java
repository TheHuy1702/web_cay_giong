package vn.edu.hcmuaf.fit.project_final_webcaygiong.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.IntroductionDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.Introduction;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "GioiThieuServlet", value = "/GioiThieu")
public class GioiThieuServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy thông tin giới thiệu từ cơ sở dữ liệu
        IntroductionDao introductionDao = new IntroductionDao();
        List<Introduction> introductionList = introductionDao.getIntroduction();

        // Đẩy thông tin lên request
        request.setAttribute("introductionList", introductionList);
        RequestDispatcher dispatcher = request.getRequestDispatcher("GioiThieu.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }
}