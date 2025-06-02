package vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.cart;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.cart.CartProduct;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.User;

import java.io.IOException;

@WebServlet(name = "update", value = "/update-cart")
public class update extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session1 = request.getSession();
        User user = (User) session1.getAttribute("user");
        if (user != null) {
            HttpSession session = request.getSession();
            Cart cart = (Cart) session.getAttribute("cart");
            if (cart == null) {
                cart = new Cart();
                session.setAttribute("cart", cart);
            }
            int id = Integer.parseInt(request.getParameter("pid"));
            int soluong = Integer.parseInt(request.getParameter("soluong"));
            int kho = Integer.parseInt(request.getParameter("kho"));
            if (soluong > kho) {
                response.sendRedirect("show-cart?pid=" + id + "&update=vuotQuaKho");
            } else if (soluong < 1) {
                response.sendRedirect("show-cart?pid=" + id + "&update=SoKhongAm");
            } else {
                cart.update(id, soluong);
                response.sendRedirect("show-cart?pid=" + id + "&update=" + soluong);
            }
        } else {
            response.sendRedirect("login");
        }
    }
}