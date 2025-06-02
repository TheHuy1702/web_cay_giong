package vn.edu.hcmuaf.fit.project_final_webcaygiong.dao;

import org.mindrot.jbcrypt.BCrypt;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.db.JDBIConnect;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.TokenForgotPassword;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.User;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class UserDao {
    List<User> users;

    public UserDao() {
        users = new ArrayList<>();
    }

    // lấy ra tất cả user.
    public List<User> getAllUsers() {
        users = JDBIConnect.get().withHandle(handle ->
                handle.createQuery("select * from users")
                        .mapToBean(User.class).list());
        return users;
    }

    public User findUserID(int userID) {
        return JDBIConnect.get().withHandle(h ->
                h.createQuery("SELECT * FROM users where userID=?")
                        .bind(0, userID)
                        .mapToBean(User.class)
                        .findOne()
                        .orElse(null)
        );
    }


    public User findUsername(String name) {
        return JDBIConnect.get().withHandle(h ->
                h.createQuery("SELECT * FROM users WHERE name = ?")
                        .bind(0, name)
                        .mapToBean(User.class)
                        .findOne()
                        .orElse(null)
        );
    }

    public boolean checkLogin(String phone, String password) {
        User user = JDBIConnect.get().withHandle(h ->
                h.createQuery("SELECT * FROM users WHERE phone = ?")
                        .bind(0, phone)
                        .mapToBean(User.class)
                        .findOne()
                        .orElse(null)
        );

        if (user != null) {
            // Kiểm tra password đã hash
            return BCrypt.checkpw(password, user.getPassword());
        }
        return false;
    }

    public boolean insertUser(User user) {
        try {
            // Hash password trước khi lưu
            String hashedPassword = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
            return JDBIConnect.get().withHandle(h -> {
                String sql = "INSERT INTO users (name, phone, email, password, verifiCode, verifiExpines, createAt, updateAt, active) " +
                        "VALUES (:name, :phone, :email, :password, :verifiCode, :verifiExpines, :createAt, :updateAt, 0)";

                int rowsAffected = h.createUpdate(sql)
                        .bind("name", user.getName())
                        .bind("phone", user.getPhone())
                        .bind("email", user.getEmail())
                        .bind("password", hashedPassword) // Sử dụng password đã hash
                        .bind("verifiCode", user.getVerifiCode())
                        .bind("verifiExpines", user.getVerifiExpines())
                        .bind("createAt", user.getCreateAt())
                        .bind("updateAt", user.getUpdateAt())
                        .execute();

                return rowsAffected > 0;
            });
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Phương thức để cập nhật mã xác minh và ngày hết hạn vào cơ sở dữ liệu
    public User findByPhone(String phone) {
        return JDBIConnect.get().withHandle(h ->
                h.createQuery("SELECT * FROM users WHERE phone = ?")
                        .bind(0, phone)
                        .mapToBean(User.class)
                        .findOne()
                        .orElse(null)
        );
    }

    public User findByEmail(String email) {
        return JDBIConnect.get().withHandle(h ->
                h.createQuery("SELECT * FROM users WHERE email = ?")
                        .bind(0, email)
                        .mapToBean(User.class)
                        .findOne()
                        .orElse(null)
        );
    }

    public void insertGoogleUser(User user) {
        JDBIConnect.get().useHandle(h -> {
            String sql = "INSERT INTO users (name, email, googleId, createAt, updateAt) VALUES (?, ?, ?, ?, ?)";
            h.createUpdate(sql)// ID của người dùng từ Google OAuth
                    .bind(0, user.getName())
                    .bind(1, user.getEmail())
                    .bind(2, user.getGoogleId())
                    .bind(3, user.getCreateAt())
                    .bind(4, user.getUpdateAt())
                    .execute();
        });
    }

    public User emailExists(String email) {
        return JDBIConnect.get().withHandle(h ->
                h.createQuery("SELECT * FROM users WHERE email = ?")
                        .bind(0, email)
                        .mapToBean(User.class)
                        .findOne()
                        .orElse(null)
        );
    }

    public User findByFacebookId(String facebookId) {
        return JDBIConnect.get().withHandle(h ->
                h.createQuery("SELECT * FROM users WHERE facebookId = ?")
                        .bind(0, facebookId)
                        .mapToBean(User.class)
                        .findOne()
                        .orElse(null)
        );
    }

    public void insertFacebookUser(User user) {
        JDBIConnect.get().useHandle(h -> {
            String sql = "INSERT INTO users (name, email, facebookId, createAt, updateAt) " +
                    "VALUES (?, ?, ?, ?, ?)";
            h.createUpdate(sql)
                    .bind(0, user.getName())
                    .bind(1, user.getEmail())
                    .bind(2, user.getFacebookId())
                    .bind(3, user.getCreateAt())
                    .bind(4, user.getUpdateAt())
                    .execute();
        });
    }

    public void updateFacebookId(int userId, String facebookId) {
        JDBIConnect.get().useHandle(h -> {
            h.createUpdate("UPDATE users SET facebookId = ?, updateAt = ? WHERE userID = ?")
                    .bind(0, facebookId)
                    .bind(1, new Date())
                    .bind(2, userId)
                    .execute();
        });
    }

    // Thêm các phương thức này vào UserDao class
    public boolean savePasswordResetToken(TokenForgotPassword token) {
        return JDBIConnect.get().withHandle(h ->
                h.createUpdate("INSERT INTO TokenForgotPassword (userID, used, token, expiryTime) VALUES (?, ?, ?, ?)")
                        .bind(0, token.getUserID())
                        .bind(1, token.isUsed())
                        .bind(2, token.getToken())
                        .bind(3, token.getExpiryTime())
                        .execute() > 0
        );
    }

    public TokenForgotPassword findToken(String token) {
        return JDBIConnect.get().withHandle(h ->
                h.createQuery("SELECT * FROM TokenForgotPassword WHERE token = ?")
                        .bind(0, token)
                        .mapToBean(TokenForgotPassword.class)
                        .findOne()
                        .orElse(null)
        );
    }

    public boolean markTokenAsUsed(String token) {
        return JDBIConnect.get().withHandle(h ->
                h.createUpdate("UPDATE TokenForgotPassword SET used = 1 WHERE token = ?")
                        .bind(0, token)
                        .execute() > 0
        );
    }

    public boolean updatePassword(int userId, String newPassword) {
        // Hash password mới trước khi lưu
        String hashedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());

        return JDBIConnect.get().withHandle(handle ->
                handle.createUpdate("UPDATE users SET password = :password, updateAt = :updateAt WHERE userID = :userID")
                        .bind("password", hashedPassword)
                        .bind("updateAt", new java.util.Date())
                        .bind("userID", userId)
                        .execute() > 0
        );
    }

    public User findUserByToken(String token) {
        return JDBIConnect.get().withHandle(h ->
                h.createQuery("SELECT u.* FROM users u JOIN ActivationToken a ON u.userID = a.userID WHERE a.token = ? AND a.used = false AND a.expiryTime > NOW()")
                        .bind(0, token)
                        .mapToBean(User.class)
                        .findOne()
                        .orElse(null)
        );
    }


    public boolean createActivationToken(int userId, String token, Date expiryTime) {
        return JDBIConnect.get().withHandle(h ->
                h.createUpdate("INSERT INTO ActivationToken (userID, token, expiryTime, used) VALUES (?, ?, ?, false)")
                        .bind(0, userId)
                        .bind(1, token)
                        .bind(2, expiryTime)
                        .execute() > 0
        );
    }

    public TokenForgotPassword findActivationToken(String token) {
        return JDBIConnect.get().withHandle(h ->
                h.createQuery("SELECT * FROM ActivationToken WHERE token = ? AND used = false AND expiryTime > NOW()")
                        .bind(0, token)
                        .mapToBean(TokenForgotPassword.class)
                        .findOne()
                        .orElse(null)
        );
    }

    public boolean markActivationTokenAsUsed(String token) {
        return JDBIConnect.get().withHandle(h ->
                h.createUpdate("UPDATE ActivationToken SET used = true WHERE token = ?")
                        .bind(0, token)
                        .execute() > 0
        );
    }

    // Cập nhật trạng thái active
    public boolean activateAccount(String phone) {
        return JDBIConnect.get().withHandle(h ->
                h.createUpdate("UPDATE users SET active = 1 WHERE phone = ?")
                        .bind(0, phone)
                        .execute() > 0
        );
    }

    // Tạo token kích hoạt mới
    public boolean createNewActivationToken(int userId, String token, Date expiryTime) {
        // Xóa token cũ nếu có
        JDBIConnect.get().useHandle(h ->
                h.execute("DELETE FROM ActivationToken WHERE userID = ?", userId)
        );

        // Tạo token mới
        return createActivationToken(userId, token, expiryTime);
    }


    public static void main(String[] args) {
        UserDao userDao = new UserDao();
    }
}
