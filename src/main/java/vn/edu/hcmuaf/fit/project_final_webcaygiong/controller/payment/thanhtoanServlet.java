package vn.edu.hcmuaf.fit.project_final_webcaygiong.controller.payment;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import org.json.JSONArray;
import org.json.JSONObject;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.CustomerDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.cart.Cart;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.cart.CartProduct;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.Customer;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.Product;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.User;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.diaChi.GHNApiClient;

import java.io.IOException;
import java.net.URLEncoder;

@WebServlet(name = "thanhtoanServlet", value = "/thanhtoan")
public class thanhtoanServlet extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy thông tin dia chi.
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        Cart cart = (Cart) session.getAttribute("cart");
        if (user != null && cart != null) {
            CustomerDao customerDao = new CustomerDao();
            Customer customer = customerDao.getCustomerWithUID(user.getUserID());
            // Kiểm tra giá trị của các biến.
            request.setAttribute("customer", customer);
            // Tính phí vận chuyển.
            try {
                int count = 0;
                JSONObject params = new JSONObject();
                params.put("from_district_id", 1442);
                params.put("from_ward_code", "21211");
                params.put("to_district_id", customer.getDistrictID());
                params.put("to_ward_code", customer.getWardCode());
                params.put("insurance_value", 0);
                params.put("shop_id", 196336);
                JSONArray items = new JSONArray();
                for (CartProduct cartProduct : cart.getList()) {
                    JSONObject item = new JSONObject();
                    item.put("name", cartProduct.getName());
                    item.put("quantity", cartProduct.getQuantity());
                    item.put("length", 20);
                    item.put("width", 20);
                    item.put("height", 20);
                    item.put("weight", 300 * cartProduct.getQuantity());
                    items.put(item);
                    count += cartProduct.getQuantity();
                }
                params.put("items", items);
                params.put("weight", 700 * count);
                params.put("service_type_id", 2);
                // Gọi API để tính phí giao hàng
                JSONObject result = GHNApiClient.callGHNApi("v2/shipping-order/fee", "POST", params);
                System.out.println("Response code: " + result.getInt("code"));
                System.out.println("Response message: " + result.getString("message"));
                System.out.println("Result: " + result);
                int service_fee = result.getJSONObject("data").getInt("service_fee");
                // Lưu thông tin phí giao hàng
                request.setAttribute("shippingFee", result.getJSONObject("data"));
                request.setAttribute("serviceFee", service_fee);
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("serviceFee", 0); // Đặt phí vận chuyển là 0 nếu có lỗi
            }

        }
        RequestDispatcher dispatcher = request.getRequestDispatcher("thanhtoan.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }
}