<%--
  Created by IntelliJ IDEA.
  User: Khương
  Date: 4/5/2025
  Time: 10:07 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>

<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>
        OneH2K
    </title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet"/>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f3f4f6;
            margin: 0;
            padding: 0;
        }

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
            margin-top: 10px;

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


        main {
            display: flex;
            padding: 20px;
        }

        aside {
            width: 25%;
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }

        aside h3 {
            margin-top: 0;
        }

        aside a {
            display: block;
            color: black;
            padding: 10px 0;
            text-decoration: none;
        }

        aside a:hover {
            color: #4CAF50;
        }

        .account .dropdown-content {
            position: relative;
            left: 0;
            top: 0;
            min-width: 150px;
            padding-left: 20px;
            border-radius: 5px;
        }

        .account:hover .dropdown-content {
            display: block;
        }

        .account .dropdown-content a {
            color: black;
            padding: 10px 15px;
            text-decoration: none;
            display: block;
            white-space: nowrap;
        }

        .account .dropdown-content a:hover {
            color: #4CAF50;
        }

        section {
            width: 75%;
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            margin-left: 20px;
        }

        .container1 {
            margin: 0 auto;
            padding: 24px;
            background-color: #ffffff;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
        }

        .header1 {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 32px;
            padding-bottom: 16px;
            border-bottom: 1px solid #e5e7eb;

        }

        .header1 a {
            color: #4A5568;
            font-size: 14px;
            text-decoration: none;
        }

        .header1 a:hover {
            color: red;
        }

        .header1 a i {
            margin-right: 4px;
        }

        .header1 .order-info {
            font-size: 14px;
        }

        .header1 .order-info .status {
            color: #E53E3E;
            margin-left: 8px;
        }

        .timeline {
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .timeline .step {
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .timeline .step .icon {
            width: 48px;
            height: 48px;
            border-radius: 50%;
            background-color: #48BB78;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .timeline .step .icon i {
            color: white;
        }

        .timeline .step .text {
            margin-top: 8px;
            text-align: center;
            color: #4A5568;
            font-size: 14px;
        }

        .timeline .step .date {
            color: #A0AEC0;
            font-size: 12px;
        }

        .timeline .line {
            flex: 1;
            height: 2px;
            background-color: #48BB78;
            margin: 0 8px;
        }

        .timeline .line.inactive {
            background-color: #E2E8F0;
        }

        .timeline .step.inactive .icon {
            background-color: #E2E8F0;
        }

        /* Container2 */
        .container2 {
            margin: 0 auto;
            background-color: #ffffff;
            padding: 24px;
            border-radius: 8px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
        }

        .header2,
        .address,
        .order-summary {
            border-bottom: 2px dashed #d1d5db;
            padding-bottom: 16px;
            margin-bottom: 16px;
        }

        .header2 .flex,
        .order-summary .flex {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header2 .flex .bars {
            display: flex;
            gap: 4px;
        }

        .header2 .flex .bars div {
            width: 16px;
            height: 4px;
        }

        .header2 .flex .bars .green {
            background-color: #3ac824;
        }

        .header2 .flex .bars .blue {
            background-color: #3b82f6;
        }

        .header2 .text-right p {
            margin: 0;
            font-size: 14px;
        }

        .address h1 {
            font-size: 20px;
            font-weight: 700;
            margin-bottom: 8px;
        }

        .address p {
            margin: 0;
        }

        .address .font-semibold {
            font-weight: 600;
        }

        .order-summary .flex {
            align-items: center;
        }

        .order-summary .flex img {
            width: 80px;
            height: 80px;
            object-fit: cover;
            margin-right: 16px;
            border-radius: 10px;
        }

        .order-summary .flex .ml-auto {
            margin-left: auto;
            text-align: right;
        }

        .order-summary .flex .line-through {
            text-decoration: line-through;
            color: #6b7280;
        }

        .order-summary .flex .text-red-500 {
            color: #ef4444;
            font-weight: 700;
        }

        .order-summary .border-t-2 {
            border-top: 2px dashed #d1d5db;
            padding-top: 16px;
        }

        .order-summary .border-t-2 .flex {
            justify-content: space-between;
            margin-bottom: 8px;
        }

        .order-summary .border-t-2 .font-bold {
            font-weight: 700;
            font-size: 18px;
        }

        .order-summary .border-t-2 .text-red-500 {
            color: #ef4444;
        }

        .order-summary .bg-yellow-100 {
            background-color: #fef3c7;
            padding: 8px;
            border-radius: 4px;
            margin-top: 16px;
        }

        .order-summary .bg-yellow-100 p {
            margin: 0;
            color: #d97706;
        }

        .order-summary .bg-yellow-100 .text-red-500 {
            color: #ef4444;
            font-weight: 700;
        }

        .order-summary .mt-4 {
            margin-top: 16px;
        }

        .order-summary .mt-4 p {
            margin: 0;
        }

        .order-summary .mt-4 .font-semibold {
            font-weight: 600;
        }

        .buttons {
            display: flex;
            gap: 8px;
        }

        .buttons button {
            padding: 4px 16px;
            border-radius: 4px;
            border: none;
            cursor: pointer;
        }

        .buttons .bg-red-500 {
            background-color: #ef4444;
            color: #ffffff;
        }

        .buttons .bg-gray-200 {
            background-color: #e5e7eb;
        }

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
    </style>
</head>

<body>

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
                <button class="iconTimKiem" type="submit"><i class="fa fa-search"></i></button>
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
<main>
    <aside>
        <h3>
            Menu
        </h3>
        <a href="#">
            Trang Chủ
        </a>
        <div class="account">
            <a href="#">
                Tài Khoản Của Tôi
            </a>
            <div class="dropdown-content">
                <a href="#">
                    Hồ Sơ
                </a>
                <a href="#">
                    Ngân Hàng
                </a>
                <a href="#">
                    Địa Chỉ
                </a>
                <a href="#">
                    Đổi Mật Khẩu
                </a>
            </div>
        </div>
        <a href="#" style="color: #45a049;">
            Đơn mua
        </a>
    </aside>
    <section>

        <div class="container1">
            <div class="header1">
                <a href="ChoXacNhanDonHang?status=Chờ xác nhận"><i class="fas fa-arrow-left"></i> TRỞ LẠI</a>
                <div class="order-info">
                    <span>MÃ ĐƠN HÀNG: ${order.orderId}</span>
                    <span class="status">| CHỜ XÁC NHẬN ĐƠN HÀNG</span>
                </div>
            </div>
            <div class="timeline">
                <div class="step">
                    <div class="icon"><i class="fas fa-file-alt"></i></div>
                    <div class="text">Đơn Hàng Đã Đặt</div>
                    <div class="date">${order.orderDate}</div>
                </div>
                <div class="line"></div>
                <div class="step">
                    <div class="icon"><i class="fas fa-dollar-sign"></i></div>
                    <div class="text">Đã Xác Nhận Thông Tin Thanh Toán</div>
                    <div class="date">${order.createAt}</div>
                </div>
                <div class="line inactive"></div>
                <div class="step inactive">
                    <div class="icon"><i class="fas fa-truck"></i></div>
                    <div class="text">Đã Giao Cho ĐVVC</div>
                    <div class="date"></div>
                </div>
                <div class="line inactive"></div>
                <div class="step inactive">
                    <div class="icon"><i class="fas fa-box"></i></div>
                    <div class="text">Chờ Giao Hàng</div>
                </div>
                <div class="line inactive"></div>
                <div class="step inactive">
                    <div class="icon"><i class="fas fa-star"></i></div>
                    <div class="text">Đánh Giá</div>
                </div>
            </div>
        </div>


        <div class="container2">
            <div class="header2">
                <div class="flex">
                    <div class="bars">
                        <div class="green"></div>
                        <div class="blue"></div>
                        <div class="green"></div>
                        <div class="blue"></div>
                        <div class="green"></div>
                        <div class="blue"></div>
                        <div class="green"></div>
                        <div class="blue"></div>
                        <div class="green"></div>
                        <div class="blue"></div>
                    </div>
                </div>
            </div>
            <div class="address">
                <h1>Địa Chỉ Nhận Hàng</h1>
                <p class="font-semibold">${customer.nameCustomer}</p>
                <p>${customer.phone}</p>
                <p> ${customer.address}, ${customer.district}, ${customer.city}</p>
            </div>
            <div class="order-summary">
                <div class="flex">
                    <h2><i class="fas fa-store" style="margin-right: 10px;">
                    </i><a href="TrangChu" style="text-decoration: none; color: black;">OnH2K</a></h2>
                </div>
                <c:forEach var="oi" items="${orderItems}">
                    <div class="flex" style="margin-bottom: 20px;">
                        <a href="ChiTietSanPham?pid=${oi.productID}" title="Xem sản phẩm"
                           style="text-decoration: none;"><img src="${oi.image}"
                                                               alt="${oi.productName}"/></a>
                        <div>
                            <a href="ChiTietSanPham?pid=${oi.productID}" title="Xem sản phẩm"
                               style="color: black; text-decoration: none;">
                                <p class="font-semibold">
                                <h4>${oi.productName}
                                </h4>
                                </p>
                            </a>
                            <p>Giá sản phẩm: <span><fmt:formatNumber value="${oi.price}" type="number"
                                                                     pattern="#,##0 VND"/></span></p>
                            <p>Số lượng: <span>x${oi.quantity}</span></p>
                        </div>
                        <div class="ml-auto">
                            <p class="line-through"><fmt:formatNumber value="${oi.quantity*oi.price}" type="number"
                                                                      pattern="#,##0 VND"/></p>
                            <p class="text-red-500"><fmt:formatNumber value="${oi.quantity*oi.price*0.8}" type="number"
                                                                      pattern="#,##0 VND"/></p>
                        </div>
                    </div>
                </c:forEach>
                <div class="border-t-2">
                    <div class="flex">
                        <p>Tổng tiền hàng</p>
                        <p><fmt:formatNumber value="${totalPrice}" type="number"
                                             pattern="#,##0 VND"/></p>
                    </div>
                    <div class="flex">
                        <p>Phí vận chuyển</p>
                        <p><fmt:formatNumber value="${order.shippingFee}" type="number"
                                             pattern="#,##0 VND"/></p>
                    </div>
                    <div class="flex">
                        <p>Giảm giá</p>
                        <p><fmt:formatNumber value="-16500" type="number"
                                             pattern="#,##0 VND"/></p>
                    </div>
                    <div class="flex font-bold">
                        <p>Thành tiền</p>
                        <p class="text-red-500"><fmt:formatNumber value="${totalPrice - 16000}" type="number"
                                                                  pattern="#,##0 VND"/></p>
                    </div>
                </div>
                <div class="bg-yellow-100">
                    <p>Vui lòng thanh toán <span class="text-red-500"><fmt:formatNumber value="${totalPrice - 16000}"
                                                                                        type="number"
                                                                                        pattern="#,##0 VND"/></span> khi
                        nhận hàng.</p>
                </div>
                <div class="mt-4">
                    <p class="font-semibold">Phương thức Thanh toán</p>
                    <p>Thanh toán khi nhận hàng</p>
                </div>
            </div>
        </div>
    </section>
</main>
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

</html>

