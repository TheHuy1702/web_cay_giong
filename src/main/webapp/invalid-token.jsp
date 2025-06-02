<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Liên kết không hợp lệ</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
  <link rel="icon" href="Ảnh/anhlogo.jpg" type="image/x-icon">
  <style>
    body {
      margin: 0;
      padding: 0;
      background: linear-gradient(135deg, #00b894, #6c5ce7, #ff7675);
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      display: flex;
      justify-content: center;
      align-items: center;
      min-height: 100vh;
      background-size: cover;
    }

    .container {
      background: #ffffff;
      padding: 40px 30px;
      border-radius: 12px;
      box-shadow: 0 12px 30px rgba(0, 0, 0, 0.25);
      width: 400px;
      text-align: center;
      animation: fadeIn 0.8s ease-out;
    }

    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(30px); }
      to { opacity: 1; transform: translateY(0); }
    }

    .icon {
      font-size: 50px;
      color: #e74c3c;
      margin-bottom: 15px;
    }

    h2 {
      color: #333;
      margin-bottom: 10px;
    }

    p {
      color: #555;
      font-size: 15px;
      line-height: 1.6;
      margin-bottom: 25px;
    }

    .alert-danger {
      background-color: #fdecea;
      color: #e74c3c;
      border: 1px solid #e74c3c;
      padding: 12px;
      border-radius: 8px;
      margin-bottom: 15px;
    }

    .btn {
      background-color: #00b894;
      color: #fff;
      padding: 12px;
      border: none;
      border-radius: 8px;
      cursor: pointer;
      width: 100%;
      font-size: 16px;
      transition: background-color 0.3s ease;
      text-decoration: none;
      display: inline-block;
    }

    .btn:hover {
      background-color: #019875;
    }
  </style>
</head>
<body>
<div class="container">
  <div class="icon">
    <i class="fas fa-exclamation-triangle"></i>
  </div>
  <h2>Liên kết không hợp lệ hoặc đã hết hạn</h2>

  <p>Vui lòng tạo một yêu cầu mới để đặt lại mật khẩu của bạn.</p>

  <a href="forgot_pass" class="btn">Gửi lại yêu cầu</a>
</div>
</body>
</html>
