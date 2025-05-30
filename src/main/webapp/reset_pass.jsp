<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đổi Mật Khẩu</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
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
            padding: 15px;
            border: 2px solid #ccc;
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

        .text-danger {
            color: red;
            font-size: 14px;
            margin-top: 5px;
        }

        .eye-icon {
            position: absolute;
            top: 60%;
            right: 10px;
            transform: translateY(-50%);
            cursor: pointer;
            color: #aaa;
            transition: color 0.3s ease;
            font-size: 20px;
        }

        .eye-icon:hover {
            color: #2ecc71;
        }

        .alert {
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 5px;
            text-align: center;
        }

        .alert-danger {
            background-color: #f8d7da;
            border-color: #f5c6cb;
            color: #721c24;
        }

        .alert-success {
            background-color: #d4edda;
            border-color: #c3e6cb;
            color: #155724;
        }
    </style>
</head>

<body>
<div>
    <a href="login.jsp" class="back-home"><i class="fas fa-arrow-left"></i> Quay lại</a>
    <div class="container">
        <h2>Đổi Mật Khẩu</h2>

        <%-- Thêm thông báo lỗi --%>
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger">${errorMessage}</div>
        </c:if>

        <form method="post" action="reset_pass">
            <input type="hidden" name="token" value="${token}"/>
            <div class="form-group">
                <label for="new-password">Mật khẩu mới</label>
                <div style="position: relative;">
                    <input type="password" id="new-password" name="new-password" placeholder="Nhập mật khẩu mới"
                           required/>
                    <i id="eye-icon" class="fas fa-eye eye-icon" onclick="togglePasswordVisibility('new-password')"></i>
                </div>
            </div>
            <div class="form-group">
                <label for="confirm-password">Xác nhận mật khẩu</label>
                <div style="position: relative;">
                    <input type="password" id="confirm-password" name="confirm-password" placeholder="Nhập lại mật khẩu"
                           required/>
                    <i id="eye-icon-confirm" class="fas fa-eye eye-icon"
                       onclick="togglePasswordVisibility('confirm-password')"></i>
                </div>
            </div>
            <button type="submit" class="btn">Cập nhật mật khẩu</button>
            <div class="extra-options">
                <p>Quay lại <a href="login.jsp">Đăng nhập</a></p>
            </div>
        </form>
    </div>
</div>

<script>
    function togglePasswordVisibility(id) {
        var passwordField = document.getElementById(id);
        var icon = document.getElementById('eye-icon' + (id === 'new-password' ? '' : '-confirm'));

        if (passwordField.type === "password") {
            passwordField.type = "text";
            icon.classList.remove("fa-eye");
            icon.classList.add("fa-eye-slash");
        } else {
            passwordField.type = "password";
            icon.classList.remove("fa-eye-slash");
            icon.classList.add("fa-eye");
        }
    }
</script>
</body>
</html>