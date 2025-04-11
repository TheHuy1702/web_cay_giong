package vn.edu.hcmuaf.fit.project_final_webcaygiong.controller.diaChiKhachHang;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import org.json.JSONArray;
import org.json.JSONObject;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.diaChi.District;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.diaChi.GHNApiClient;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.diaChi.Ward;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "AddressServlet", value = "/address")
public class AddressServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String type = request.getParameter("type");
        String id = request.getParameter("id");

        try {
            if ("provinces".equals(type)) {
                handleProvinces(response);
            } else if ("districts".equals(type) && id != null) {
                handleDistricts(response, id);
            } else if ("wards".equals(type) && id != null) {
                handleWards(response, id);
            } else {
                // Nếu loại yêu cầu không hợp lệ, trả về lỗi 400
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"error\":\"Thiếu tham số\"}");// Thông báo lỗi
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Trả về mã lỗi 500 nếu có ngoại lệ xảy ra
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\":\"Có lỗi xảy ra\"}");
        }
    }

    // Hàm xử lý yêu cầu lấy danh sách tỉnh
    private void handleProvinces(HttpServletResponse response) throws IOException {
        JSONObject result = GHNApiClient.callGHNApi("master-data/province", "GET", new JSONObject()); // Gọi API để lấy dữ liệu tỉnh
        // Lấy mảng tỉnh từ kết quả, hoặc tạo mảng rỗng nếu không có dữ liệu
        JSONArray provincesArray = result.has("data") ? result.getJSONArray("data") : new JSONArray();
        response.setContentType("application/json");// Thiết lập kiểu nội dung phản hồi là JSON
        response.getWriter().write(provincesArray.toString());
    }

    private void handleDistricts(HttpServletResponse response, String provinceId) throws IOException {
        // Gọi API để lấy tất cả quận/huyện
        JSONObject result = GHNApiClient.callGHNApi("master-data/district", "GET", new JSONObject());
        List<District> districtsList = new ArrayList<>();

        if (result.has("data")) {
            JSONArray districtsArray = result.getJSONArray("data");// Lấy mảng quận/huyện

            // Lọc quận/huyện theo provinceId
            for (int i = 0; i < districtsArray.length(); i++) {
                JSONObject districtObject = districtsArray.getJSONObject(i); // Lấy từng quận/huyện
                int districtId = districtObject.getInt("DistrictID");
                String districtName = districtObject.getString("DistrictName");
                int districtProvinceId = districtObject.getInt("ProvinceID"); // Lấy provinceId của quận/huyện

                // Kiểm tra nếu provinceId của quận/huyện trùng với provinceId đã cho
                if (districtProvinceId == Integer.parseInt(provinceId)) {
                    District district = new District(districtId, districtName);
                    districtsList.add(district);
                }
            }
        }

        // In ra danh sách các quận/huyện đã lọc
        for (District district : districtsList) {
            System.out.println(district);
        }

        response.setContentType("application/json");
        response.getWriter().write(new JSONArray(districtsList).toString());
    }

    private void handleWards(HttpServletResponse response, String districtId) throws IOException {
        try {
            // Xây dựng URL yêu cầu
            String url = String.format("master-data/ward?district_id=%s", districtId);
            JSONObject result = GHNApiClient.callGHNApi(url, "GET", new JSONObject());

            List<Ward> wardsList = new ArrayList<>();

            if (result.has("data")) {
                JSONArray wardsArray = result.getJSONArray("data");
                for (int i = 0; i < wardsArray.length(); i++) {
                    JSONObject wardObject = wardsArray.getJSONObject(i);
                    Ward ward = new Ward();
                    ward.setId(wardObject.getInt("WardCode"));
                    ward.setName(wardObject.getString("WardName"));
                    wardsList.add(ward);
                }
            }
            for (Ward w : wardsList) {
                System.out.println(w.getId() + "////" + w.getName());
            }
            response.setContentType("application/json");
            response.getWriter().write(new JSONArray(wardsList).toString());
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\":\"Có lỗi xảy ra\"}");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }
}