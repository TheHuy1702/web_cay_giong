<!-- <%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> -->
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>OneH2K</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="icon" href="Ảnh/anhlogo.jpg" type="image/x-icon">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>

    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }
        #headerSection {
            display: flex;
            margin: auto;
            /* overflow: hidden; */
            background-color: #8BC34A;
            padding: 10px;
            height: 50px;
            justify-content: center;
            align-items: center;
            color: white;
        }
        .header h1 {
            margin: 0;
            font-size: 40px;
            color: #FFCDD2;
            text-align: center;
            padding-top: 50px;
        }
        .user {
            position: relative;
            display: inline-block;
            cursor: pointer;
            padding: 10px;
            right: -450px;
            border-radius: 5px;
            z-index: 1000; /* Đảm bảo nằm trên các phần khác */
        }

        .logout-menu {
            display: none;
            position: absolute;
            right: 0;
            top: 60px; /* Dịch xuống để không bị che */
            background-color: #fff;
            border: 1px solid #ccc;
            border-radius: 5px;
            padding: 10px;
            z-index: 2000; /* Đảm bảo nằm trên content */
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1); /* Đổ bóng nhẹ để nổi bật */
        }

        .user:hover .logout-menu {
            display: block;
        }


        .user i {
            font-size: 30px;

        }

        /* .user {
            position: relative;
            display: inline-block;
            cursor: pointer;
            padding: 10px;
            right: -450px;

            border-radius: 5px;
        } */

        .user .logout-menu {
            width: 135px;
        }

        .user .logout-menu:hover {
            background-color: #f9f9f9;
        }

        .user .logout-menu i {
            font-size: 16px;
            color: red;
        }

        .user .logout-menu a {
            text-decoration: none;
            color: red;
            font-size: 14px;
            width: fit-content;
        }

        /* .user:hover .logout-menu {
            display: block;
        } */
        #ContentSection {
            margin: auto;
            padding-top: 10px;
            background-color: #ededed;
            padding-bottom: 10px;
            position: relative; /* Đảm bảo menu không bị che */
            z-index: 1;
        }
        .container {
            display: flex;
            align-items: flex-start;
        }
        .container-2{
            display: block;
        }

        #footerSection {
            margin-top: 20px;
            margin: auto;
        }

        .custom-bg {
            background-color: #8BC34A;
        }

        .footer-container {
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            align-items: start;
            text-align: center;
            padding: 20px;
            color: white;
        }

        .footer-container h2 {
            font-size: 20px;
            color: white;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .footer-container p {
            margin-bottom: 10px;
        }

        .footer-container a {
            color: white;
            text-decoration: underline;
        }

        .footer-container .contact-info {
            flex: 1;
        }

        .footer-container .map {
            flex: 1;
            display: flex;
            margin-top: -200px;
            margin-left: 100px;
        }

        .footer-container .map iframe {
            width: 250px;
            height: 175px;
            border: 1px solid white;
            margin-top: 10px;
            border-radius: 6px;
        }

        .footer-container .separator {
            display: none;
            margin: 10px 0px;
        }

        .footer-container .credits {
            flex: 1;
            text-align: right;
        }

        .footer-container .credits p {
            margin-bottom: 0.5rem;
        }
        @media (min-width: 768px) {
            .footer-container {
                flex-direction: row;
                text-align: left;
            }

            .footer-container .separator {
                display: block;
                border-left: 1px solid white;
                height: 200px;
            }
        }

        .back-to-top {
            position: fixed;
            background: linear-gradient(45deg, #6bff6b, rgb(126, 189, 206), white);
            bottom: -60px;
            right: 20px;
            border: none;
            color: green;
            padding: 10px;
            border-radius: 5px;
            cursor: pointer;
            display: none;
            display: flex;
            flex-direction: column;
            align-items: center;
            transition: bottom 0.5s ease, transform 0.5s ease;
            box-shadow: 0px 0px 14px 0px rgb(255, 255, 255);

        }

        .back-to-top:hover {
            background-color: #8BC34A;
            color: white;
            transform: scale(1.1);
        }

        .sidebar {
            margin-left: 20px;
            width: 200px;
            position: relative;

        }

        .sidebar a {
            color: black;
            padding: 14px 20px;
            text-decoration: none;
            display: block;
            width: fit-content;
            transition: transform 0.3s ease;
            position: relative;
        }

        .sidebar a:hover {
            color: #45a049;
            transform: scale(1.1);
        }

        /* Định dạng phần "Tài Khoản Của Tôi" */
        .account {
            position: relative;
            display: block;
        }

        /* Luôn hiển thị menu con */
        .account .dropdown-content {
            display: block; /* Luôn hiển thị */
            position: relative;
            left: 0;
            top: 0;
            min-width: 150px;
            padding-left: 20px;
            border-radius: 5px;
        }

        /* Định dạng các mục trong menu con */
        .account .dropdown-content a {
            color: black;
            padding: 10px 15px;
            text-decoration: none;
            display: block;
            white-space: nowrap;
        }

        .account .dropdown-content a:hover {
            color: #45a049;
        }
        .header{
            color: black;
            font-size: 20px;
            font-weight: bold;
        }
        .content {
            text-align: center;

            background-color: white;
            color: #666;
            padding: 20px;
            padding-bottom: 230px;
            width: 80%;
        }

        h2 {
            margin-bottom: 5px;
        }

        p {
            color: gray;
        }

        form {
            display: block;
            flex-direction: column;
            gap: 10px;
        }

        label {
            font-weight: bold;
        }

        input, select {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .gender {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .dob {
            display: flex;
            gap: 10px;
        }

        select {
            flex: 1;
        }

        .save-btn {
            background-color: #e74c3c;
            color: white;
            border: none;
            padding: 10px;
            border-radius: 5px;
            cursor: pointer;
        }

        .save-btn:hover {
            background-color: #c0392b;
        }

        #hoSo{
            display: flex;

        }
        /* .thongtin{
            margin-bottom: 10px;
        }
        .donMua{
            margin-bottom: 10px;
        } */
        .change-link {
            color: #4CAF50;
            text-decoration: none;
            font-weight: bold;
            cursor: pointer;
        }
        .popup-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            justify-content: center;
            align-items: center;
            z-index: 1000;
        }
        .popup-content {
            width: 400px;
            padding: 20px;
            background-color: white;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
            display: flex;
            flex-direction: column;
            align-items: stretch;
        }
        .popup-header {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 15px;
            text-align: center;
        }
        .popup-input {
            width: 100%;
            padding: 8px;
            margin-top: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }
        .button {
            background-color: #e74c3c;
            color: white;
            padding: 10px 15px;
            text-decoration: none;
            border-radius: 5px;
            font-size: 14px;
            display: inline-block;
            margin-top: 10px;
        }
        .button:hover {
            background-color: #c0392b;
        }

        .popup-buttons {
            display: flex;
            justify-content: space-between;
            margin-top: 10px;
        }

        .popup-buttons button {
            width: 48%;
            padding: 10px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            font-size: 14px;
        }

        .cancel-button {
            background-color: #ccc;
            color: white;
            transition: transform 0.5s ease;
        }

        .cancel-button:hover {
            background-color: darkred;
            transform: scale(1.05);
        }

        .save-button {
            margin: 5px;
            background-color: #4caf50;
            color: white;
            transition: transform 0.5s ease;
        }

        .save-button:hover {
            background-color: #0a670d;
            transform: scale(1.05);
        }
    </style>
</head>
<body>
<div id="headerSection">
    <h1>TÀI KHOẢN CỦA TÔI</h1>
    <div class="user">
        <i class="fas fa-user-circle "></i> <br> ${sessionScope.user.name}
        <div class="logout-menu">
            <form method="post" action="logout">
                <button class="thongtin" id="thongTin" type="submit"> Thông tin tài khoản
                </button>
                <hr style="border: 1px solid  #ccc;">
                <button class="donMua" id="donMua" type="submit"> Đơn mua
                </button>
                <hr style="border: 1px solid  #ccc;">
                <button class="dangxuat" id="logout1" type="submit"><i
                        class="fas fa-sign-out-alt"></i> Đăng xuất
                </button>
            </form>
        </div>
    </div>
</div>
<DIV id="ContentSection">
    <div class="container">
        <div class="sidebar">
            <h3>Menu</h3>
            <a href="#">Trang Chủ</a>
            <div class="account">
                <a href="taiKhoanCuaToi">Tài Khoản Của Tôi</a>
                <div class="dropdown-content">
                    <a href="taiKhoanCuaToi">Hồ Sơ</a>
                    <a href="#" style="color: red"><b>Ngân Hàng</b></a>
                    <a href="#">Địa Chỉ</a>
                    <a href="#">Đổi Mật Khẩu</a>

                </div>
            </div>
            <a href="#">Đơn mua</a>
        </div>

        <div class="content">
            <h2>Đổi mật khẩu</h2>
            <c:if test="${not empty error}">
                <p style="color:red;">${error}</p>
            </c:if>
            <c:if test="${not empty message}">
                <p style="color:green;">${message}</p>
            </c:if>

            <form method="post" action="doiMatKhau">
                <label for="currentPassword">Mật khẩu hiện tại:</label>
                <input type="password" id="currentPassword" name="currentPassword" required>

                <label for="newPassword">Mật khẩu mới:</label>
                <input type="password" id="newPassword" name="newPassword" required>

                <label for="confirmPassword">Xác nhận mật khẩu mới:</label>
                <input type="password" id="confirmPassword" name="confirmPassword" required>

                <button type="submit">Lưu thay đổi</button>
            </form>
            <a class="back-link" href="taiKhoanCuaToi">&#8592; Quay lại tài khoản</a>

        </div>
    </div>
    </DIV>
    <div id="footerSection" class="custom-bg">
        <footer class="footer-container">
            <div class="contact-info">
                <h2>Liên hệ chúng tôi</h2>
                <p><i class="fas fa-map-marker-alt"></i> DC: Cư xá C, Trường đại học Nông Lâm, Khu phố 6, Phường
                    Linh
                    Trung, TP. Thủ Đức, TP. Hồ Chí Minh</p>
                <p><i class="fas fa-phone-alt"></i> SĐT liên hệ: 0707188079</p>
                <p><i class="fas fa-envelope"></i> EMAIL: <a
                        href="mailto:22130000@st.hcmuaf.edu.vn">22130000@st.hcmuaf.edu.vn</a></p>
                <p><i class="fas fa-globe"></i> WEBSITE: <a href="https://OneH2K.vn">https://OneH2K.vn</a></p>
            </div>
            <div class="separator"></div>
            <div class="credits">
                <p>&copy; 2024 OneH2K.Vn |</p>
                <p>Cửa hàng bán cây giống</p>
                <p style="padding-top: 20px;">___________________</p>
                <p class="text-sm" style="padding-top: 40px;">Thiết kế bởi OneH2K</p>
                <div class="map">
                    <iframe
                            src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d1959.1072550471563!2d106.78855811579251!3d10.871282831661734!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x317527b5a31ff523%3A0x4ab7fc7a54bec4a4!2zQ8awIHjDoSBDLCBLVFggVHLGsOG7nW5nIMSQ4bqhaSBo4buNYyBOw7RuZyBMw6Jt!5e0!3m2!1svi!2s!4v1732027299631!5m2!1svi!2s"
                            allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
                </div>
            </div>
        </footer>
    </div>
    <button class="back-to-top" id="backToTop"><i class="fas fa-arrow-up"></i>
        <div>Lên đầu trang</div>
    </button>
</body>
<script>
</script>
</html>
