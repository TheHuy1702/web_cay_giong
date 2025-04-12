package vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.diaChi;

import org.json.JSONObject;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.stream.Collectors;

public class GHNApiClient {
    private static final String GHN_API_URL = "https://dev-online-gateway.ghn.vn/shiip/public-api/";
    private static final String GHN_TOKEN = "a12b4274-1234-11f0-95d0-0a92b8726859"; // Kiểm tra token

    public static JSONObject callGHNApi(String endpoint, String method, JSONObject requestBody) throws IOException {
        URL url = new URL(GHN_API_URL + endpoint);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();

        conn.setRequestMethod(method);
        conn.setRequestProperty("Content-Type", "application/json");
        conn.setRequestProperty("token", GHN_TOKEN);
        conn.setRequestProperty("shop_id", "196336");
        conn.setRequestProperty("Accept", "application/json");

        if (method.equalsIgnoreCase("POST")) {
            conn.setDoOutput(true);
            try (OutputStream os = conn.getOutputStream()) {
                byte[] input = requestBody.toString().getBytes(StandardCharsets.UTF_8);
                os.write(input, 0, input.length);
            }
        }

        int responseCode = conn.getResponseCode();
        if (responseCode == HttpURLConnection.HTTP_OK) {
            try (BufferedReader br = new BufferedReader(
                    new InputStreamReader(conn.getInputStream(), StandardCharsets.UTF_8))) {
                StringBuilder response = new StringBuilder();
                String responseLine;
                while ((responseLine = br.readLine()) != null) {
                    response.append(responseLine.trim());
                }
                return new JSONObject(response.toString());
            }
        } else {
            // Đọc thông tin lỗi từ stream
            InputStream errorStream = conn.getErrorStream();
            String errorResponse = new BufferedReader(new InputStreamReader(errorStream))
                    .lines().collect(Collectors.joining("\n"));
            throw new IOException("HTTP error code: " + responseCode + ", response: " + errorResponse);
        }
    }
}
