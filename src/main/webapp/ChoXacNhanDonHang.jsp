<%--
  Created by IntelliJ IDEA.
  User: Khương
  Date: 3/30/2025
  Time: 11:42 PM
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

        /*header {*/
        /*  background-color: #4CAF50;*/
        /*  color: white;*/
        /*  display: flex;*/
        /*  justify-content: space-between;*/
        /*  align-items: center;*/
        /*  padding: 10px 20px;*/
        /*}*/

        /*header h1 {*/
        /*  margin: 0;*/
        /*  font-size: 24px;*/
        /*}*/

        /*.user {*/
        /*  position: relative;*/
        /*  cursor: pointer;*/
        /*}*/

        /*.user i {*/
        /*  font-size: 24px;*/
        /*}*/

        /*.user .logout-menu {*/
        /*  display: none;*/
        /*  position: absolute;*/
        /*  right: 0;*/
        /*  top: 40px;*/
        /*  background-color: white;*/
        /*  border: 1px solid #ccc;*/
        /*  border-radius: 5px;*/
        /*  padding: 10px;*/
        /*  box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);*/
        /*}*/

        /*.user:hover .logout-menu {*/
        /*  display: block;*/
        /*}*/

        /*.logout-menu button {*/
        /*  background: none;*/
        /*  border: none;*/
        /*  padding: 10px;*/
        /*  text-align: left;*/
        /*  width: 100%;*/
        /*  cursor: pointer;*/
        /*}*/

        /*.logout-menu button:hover {*/
        /*  background-color: #f9f9f9;*/
        /*}*/
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

        .nav ul {
            display: flex;
            padding: 0;
            margin: 0;
            list-style: none;
            border-bottom: 1px solid #e5e7eb;
        }

        .nav li {
            padding: 10px 20px;
        }

        .nav a {
            text-decoration: none;
            color: #4b5563;
        }

        .nav a:hover {
            color: #ef4444;
        }

        .nav a.active {
            color: #ef4444;
            border-bottom: 2px solid #ef4444;
        }

        .header2,
        .footerSub {
            padding: 20px;
            border-bottom: 1px solid #e5e7eb;
        }

        .header2 {
            display: flex;
            flex-direction: row;
            justify-content: space-between;
        }

        .header2 .left {
            display: flex;
            align-items: center;
        }

        .header2 .left i {
            font-size: 24px;
            margin-right: 10px;
        }

        .header2 .right {
            display: flex;
            justify-content: space-between;
        }

        .header2 .shipping-status i {
            color: #10b981;
            margin-right: 5px;
        }

        .header2 .shipping-status a {
            text-decoration: none;
            color: #10b981;
        }

        .header2 .shipping-status a:hover {
            color: #ef4444;
        }

        .header2 .shipping-status .status {
            color: #ef4444;
            margin-left: 5px;
        }

        .content {
            padding: 20px;
            display: flex;
            flex-direction: column;
        }

        .content .item {
            display: flex;
            margin-bottom: 20px;
        }

        .content .item img {
            width: 100px;
            height: 100px;
            object-fit: cover;
            border-radius: 10px;
        }

        .content .item .details {
            margin-left: 20px;
            margin-top: -20px;
            flex: 1;
        }

        .content .item .details h2 {
            margin: 0;
            color: #4b5563;
        }

        .content .item .details p {
            margin: 5px 0;
            color: #6b7280;
        }

        .content .item .price {
            text-align: right;
        }

        .content .item .price .original {
            text-decoration: line-through;
            color: #9ca3af;
        }

        .content .item .price .discounted {
            color: #ef4444;
            font-size: 20px;
        }

        .content .note {
            color: #6b7280;
        }

        .content .note .date {
            color: #3b82f6;
        }

        .footerSub {
            display: flex;
            justify-content: space-between;
            align-items: center;
            height: 23px;
        }

        .footerSub .total {
            color: #ef4444;
            font-size: 20px;
        }

        .footerSub .actions button {
            margin-left: 10px;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .footerSub .actions .cancel {
            background-color: red;
            color: white;
        }

        .footerSub .actions .cancel:hover {
            background-color: darkred;
            color: white;
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

        .contentInfo {
            margin-top: 10px;
            border: 1px solid #e5e7eb;
            background-color: #f7f7f7;
        }

        .contentInfo .footerSub {
            border-top: 1px solid #e5e7eb;
        }

        .cancelForm {
            display: none;
        }

        .cancelForm {
            display: none;
            position: fixed;
            width: 400px;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: white;
            padding: 5px 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
        }

        .cancelForm .buttons {
            display: flex;
            justify-content: space-between;
            margin-left: 10px;
            margin-right: 10px;
        }

        .cancelForm h2, .cancelForm .fa-exclamation-triangle {
            text-align: center;
            font-size: 20px;
            color: red;
            padding: 5px;
        }

        .cancelForm p {
            text-align: center;
        }

        .cancelForm button {
            padding: 10px;
            border-radius: 5px;
            border: none;
            background-color: #4CAF50;
            color: white;
            cursor: pointer;
            margin-bottom: 10px;
        }

        .cancelForm button:hover {
            background-color: #45a049;
        }

        #submitBtn:hover {
            background-color: red;
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

<%--<header>--%>
<%--  <h1>--%>
<%--    TÀI KHOẢN CỦA TÔI--%>
<%--  </h1>--%>
<%--  <div class="user">--%>
<%--    <i class="fas fa-user-circle">--%>
<%--    </i>--%>
<%--    <br />--%>
<%--    ${sessionScope.user.name}--%>
<%--    <div class="logout-menu">--%>
<%--      <form action="logout" method="post">--%>
<%--        <button type="submit">--%>
<%--          Thông tin tài khoản--%>
<%--        </button>--%>
<%--        <hr />--%>
<%--        <button type="submit">--%>
<%--          Đơn mua--%>
<%--        </button>--%>
<%--        <hr />--%>
<%--        <button type="submit">--%>
<%--          <i class="fas fa-sign-out-alt">--%>
<%--          </i>--%>
<%--          Đăng xuất--%>
<%--        </button>--%>
<%--      </form>--%>
<%--    </div>--%>
<%--  </div>--%>
<%--</header>--%>
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
        <div class="nav">
            <ul>
                <li>
                    <a href="TatCaDonHang?status=all">
                        Tất cả (${slAll!=null?slAll:0})
                    </a>
                </li>
                <li>
                    <a class="active" href="ChoXacNhanDonHang?status=Chờ xác nhận">
                        Chờ xác nhận (${slDH!=null?slDH:0})
                    </a>
                </li>
                <li>
                    <a href="ChoGiaoHang?status=Đã xác nhận">
                        Chờ giao hàng (${slChoGH!=null?slChoGH:0})
                    </a>
                </li>
                <li>
                    <a href="DonHangHoanThanh?status=Đã giao">
                        Hoàn thành (${slDaGiao!=null?slDaGiao:0})
                    </a>
                </li>
                <li>
                    <a href="DonHangDaHuy?status=Đã hủy">
                        Đã hủy (${slHuy!=null?slHuy:0})
                    </a>
                </li>
            </ul>
        </div>
        <c:if test="${empty orders}">
            <div class="alert-warning">
                Không có.
            </div>
        </c:if>
        <c:if test="${not empty orders}">
            <c:forEach var="o" items="${orders}">
                <div class="contentInfo">
                    <div class="header2">
                        <div class="left">
                            <i class="fas fa-store" style="color: #45a049;">
                            </i>
                            <span><a href="TrangChu" style="color: black; text-decoration: none; font-weight: bold;">OneH2K</a></span>
                        </div>
                        <div class="right">
                            <div class="shipping-status">
                                <a href="ChoXNDetail?oId=${o.orderID}"> <i class="fas fa-truck">
                                </i></a>
                                <span title="Xem chi tiết"> <a href="ChoXNDetail?oId=${o.orderID}">Người bán sẽ sớm xác nhận đơn hàng của bạn</a>
       </span>
                                <span class="status">
        CHỜ XÁC NHẬN ĐƠN HÀNG
       </span>
                            </div>
                        </div>
                    </div>
                    <c:forEach var="i" items="${o.orderItems}">
                        <div class="content">
                            <div class="item">
                                <a title="Xem sản phẩm" href="ChiTietSanPham?pid=${i.productID}"
                                   style="text-decoration: none;">
                                    <img alt="${i.productName}"
                                         src="${i.image}"
                                         width="100"/>
                                </a>
                                <div class="details">
                                    <h3 title="Xem sản phẩm">
                                        <a href="ChiTietSanPham?pid=${i.productID}"
                                           style="text-decoration: none; color: black;">${i.productName}</a>
                                    </h3>
                                    <p>
                                        Giá sản phẩm:
                                            <fmt:formatNumber value="${i.price}" type="number"
                                                              pattern="#,##0 VND"/>
                                    <p>
                                    <p>
                                        Số lượng: x${i.quantity}
                                    </p>
                                </div>
                                <div class="price">
                                    <p class="original">
                                        <fmt:formatNumber value="${i.quantity*i.price}" type="number"
                                                          pattern="#,##0 VND"/>
                                    </p>
                                    <p class="discounted">
                                        <fmt:formatNumber value="${i.quantity*i.price*0.8}" type="number"
                                                          pattern="#,##0 VND"/>
                                    </p>
                                </div>
                            </div>
                            <div class="note">
                                Đơn hàng sẽ được chuẩn bị và chuyển đi trước
                                <span class="date">
                        ${o.ngay}
                    </span>
                            </div>
                        </div>
                    </c:forEach>
                    <div class="footerSub">
                        <div class="total">
                            Thành tiền:
                            <fmt:formatNumber value="${o.totalAmount}" type="number" pattern="#,##0 VND"/>
                        </div>
                        <div class="actions">
                            <button class="cancel" onclick="showRatingForm(${o.orderID})">
                                Hủy Đơn Hàng
                            </button>
                        </div>
                    </div>

                    <div id="cancelForm-${o.orderID}" class="cancelForm">
                        <form method="post" action="ChoXacNhanDonHang">
                            <input type="hidden" name="orderID" value="${o.orderID}">
                            <input type="hidden" name="actionBy" value="Người mua">
                            <h2>
                                <i class="fas fa-exclamation-triangle"></i> Xác Nhận Hủy Đơn Hàng
                            </h2>
                            <p>
                                Bạn có chắc chắn muốn hủy đơn hàng này? Hành động này không thể hoàn tác.
                            </p>
                            <div class="buttons">
                                <button type="button" id="cancelBtn" onclick="hideRatingForm(${o.orderID})">
                                    Quay Lại
                                </button>
                                <button type="submit" id="submitBtn" value="huyDon" name="action">
                                    <i class="fas fa-times-circle"></i> Hủy Đơn Hàng
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </c:forEach>
        </c:if>
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
<script>
    function showRatingForm(orderID) {
        document.querySelectorAll('.cancelForm').forEach(form => {
            form.style.display = 'none'; // Ẩn tất cả các form
        });
        document.getElementById('cancelForm-' + orderID).style.display = 'block'; // Hiện form cụ thể
    }

    function hideRatingForm(orderID) {
        document.getElementById('cancelForm-' + orderID).style.display = 'none'; // Ẩn form cụ thể
    }
</script>
</html>
