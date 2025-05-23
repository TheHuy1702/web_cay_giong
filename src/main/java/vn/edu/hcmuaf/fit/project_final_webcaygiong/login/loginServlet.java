package vn.edu.hcmuaf.fit.project_final_webcaygiong.login;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.LogUtil;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.UserDao;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.User;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.TimeUnit;

@WebServlet(name = "loginServlet", value = "/login")
public class loginServlet extends HttpServlet {
    private static final Map<String, Integer> failedAttempts = new HashMap<>();
    private static final Map<String, Long> blockedIPs = new HashMap<>();
    private static final Map<String, Boolean> warningEmailSent = new HashMap<>();
    private static final int MAX_FAILED_ATTEMPTS = 3;
    private static final int MAX_BLOCKED_ATTEMPTS = 5;
    private static final long BLOCK_DURATION = TimeUnit.MINUTES.toMillis(5); // 5 phút

    private EmailService emailService;

    @Override
    public void init() throws ServletException {
        super.init();
        emailService = new EmailService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String ip = request.getRemoteAddr();
        if (isIPBlocked(ip)) {
            request.setAttribute("error", "Tài khoản của bạn đã bị tạm khóa do đăng nhập sai quá nhiều lần. Vui lòng thử lại sau 5 phút.");
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        HttpSession session = request.getSession();
        UserDao userDao = new UserDao();
        LogUtil logUtil = new LogUtil();
        String ip = request.getRemoteAddr();

        // Kiểm tra IP có bị block không
        if (isIPBlocked(ip)) {
            request.setAttribute("error", "Tài khoản của bạn đã bị tạm khóa do đăng nhập sai quá nhiều lần. Vui lòng thử lại sau 5 phút.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // Kiểm tra tài khoản admin
        User adminUser = userDao.findByPhone("0123456789");
        if (adminUser != null && adminUser.getPhone().equals(phone)) {
            if (adminUser.getPassword().equals(password)) {
                if (adminUser.isActive()) {
                    resetFailedAttempts(ip);
                    logUtil.log(request, "Login", "INFO", "login.jsp", "User",
                            "Not logged in", "Logged in as admin");
                    session.setAttribute("user", adminUser);
                    session.setAttribute("au", true);
                    response.sendRedirect("DashBoard");
                    return;
                } else {
                    logUtil.log(request, "Login failed - account inactive", "WARN", "login.jsp", "User",
                            "Not logged in", "Attempt to login as inactive admin");
                    request.setAttribute("error", "Tài khoản admin chưa được kích hoạt. Vui lòng kiểm tra email.");
                }
            } else {
                handleFailedLogin(request, ip, phone, "admin", userDao);
                request.setAttribute("error", "Số điện thoại hoặc mật khẩu không đúng.");
            }
            request.setAttribute("phone", phone);
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // Kiểm tra người dùng thường
        User user = userDao.findByPhone(phone);
        if (user != null) {
            boolean isLogin = userDao.checkLogin(phone, password);
            if (isLogin) {
                if (user.isActive()) {
                    resetFailedAttempts(ip);
                    logUtil.log(request, "Login", "INFO", "login.jsp", "User",
                            "Not logged in", "Logged in as user");
                    session.setAttribute("user", user);
                    session.setAttribute("au", false);
                    response.sendRedirect("TrangChu");
                    return;
                } else {
                    logUtil.log(request, "Login failed - account inactive", "WARN", "login.jsp", "User",
                            "Not logged in", "Attempt to login as inactive user");
                    request.setAttribute("error", "Tài khoản chưa được kích hoạt. Vui lòng kiểm tra email.");
                }
            } else {
                handleFailedLogin(request, ip, phone, "user", userDao);
                request.setAttribute("error", "Số điện thoại hoặc mật khẩu không đúng.");
            }
        } else {
            handleFailedLogin(request, ip, phone, "non-existent user", userDao);
            request.setAttribute("error", "Số điện thoại không tồn tại.");
        }

        request.setAttribute("phone", phone);
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    private void handleFailedLogin(HttpServletRequest request, String ip, String phone, String userType, UserDao userDao) {
        int attempts = incrementFailedAttempts(ip);
        LogUtil logUtil = new LogUtil();

        logUtil.log(request, "Login failed", "WARN", "login.jsp", "User",
                "Not logged in", "Failed login attempt for " + userType + " with phone: " + phone);

        if (attempts >= MAX_FAILED_ATTEMPTS && attempts < MAX_BLOCKED_ATTEMPTS) {
            request.setAttribute("warning", "Bạn đã đăng nhập sai " + attempts + " lần. Nếu sai quá " + MAX_BLOCKED_ATTEMPTS + " lần, tài khoản sẽ bị tạm khóa trong 5 phút.");

            // Gửi email cảnh báo khi đạt MAX_FAILED_ATTEMPTS lần
            if (attempts == MAX_FAILED_ATTEMPTS && !warningEmailSent.getOrDefault(ip, false)) {
                User user = userDao.findByPhone(phone);
                if (user != null) {
                    boolean emailSent = emailService.sendWarningEmail(
                            user.getEmail(),
                            user.getName(),
                            attempts
                    );
                    if (emailSent) {
                        warningEmailSent.put(ip, true);
                        logUtil.log(request, "Warning email sent", "INFO", "login.jsp", "User",
                                "Not logged in", "Sent warning email to " + user.getEmail());
                    }
                }
            }
        } else if (attempts >= MAX_BLOCKED_ATTEMPTS) {
            blockIP(ip);
            request.setAttribute("error", "Bạn đã đăng nhập sai quá " + MAX_BLOCKED_ATTEMPTS + " lần. Tài khoản bị tạm khóa trong 5 phút.");
        }
    }

    private synchronized int incrementFailedAttempts(String ip) {
        int attempts = failedAttempts.getOrDefault(ip, 0) + 1;
        failedAttempts.put(ip, attempts);
        return attempts;
    }

    private synchronized void resetFailedAttempts(String ip) {
        failedAttempts.remove(ip);
        warningEmailSent.remove(ip);
    }

    private synchronized void blockIP(String ip) {
        blockedIPs.put(ip, System.currentTimeMillis());
    }

    private synchronized boolean isIPBlocked(String ip) {
        if (blockedIPs.containsKey(ip)) {
            long blockTime = blockedIPs.get(ip);
            if (System.currentTimeMillis() - blockTime < BLOCK_DURATION) {
                return true;
            } else {
                blockedIPs.remove(ip);
                failedAttempts.remove(ip);
                warningEmailSent.remove(ip);
                return false;
            }
        }
        return false;
    }
}