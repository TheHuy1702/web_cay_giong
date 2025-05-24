package vn.edu.hcmuaf.fit.project_final_webcaygiong.login;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.LogUtil;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.UserDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.User;

import java.io.IOException;
import java.util.Date;
import java.util.UUID;

@WebServlet(name = "registerServlet", value = "/register")
public class registerServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        String error = null;
        UserDao userDao = new UserDao();
        LogUtil logUtil = new LogUtil();
        String ip = request.getRemoteAddr();

        try {
            // Kiểm tra định dạng mật khẩu
            if (!isValidPassword(password)) {
                error = "Mật khẩu phải chứa ít nhất 1 ký tự hoa, 1 ký tự thường và 1 số!";
                request.setAttribute("passwordError", error);
                logUtil.log(request, "Register failed - invalid password", "WARN", "register.jsp", "Registration", "", "Invalid password format for phone: " + phone);
            }

            // Kiểm tra định dạng số điện thoại
            if (!isValidPhoneNumber(phone)) {
                error = "Số điện thoại phải bắt đầu bằng 0 và gồm 10 chữ số!";
                request.setAttribute("phoneError", error);
                logUtil.log(request, "Register failed - invalid phone", "WARN", "register.jsp", "Registration", "", "Invalid phone format: " + phone);
            }

            // Kiểm tra mật khẩu khớp
            if (error == null && !password.equals(confirmPassword)) {
                error = "Mật khẩu và xác nhận mật khẩu không khớp!";
                request.setAttribute("confirmPasswordError", error);
                logUtil.log(request, "Register failed - password mismatch", "WARN", "register.jsp", "Registration", "", "Password mismatch for phone: " + phone);
            }

            // Kiểm tra số điện thoại đã tồn tại
            if (error == null && userDao.findByPhone(phone) != null) {
                error = "Số điện thoại đã được đăng ký!";
                request.setAttribute("phoneError", "Số điện thoại đã được đăng ký");
                logUtil.log(request, "Register failed - phone exists", "WARN", "register.jsp", "Registration", "", "Phone already exists: " + phone);
            }

            // Kiểm tra email đã tồn tại
            if (error == null && userDao.emailExists(email) != null) {
                error = "Email đã được đăng ký!";
                request.setAttribute("emailError", "Email đã được đăng ký");
                logUtil.log(request, "Register failed - email exists", "WARN", "register.jsp", "Registration", "", "Email already exists: " + email);
            }

            if (error == null) {
                // Tạo user mới (chưa kích hoạt)
                User newUser = new User();
                newUser.setName(name);
                newUser.setPhone(phone);
                newUser.setEmail(email);
                newUser.setPassword(password);
                newUser.setCreateAt(new Date());
                newUser.setUpdateAt(new Date());
                newUser.setActive(false);

                // Thêm user vào database
                boolean insertSuccess = userDao.insertUser(newUser);

                if (!insertSuccess) {
                    error = "Lỗi khi lưu thông tin người dùng. Vui lòng thử lại.";
                    request.setAttribute("error", error);
                    logUtil.log(request, "Register failed - DB error", "ERROR", "register.jsp", "Registration", "", "DB insert failed for phone: " + phone);
                } else {
                    // Lấy lại user vừa tạo để lấy ID
                    User createdUser = userDao.emailExists(email);
                    if (createdUser != null) {
                        // Tạo token xác thực
                        String token = UUID.randomUUID().toString();
                        Date expiryDate = new Date(System.currentTimeMillis() + 24 * 60 * 60 * 1000);

                        // Lưu vào bảng token riêng
                        boolean saveToken = userDao.createActivationToken(createdUser.getUserID(), token, expiryDate);

                        if (saveToken) {
                            // Tạo link kích hoạt
                            String activationLink = getActivationLink(request, token);

                            // Gửi email kích hoạt
                            boolean emailSent = EmailUtility.sendActivationEmail(email, activationLink);

                            if (emailSent) {
                                // Ghi log đăng ký thành công
                                logUtil.log(request, "Register success", "INFO", "register.jsp", "Registration", "Not registered", "New user registered: " + createdUser.getUserID());

                                request.setAttribute("email", email);
                                request.getRequestDispatcher("activation_pending.jsp").forward(request, response);
                                return;
                            } else {
                                error = "Không thể gửi email kích hoạt. Vui lòng thử lại sau.";
                                logUtil.log(request, "Register failed - email not sent", "ERROR", "register.jsp", "Registration", "", "Activation email failed for user: " + createdUser.getUserID());
                            }
                        } else {
                            error = "Lỗi khi tạo mã kích hoạt. Vui lòng thử lại.";
                            logUtil.log(request, "Register failed - token creation error", "ERROR", "register.jsp", "Registration", "", "Token creation failed for user: " + createdUser.getUserID());
                        }
                    } else {
                        error = "Không tìm thấy người dùng vừa tạo.";
                        logUtil.log(request, "Register failed - user not found", "ERROR", "register.jsp", "Registration", "", "User not found after creation for phone: " + phone);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            error = "Đã xảy ra lỗi hệ thống. Vui lòng thử lại sau.";
            request.setAttribute("error", error);
            logUtil.log(request, "Register failed - system error", "ERROR", "register.jsp", "Registration", "", "System error: " + e.getMessage());
        }

        if (error != null) {
            // Giữ lại thông tin người dùng nhập
            request.setAttribute("name", name);
            request.setAttribute("phone", phone);
            request.setAttribute("email", email);
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }

    private String getActivationLink(HttpServletRequest request, String token) {
        String contextPath = request.getContextPath();
        String activationPath = "/activation?token=" + token;

        // Xây dựng URL hoàn chỉnh
        String scheme = request.getScheme(); // http hoặc https
        String serverName = request.getServerName(); // tên server
        int serverPort = request.getServerPort(); // cổng

        StringBuilder link = new StringBuilder();
        link.append(scheme).append("://").append(serverName);

        // Thêm cổng nếu không phải là cổng mặc định
        if (("http".equals(scheme) && serverPort != 80) || ("https".equals(scheme) && serverPort != 443)) {
            link.append(":").append(serverPort);
        }

        link.append(contextPath).append(activationPath);
        return link.toString();
    }

    // Kiểm tra định dạng số điện thoại
    private boolean isValidPhoneNumber(String phone) {
        return phone != null && phone.matches("0\\d{9}");
    }

    // Kiểm tra độ mạnh của mật khẩu
    private boolean isValidPassword(String password) {
        return password != null && password.matches("^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d).+$");
    }
}