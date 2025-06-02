package vn.edu.hcmuaf.fit.project_final_webcaygiong.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.QLSPDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.HistoryEntry;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "LichSuServlet ", value = "/LichSu")
public class LichSuServlet extends HttpServlet {
    private QLSPDao qlspDao = new QLSPDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<HistoryEntry> histories = qlspDao.getAllHistories();
        request.setAttribute("histories", histories);

        RequestDispatcher dispatcher = request.getRequestDispatcher("LichSu.jsp");
        dispatcher.forward(request, response);
    }
}
