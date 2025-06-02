package vn.edu.hcmuaf.fit.project_final_webcaygiong.controller.voucher;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import org.json.JSONArray;
import org.json.JSONObject;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.CustomerDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.DiscountDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.cart.Cart;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.cart.CartProduct;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.Customer;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.Discount;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.User;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.diaChi.GHNApiClient;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet(name = "ApplyDiscountServlet", value = "/ApplyDiscount")
public class ApplyDiscountServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        Cart cart = (Cart) session.getAttribute("cart");
        if (user != null && cart != null) {
            double tongGiaCu = cart.getTotal();
            double giamGia = 0;

            String code = request.getParameter("code");
            DiscountDao discountDao = new DiscountDao();
            Discount discount = discountDao.getDiscountByCode(code);
            if(discount != null){
                if(discount.getPercentDecrease() == 0.0){
                    giamGia = 0;
                }else{
                    giamGia = tongGiaCu * (discount.getPercentDecrease()/100);
                }
            }
            request.setAttribute("giamGia",giamGia);
            response.sendRedirect("thanhtoan?apdung=thanhcong&giamGia=" + giamGia);
        } else {
            response.sendRedirect("login");
        }
    }
}