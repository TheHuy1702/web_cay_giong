<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Email kích hoạt đã được gửi</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="icon" href="Ảnh/anhlogo.jpg" type="image/x-icon">
    <style>
        body {
            margin: 0;
            padding: 0;
            background: linear-gradient(135deg, #00b894, #2ecc71, #27ae60);
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
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            width: 500px;
            animation: fadeIn 1s ease-out;
            text-align: center;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        h2 {
            background: linear-gradient(135deg, #27ae60, #2ecc71);
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

        p {
            font-size: 16px;
            color: #333;
            margin-bottom: 16px;
            animation: formGroupAnimation 1s ease-out;
        }

        @keyframes formGroupAnimation {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        strong {
            color: #e67e22;
        }

        .btn {
            background-color: #2ecc71;
            color: #fff;
            padding: 12px 25px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
            margin: 10px 0;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
        }

        .btn:hover {
            background-color: #27ae60;
            transform: scale(1.05);
            box-shadow: 0 0 15px rgba(46, 204, 113, 0.7);
        }

        .action-buttons {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-top: 25px;
        }

        .btn-outline {
            background-color: transparent;
            border: 2px solid #2ecc71;
            color: #2ecc71;
            padding: 10px 20px;
            border-radius: 8px;
            text-decoration: none;
            font-size: 16px;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .btn-outline:hover {
            background-color: #2ecc71;
            color: white;
            transform: scale(1.05);
            box-shadow: 0 0 10px rgba(46, 204, 113, 0.5);
        }

        .btn-outline i {
            margin-right: 8px;
            font-size: 14px;
        }

        .icon {
            font-size: 60px;
            margin-bottom: 20px;
            color: #2ecc71;
            animation: bounce 1s;
        }

        @keyframes bounce {
            0%, 20%, 50%, 80%, 100% { transform: translateY(0); }
            40% { transform: translateY(-20px); }
            60% { transform: translateY(-10px); }
        }

    </style>
</head>
<body>
<div>
    <a href="TrangChu" class="back-home"><i class="fas fa-home"></i> Trang chủ</a>

    <div class="container">
        <div class="icon">
            <i class="fas fa-envelope"></i>
        </div>

        <h2>Email kích hoạt đã được gửi!</h2>

        <p>Chúng tôi đã gửi link kích hoạt tài khoản đến email <strong>${email}</strong>.</p>
        <p>Vui lòng kiểm tra email và nhấp vào link để hoàn tất đăng ký.</p>

        <p>Nếu không nhận được email:</p>
        <form action="resendActivation" method="post">
            <input type="hidden" name="email" value="${email}">
            <button type="submit" class="btn">
                <i class="fas fa-paper-plane"></i> Gửi lại email kích hoạt
            </button>
        </form>

        <div class="action-buttons">
            <a href="TrangChu" class="btn-outline">
                <i class="fas fa-home"></i> Về trang chủ
            </a>
            <a href="login" class="btn-outline">
                <i class="fas fa-sign-in-alt"></i> Đăng nhập
            </a>
        </div>
    </div>
</div>
</body>
</html>