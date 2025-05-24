<%--
  Created by IntelliJ IDEA.
  User: Khương
  Date: 1/14/2025
  Time: 9:27 PM
  To change this template use File | Settings | File Templates.
--%>

<%--
  Created by IntelliJ IDEA.
  User: Khương
  Date: 12/24/2024
  Time: 1:10 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết sản phẩm - OnH2K</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="icon" href="Ảnh/anhlogo.jpg" type="image/x-icon">
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: sans-serif, Tahoma;
            background-color: #ddd;
        }

        /* id 1 */

        #headerSection {
            margin: auto;
        }

        .header {
            background-color: #8BC34A;
            padding: 10px;
            height: 150px;
            text-align: center;
            color: white;
            overflow: hidden;
        }

        .header h1 {
            margin: 0;
            font-size: 40px;
            color: #FFCDD2;
            text-align: center;
            padding-top: 50px;
        }

        .header p {
            margin: 0;
            font-size: 14px;
        }

        .navbar {
            display: flex;
            background-color: #4CAF50;
            padding: 0px;
            /* Khoảng cách giữa các phần tử */
            align-items: center;
        }

        .navbar a {
            color: white;
            padding: 24px 20px;
            text-decoration: none;
            text-align: center;
        }

        .navbar a:hover {
            background-color: #45a049;
        }

        .navbar .dropdown {
            position: relative;
            display: inline-block;
        }

        .navbar .dropdown-content {
            margin-top: 24px;
            /* Khoảng cách giữa các phần tử */
            display: none;
            position: absolute;
            background-color: #4CAF50;
            min-width: 160px;
            box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
            z-index: 1;
        }

        .navbar .dropdown-content a {
            color: white;
            padding: 12px 16px;
            text-decoration: none;
            display: block;
            text-align: left;
        }

        .navbar .dropdown-content a:hover {
            background-color: #45a049;
        }

        .navbar .dropdown:hover .dropdown-content {
            display: block;
        }

        .navbar .search-container {
            flex-grow: 1;
            display: flex;
            justify-content: center;
            margin-top: -6px;

        }

        .navbar input[type=text] {
            padding: 6px;
            margin-top: 8px;
            font-size: 17px;
            border: none;
            border-radius: 4px;
        }

        .navbar .search-container button {
            padding: 6px 10px;
            margin-top: 8px;
            margin-right: 16px;
            background: #ddd;
            font-size: 17px;
            border: none;
            cursor: pointer;
            border-radius: 4px;
        }

        .navbar .search-container button:hover {
            background: #ccc;
        }

        /* gợi ý cho tìm kiếm */
        .search-suggestions {
            margin-right: 54px;
            margin-top: 38px;
            position: absolute;
            background-color: #ffffff;
            border: 1px solid #ccc;
            /* Màu viền tương tự các phần khác */
            border-radius: 5px;
            /* Thêm bo góc để mềm mại */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            /* Thêm hiệu ứng đổ bóng */
            max-height: 250px;
            /* Tăng chiều cao tối đa để phù hợp hơn */
            overflow-y: auto;
            width: 220px;
            /* Để phù hợp với chiều rộng container */
            z-index: 200;
            /* Tăng z-index để chắc chắn hiển thị trên các thành phần khác */
        }

        .search-suggestions a {
            display: block;
            padding: 10px 12px;
            /* Điều chỉnh padding cho cân đối */
            font-size: 14px;
            /* Cỡ chữ nhỏ gọn */
            text-decoration: none;
            color: #333;
            /* Màu chữ đậm hơn một chút */
            transition: background-color 0.3s ease, color 0.3s ease;
            /* Hiệu ứng mượt */
            text-align: left;
        }

        .search-suggestions a:hover {
            background-color: #f5f5f5;
            /* Màu nền khi hover đồng bộ với giao diện */
            color: #45a049;
            /* Đồng bộ với màu hover của navbar */
        }

        .navbar .icons {
            display: flex;
            align-items: center;
        }

        .navbar .icons a {
            padding: 0 10px;
        }

        /* .navbar .search-container .fa-search {
            display: flex;
        } */

        .content {
            display: flex;
        }

        .header .logo {
            font-size: 40px;
            font-weight: bold;
            background: linear-gradient(90deg, rgb(114, 249, 254), #FAEBD7, hotpink, #FFFF00, #FF4500, #00FFFF, #7B68EE, #00B0FF);
            /* Gradient màu sắc */
            background-clip: text;
            -webkit-background-clip: text;
            color: transparent;
            text-shadow: -3px -3px 1px #FFFFE0;
            position: relative;
            display: inline-block;
            padding-top: 50px;
            animation: bounce 1s infinite;
            /* Hiệu ứng nhảy */
        }

        .header .heart {
            color: #45a049;
            font-size: 26px;
            position: absolute;
            top: 27px;
            transform: rotate(45deg);
            /* Xoay 45 độ */

        }

        .tree-icon {
            color: #4CAF50;
            font-size: 26px;
            position: absolute;
        }

        .tree-left {
            transform: rotate(-80deg);
            /* Xoay 80 độ */
            left: -30px;
            /* Đưa ra ngoài logo */

        }

        .tree-right {
            transform: rotate(45deg);
            /* Xoay 45 độ */
            right: -45px;
            /* Đưa ra ngoài logo */
            top: 60px;
        }

        .tree-top {
            transform: rotate(-10deg);
            /* Xoay 10 độ */
            top: 25px;
        }

        /*chữ chạy từ trái sang phải*/
        .marquee-content {
            animation: marquee 20s linear infinite;
        }

        @keyframes marquee {
            0% {
                transform: translateX(100%);
            }

            100% {
                transform: translateX(-100%);
            }
        }

        .emoji {
            font-size: 30px;
            /* Kích thước biểu tượng */
            position: relative;
            /* Để định vị màu trái tim */
            display: inline-block;
            /* Để hiệu ứng hoạt động chính xác */
            animation: bounce 1s infinite;
            /* Hiệu ứng nhảy */
        }

        .emoji .face {
            color: gold;
            /* Màu hồng cho mặt cười */
        }

        .emoji .heart {
            font-size: 16px;
            /* Kích thước trái tim */
            color: red;
            /* Màu đỏ cho trái tim */
            position: absolute;
            /* Đặt trái tim lên trên mặt cười */
            left: 16px;
            /* Điều chỉnh vị trí của trái tim */
            top: 16px;
            /* Đặt trái tim ở vị trí thích hợp */
        }

        @keyframes bounce {

            0%,
            20%,
            50%,
            80%,
            100% {
                transform: translateY(0);
                /* Tại vị trí ban đầu */
            }

            40% {
                transform: translateY(-20px);
                /* Nhảy lên 20px */
            }

            60% {
                transform: translateY(-10px);
                /* Nhảy lên 10px */
            }
        }

        .emoji2 {
            font-size: 30px;
            /* Kích thước biểu tượng */
            position: relative;
            /* Để định vị màu trái tim */
            display: inline-block;
            /* Để hiệu ứng hoạt động chính xác */
            animation: bounce2 1s infinite;
            /* Hiệu ứng nhảy */
        }

        .emoji2 .face {
            color: gold;
            /* Màu hồng cho mặt cười */
        }

        .emoji2 .heart {
            font-size: 16px;
            /* Kích thước trái tim */
            color: red;
            /* Màu đỏ cho trái tim */
            position: absolute;
            /* Đặt trái tim lên trên mặt cười */
            left: 16px;
            /* Điều chỉnh vị trí của trái tim */
            top: 16px;
            /* Đặt trái tim ở vị trí thích hợp */
        }

        @keyframes bounce2 {

            0%,
            20%,
            50%,
            80%,
            100% {
                transform: translateY(-10px);
                /* Tại vị trí ban đầu */
            }

            40% {
                transform: translateY(20px);
                /* Nhảy lên 20px */
            }

            60% {
                transform: translateY(0px);
                /* Nhảy lên 10px */
            }
        }

        /* id 2 */

        #contentSection,
        .container {
            margin: auto;
            background-color: white;
        }

        .dangxuat {
            background-color: #4CAF50; /* Màu nền cam */
            color: white; /* Màu chữ trắng */
            padding: 10px 20px; /* Khoảng cách bên trong */
            border: none; /* Không viền */
            border-radius: 5px; /* Bo góc */
            font-size: 16px; /* Kích thước chữ */
            cursor: pointer; /* Con trỏ chuột khi hover */
            transition: background-color 0.3s, transform 0.3s; /* Hiệu ứng chuyển màu và phóng to */
        }

        .dangxuat:hover {
            color: red; /* Màu nền khi hover */
            transform: scale(1.01); /* Phóng to khi hover */
        }

        /* id 3 */
        #footerSection {
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

        .container {
            background-color: #fff;
            padding-bottom: 100px;
            padding-top: 50px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .container h1 {
            color: #4CAF50;
            margin-bottom: 20px;
        }

        .container p {
            color: #555;
            margin-bottom: 30px;
        }

        .btn-home, .btn-wait {
            display: inline-block;
            padding: 10px 20px;
            background-color: #4CAF50;
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s;
            margin: 5px; /* Thêm khoảng cách giữa các nút */
        }

        .btn-home:hover, .btn-wait:hover {
            background-color: #45a049;
        }

        .btn-home i, .btn-wait i {
            margin-right: 8px;
        }

    </style>
</head>

<body>
<div>
    <div id="headerSection">
        <div class="header">
            <div class="logo">
                <i class="fas fa-tree tree-icon tree-left"></i>
                <i class="fas fa-tree tree-icon tree-right"></i>
                <i class="fas fa-tree tree-icon tree-top"></i>
                OneH2K <i class="fas fa-heart heart"></i> <i class="fas fa-heart heart"></i> <i
                    class="fas fa-heart heart"></i>
            </div>
            <div class="marquee-content">Chào mừng bạn đến với cửa hàng bán cây giống số 1 Việt Nam
                <div class="emoji">
                    <i class="fas fa-kiss-wink-heart face"></i>
                    <i class="fas fa-heart heart"></i>
                </div>
                <div class="emoji2">
                    <i class="fas fa-kiss-wink-heart face"></i>
                    <i class="fas fa-heart heart"></i>
                </div>
                <div class="emoji">
                    <i class="fas fa-kiss-wink-heart face"></i>
                    <i class="fas fa-heart heart"></i>
                </div>
                <div class="emoji">
                    <i class="fas fa-kiss-wink-heart face" style="margin-left: 520px;"></i>
                    <i class="fas fa-heart heart" style="margin-left: 520px;"></i>
                </div>
                <div class="emoji2">
                    <i class="fas fa-kiss-wink-heart face"></i>
                    <i class="fas fa-heart heart"></i>
                </div>
                <div class="emoji">
                    <i class="fas fa-kiss-wink-heart face"></i>
                    <i class="fas fa-heart heart"></i>
                </div>
            </div>
        </div>
        <div class="navbar">
            <a href="TrangChu"><i class="fas fa-home"></i> TRANG CHỦ</a>
            <div class="dropdown">
                <a href="#"><i class="fas fa-seedling"></i> SẢN PHẨM <i class="fa fa-caret-down"></i></a>
                <div class="dropdown-content">
                    <a href="category?cid=1">GIỐNG CÂY ĂN QUẢ</a>
                    <a href="category?cid=2">GIỐNG CÂY CẢNH</a>
                    <a href="category?cid=3">GIỐNG CÂY DƯỢC LIỆU</a>
                    <a href="category?cid=4">GIỐNG HOA</a>
                    <a href="category?cid=5">GIỐNG CÂY MỚI LẠ</a>
                    <a href="category?cid=6">GIỐNG CÂY CÔNG NGHIỆP</a>
                </div>
            </div>
            <a href="GioiThieu">GIỚI THIỆU</a>
            <div class="search-container">
                <form method="get" action="TrangChu">
                    <input type="text" placeholder="Tìm kiếm..." id="search-input" name="search"
                           value="${ser}">
                    <button type="submit"><i class="fa fa-search"></i></button>
                </form>
            </div>
            <div class="icons">
                <a href="show-cart"><span>Giỏ Hàng ${sessionScope.cart!=null?sessionScope.cart.totalQuantity:0} <i
                        class="fas fa-shopping-cart"></i></span></a>


                <div id="user-info">
                    <c:choose>
                        <c:when test="${not empty sessionScope.user}">
            <span id="user-welcome" style="color: white;">
                Xin chào, <c:out value="${sessionScope.user.name}"/>
            </span>
                            <i class="fas fa-user" id="user-icon"
                               style="color: white; background-color: #ddd; padding: 7px; border-radius: 100%;"></i>
                            <form method="post" action="logout">
                                <button class="dangxuat" id="logout" type="submit">ĐĂNG XUẤT</button>
                            </form>
                        </c:when>
                        <c:otherwise>
                            <span id="user-welcome" style="display: none; color: white;"></span>
                            <i class="fas fa-user" id="user-icon"
                               style="display: none; color: white; background-color: #ddd; padding: 7px; border-radius: 100%;"></i>
                            <a href="login" id="login-link">ĐĂNG NHẬP</a>
                            <a href="register" id="register-link">ĐĂNG KÝ</a>
                        </c:otherwise>
                    </c:choose>
                </div>

            </div>
        </div>
    </div>


    <div id="contentSection">

        <div class="container">
            <h1>Đặt hàng thành công!</h1>
            <p>Cảm ơn bạn đã đặt hàng. Chúng tôi sẽ xử lý đơn hàng của bạn trong thời gian sớm nhất.</p>
            <a href="TrangChu" class="btn-home"><i class="fas fa-home"></i>Quay về trang chủ</a>
            <a href="ChoXacNhanDonHang?status=Chờ xác nhận" class="btn-wait"><i class="fas fa-clock"></i>Thông tin đơn
                hàng</a>
        </div>

    </div>


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
</div>
</body>
</html>