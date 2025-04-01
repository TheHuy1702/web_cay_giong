<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đổi Mật Khẩu</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="icon" href="Ảnh/anhlogo.jpg" type="image/x-icon">
    <style>
        body {
            margin: 0;
            padding: 0;
            background: linear-gradient(135deg, #00b894, #ff7675, #6c5ce7);
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
            color: #09ba97;
        }

        .container {
            background: rgba(255, 255, 255, 0.9);
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            width: 350px;
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
            margin-bottom: 20px;
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
            position: relative; /* Thêm thuộc tính này cho container */
        }

        .form-group input {
            margin-top: 5px;
            width: 100%;
            padding: 12px 40px 12px 12px; /* Thêm padding phải để có chỗ cho icon */
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
            margin-top: 10px;
            font-size: 14px;
            color: #333;
        }

        .extra-options a {
            color: #ffdd57;
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s ease;
        }

        .extra-options a:hover {
            color: #00b894;
            text-decoration: underline;
        }

        .eye-icon {
            position: absolute;
            top: 50%;
            right: 12px; /* Đảm bảo icon cách phải 12px */
            transform: translateY(-50%); /* Đặt icon vào giữa */
            cursor: pointer;
            color: #aaa;
            transition: color 0.3s ease;
            font-size: 20px;
        }

        .eye-icon:hover {
            color: #00b894;
        }

        .text-danger {
            color: red;
            font-size: 14px;
            margin-top: 5px;
        }

    </style>
</head>

<body>
<a href="login.jsp" class="back-home"><i class="fas fa-arrow-left"></i></a>
<div class="container">
    <h2>Đổi Mật Khẩu</h2>
    <form method="post" action="reset_pass">
        <input type="hidden" name="phone" value="${param.phone}"/>
        <div class="form-group">
            <label for="new-password">Mật khẩu mới</label>
            <div style="position: relative;">
                <input type="password" id="new-password" name="new-password" placeholder="Nhập mật khẩu mới" required/>
                <i id="eye-icon" class="fas fa-eye eye-icon" onclick="togglePasswordVisibility('new-password')"></i>
            </div>
        </div>
        <div class="form-group">
            <label for="confirm-password">Xác nhận mật khẩu</label>
            <div style="position: relative;">
                <input type="password" id="confirm-password" name="confirm-password" placeholder="Nhập lại mật khẩu" required/>
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
