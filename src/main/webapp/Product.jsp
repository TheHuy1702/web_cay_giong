<%--
  Created by IntelliJ IDEA.
  User: Khương
  Date: 12/25/2024
  Time: 2:21 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.net.URLEncoder" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giống hoa - OnH2K</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="icon" href="Ảnh/anhlogo.jpg" type="image/x-icon">
    <style>
        body {
            margin: 0;
            font-family: sans-serif, Tahoma;
            background-color: #ddd;
        }

        /*id 1*/
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

        .navbar {

            display: flex;
            background-color: #4CAF50;
            padding: 0px;
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

        /* .navbar .search-container .fa-search {
            display: flex;
        } */

        .navbar .search-container button:hover {
            background: #ccc;
        }

        .navbar .icons {
            display: flex;
            align-items: center;
        }

        .navbar .icons a {
            padding: 0 10px;
        }

        /*id 2*/
        #ContentSection {
            margin: auto;
            display: flex;
            background-color: white;
        }

        /*lọc giá sản phẩm*/
        .content-filter {
            display: flex;
            justify-content: flex-end;
            justify-items: center;
            text-align: center;
            margin-top: -9px;
            margin-left: 600px;
            position: absolute;
        }

        .content-filter select {
            height: 20px;
            margin-top: 14px;
            margin-right: 30px;
            border-radius: 5px;
        }

        .content-filter label {
            margin-top: 16px;
            margin-right: 10px;

        }

        .slide_bar {
            min-width: 20%;
            padding: 20px;
        }

        .list a {
            color: black;
            padding: 14px 20px;
            text-decoration: none;
            display: block;
            width: fit-content;
            transition: transform 0.3s ease;

        }

        .list {
            margin-top: 20px;
        }

        .list a:hover {
            color: #45a049;
            transform: scale(1.1);
        }

        .list .list_dropdown {
            position: relative;
            display: inline-block;
        }

        .list .list_dropdown-content {
            display: none;
            /* Ẩn các mục con ban đầu */
            padding: 0px;
            margin-left: 30px;
        }

        .list .list_dropdown-content a {
            color: black;
            padding: 12px 16px;
            text-decoration: none;
            display: block;
        }

        .list .list_dropdown-content a:hover {
            color: #45a049;
        }

        .list_dropdown h3 {
            width: fit-content;
            display: inline-block;
        }

        .breadcrumb {
            margin-top: 20px;
            width: max-content;
        }

        .breadcrumb a:first-child {
            display: inline-block;
            text-decoration: none;
            transition: transform 0.3s ease;
        }

        .breadcrumb a:first-child:hover {
            cursor: pointer;
            /* font-weight: bold; */
            color: #45a049;
        }


        .content {
            padding-top: 35px;
        }

        .content p {
            text-align: right;
            margin-right: 50px;
        }

        .container {
            display: flex;
            flex-wrap: wrap;
            justify-content: flex-start;
            padding: 20px;
            margin-top: 40px;

        }

        .product {
            width: 250px;
            margin: 10px;
            text-align: center;
            float: right;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.3);
            /* Bóng */
            border-radius: 15px;
        }

        .product-name a {
            color: black;
            text-decoration: none;
            transition: transform 0.3s ease;
            display: inline-block;
        }

        .product-name a:hover {
            color: #45a049;
            transform: scale(1.1);
        }

        .product img,
        .product a {
            transition: transform 0.3s ease;
            /* Thêm hiệu ứng chuyển tiếp */
        }

        .product img:hover {
            transform: scale(1.075);
        }

        .product a:hover {
            transform: scale(1.1);
            /* Phóng to hình ảnh khi di chuột */
        }

        .product img {
            width: 240px;
            height: 260px;
            background-color: #e0e0e0;
            border-radius: 10px;
            margin-top: 5px;
        }

        .product-name {
            font-weight: bold;
            margin: 10px 0;
        }

        .product-price {
            color: #000;
            margin: 5px 0;
        }

        .product-buy {
            cursor: pointer;
            transition: transform 0.3s ease;
            border: 2px solid red;
            font-size: 16px;
        }

        .product-buy:hover {
            transform: scale(1.1);
        }

        .product-details,
        .product-buy {
            display: inline-block;
            margin: 5px 0;
            padding: 5px 10px;
            border-radius: 5px;
            text-decoration: none;
            color: white;
        }

        .product-details {
            background-color: #4CAF50;
        }

        .product-buy {
            background-color: #FF0000;
        }

        /*id 3*/
        #pageSection {
            padding-top: 20px;
            padding-bottom: 20px;
            margin-left: auto;
            margin-right: auto;
            background-color: white;
        }

        .pagination {
            display: flex;
            align-items: center;
            /* căn giữa */
            justify-content: center;
            /* căn giữa */
            gap: 10px;
        }

        .pagination a {
            text-decoration: none;
        }

        .pagination .next a {
            font-size: 24px;
            font-weight: bold;
            color: black;
            transition: background-color 0.3s, color 0.3s, font-size 0.3s;
        }

        .pagination .next a:hover {
            color: #28a745;
        }

        .pagination .next a:active {
            color: #28a745; /* Màu xanh khi nhấn */
            font-size: 28px; /* Kích thước lớn hơn khi nhấn */
        }

        .pagination .previous a {
            font-size: 24px;
            font-weight: bold;
            color: black;
            transition: background-color 0.3s, color 0.3s, font-size 0.3s;
        }

        .pagination .previous a:hover {
            color: #28a745;
        }

        .pagination .previous a:active {
            color: #28a745; /* Màu xanh khi nhấn */
            font-size: 28px; /* Kích thước lớn hơn khi nhấn */
        }

        .page {
            width: 40px;
            height: 40px;
            border: 2px solid #ddd;
            border-radius: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 18px;
            font-weight: bold;
            color: #000;
            cursor: pointer;
            transition: background-color 0.3s, color 0.3s;
        }

        .page.active {
            background-color: #28a745;
            color: #fff;
        }

        .page:hover {
            background-color: #ddd;
        }

        /*id 4*/
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

        /* quay về đầu trang*/
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
            transform: scale(1.1);
            color: white;
        }

        .subcate {
            margin-left: 20px;

        }

        .subcate a:hover {
            color: #6bff6b;
        }

        .list .active {
            color: #4CAF50;
            font-weight: bold;
        }

        .subcate .active {
            color: #6bff6b;
            font-weight: bold;
        }

        .breadcrumb .display {
            font-weight: bold;

        }

        .breadcrumb .nodisplay {
            display: none;
        }

        .resultCountP {
            position: absolute;
            right: 80px;
            top: 262px;
        }

        /* CSS cho nút Đăng Xuất */
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
                    <a href="category?cid=6">GIỐNG CÂY MỚI LẠ</a>
                    <a href="category?cid=5">GIỐNG CÂY CÔNG NGHIỆP</a>
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

    <div id="ContentSection">
        <div class="slide_bar">
            <nav class="breadcrumb">
                <a href="TrangChu">Trang
                    chủ</a>/<a><b> ${ act == null?listCategory[0].nameCategory:listCategory[act-1].nameCategory}</b></a>
                <a class="${actSub==null?"nodisplay":"display"}">/<b>${actSub}</b></a>
            </nav>
            <div class="list">
                <div class="list_dropdown">
                    <h3>DANH MỤC SẢN PHẨM</h3>
                    <a href="category?cid=${listCategory[0].categoryID}"
                       class="dropdown-toggle ${act==listCategory[0].categoryID?"active":""}">${listCategory[0].nameCategory}
                    </a>
                    <div class="subcate">
                        <c:forEach var="cateSub" items="${listSubCategory}">
                            <a class="${actSub==cateSub.subCategoriesName?"active":""}"
                               href="subCategory?cid=${listCategory[0].categoryID}&subN=${URLEncoder.encode(cateSub.subCategoriesName, "UTF-8")}">
                                    ${cateSub.subCategoriesName}
                            </a>
                        </c:forEach>
                    </div>
                </div>
                <c:forEach var="cate" items="${listCategory}" begin="1">
                    <a class="${act==cate.categoryID?"active":""}"
                       href="category?cid=${cate.categoryID}">${cate.nameCategory}</a>
                </c:forEach>
            </div>
        </div>

        <div class="content">
            <div class="content-filter">
                <c:if test="${not hidePriceFilter}">
                    <form action="category" method="get">
                        <label for="priceRange">Chọn khoảng giá:</label>
                        <select id="priceRange" name="priceRange" required>
                            <option value="" disabled <c:if test="${empty param.priceRange}">selected</c:if>>--Chọn
                                khoảng
                                giá--
                            </option>
                            <option value="" <c:if test="${empty param.priceRange}">selected</c:if>>Tất cả</option>
                            <option value="0-49000" <c:if test="${param.priceRange == '0-49000'}">selected</c:if>>Dưới
                                50.000 VNĐ
                            </option>
                            <option value="50000-99000"
                                    <c:if test="${param.priceRange == '50000-99000'}">selected</c:if>>
                                50.000 - 99.000 VNĐ
                            </option>
                            <option value="100000-149000"
                                    <c:if test="${param.priceRange == '100000-149000'}">selected</c:if>>100.000 -
                                149.000
                                VNĐ
                            </option>
                            <option value="150000-199000"
                                    <c:if test="${param.priceRange == '150000-199000'}">selected</c:if>>150.000 -
                                199.000
                                VNĐ
                            </option>
                            <option value="200000" <c:if test="${param.priceRange == '200000'}">selected</c:if>>Trên
                                200.000
                                VNĐ
                            </option>
                        </select>
                        <input type="hidden" name="cid" value="${act}">
                    </form>
                </c:if>

            </div>
            <p id="resultCount" class="resultCountP">Hiển thị ${fn:length(listP)} kết quả</p>
            <div class="container">
                <c:forEach var="p" items="${listP}">
                    <div class="product">
                        <a href="ChiTietSanPham?pid=${p.productID}"><img alt="${p.name}" height="270"
                                                                         src="${p.imageMain}" width="197"/></a>
                        <div class="product-name">
                            <a href="ChiTietSanPham?pid=${p.productID}">${p.name}</a>
                        </div>
                        <div class="product-price">
                            <fmt:formatNumber value="${p.price}" type="number" pattern="#,##0 VND"/>
                        </div>
                        <a class="product-details" href="ChiTietSanPham?pid=${p.productID}">
                            Chi tiết sản phẩm
                        </a>
                        <form action="buyNow" method="POST">
                            <input type="hidden" name="pid" value="${p.productID}"/>
                            <button class="product-buy" type="submit">
                                Mua
                            </button>
                        </form>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>

    <c:if test="${not hidePagination}">
        <div id="pageSection">
            <div class="pagination">
                <c:if test="${tag>1}">
                    <div class="previous"><a href="?cid=${act}&page=${tag-1}"
                    ><</a></div>
                </c:if>
                <c:forEach begin="1" end="${endP}" var="i">
                    <a href="?cid=${act}&page=${i}">
                        <div class="${tag==i?"page active":"page"}">
                                ${i}
                        </div>
                    </a>
                </c:forEach>
                <c:if test="${tag<endP}">
                    <div class="next"><a href="?cid=${act}&page=${tag+1}"
                    >></a></div>
                </c:if>
            </div>
        </div>
    </c:if>


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
                            allowfullscreen="" loading="lazy"
                            referrerpolicy="no-referrer-when-downgrade"></iframe>
                </div>
            </div>
        </footer>
    </div>
    <button class="back-to-top" id="backToTop"><i class="fas fa-arrow-up"></i>
        Lên đầu trang
    </button>
</div>
</body>
<script>
    // quay về đầu trang
    // Hiện nút khi cuộn xuống
    window.onscroll = function () {
        const button = document.getElementById('backToTop');
        if (document.body.scrollTop > 100 || document.documentElement.scrollTop > 100) {
            button.style.bottom = "20px";
        } else {
            button.style.bottom = "-60px";
        }
    };

    // Cuộn lên đầu trang khi nhấn nút
    document.getElementById('backToTop').onclick = function () {
        window.scrollTo({top: 0, behavior: 'smooth'});
    };


    document.addEventListener('DOMContentLoaded', function () {
        const priceRangeSelect = document.getElementById('priceRange');
        priceRangeSelect.addEventListener('change', function () {
            this.form.submit(); // Tự động gửi form khi chọn khoảng giá
        });
    });


</script>

</html>
