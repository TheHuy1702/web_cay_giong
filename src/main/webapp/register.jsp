<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Ký</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="icon" href="Ảnh/anhlogo.jpg" type="image/x-icon">
    <style>
        body {
            margin: 0;
            padding: 0;
            background: linear-gradient(135deg, #00b894, #6c5ce7, #ff7675);
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
            color: #f60a36;
        }

        .container {
            background: rgba(255, 255, 255, 0.9);
            padding-left: 40px;
            padding-right: 40px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            width: 400px;
            text-align: center;
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
            background: linear-gradient(135deg, #ff7675, #00b894, #6c5ce7);
            -webkit-background-clip: text;
            color: transparent;
            font-size: 36px;
            font-weight: 700;
            margin-bottom: 15px;
            margin-top: 20px;
            animation: slideIn 1s ease-out;
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
            margin-bottom: 20px;
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
            margin-top: 5px;
            width: 100%;
            padding: 12px;
            border: 2px solid #ccc;
            border-radius: 8px;
            font-size: 16px;
            box-sizing: border-box;
            transition: all 0.3s ease;
        }

        .form-group input:focus {
            border-color: #00b894;
            outline: none;
            box-shadow: 0 0 10px rgba(0, 183, 148, 0.6);
        }

        .btn {
            background-color: #00b894;
            color: #fff;
            padding: 12px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            width: 100%;
            font-size: 18px;
            transition: background-color 0.3s ease, transform 0.3s ease, box-shadow 0.3s ease;
        }

        .btn:hover {
            background-color: #00a182;
            transform: scale(1.05);
            box-shadow: 0 0 15px rgba(0, 183, 148, 0.7);
        }

        .extra-options {
            margin-bottom: 20px;
            margin-top: 10px;
            font-size: 14px;
            color: #333;
        }

        .extra-options a {
            color: #333;
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s ease;
        }

        .extra-options a:hover {
            color: #00b894;
            text-decoration: underline;
        }

        .error-message {
            color: red;
            font-size: 12px;
            margin-top: 5px;
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
            color: #00b894;
        }

        .social-buttons {
            display: flex;
            justify-content: space-between;
        }

        .social-btn {
            flex: 1;
            margin: 0 5px;
            padding: 10px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s ease, transform 0.3s ease, box-shadow 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .social-btn.facebook {
            background-color: #3b5998;
            color: #fff;
        }

        .social-btn.google {
            background-color: #db4437;
            color: #fff;
        }

        .social-btn:hover {
            transform: scale(1.05);
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.2);
        }

        .social-btn i {
            margin-right: 8px;
        }

        .or-divider {
            margin: 15px 0;
            color: #333;
            font-size: 14px;
            position: relative;
        }

        .or-divider::before, .or-divider::after {
            content: '';
            flex: 1;
            border-bottom: 1px solid #ccc;
            margin: auto;
        }

        .or-divider::before {
            margin-right: 10px;
        }

        .or-divider::after {
            margin-left: 10px;
        }
    </style>
</head>
<body>
<a href="TrangChu" class="back-home"><i class="fas fa-home"></i>Trang chủ</a>
<div class="container">
    <h2>Đăng Ký</h2>
    <form action="register" method="post">
        <div class="form-group">
            <label for="name">Họ & tên</label>
            <input type="text" id="name" name="name" placeholder="Họ & tên" required>
        </div>
        <div class="form-group">
            <label for="phone">Số điện thoại</label>
            <input type="text" id="phone" name="phone" placeholder="Số điện thoại" required>
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
        <div class="or-divider">---------hoặc---------</div>
        <div class="social-buttons">
            <button type="button" class="social-btn facebook"><i class="fab fa-facebook-f"></i>Facebook</button>
            <button type="button" class="social-btn google"><i class="fab fa-google"></i>Google</button>
        </div>
        <p class="extra-options">Đã có tài khoản? <a href="login">Đăng nhập</a></p>
        <% if(request.getAttribute("error") != null) { %>
        <p class="error-message"><%= request.getAttribute("error") %></p>
        <% } %>
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
</script>
</body>
</html>