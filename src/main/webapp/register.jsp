<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Ký</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="icon" href="Ảnh/anhlogo.jpg" type="image/x-icon">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        body {
            margin: 0;
            padding: 0;
            background: linear-gradient(135deg, #00b894, #2ecc71, #27ae60); /* Green gradient */
            font-family: Arial, Helvetica, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background-size: cover;
        }

        .back-home {
            position: absolute;
            top: 20px;
            left: 30px;
            font-size: 20px;
            color: #fff;
            text-decoration: none;
            display: flex;
            align-items: center;
            transition: color 0.3s;
        }

        .back-home i {
            margin-right: 8px;
        }

        .back-home:hover {
            color: #2ecc71;
        }

        .container {
            background: rgba(255, 255, 255, 0.9);
            padding: 10px 40px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            width: 400px;
            animation: fadeIn 1s ease-out;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }

        h2 {
            background: linear-gradient(135deg, #27ae60, #2ecc71);
            -webkit-background-clip: text;
            color: transparent;
            font-size: 36px;
            font-weight: 700;
            margin-bottom: 20px;
            animation: slideIn 1s ease-out;
            text-align: center;
        }

        @keyframes slideIn {
            from {
                transform: translateY(-30px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        .form-group {
            margin-bottom: 25px;
            text-align: left;
            animation: formGroupAnimation 1s ease-out;
        }

        @keyframes formGroupAnimation {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }

        .form-group input {
            margin-top: 10px;
            width: 100%;
            padding: 10px;
            border: 2px solid #ccc;
            border-radius: 8px;
            font-size: 15px;
            box-sizing: border-box;
            transition: all 0.3s ease;
            background: rgba(255, 255, 255, 0.8);
        }

        .form-group input:focus {
            border-color: #2ecc71;
            outline: none;
            box-shadow: 0 0 10px rgba(46, 204, 113, 0.6);
        }

        .btn {
            background-color: #2ecc71;
            color: #fff;
            padding: 15px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            width: 100%;
            font-size: 18px;
            transition: background-color 0.3s ease, transform 0.3s ease, box-shadow 0.3s ease;
        }

        .btn:hover {
            background-color: #27ae60;
            transform: scale(1.05);
            box-shadow: 0 0 15px rgba(46, 204, 113, 0.7);
        }

        .extra-options {
            margin-top: 15px;
            font-size: 14px;
            color: #333;
            text-align: center;
        }

        .extra-options a {
            color: #333;
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s ease;
        }

        .extra-options a:hover {
            color: #2ecc71;
            text-decoration: underline;
        }

        .fa-eye {
            position: absolute;
            top: 60%;
            right: 10px;
            transform: translateY(-50%);
            cursor: pointer;
            color: #aaa;
            transition: color 0.3s ease;
        }

        .fa-eye:hover {
            color: #2ecc71;
        }

        .text-danger {
            color: red;
            font-size: 14px;
            margin-top: 5px;
        }

        .success-message {
            color: green;
            font-size: 14px;
            margin: 10px 0;
            padding: 10px;
            background-color: #e8f5e9;
            border-radius: 5px;
            text-align: center;
        }

        .error-message {
            color: red;
            font-size: 14px;
            margin: 10px 0;
            padding: 10px;
            background-color: #ffebee;
            border-radius: 5px;
            text-align: center;
        }

        .validation-error {
            color: red;
            font-size: 12px;
            margin-top: 5px;
            display: none;
        }

        .is-invalid {
            border-color: #ff7675 !important;
        }
    </style>
</head>
<body>
<a href="TrangChu" class="back-home"><i class="fas fa-home"></i>Trang chủ</a>
<div class="container">
    <h2>Đăng Ký</h2>

    <%-- Hiển thị thông báo thành công --%>
    <c:if test="${not empty success}">
        <div class="success-message">
                ${success}
        </div>
    </c:if>

    <form action="register" method="post" id="registerForm">
        <div class="form-group">
            <label for="name">Họ & tên</label>
            <input type="text" id="name" name="name" placeholder="Họ & tên" required value="${param.name}">
        </div>
        <div class="form-group">
            <label for="phone">Số điện thoại</label>
            <input type="text" id="phone" name="phone" placeholder="Số điện thoại" required value="${param.phone}">
            <div id="phoneError" class="validation-error">Số điện thoại đã được đăng ký</div>
        </div>
        <div class="form-group">
            <label for="email">Email</label>
            <input type="email" id="email" name="email" placeholder="Email" required value="${param.email}">
            <div id="emailError" class="validation-error">Email đã được đăng ký</div>
        </div>
        <div class="form-group">
            <label for="password">Mật khẩu</label>
            <div style="position: relative;">
                <input type="password" id="password" name="password" placeholder="Mật khẩu" required>
                <i id="togglePassword" class="fas fa-eye"></i>
            </div>
        </div>
        <div class="form-group">
            <label for="confirm-password">Xác nhận mật khẩu</label>
            <div style="position: relative;">
                <input type="password" id="confirm-password" name="confirmPassword" placeholder="Xác nhận mật khẩu" required>
                <i id="toggleConfirmPassword" class="fas fa-eye"></i>
            </div>
        </div>
        <button type="submit" class="btn">Đăng Ký</button>
        <p class="extra-options">Đã có tài khoản? <a href="login">Đăng nhập</a></p>

        <%-- Hiển thị thông báo lỗi --%>
        <c:if test="${not empty error}">
            <div class="error-message">${error}</div>
        </c:if>
    </form>
</div>
<script>
    document.addEventListener("DOMContentLoaded", () => {
        const togglePassword = document.getElementById("togglePassword");
        const passwordField = document.getElementById("password");

        togglePassword.addEventListener("click", () => {
            const type = passwordField.type === "password" ? "text" : "password";
            passwordField.type = type;
            togglePassword.classList.toggle("fa-eye-slash");
        });

        const toggleConfirmPassword = document.getElementById("toggleConfirmPassword");
        const confirmPasswordField = document.getElementById("confirm-password");

        toggleConfirmPassword.addEventListener("click", () => {
            const type = confirmPasswordField.type === "password" ? "text" : "password";
            confirmPasswordField.type = type;
            toggleConfirmPassword.classList.toggle("fa-eye-slash");
        });
    });
    $(document).ready(function() {
        // Kiểm tra số điện thoại khi người dùng rời khỏi trường nhập
        $('#phone').on('blur', function () {
            const phone = $(this).val();
            if (phone.length >= 10) { // Chỉ kiểm tra nếu số điện thoại có đủ độ dài
                checkPhoneAvailability(phone);
            }
        });

        // Kiểm tra email khi người dùng rời khỏi trường nhập
        $('#email').on('blur', function() {
            const email = $(this).val();
            if(email.includes('@')) { // Kiểm tra định dạng email cơ bản
                checkEmailAvailability(email);
            }
        });

        // Ngăn form submit nếu có lỗi validation
        $('#registerForm').on('submit', function(e) {
            const hasPhoneError = $('#phoneError').is(':visible');
            const hasEmailError = $('#emailError').is(':visible');

            if(hasPhoneError || hasEmailError) {
                e.preventDefault();
                alert('Vui lòng kiểm tra lại thông tin đăng ký');
            }
        });

        function checkPhoneAvailability(phone) {
            $.get('checkAvailability', {type: 'phone', value: phone}, function(response) {
                if(response.available) {
                    $('#phone').removeClass('is-invalid');
                    $('#phoneError').hide();
                } else {
                    $('#phone').addClass('is-invalid');
                    $('#phoneError').show();
                }
            });
        }

        function checkEmailAvailability(email) {
            $.get('checkAvailability', {type: 'email', value: email}, function(response) {
                if(response.available) {
                    $('#email').removeClass('is-invalid');
                    $('#emailError').hide();
                } else {
                    $('#email').addClass('is-invalid');
                    $('#emailError').show();
                }
            });
        }
    });
</script>
</body>
</html>