package vn.edu.hcmuaf.fit.project_final_webcaygiong.controller.theoDoiDonHang;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import org.json.JSONArray;
import org.json.JSONObject;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.CustomerDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.OrderDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.QLDHDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.Customer;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.User;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.diaChi.GHNApiClient;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet(name = "ThoiGianGiaoHangDuKienServlet", value = "/ThoiGianGiaoHangDuKien")
public class ThoiGianGiaoHangDuKienServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("lp","alalalalalla");
        RequestDispatcher dispatcher = request.getRequestDispatcher("testTGGH.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("123456");
        try {
            QLDHDao dao = new QLDHDao();
            CustomerDao customerDao = new CustomerDao();
            List<Map<String, Object>> orders;
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            // Kiểm tra xem đã đăng nhập hay chưa.
            if (user != null) {
                int userID = user.getUserID();
                Customer customer = customerDao.getCustomerWithUID(userID);
                JSONObject params = new JSONObject();
                params.put("payment_type_id", 2);
                // Thông tin người nhận
                params.put("required_note", "KHONGCHOXEMHANG");
                params.put("to_name", customer.getNameCustomer()); // Tên người nhận
                params.put("to_phone", customer.getPhone()); // Số điện thoại
                params.put("to_address", customer.getAddress()); // Địa chỉ nhận hàng
                String address = customer.getAddress();
                int lastCommaIndex = address.lastIndexOf(",");
                String wardName = address.substring(lastCommaIndex + 1).trim();
                System.out.println(wardName + "12345::::");
                params.put("to_ward_name", wardName); // Tên xã/phường
                params.put("to_district_name", customer.getDistrict()); // Tên quận/huyện
                params.put("to_province_name", customer.getCity()); // Tên tỉnh/thành phố
                params.put("weight", 2000); // Trọng lượng (gram)
                params.put("service_type_id", 2); // Loại dịch vụ
                // Thêm thông tin hàng hóa
                JSONArray items = new JSONArray();
                JSONObject item = new JSONObject();
                item.put("name", "Áo Polo"); // Thay bằng tên hàng hóa thực tế
                item.put("code", "Polo123"); // Mã hàng hóa
                item.put("quantity", 1); // Số lượng
                item.put("price", 10000); // Giá trị đơn hàng
                item.put("length", 12); // Chiều dài hàng hóa
                item.put("width", 12); // Chiều rộng hàng hóa
                item.put("height", 12); // Chiều cao hàng hóa
                item.put("weight", 1200); // Trọng lượng hàng hóa
                items.put(item);
                params.put("items", items); // Thêm vào params
                // Gọi API để tạo đơn hàng
                JSONObject result = GHNApiClient.callGHNApi("v2/shipping-order/create", "POST", params);
                String tgdk = result.getJSONObject("data").getString("expected_delivery_time");
                System.out.println(tgdk + "55555555");
                session.setAttribute("tgdk", tgdk);
                request.setAttribute("al","kokokokokokokok");
                request.setAttribute("tgdk2",tgdk);
                System.out.println("THANH CONG");
                RequestDispatcher dispatcher = request.getRequestDispatcher("testTGGH.jsp");
                dispatcher.forward(request, response);
            } else {
                response.sendRedirect("login");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}