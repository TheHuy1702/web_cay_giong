package vn.edu.hcmuaf.fit.project_final_webcaygiong.dao;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.db.JDBIConnect;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.User;

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
            String sql = "INSERT INTO log(userID, userAction, actionType,levelLog, oldData, newData, sourcePage, resource, ipAddress) VALUES (?,?,?,?,?,?,?,?,?)";
            JDBIConnect.get().withHandle(handle -> {
                handle.createUpdate(sql)
                        .bind(0, userId)
                        .bind(1, username)
                        .bind(2, action)
                        .bind(3, levelLog)
                        .bind(4, oldData)
                        .bind(5, newData)
                        .bind(6, sourcePage)
                        .bind(7, resource)
                        .bind(8, ip)
                        .execute();
                return null;
            });
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

