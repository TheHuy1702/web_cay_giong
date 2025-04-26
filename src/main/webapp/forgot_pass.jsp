<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quên Mật Khẩu</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
    <link rel="icon" href="Ảnh/anhlogo.jpg" type="image/x-icon">
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
            padding: 20px 40px;
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
            position: relative;
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

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #555;
        }

        .form-group input {
            width: 100%;
            padding: 15px;
            border: 2px solid #ddd;
            border-radius: 8px;
            font-size: 16px;
            box-sizing: border-box;
            transition: all 0.3s ease;
            background: rgba(255, 255, 255, 0.8);
        }

        .form-group input:focus {
            border-color: #2ecc71;
            outline: none;
            box-shadow: 0 0 10px rgba(46, 204, 113, 0.6);
        }

        .form-group.error input {
            border-color: #ff7675;
        }

        .reset-btn {
            width: 100%;
            padding: 15px;
            background-color: #2ecc71;
            font-size: 18px;
            font-weight: bold;
            color: #fff;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 10px;
        }

        .reset-btn:hover {
            background-color: #27ae60;
            transform: scale(1.05);
            box-shadow: 0 0 15px rgba(46, 204, 113, 0.7);
        }

        .text-danger {
            color: red;
            font-size: 14px;
            margin-top: 5px;
        }

        .alert {
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 14px;
            text-align: center;
        }

        .alert-danger {
            background-color: #ffebee;
            color: #f44336;
            border: 1px solid #f44336;
        }

        .alert-success {
            background-color: #e8f5e9;
            color: #4CAF50;
            border: 1px solid #4CAF50;
        }

        .email-icon {
            position: absolute;
            right: 15px;
            top: 46px;
            color: #aaa;
            font-size: 18px;
        }

        .mail-buttons {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-top: 20px;
        }

        .mail-btn {
            padding: 10px 15px;
            border-radius: 8px;
            text-decoration: none;
            color: white;
            font-weight: bold;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s;
            font-size: 14px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .mail-btn:hover {
            transform: scale(1.05);
            box-shadow: 0 6px 8px rgba(0, 0, 0, 0.2);
        }

        .mail-btn i {
            font-size: 16px;
        }

        .gmail-btn {
            background-color: #DB4437;
        }

        .outlook-btn {
            background-color: #0078D4;
        }

        .yahoo-btn {
            background-color: #720e9e;
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
<a href="login" class="back-home"><i class="fas fa-arrow-left"></i></a>
<div class="container">
    <h2>Quên Mật Khẩu</h2>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">
                ${error}
        </div>
    </c:if>

    <c:if test="${not empty success}">
        <div class="alert alert-success">
                ${success}
        </div>
        <div class="or-separator">Truy cập email của bạn</div>
        <div class="mail-buttons">
            <a href="https://mail.google.com" class="mail-btn gmail-btn" target="_blank">
                <i class="bi bi-envelope"></i> Gmail
            </a>
            <a href="https://outlook.live.com" class="mail-btn outlook-btn" target="_blank">
                <i class="bi bi-envelope"></i> Outlook
            </a>
            <a href="https://mail.yahoo.com" class="mail-btn yahoo-btn" target="_blank">
                <i class="bi bi-envelope"></i> Yahoo
            </a>
        </div>
    </c:if>

    <c:if test="${empty success}">
        <form method="post" action="forgot_pass" id="forgotForm">
            <div class="form-group" id="emailGroup">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" placeholder="Nhập email đã đăng ký" required
                       value="${email != null ? email : ''}">
                <i class="fas fa-envelope email-icon"></i>
                <span class="text-danger" id="emailError">${emailError}</span>
            </div>

            <button type="submit" class="reset-btn">
                <i class="fas fa-key"></i> Đặt lại mật khẩu
            </button>
        </form>
    </c:if>
</div>

<script>
    // Hiển thị lỗi email nếu có
    const emailError = document.getElementById('emailError');
    if (emailError && emailError.textContent.trim() !== '') {
        emailError.style.display = 'block';
        document.getElementById('emailGroup').classList.add('error');
    }

    // Validate form trước khi submit
    const forgotForm = document.getElementById('forgotForm');
    if (forgotForm) {
        forgotForm.addEventListener('submit', function (e) {
            const email = document.getElementById('email').value;
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            const emailGroup = document.getElementById('emailGroup');
            const emailError = document.getElementById('emailError');

            // Reset trạng thái lỗi trước khi validate
            emailGroup.classList.remove('error');
            emailError.style.display = 'none';
            emailError.textContent = '';

            if (!emailRegex.test(email)) {
                e.preventDefault();
                emailGroup.classList.add('error');
                emailError.textContent = 'Vui lòng nhập địa chỉ email hợp lệ!';
                emailError.style.display = 'block';
                return false;
            }

            return true;
        });
    }
</script>
</body>
</html>