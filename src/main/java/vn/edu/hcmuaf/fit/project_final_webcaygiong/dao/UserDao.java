package vn.edu.hcmuaf.fit.project_final_webcaygiong.dao;

import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.db.JDBIConnect;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.User;

import java.sql.Timestamp;
import java.util.*;

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

    // Phương thức để kiểm tra mật khẩu
    private boolean checkPassword(String inputPassword, String storedPassword) {
        return inputPassword.equals(storedPassword);
    }

    public void insertUser(User user) {
        JDBIConnect.get().useHandle(h -> {
            String sql = "INSERT INTO users (name, phone, password, createAt, updateAt) VALUES (?, ?, ?, ?, ?)";
            h.createUpdate(sql)
                    .bind(0, user.getName())
                    .bind(1, user.getPhone())
                    .bind(2, user.getPassword()) // Mật khẩu đã được mã hóa nếu cần
                    .bind(3, user.getCreateAt()) // Thời gian tạo
                    .bind(4, user.getUpdateAt()) // Thời gian sửa đổi
                    .execute();
        });
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

    // danh sách user theo sắp sếp.
    public List<Map<String, Object>> dsUser(String sortBy) {
        String query = " SELECT DISTINCT  u.userID,u.name, u.phone, u.createAt, u.updateAt,u.status, c.customerID , c.email FROM users u JOIN customers c ON u.userID = c.userID  GROUP BY u.userID  ORDER BY u.createAt " + (sortBy.equals("desc") ? "DESC" : "ASC");
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

    public static void main(String[] args) {
    }

    public List<User> searchUser(String keyword) {
        return JDBIConnect.get().withHandle(handle ->
                handle.createQuery("SELECT * FROM users WHERE name LIKE ? OR phone LIKE ?")
                        .bind(0, "%" + keyword + "%")
                        .bind(1, keyword + "%")
                        .mapToBean(User.class)
                        .list()
        );
    }
}
