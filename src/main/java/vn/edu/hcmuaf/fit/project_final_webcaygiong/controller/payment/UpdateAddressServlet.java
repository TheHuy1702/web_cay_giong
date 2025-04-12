package vn.edu.hcmuaf.fit.project_final_webcaygiong.controller.payment;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import org.json.JSONArray;
import org.json.JSONObject;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.CustomerDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.Customer;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.User;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.diaChi.District;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.diaChi.GHNApiClient;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.diaChi.Ward;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "UpdateAddressServlet", value = "/UpdateAddress")
public class UpdateAddressServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CustomerDao customerDao = new CustomerDao();
        String fullName = request.getParameter("fullName");
        String phoneNumber = request.getParameter("phoneNumber");
        String address = request.getParameter("address");
        String district = request.getParameter("districtName");
        String city = request.getParameter("provinceName");
        String ward = request.getParameter("wardName");
        String prodName = request.getParameter("prodName");
        String prodQuantity = request.getParameter("prodQuantity");
        int districtId = Integer.parseInt(request.getParameter("districtId"));
        String wardCode = request.getParameter("wardCode");

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user != null) {
            // Cập nhật địa chỉ cho khách hàng
            customerDao.updateCustomerAddress(user.getUserID(), fullName, phoneNumber, address + ", " + ward, district, city);
            try {
                JSONObject params = new JSONObject();
                params.put("service_type_id", 2); // Loại dịch vụ
                params.put("from_district_id", 1442); // ID quận gửi (ví dụ: Quận 1)
                params.put("from_ward_code", "21211");
                params.put("to_district_id", districtId); // ID quận nhận (ví dụ: Quận 4)
                params.put("to_ward_code", wardCode); // Mã xã/phường (ví dụ: Mã xã)
                params.put("length", 30); // Chiều dài (cm)
                params.put("width", 20); // Chiều rộng (cm)
                params.put("height", 10); // Chiều cao (cm)
                params.put("weight", 3000); // Trọng lượng (gram)
                params.put("insurance_value", 0); // Giá trị bảo hiểm
                params.put("shop_id", 196336); // ID shop của bạn

                // Gọi API để tính phí giao hàng
                JSONObject result = GHNApiClient.callGHNApi("v2/shipping-order/fee", "POST", params);
                System.out.println("Response code: " + result.getInt("code"));
                System.out.println("Response message: " + result.getString("message"));
                System.out.println("Result: " + result);
                int service_fee = result.getJSONObject("data").getInt("service_fee");
                // Lưu thông tin phí giao hàng
                request.setAttribute("shippingFee", result.getJSONObject("data"));
                response.sendRedirect("thanhtoan?update=thanhcong" + "&serviceFee=" + service_fee);

            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Không thể tính phí giao hàng: " + e.getMessage());
                request.getRequestDispatcher("error.jsp").forward(request, response); // Chuyển đến trang lỗi
            }
        } else {
            response.sendRedirect("login");
        }

    }
}