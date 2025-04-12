<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
  <title>Xác nhận OTP</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #ededed;
      margin: 0;
      padding: 0;
    }

    .otp-container {
      width: 50%;
      margin: 50px auto;
      background-color: white;
      border-radius: 10px;
      padding: 30px;
      box-shadow: 0 0 12px rgba(0,0,0,0.1);
      text-align: center;
    }

    .otp-container h2 {
      color: #4CAF50;
      margin-bottom: 20px;
    }

    .otp-container input[type="text"] {
      padding: 10px;
      width: 80%;
      font-size: 16px;
      border: 1px solid #ccc;
      border-radius: 6px;
      margin-bottom: 20px;
    }

    .otp-container button {
      background-color: #4CAF50;
      border: none;
      padding: 10px 20px;
      color: white;
      border-radius: 5px;
      cursor: pointer;
      font-weight: bold;
    }

    .otp-container button:hover {
      background-color: #388e3c;
    }

    .resend-btn {
      margin-top: 15px;
      background-color: #f44336;
    }

    .resend-btn[disabled] {
      background-color: #ccc;
      cursor: not-allowed;
    }

    .message {
      color: green;
      margin-bottom: 15px;
    }

    .error {
      color: red;
      margin-bottom: 15px;
    }

    #countdown {
      margin-top: 10px;
      color: #888;
    }

  </style>
</head>
<body>

<div class="otp-container">
  <h2>Nhập mã OTP đã gửi đến email của bạn</h2>

  <c:if test="${not empty error}">
    <div class="error">${error}</div>
  </c:if>
  <c:if test="${not empty message}">
    <div class="message">${message}</div>
  </c:if>

  <form method="post" action="verify-email-otp">
    <input type="text" name="otp" placeholder="Nhập mã OTP..." required /><br>
    <button type="submit">Xác nhận</button>
  </form>

  <form method="get" action="send-otp-email">
    <button class="resend-btn" type="submit" id="resendBtn" disabled>Gửi lại mã OTP</button>
    <div id="countdown">Bạn có thể gửi lại mã sau <span id="seconds">60</span> giây</div>
  </form>
</div>

<script>
  let seconds = 60;
  const resendBtn = document.getElementById('resendBtn');
  const countdown = document.getElementById('seconds');

  const timer = setInterval(() => {
    seconds--;
    countdown.innerText = seconds;

    if (seconds <= 0) {
      clearInterval(timer);
      resendBtn.disabled = false;
      document.getElementById('countdown').innerText = "Bạn có thể gửi lại mã OTP.";
    }
  }, 1000);
</script>

</body>
</html>
