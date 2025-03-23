<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Nhập</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="icon" href="Ảnh/anhlogo.jpg" type="image/x-icon">
    <style>
        body {
            margin: 0;
            padding: 0;
            background: linear-gradient(135deg, #00b894, #6c5ce7, #ff7675); /* Màu gradient mới */
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
            background: linear-gradient(135deg, #ff7675, #00b894, #6c5ce7);
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
            padding: 15px;
            border: 2px solid #ccc;
            border-radius: 8px;
            font-size: 16px;
            box-sizing: border-box;
            transition: all 0.3s ease;
            background: rgba(255, 255, 255, 0.8);
        }

        .form-group input:focus {
            border-color: #00b894;
            outline: none;
            box-shadow: 0 0 10px rgba(0, 183, 148, 0.6);
        }

        .btn {
            background-color: #00b894;
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
            background-color: #00a182;
            transform: scale(1.05);
            box-shadow: 0 0 15px rgba(0, 183, 148, 0.7);
        }

        .btn-social {
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: #fff;
            color: #333;
            padding: 15px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            width: 48%; /* Giảm width để hai nút nằm ngang hàng */
            font-size: 16px;
            margin-bottom: 15px;
            transition: background-color 0.3s ease, transform 0.3s ease, box-shadow 0.3s ease;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .btn-social:hover {
            transform: scale(1.05);
            box-shadow: 0 6px 8px rgba(0, 0, 0, 0.2);
        }

        .btn-social i {
            margin-right: 10px;
            font-size: 20px;
        }

        .btn-facebook {
            background-color: #1877f2;
            color: #fff;
        }

        .btn-google {
            background-color: #db4437;
            color: #fff;
        }

        .extra-options {
            margin-top: 15px;
            font-size: 14px;
            color: #fff;
        }

        .extra-option {
            margin-top: 15px;
            font-size: 14px;
            color: #fff;
            text-align: center;
        }

        .extra-option a {
            color: #333;
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s ease;
        }

        .extra-option a:hover {
            color: #00b894;
            text-decoration: underline;
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

        .text-danger {
            color: red;
            font-size: 14px;
            margin-top: 5px;
        }

        .error-message {
            color: red;
            font-size: 12px;
            margin-top: 5px;
        }

        .success-message {
            color: green;
            font-size: 12px;
            margin-top: 5px;
        }

        .social-buttons {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }

        .or-separator {
            text-align: center;
            margin: 20px 0;
            color: #333;
            font-size: 16px;
            position: relative;
        }

        .or-separator::before,
        .or-separator::after {
            content: '';
            flex: 1;
            border-bottom: 1px solid #ccc;
            margin: auto;
        }

        .or-separator::before {
            margin-right: 10px;
        }

        .or-separator::after {
            margin-left: 10px;
        }
    </style>
</head>

<body>
<div>
    <a href="TrangChu" class="back-home"><i class="fas fa-home"></i> Trang chủ</a>
    <div class="container">
        <h2>Đăng Nhập</h2>
        <form method="post" action="login" id="loginForm">
            <div class="form-group">
                <label for="phone">Số điện thoại</label>
                <input type="text" id="phone" placeholder="Số điện thoại" required name="phone" value="${phone}">
                <p class="text-danger" id="phoneError"></p>
            </div>
            <div class="form-group">
                <label for="password">Mật khẩu</label>
                <div style="position: relative;">
                    <input type="password" id="password" placeholder="Mật khẩu" required name="password">
                    <i id="togglePassword" class="fas fa-eye"></i>
                </div>
                <p class="text-danger" id="passwordError">${passwordError}</p>
            </div>
            <div class="extra-options">
                <p style="color: #333;"><a href="forgot_pass">Quên mật khẩu ?</a></p>
            </div>
            <button class="btn" type="submit">Đăng Nhập</button>
            <div class="or-separator">--------- hoặc ---------</div>
            <div class="social-buttons">
                <button class="btn btn-social btn-facebook">
                    <i class="fab fa-facebook-f"></i> Facebook
                </button>
                <button class="btn btn-social btn-google">
                    <i class="fab fa-google"></i> Google
                </button>
            </div>
            <div class="extra-option">
                <p style="color: #333;">Chưa có tài khoản ? <a href="register">Đăng ký</a></p>
            </div>
        </form>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", () => {
        const togglePassword = document.getElementById("togglePassword");
        const passwordField = document.getElementById("password");
        const phoneField = document.getElementById("phone");
        const phoneError = document.getElementById("phoneError");
        const passwordError = document.getElementById("passwordError");
        const loginForm = document.getElementById("loginForm");

        togglePassword.addEventListener("click", () => {
            const type = passwordField.type === "password" ? "text" : "password";
            passwordField.type = type;
            togglePassword.classList.toggle("fa-eye-slash");
        });

        loginForm.addEventListener("submit", (event) => {
            let valid = true;
            phoneError.textContent = "";
            passwordError.textContent = "";

            // Validate phone number
            const phone = phoneField.value;
            const phoneRegex = /^0\d{9}$/; // 10 digits starting with 0
            if (!phoneRegex.test(phone)) {
                phoneError.textContent = "Số điện thoại phải có 10 chữ số và bắt đầu bằng 0.";
                valid = false;
            }

            // Validate password
            const password = passwordField.value;
            const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/; // At least 8 characters, 1 uppercase, 1 lowercase, 1 number, 1 special character
            if (!passwordRegex.test(password)) {
                passwordError.textContent = "Mật khẩu phải có ít nhất 8 ký tự, bao gồm chữ hoa, chữ thường, ký tự đặc biệt và số.";
                valid = false;
            }

            if (!valid) {
                event.preventDefault(); // Prevent form submission if validation fails
            }
        });
    });
</script>

</body>
</html>