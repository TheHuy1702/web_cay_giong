package vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.cart;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.controller.ProductServlet;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.ProductDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.cart.Cart;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.cart.CartProduct;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.Product;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.User;

import java.io.IOException;

@WebServlet(name = "add", value = "/add-cart")
public class add extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session1 = request.getSession();
        User user = (User) session1.getAttribute("user");
        if (user != null) {
            int id = Integer.parseInt(request.getParameter("pid"));
            int soluong = Integer.parseInt(request.getParameter("soluongSanP"));
            int kho = Integer.parseInt(request.getParameter("kho"));
            if (soluong > kho) {
                response.sendRedirect("ChiTietSanPham?pid=" + id + "&addCart=vuotQuaKho");
            } else {
                ProductDao productDao = new ProductDao();
                Product product = productDao.getProductByID(id);
                if (product == null) {
                    response.sendRedirect("ChiTietSanPham?pid=" + id + "&addCart=false");
                } else {
                    HttpSession session = request.getSession(true);
                    Cart cart = (Cart) session.getAttribute("cart");
                    if (cart == null) cart = new Cart();
                    if (cart.getQuantityOfProduct(id) >= kho) {
                        response.sendRedirect("ChiTietSanPham?pid=" + id + "&addCart=vuotQuaKho");
                    } else {
                        cart.add(product, soluong);
                        session.setAttribute("cart", cart);
                        response.sendRedirect("ChiTietSanPham?pid=" + id + "&addCart=ok");
                    }
                }
            }
        } else {
            response.sendRedirect("login");
        }
    }
}