package vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.cart;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.ProductDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.Product;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.User;

import java.io.IOException;

@WebServlet(name = "buyNow", value = "/buyNow")
public class buyNow extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session1=request.getSession();
        User user = (User) session1.getAttribute("user");
        if (user!=null){
            int id = Integer.parseInt(request.getParameter("pid"));
            int soluong = 1;
            ProductDao productDao = new ProductDao();
            Product product = productDao.getProductByID(id);
            if (product == null) {
                response.sendRedirect("ChiTietSanPham?pid=" + id + "&addCart=false");
            } else {
                HttpSession session = request.getSession(true);
                Cart cart = (Cart) session.getAttribute("cart");
                if (cart == null) cart = new Cart();
                cart.add(product, soluong);
                session.setAttribute("cart", cart);
                response.sendRedirect("show-cart");


            }
        }else{
            response.sendRedirect("login");
        }
    }
}