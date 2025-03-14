package vn.edu.hcmuaf.fit.project_final_webcaygiong.login;


import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.User;

import java.io.IOException;

@WebFilter(urlPatterns = {"/*"}, description = "Filte for login")
public class loginFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        Filter.super.init(filterConfig);
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest rq = (HttpServletRequest) servletRequest;
        HttpServletResponse rp = (HttpServletResponse) servletResponse;
        HttpSession session = rq.getSession();
        String requestURI = rq.getRequestURI();

        // Kiểm tra xem người dùng có đăng nhập chưa
        User user = (User) session.getAttribute("user");

        // Nếu người dùng chưa đăng nhập và yêu cầu truy cập vào các trang không được phép
        if (user == null) {
            // Nếu yêu cầu vào trang admin, chuyển hướng đến trang login
            if (requestURI.contains("/DashBoard")) {
                rp.sendRedirect(rq.getContextPath() + "/login");
                return;
            }
        } else {
            // Nếu người dùng đã đăng nhập, kiểm tra quyền truy cập
            // Kiểm tra nếu người dùng cố gắng truy cập trang admin khi đã đăng nhập
            Boolean isAdmin = (Boolean) session.getAttribute("au");
            if (isAdmin != null && isAdmin) {
                // Nếu là admin, cho phép truy cập vào trang DashBoard
                if (requestURI.contains("/DashBoard")) {
                    chain.doFilter(servletRequest, servletResponse);
                    return;
                }
            } else {
                // Nếu không phải admin, không cho phép truy cập vào trang admin
                if (requestURI.contains("/DashBoard")) {
                    rp.sendRedirect(rq.getContextPath() + "/TrangChu");
                    return;
                }
            }
            // Nếu người dùng đã đăng nhập và không cố gắng truy cập trang admin, cho phép truy cập
            if (requestURI.contains("/login")) {
                rp.sendRedirect(rq.getContextPath() + "/TrangChu");
                return;
            }
        }

        // Tiếp tục chuỗi bộ lọc
        chain.doFilter(servletRequest, servletResponse);
    }

    @Override
    public void destroy() {
        Filter.super.destroy();
    }
}
