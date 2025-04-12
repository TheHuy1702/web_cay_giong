package vn.edu.hcmuaf.fit.project_final_webcaygiong.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "VerifyEmailOtpServlet", value = "/verify-email-otp")
public class VerifyEmailOtpServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        String otpInput = request.getParameter("otp");
        String otpStored = (String) session.getAttribute("otp");
        Long otpTime = (Long) session.getAttribute("otpTime");
        String otpAction = (String) session.getAttribute("otpAction");

        if (otpStored == null || otpTime == null || System.currentTimeMillis() - otpTime > 3 * 60 * 1000) {
            request.setAttribute("error", "Mã OTP đã hết hạn. Vui lòng yêu cầu mã mới.");
            request.getRequestDispatcher("otpVerify.jsp").forward(request, response);
            return;
        }

        if (!otpInput.equals(otpStored)) {
            request.setAttribute("error", "Mã OTP không đúng. Vui lòng kiểm tra lại.");
            request.getRequestDispatcher("otpVerify.jsp").forward(request, response);
            return;
        }

        session.removeAttribute("otp");
        session.removeAttribute("otpTime");
        session.removeAttribute("otpLastSent");

        // Chuyển hướng theo mục đích OTP
        if (otpAction == null) {
            response.sendRedirect("taiKhoanCuaToi");
            return;
        }

        switch (otpAction) {
            case "changePassword":
                response.sendRedirect("doiMatkhau");
                break;
            case "updateEmail":
                session.setAttribute("openPopup", "email");
                response.sendRedirect("taiKhoanCuaToi");
                break;
            case "updatePhone":
                session.setAttribute("openPopup", "phone");
                response.sendRedirect("taiKhoanCuaToi");
                break;
            default:
                response.sendRedirect("taiKhoanCuaToi");
                break;
        }
    }
    }

