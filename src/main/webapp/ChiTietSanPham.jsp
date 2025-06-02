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

        .main-content {
            display: flex;
            justify-content: space-between;
        }

        .breadcrumb {
            padding-top: 39px;
            width: max-content;
            margin-left: 20px;
            margin-bottom: 10px;
        }

        .breadcrumb a:first-child,
        .breadcrumb a:nth-child(2) {
            text-decoration: none;
            color: black;
            cursor: pointer;
        }
        .breadcrumb a:nth-child(2) {
            font-size: 18px;
        }

        .breadcrumb a:nth-child(2):hover {
            color: #ff9900;
        }


        .breadcrumb a:first-child:hover {
            color: #45a049;

            /* Thay đổi màu sắc khi di chuột */
        }

        .breadcrumb .name-tree {
            font-size: 18px;
        }

        .left-column{
            width: 35%;
            margin-left: 40px;
        }
        .right-column {
            width: 60%;
            margin-left: 20px;
            margin-top: 50px;
            margin-right: 20px;
        }

        .product-title {
            font-size: 24px;
            font-weight: bold;
            color: green;
            padding-bottom: 10px;
        }

        .right-column .product-rating {
            color: red;
            padding-bottom: 10px;
            font-weight: 550;
        }

        .right-column .product-price {
            font-size: 20px;
            color: red;
            font-weight: bold;
        }

        .buy-now {
            background-color: red;
            color: white;
            padding: 10px 20px;
            border: none;
            cursor: pointer;
            font-size: 16px;
            margin-top: 10px;
            border-radius: 10px;
            transition: transform 0.25s ease;
        }

        .buy-now:hover {
            transform: scale(1.1);
        }

        .quantity {
            display: flex;
            align-items: center;
            margin-top: 10px;
        }

        .quantity .minus {
            background-color: #ddd;
            border: 1px solid #ccc;
            padding: 5px 10px;
            font-weight: bold;
            margin-left: 10px;
            margin-right: -5px;
            width: 30px;
            cursor: pointer;
            transition: transform 0.4s ease;
        }

        .quantity .minus:hover {
            transform: scale(1.025);
            background-color: #50c555;
        }

        .quantity .plus {
            background-color: #ddd;
            border: 1px solid #ccc;
            padding: 5px 10px;
            font-weight: bold;
            margin-left: -5px;
            width: 30px;
            cursor: pointer;
            transition: transform 0.4s ease;
        }

        .quantity .plus:hover {
            transform: scale(1.025);
            background-color: #50c555;
        }

        .quantity input {
            width: 35px;
            text-align: center;
            margin: 0 10px;
            height: 24px;
            border: 1px solid #ccc;
        }

        .add-to-cart {
            display: flex;
            align-items: center;
            margin-top: 10px;
        }

        .add-to-cart button {
            background-color: red;
            color: white;
            padding: 10px 20px;
            border: none;
            cursor: pointer;
            margin-left: 10px;
            border-radius: 10px;
            transition: transform 0.8s ease;
        }

        .add-to-cart button:hover {
            background-color: #45a049;
            transform: scale(1.01);
        }

        .main-image {
            width: 470px;
            height: 450px;
            background-color: #ccc;
            position: relative;
            margin-top: 20px;
            border-radius: 10px;
            /* Bo góc hình ảnh */

        }

        .main-image img {
            width: 470px;
            height: 100%;
            transition: transform 0.25s;
            /* Hiệu ứng mượt mà khi lật */
            border-radius: 10px;
            /* Bo góc hình ảnh */
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
            /* Bóng đổ cho hình ảnh */

        }

        .product-images {
            display: flex;
            width: 470px;
            justify-content: space-between;
            margin-top: 20px;
        }

        .product-images img:hover {
            transform: scale(1.2);
            /* Phóng to hình ảnh khi hover */
        }

        .product-images img {
            cursor: pointer;
            margin: 0 5px;
            transition: transform 0.3s;
            /* Thêm hiệu ứng chuyển tiếp */
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
            /* Bóng đổ cho hình ảnh */
            border-radius: 10px;
            /* Bo góc hình ảnh */
        }

        .product-info,
        .product-details,
        .comment-section{
            border: 2px solid #ececec;
            padding: 10px;
            margin-top: 20px;
            background-color: white;
        }

        .product-info h3,
        .product-details h3,
        .comment-section h3{
            background-color: #9dee46;
            padding: 10px;
            border-radius: 10px;
        }
        .product-info h3{
            margin-top: 0;
        }

        .product-details ul {
            list-style-type: none;
            padding: 0;
        }

        .product-details ul li {
            margin-bottom: 10px;
        }

        .product-details ul li i {
            color: green;
            margin-right: 5px;
        }

        .product-details i {
            color: red;
            margin-right: 5px;
        }


        .product-details h3 {
            background-color: #9dee46;
            padding: 10px;
            margin-top: 0;
        }

        .product-details p {
            margin: 10px 0;
        }

        .product-details .section-title {
            font-weight: bold;
            color: green;
            margin-top: 10px;
        }

        .product-details .section-content {
            margin-left: 20px;
        }

        /*Bình luận và đánh giá */
        .comment-section, .product-details, .product-info   {
            margin-top: 30px;
            margin-left: 20px;
            margin-right: 20px;
            border-radius: 10px;
        }


        .average-rating {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }

        .average-rating .rating {
            color: #ffcc00;
            margin-right: 10px;
        }

        .average-rating span {
            font-size: 18px;
            font-weight: 500;
        }

        .comment-form {
            display: flex;
            flex-direction: column;
        }

        .comment-form input,
        .comment-form textarea {
            margin-bottom: 10px;
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .comment-form .star-rating {
            display: flex;
            margin-bottom: 10px;
        }

        .comment-form .star-rating i {
            font-size: 24px;
            color: #ccc;
            cursor: pointer;
        }

        .comment-form .star-rating i.selected {
            color: #ffcc00;
        }

        .choose-comment {
            color: #757575;
            margin-bottom: 8px;
            margin-left: 5px;
        }

        .comment-form button {
            padding: 10px 20px;
            font-size: 16px;
            color: #fff;
            background-color: #007bff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .comment-form button:hover {
            background-color: #0056b3;
        }

        .comments-list {
            margin-top: 30px;
        }

        .comment-item {
            display: flex;
            align-items: flex-start;
            margin-bottom: 20px;
        }

        .comment-item img {
            border-radius: 50%;
            margin-right: 20px;
        }

        .comment-content {
            max-width: 600px;
        }

        .comment-content h4 {
            margin: 0;
            font-size: 18px;
        }

        .comment-content p {
            margin: 5px 0;
            font-size: 16px;
        }

        .comment-content .rating {
            color: #ffcc00;
        }

        .view-all-comments {
            text-align: center;
            margin-top: 20px;
            margin-bottom: 10px;
        }

        .view-all-comments2 {
            text-align: center;
            margin-top: 20px;
            margin-bottom: 10px;
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

        .view-all-comments a {
            padding: 10px 20px;
            font-size: 16px;
            background-color: #4caf50;
            color: #fff;
            text-decoration: none;
            border-radius: 5px;

        }

        .view-all-comments2 a {
            padding: 10px 20px;
            font-size: 16px;
            background-color: #4caf50;
            color: #fff;
            text-decoration: none;
            border-radius: 5px;

        }

        .view-all-comments a:hover {
            background-color: #28732a;
        }

        .view-all-comments2 a:hover {
            background-color: #28732a;
        }

        .error-message {
            color: red;
            margin-bottom: 10px;
        }

        /* thêm sản phẩm */
        .container_2 {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
            padding-bottom: 20px;

        }

        .container_2 .product {
            width: 250px;
            margin: 10px;
            text-align: center;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.3);
            /* Bóng */
            border-radius: 15px;
        }

        .container_2 .product img {
            width: 240px;
            height: 260px;
            background-color: #e0e0e0;
            transition: transform 0.3s ease;
            border-radius: 15px;
            margin-top: 5px;
        }

        .container_2 .product-name {
            font-weight: bold;
            margin: 10px 0;
        }

        .container_2 .product-name a {
            text-decoration: none;
            color: black;
            transition: transform 0.3s ease;
            display: inline-block;
        }

        .container_2 .product-name a:hover {
            color: #45a049;
            transform: scale(1.1);
        }

        .container_2 .product-details {
            transition: transform 0.3s ease;
        }

        .container_2 .product img:hover {
            transform: scale(1.075);
        }

        .container_2 .product a:hover {
            transform: scale(1.1);
        }

        .container_2 .product-price {
            color: #000;
            margin: 5px 0;

        }

        .container_2 .product img {
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
            /* Bóng đổ cho hình ảnh */
        }

        .container_2 .product-buy {
            border: 1px solid #ccc;
            display: inline-block;
            margin: 5px 0;
            padding: 5px 10px;
            border-radius: 5px;
            color: white;
            cursor: pointer;
        }

        .container_2 .product-details {
            display: inline-block;
            margin: 5px 0;
            padding: 5px 10px;
            border-radius: 5px;
            text-decoration: none;
            color: white;
        }

        .container_2 .product-details {
            background-color: #4CAF50;
        }

        .container_2 .product-buy {
            background-color: #FF0000;
            transition: transform 0.3s ease;
        }

        .container_2 .product-buy:hover {
            transform: scale(1.1);
        }

        .product-same h3 {
            background-color: #9dee46;
            border-radius: 10px;
            padding: 10px;
        }

        .comment-section h3 {
            background-color: #9dee46;
            padding: 10px;
            margin-top: 0;
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
            color: white;
            transform: scale(1.1);
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

        /*đã thêm vào giỏ hàng*/
        #cart-message {
            position: absolute;
            margin-top: -80px;
            margin-left: 250px;
            color: green;
            width: 300px;
            text-align: center;
            border-radius: 5px;
            background-color: #6bff6b;
        }

        .comment-form button {
            margin-top: 20px;
        }

        .custom-select {
            height: 40px;
            font-size: 16px;
            border-radius: 5px;
            border: 1px solid #ccc;
            color: #ffcc00;
            font-weight: bold;
        }

        .listCom {
            margin-top: 19px;
            border: 5px solid #f7f7f7;
            background-color: #efefef;
            border-radius: 10px;
        }

        .listCom .fa-star {
            color: #ffcc00;
        }

        .listCom .fa-user {
            background-color: #ccc;
            padding: 5px;
            border-radius: 90%;
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
        <nav class="breadcrumb">
            <a href="TrangChu">Trang chủ</a>/<a
                href="category?cid=${cid}">${nameCate}</a>/<b
                class="name-tree"> ${detail.name}</b>
        </nav>
        <div class="container">
            <div class="main-content">
                <div class="left-column">
                    <div class="main-image">
                        <img id="mainImage" alt="${detail.name}" src="${detail.imageMain}"
                             />
                    </div>
                    <div class="product-images">
                        <c:forEach var="listSubImage" items="${listSubImage}">
                            <img alt="Product image ${listSubImage.imageID}" height="100" src="${listSubImage.imageSub}"
                                 width="100"/>
                        </c:forEach>
                    </div>
                </div>
                <div class="right-column">
                    <div class="product-title">
                        ${detail.name}
                    </div>
                    <div class="product-rating">
                        <i class="fas fa-star"></i> ${tbSao} sao cho chất lượng
                    </div>
                    <div class="product-price">
                        Giá: <fmt:formatNumber value="${detail.price}" type="number" pattern="#,##0 VND"/>
                    </div>

                    <form action="buyNow" method="POST">
                        <input type="hidden" name="pid" value="${detail.productID}"/>
                        <button class="buy-now" type="submit">
                            Mua ngay
                        </button>
                    </form>


                    <form id="addToCartForm" action="add-cart" method="post">
                        <div class="quantity">
                            Thêm số lượng:
                            <div>
                                <button class="minus" type="button" id="btnDecrease" onclick="changeQuantity(-1)">-
                                </button>
                                <input type="number" id="quantity" name="soluongSanP" value="1" min="1"/>
                                <button class="plus" type="button" id="btnIncrease" onclick="changeQuantity(1)">+
                                </button>
                            </div>
                        </div>
                        <input type="hidden" name="pid" value="${detail.productID}"/>
                        <input type="hidden" name="kho" value="${detail.stock}"/>
                        <div class="add-to-cart">
                            Số sản phẩm còn: ${detail.stock}
                            <button type="submit" class="add-to-cart">Thêm sản phẩm</button>
                        </div>
                    </form>


                    <div class="product-info">
                        <h3>Giới thiệu:</h3>
                        <p>
                            ${detail.introduce}
                        </p>
                    </div>
                </div>
            </div>
            <div class="product-details">
                <h3>
                    Thông tin sản phẩm:
                </h3>
                <p class="section-title">
                    Đặc điểm ${detail.name}
                </p>
                <div class="section-content">
                    ${detail.infoPro}
                </div>
            </div>

            <div class="comment-section">
                <h3>
                    Bình luận và đánh giá:
                </h3>
                <div class="tb" style="margin-bottom: 10px;">Trung bình số sao: (${tbSao}/5) <i
                        class="fas fa-star" style="color: yellow;"></i></div>
                <c:if test="${showAll}">
                    <c:forEach var="commentAll" items="${listCommentAndReviewAll}">
                        <div class="listCom">
                            <strong><i class="fas fa-user icon"></i> ${commentAll.name}</strong>
                            (${commentAll.ratingStars} <i
                                class="fas fa-star"></i>)
                            <p>${commentAll.content}</p>
                        </div>
                    </c:forEach>
                    <div class="view-all-comments">
                        <a href="ChiTietSanPham?pid=${detail.productID}&showAll=false">Ẩn bớt bình luận và đánh
                            giá</a>
                    </div>

                </c:if>
                <c:if test="${!showAll}">
                    <c:forEach var="comment" items="${listCommentAndReview}">
                        <div class="listCom">
                            <strong><i class="fas fa-user icon"></i> ${comment.name}</strong> (${comment.ratingStars} <i
                                class="fas fa-star"></i>)
                            <p>${comment.content}</p>
                        </div>
                    </c:forEach>
                    <div class="view-all-comments2">
                        <a href="ChiTietSanPham?pid=${detail.productID}&showAll=true">Xem tất cả bình luận và đánh
                            giá</a>
                    </div>
                </c:if>

            </div>
        </div>


        <div class="product-same">
            <h3>
                Sản phẩm tương tự:
            </h3>
        </div>
        <div class="container_2">
            <c:forEach var="psimilar" items="${similarProducts}">
                <div class="product">
                    <a href="ChiTietSanPham?pid=${psimilar.productID}"><img alt="${psimilar.name}" height="270"
                                                                            src="${psimilar.imageMain}"
                                                                            width="197"/></a>
                    <div class="product-name">
                        <a href="ChiTietSanPham?pid=${psimilar.productID}">${psimilar.name}</a>
                    </div>
                    <div class="product-price">
                        <fmt:formatNumber value="${psimilar.price}" type="number" pattern="#,##0 VND"/>
                    </div>
                    <a class="product-details" href="ChiTietSanPham?pid=${psimilar.productID}">
                        Chi tiết sản phẩm
                    </a>
                    <form action="buyNow" method="POST">
                        <input type="hidden" name="pid" value="${psimilar.productID}"/>
                        <button class="product-buy" type="submit">
                            Mua
                        </button>
                    </form>
                </div>
            </c:forEach>
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
    <button class="back-to-top" id="backToTop"><i class="fas fa-arrow-up"></i>
        <div>Lên đầu trang</div>
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

    // Thay doi so luong.
    function changeQuantity(amount) {
        const quantityInput = document.getElementById('quantity');
        let currentValue = parseInt(quantityInput.value);
        currentValue = Math.max(1, currentValue + amount);
        quantityInput.value = currentValue; // Cập nhật giá trị ô nhập
    }

</script>

</html>
