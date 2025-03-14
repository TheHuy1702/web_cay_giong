package vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.cart;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.CommentAndReviewDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.ProductDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.cart.Cart;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.Product;

import java.io.IOException;

@WebServlet(name = "remove", value = "/del-cart")
public class remove extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("pid"));
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }
        if ("delete".equals(action)) {
            boolean dl = cart.removeProduct(id);
            if (dl) {
                response.sendRedirect("show-cart?remove=thanhCong");
            } else {
                response.sendRedirect("show-cart?remove=thatBai");
            }
        }
    }
}
