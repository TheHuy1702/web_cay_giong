package vn.edu.hcmuaf.fit.project_final_webcaygiong.dao;

import org.mindrot.jbcrypt.BCrypt;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.db.JDBIConnect;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.TokenForgotPassword;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.User;

import java.util.*;

public class UserDao {
    List<User> users;

    public UserDao() {
        users = new ArrayList<>();
    }

    // lấy ra tất cả user
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
            return BCrypt.checkpw(password, user.getPassword());
        }
        return false;
    }

    public boolean insertUser(User user) {
        try {
            String hashedPassword = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
            return JDBIConnect.get().withHandle(h -> {
                String sql = "INSERT INTO users (name, phone, email, password, verifiCode, verifiExpines, createAt, updateAt, active) " +
                        "VALUES (:name, :phone, :email, :password, :verifiCode, :verifiExpines, :createAt, :updateAt, 0)";

                int rowsAffected = h.createUpdate(sql)
                        .bind("name", user.getName())
                        .bind("phone", user.getPhone())
                        .bind("email", user.getEmail())
                        .bind("password", hashedPassword)
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
            h.createUpdate(sql)
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

    public List<Map<String, Object>> dsUser(String sortBy) {
        String query = " SELECT DISTINCT  u.userID,u.name, u.phone, u.createAt, u.updateAt,u.status, c.customerID , c.email " +
                "FROM users u JOIN customers c ON u.userID = c.userID  " +
                "GROUP BY u.userID  ORDER BY u.createAt " + (sortBy.equals("desc") ? "DESC" : "ASC");
        return JDBIConnect.get().withHandle(handle ->
                handle.createQuery(query)
                        .map((rs, ctx) -> {
                            Map<String, Object> result = new HashMap<>();
                            result.put("userID", rs.getInt("userID"));
                            result.put("name", rs.getString("name"));
                            result.put("phone", rs.getString("phone"));
                            result.put("createAt", rs.getDate("createAt"));
                            result.put("updateAt", rs.getDate("updateAt"));
                            result.put("status", rs.getString("status"));
                            result.put("customerID", rs.getInt("customerID"));
                            result.put("email", rs.getString("email"));
                            return result;
                        })
                        .list());
    }

    public List<User> getUsers(String sortBy) {
        users = JDBIConnect.get().withHandle(handle ->
                handle.createQuery("SELECT * FROM users ORDER BY createAt " + (sortBy.equals("desc") ? "DESC" : "ASC"))
                        .mapToBean(User.class).list());
        return users;
    }

    // ✅ Bổ sung searchUser để fix lỗi build
    public List<User> searchUser(String keyword) {
        return JDBIConnect.get().withHandle(handle ->
                handle.createQuery("SELECT * FROM users WHERE name LIKE ? OR phone LIKE ?")
                        .bind(0, "%" + keyword + "%")
                        .bind(1, "%" + keyword + "%")
                        .mapToBean(User.class)
                        .list()
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

    public static boolean updatePassword(int userId, String newPassword) {
        String hashedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());

        return JDBIConnect.get().withHandle(handle ->
                handle.createUpdate("UPDATE users SET password = :password, updateAt = :updateAt WHERE userID = :userID")
                        .bind("password", hashedPassword)
                        .bind("updateAt", new java.util.Date())
                        .bind("userID", userId)
                        .execute() > 0
        );
    }

    // ✅ Bổ sung findUserByToken để fix lỗi build
    public User findUserByToken(String token) {
        return JDBIConnect.get().withHandle(h ->
                h.createQuery("SELECT u.* FROM users u JOIN ActivationToken a ON u.userID = a.userID " +
                                "WHERE a.token = ? AND a.used = false AND a.expiryTime > NOW()")
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

    public boolean activateAccount(String phone) {
        return JDBIConnect.get().withHandle(h ->
                h.createUpdate("UPDATE users SET active = 1 WHERE phone = ?")
                        .bind(0, phone)
                        .execute() > 0
        );
    }

    public boolean createNewActivationToken(int userId, String token, Date expiryTime) {
        JDBIConnect.get().useHandle(h ->
                h.execute("DELETE FROM ActivationToken WHERE userID = ?", userId)
        );
        return createActivationToken(userId, token, expiryTime);
    }

    public static void main(String[] args) {
        UserDao userDao = new UserDao();
    }
}
