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
            position: relative;
        }

        .form-group input {
            margin-top: 5px;
            width: 100%;
            padding: 12px 40px 12px 12px;
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

        button {
            padding: 12px;
            font-size: 16px;
            font-weight: bold;
            color: #fff;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.3s ease, box-shadow 0.3s ease;
        }

        button:hover {
            transform: scale(1.05);
        }

        button[type="button"] {
            float: left;
            margin-left: 60px;
            background-color: #09ba97;
        }

        button[type="submit"] {
            margin-right: 60px;
            float: right;
        }

        .xacnhan {
            background-color: #09ba97;
        }

        .xacnhan:hover {
            background-color: #068a70;
        }

        .guima {
            background-color: #83eef6;
        }

        .guima:hover {
            background-color: #14bbca;
        }

        .notification {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 14px;
            color: red;
            margin-top: 10px;
        }

        .timer {
            color: blue;
        }

        .error-message {
            color: red;
            font-size: 12px;
            display: none;
        }

        #notification {
            position: fixed;
            top: 20px;
            right: 20px;
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border-radius: 5px;
            font-size: 16px;
            display: none;
        }

        #notification.error {
            background-color: #f44336;
        }

        .eye-icon {
            position: absolute;
            top: 50%;
            right: 12px;
            transform: translateY(-50%);
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
<a href="login" class="back-home"><i class="fas fa-arrow-left"></i></a>
<div class="container">
    <h2>Quên Mật Khẩu</h2>
    <form method="post" action="forgot_pass">
        <input type="hidden" name="action" id="action" value="sendCode">
        <div class="form-group">
            <label for="phone">Số điện thoại</label>
            <input type="text" id="phone" name="phone" placeholder="Nhập số điện thoại đã đăng ký" required
                   value="${phone != null ? phone : ''}">
            <div style="color: red;">${phoneError}</div>
        </div>
        <div class="form-group">
            <label for="code">Mã Code</label>
            <input type="text" id="code" name="code" placeholder="Nhập mã code" maxlength="4">
            <div style="color: green;">${codeMessage}</div>
            <div style="color: red;">${codeError}</div>
        </div>
        <button type="submit" class="guima" onclick="document.getElementById('action').value='sendCode'">Gửi Mã</button>
        <button type="submit" class="xacnhan" onclick="document.getElementById('action').value='validateCode'">Xác
            Nhận
        </button>

    </form>
</div>
</body>
</html>
