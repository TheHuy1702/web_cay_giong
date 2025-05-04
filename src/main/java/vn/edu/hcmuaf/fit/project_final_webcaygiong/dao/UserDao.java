package vn.edu.hcmuaf.fit.project_final_webcaygiong.dao;

import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.db.JDBIConnect;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.TokenForgotPassword;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.User;

import java.sql.Timestamp;
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

        // Kiểm tra xem người dùng có tồn tại.
        if (user != null) {
            return checkPassword(password, user.getPassword());
        }
        return false;
    }

    public boolean checkLogin2(String phone, String password) {
        User user = JDBIConnect.get().withHandle(h ->
                h.createQuery("SELECT u.* FROM users u join ActivationToken a ON u.userID = a.userID WHERE a.used = 1  and phone = ?")
                        .bind(0, phone)
                        .mapToBean(User.class)
                        .findOne()
                        .orElse(null)
        );

        // Kiểm tra xem người dùng có tồn tại.
        if (user != null) {
            return checkPassword(password, user.getPassword());
        }
        return false;
    }


    // Phương thức để kiểm tra mật khẩu
    private boolean checkPassword(String inputPassword, String storedPassword) {
        return inputPassword.equals(storedPassword);
    }

    public boolean insertUser(User user) {
        try {
            return JDBIConnect.get().withHandle(handle -> {
                String sql = "INSERT INTO users (name, phone, email, password, verifiCode, verifiExpines, createAt, updateAt) " +
                        "VALUES (:name, :phone, :email, :password, :verifiCode, :verifiExpines, :createAt, :updateAt)";

                int rowsAffected = handle.createUpdate(sql)
                        .bind("name", user.getName())
                        .bind("phone", user.getPhone())
                        .bind("email", user.getEmail())
                        .bind("password", user.getPassword())
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

    public boolean updateOrInsertVerificationCode(String phone, String verificationCode, Date expirationDate) {
        User user = findByPhone(phone);
        if (user == null) {
            return false;
        }
        return JDBIConnect.get().withHandle(h ->
                h.createUpdate("UPDATE users SET verifiCode = ?, verifiExpines = ? WHERE phone = ?")
                        .bind(0, verificationCode)
                        .bind(1, expirationDate)
                        .bind(2, phone)
                        .execute() > 0
        );
    }

    public boolean isVerificationCodeValid(String phone, String verificationCode) {
        User user = findByPhone(phone);
        if (user == null || user.getVerifiCode() == null || user.getVerifiExpines() == null) {
            return false;
        }
        return user.getVerifiCode().equals(verificationCode) &&
                user.getVerifiExpines().after(new Date(System.currentTimeMillis()));
    }

    public static boolean updatePassword(String phone, String newPassword) {
        // Thực hiện cập nhật mật khẩu vào cơ sở dữ liệu mà không mã hóa
        return JDBIConnect.get().withHandle(h ->
                h.createUpdate("UPDATE users SET password = ?, updateAt = ? WHERE phone = ?")
                        .bind(0, newPassword)  // Liên kết mật khẩu mới (không mã hóa)
                        .bind(1, new Timestamp(System.currentTimeMillis()))  // Cập nhật thời gian thay đổi
                        .bind(2, phone)  // Liên kết số điện thoại
                        .execute() > 0  // Trả về true nếu có ít nhất 1 bản ghi bị thay đổi
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

    public void updateGoogleId(int userId, String googleId) {
        JDBIConnect.get().useHandle(h -> {
            h.createUpdate("UPDATE users SET googleId = ?, updateAt = ? WHERE userID = ?")
                    .bind(0, googleId)
                    .bind(1, new Date())
                    .bind(2, userId)
                    .execute();
        });
    }

    public User findByGoogleId(String googleId) {
        return JDBIConnect.get().withHandle(h ->
                h.createQuery("SELECT * FROM users WHERE googleId = ?")
                        .bind(0, googleId)
                        .mapToBean(User.class)
                        .findOne()
                        .orElse(null)
        );
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
        return JDBIConnect.get().withHandle(handle ->
                handle.createUpdate("UPDATE users SET password = :password, updateAt = :updateAt WHERE userID = :userID")
                        .bind("password", newPassword)
                        .bind("updateAt", new java.util.Date())
                        .bind("userID", userId)
                        .execute() > 0
        );
    }

    // Thêm các phương thức này vào class UserDao

    public boolean isTokenValid(String token) {
        return JDBIConnect.get().withHandle(h ->
                h.createQuery("SELECT COUNT(*) FROM ActivationToken WHERE token = ? AND used = 1 AND expiryTime > NOW()")
                        .bind(0, token)
                        .mapTo(Integer.class)
                        .findOne()
                        .orElse(0) > 0
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

    public boolean activateUserById(int userId, String token) {
        return JDBIConnect.get().withHandle(h ->
                h.createUpdate("UPDATE users SET verifiCode = ?, verifiExpines = NULL WHERE userID = ?")
                        .bind(0, token)
                        .bind(1,userId)
                        .execute() > 0
        );
    }


    public boolean activateUser(String verificationCode) {
        return JDBIConnect.get().withHandle(h ->
                h.createUpdate("UPDATE users SET verifiCode = NULL, verifiExpines = NULL WHERE verifiCode = ? AND verifiExpines > NOW()")
                        .bind(0, verificationCode)
                        .execute() > 0
        );
    }

    // sửa
    public boolean createVerificationCode(User user, String verificationCode, Date expiryDate) {
        return JDBIConnect.get().withHandle(h ->
                h.createUpdate("UPDATE users SET verifiCode = ?, verifiExpines = ? WHERE userID = ?")
                        .bind(0, verificationCode)
                        .bind(1, expiryDate)
                        .bind(2, user.getUserID())
                        .execute() > 0
        );
    }

    public User findByVerificationCode(String verificationCode) {
        return JDBIConnect.get().withHandle(h ->
                h.createQuery("SELECT * FROM users WHERE verifiCode = ? AND verifiExpines > NOW()")
                        .bind(0, verificationCode)
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


    public static void main(String[] args) {
        UserDao userDao = new UserDao();
//        List<User> listAll = userDao.getAllUsers();
//        for (User c : listAll) {
//            System.out.println(c);
//        }
//        System.out.println(userDao.findUserID(2));
//        boolean test = userDao.createVerificationCode(new User(17), "02959823429fakfj", null);
//        if (test == true) {
//            System.out.println(userDao.findUserID(17));
//        } else {
//            System.out.println("Không thành công!");
//        }
        System.out.println(userDao.findUserByToken("6d93b105-9dae-473f-aaae-b3625b3548c1"));
        System.out.println(userDao.checkLogin2("0707180788","Hoai#2314"));
    }
}
