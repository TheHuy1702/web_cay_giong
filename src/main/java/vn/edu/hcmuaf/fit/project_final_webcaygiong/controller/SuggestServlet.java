package vn.edu.hcmuaf.fit.project_final_webcaygiong.controller;

import com.google.gson.Gson;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.ProductDao;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "SuggestServlet ", value = "/SuggestServlet")
public class SuggestServlet extends HttpServlet {
    private ProductDao productDao = new ProductDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String query = request.getParameter("query");
        List<String> suggestions = new ArrayList<>();

        if (query != null && !query.trim().isEmpty()) {
            suggestions = productDao.getSuggestions(query);
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try (PrintWriter out = response.getWriter()) {
            new Gson().toJson(suggestions, out);
            out.flush();
        }
    }
}
