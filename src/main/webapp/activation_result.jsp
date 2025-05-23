<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kết quả kích hoạt tài khoản</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
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

        .message-box {
            padding: 20px;
            margin: 20px 0;
            border-radius: 8px;
            font-size: 16px;
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

        .success {
            background-color: rgba(46, 204, 113, 0.2);
            color: #27ae60;
            border-left: 4px solid #2ecc71;
        }

        .error {
            background-color: rgba(231, 76, 60, 0.2);
            color: #c0392b;
            border-left: 4px solid #e74c3c;
        }

        .info {
            background-color: rgba(52, 152, 219, 0.2);
            color: #2980b9;
            border-left: 4px solid #3498db;
        }

        .btn {
            background-color: #2ecc71;
            color: #fff;
            padding: 12px 25px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
            margin: 10px 5px;
            transition: background-color 0.3s ease, transform 0.3s ease, box-shadow 0.3s ease;
            text-decoration: none;
            display: inline-block;
        }

        .btn:hover {
            background-color: #27ae60;
            transform: scale(1.05);
            box-shadow: 0 0 15px rgba(46, 204, 113, 0.7);
        }

        .btn-outline {
            background-color: transparent;
            border: 2px solid #2ecc71;
            color: #2ecc71;
        }

        .btn-outline:hover {
            background-color: #2ecc71;
            color: white;
        }

        .icon {
            font-size: 60px;
            margin-bottom: 20px;
            color: #2ecc71;
            animation: bounce 1s;
        }

        @keyframes bounce {
            0%, 20%, 50%, 80%, 100% {
                transform: translateY(0);
            }
            40% {
                transform: translateY(-20px);
            }
            60% {
                transform: translateY(-10px);
            }
        }

        .action-group {
            margin-top: 30px;
        }

    </style>
</head>
<body>
<div>
    <a href="TrangChu" class="back-home"><i class="fas fa-home"></i> Trang chủ</a>

    <div class="container">
        <div class="icon">
            <c:choose>
                <c:when test="${not empty success}">
                    <i class="fas fa-check-circle"></i>
                </c:when>
                <c:when test="${not empty error}">
                    <i class="fas fa-exclamation-circle"></i>
                </c:when>
                <c:otherwise>
                    <i class="fas fa-info-circle"></i>
                </c:otherwise>
            </c:choose>
        </div>

        <h2>Kết quả kích hoạt tài khoản</h2>

        <c:choose>
            <c:when test="${not empty success}">
                <div class="message-box success">
                    <p>${success}</p>
                </div>
                <div class="action-group">
                    <a href="login" class="btn">Đăng nhập ngay</a>
                </div>
            </c:when>

            <c:when test="${not empty error}">
                <div class="message-box error">
                    <p>${error}</p>
                </div>
                <div class="action-group">
                    <form action="resendActivation" method="post" style="display: inline;">
                        <input type="text" name="email" value="${user.email}">
                        <button type="submit" class="btn">Gửi lại link kích hoạt</button>
                    </form>
                    <a href="TrangChu" class="btn btn-outline">Về trang chủ</a>
                </div>
            </c:when>

            <c:when test="${not empty message}">
                <div class="message-box info">
                    <p>${message}</p>
                </div>
                <div class="action-group">
                    <a href="login" class="btn">Đăng nhập ngay</a>
                    <a href="TrangChu" class="btn btn-outline">Về trang chủ</a>
                </div>
            </c:when>
        </c:choose>
    </div>
</div>
</body>
</html>