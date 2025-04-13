<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quên Mật Khẩu</title>
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
            margin-bottom: 25px;
            text-align: left;
            position: relative;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #555;
        }

        .form-group input {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #ddd;
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

        .form-group.error input {
            border-color: #ff7675;
        }

        .reset-btn {
            width: 100%;
            padding: 14px;
            background-color: #09ba97;
            font-size: 16px;
            font-weight: bold;
            color: #fff;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 10px;
        }

        .reset-btn:hover {
            background-color: #068a70;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(9, 186, 151, 0.4);
        }

        .reset-btn:active {
            transform: translateY(0);
        }

        .text-danger {
            color: #ff7675;
            font-size: 14px;
            margin-top: 8px;
            display: none; /* Ẩn mặc định */
        }

        .alert {
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 14px;
            display: none; /* Ẩn mặc định */
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
    </style>
</head>

<body>
<a href="login" class="back-home"><i class="fas fa-arrow-left"></i></a>
<div class="container">
    <h2>Quên Mật Khẩu</h2>

    <%-- Thông báo - ẩn mặc định --%>
    <div class="alert alert-danger" id="errorAlert" style="display:none;">${error}</div>
    <div class="alert alert-success" id="successAlert" style="display:none;">${success}</div>

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
</div>

<script>
    // Hiển thị lỗi email nếu có
    const emailError = document.getElementById('emailError');
    if (emailError.textContent.trim() !== '') {
        emailError.style.display = 'block';
        document.getElementById('emailGroup').classList.add('error');
    }

    // Validate form trước khi submit
    document.getElementById('forgotForm').addEventListener('submit', function (e) {
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

        // Hiển thị thông báo nếu có nội dung
        window.onload = function() {
        const errorAlert = document.getElementById('errorAlert');
        const successAlert = document.getElementById('successAlert');

        if(errorAlert.textContent.trim() !== '') {
        errorAlert.style.display = 'block';
    }
        if(successAlert.textContent.trim() !== '') {
        successAlert.style.display = 'block';
    }
    };
        // Hiển thị thông báo nếu có nội dung
        window.onload = function() {
        const errorAlert = document.getElementById('errorAlert');
        const successAlert = document.getElementById('successAlert');

        if(errorAlert && errorAlert.textContent.trim() !== '') {
        errorAlert.style.display = 'block';
    }
        if(successAlert && successAlert.textContent.trim() !== '') {
        successAlert.style.display = 'block';
    }
    };

        // Validate form trước khi submit
        document.getElementById('forgotForm').addEventListener('submit', function(e) {
        const email = document.getElementById('email').value;
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        const emailGroup = document.getElementById('emailGroup');
        const emailError = document.getElementById('emailError');

        // Reset trạng thái lỗi trước khi validate
        emailGroup.classList.remove('error');
        emailError.style.display = 'none';
        emailError.textContent = '';

        if(!emailRegex.test(email)) {
        e.preventDefault();
        emailGroup.classList.add('error');
        emailError.textContent = 'Vui lòng nhập địa chỉ email hợp lệ!';
        emailError.style.display = 'block';
        return false;
    }

        return true;
    });
</script>
</body>
</html>