package vn.edu.hcmuaf.fit.project_final_webcaygiong.controller;

import com.google.gson.Gson;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.QLSPDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.QuanLiSanPham;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.HistoryEntry;

import java.io.IOException;

@WebServlet(name = "UndoServlet", value = "/Undo")
public class UndoServlet extends HttpServlet {
    private QLSPDao qlspDao = new QLSPDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int historyId = Integer.parseInt(request.getParameter("historyId"));

        // Lấy thông tin log lịch sử
        HistoryEntry history = qlspDao.getHistoryById(historyId);
        if (history == null) {
            response.sendRedirect("LichSu?error=NotFound");
            return;
        }

        // Parse oldData
        Gson gson = new Gson();
        QuanLiSanPham oldProduct = gson.fromJson(history.getOldData(), QuanLiSanPham.class);

        // Xử lý Undo theo loại hành động
        if ("xoa".equals(history.getActionType())) {
            qlspDao.insertProduct(oldProduct);
        } else if ("sua".equals(history.getActionType())) {
            qlspDao.update(oldProduct, oldProduct.getProductID());
        }

        // Xóa log lịch sử sau khi undo
        qlspDao.deleteHistory(historyId);

        // Quay về trang lịch sử
        response.sendRedirect("LichSu?undo=success");
    }
}
