package vn.edu.hcmuaf.fit.project_final_webcaygiong.dao;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.db.JDBIConnect;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.User;

import java.sql.Timestamp;
import java.time.LocalDateTime;

public class LogUtil {

    public void log(HttpServletRequest request, String action, String levelLog,
                    String sourcePage, String resource, String oldData, String newData) {
        String ip = request.getRemoteAddr();
        HttpSession session = request.getSession(false);
        Integer userId;
        String username;

        // Lấy thông tin người dùng từ session (nếu có)
        if (session != null && session.getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");
            userId = user.getUserID();
            username = user.getName();
        } else {
            username = "guest";
            userId = null;
        }

        try {
            String sql = "INSERT INTO logs(userID, username, action, action_type, level_log, old_data, new_data, source_page, resource, ip_address, time_action) " +
                    "VALUES (:userId, :username, :action, :actionType, :levelLog, :oldData, :newData, :sourcePage, :resource, :ipAddress, :timeAction)";

            JDBIConnect.get().withHandle(handle -> {
                handle.createUpdate(sql)
                        .bind("userId", userId)
                        .bind("username", username)
                        .bind("action", action)
                        .bind("actionType", getActionType(action))
                        .bind("levelLog", levelLog)
                        .bind("oldData", oldData != null ? oldData : "")
                        .bind("newData", newData != null ? newData : "")
                        .bind("sourcePage", sourcePage != null ? sourcePage : "")
                        .bind("resource", resource != null ? resource : "")
                        .bind("ipAddress", ip)
                        .bind("timeAction", Timestamp.valueOf(LocalDateTime.now()))
                        .execute();
                return null;
            });
        } catch (Exception e) {
            e.printStackTrace();
            // Ghi log lỗi vào console hoặc file log nếu cần
            System.err.println("Lỗi khi ghi log: " + e.getMessage());
        }
    }

    private String getActionType(String action) {
        if (action == null) return "OTHER";

        action = action.toLowerCase();
        if (action.contains("login")) return "AUTHENTICATION";
        if (action.contains("create") || action.contains("insert")) return "CREATE";
        if (action.contains("update") || action.contains("edit")) return "UPDATE";
        if (action.contains("delete") || action.contains("remove")) return "DELETE";
        if (action.contains("read") || action.contains("view") || action.contains("get")) return "READ";

        return "OTHER";
    }
}