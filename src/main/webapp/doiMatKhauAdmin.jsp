<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html lang="vi">
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
            font-family: sans-serif, tahoma;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;

        }

        #HeaderSection {

            margin-left: auto;
            margin-right: auto;
        }

        #ContentSection {

            margin-left: auto;
            margin-right: auto;
            background-color: white;
        }

        .header {
            background-color: #4CAF50;
            color: white;
            text-align: center;
        }

        .header .title {
            margin-bottom: -40px;
            padding-top: 30px;
        }

        .container {
            display: flex;
        }


        .sidebar {
            width: 20%;
            background-color: #333;
            padding: 20px;
            color: white;
            max-height: 100%;
        }

        .sidebar h3 {
            margin-top: 0;
            font-size: 20px;

        }

        .sidebar ul {
            list-style-type: none;
            padding: 0;
        }

        .sidebar ul li {
            padding: 20px 5px;
            width: 100%;
            cursor: pointer;
            height: auto;
        }

        .sidebar ul li:hover {
            background-color: #555;
        }

        .sidebar .background {
            background-color: #555;
        }

        .sidebar ul a {
            color: white;
            text-decoration: none;
        }

        .sidebar .icon {
            margin-right: 20px;
            color: white;
        }

        .content {
            width: 80%;
            padding: 20px;
        }

        .content h2 {
            margin-top: 0;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
        }

        .form-group input, .form-group textarea, .form-group select {
            width: 100%;
            padding: 10px;
            box-sizing: border-box;
        }

        .form-group button {
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
        }

        .form-group button:hover {
            background-color: #45a049;
        }


        .form-group-child {
            margin-bottom: 15px;
            display: block;
        }

        .form-group-child label {
            display: block;
            margin-bottom: 5px;
        }

        .form-group-child select {
            width: 100%;
            padding: 10px;
            box-sizing: border-box;
        }


        .product-list {
            margin-top: 20px;
        }

        .product-list table {
            width: 100%;
            border-collapse: collapse;
        }

        .product-list table, .product-list th, .product-list td {
            border: 1px solid #ddd;
        }

        .product-list th, .product-list td {
            padding: 10px;
            text-align: left;
        }

        .product-list th {
            background-color: #f2f2f2;
        }


        #product-image-main {
            display: inline-block;
        }

        #preview-image-main {
            width: 100px;
            height: 100px;
            object-fit: cover;
        }

        #preview-images {
            display: flex;
            margin-right: 10px;
            width: 100px;
            height: 100px;
        }

        td button:hover {
            cursor: pointer;
            background-color: rgb(248, 153, 153);
        }

        .head-list {
            display: flex;
        }

        .head-list h2 {
            width: 70%;
        }

        .search-container {
            width: 30%;
            float: right;
        }

        .search-container input {
            width: 60%;
            height: 50%;
            border-radius: 6px;
        }

        .search-container button {
            cursor: pointer;
            padding-bottom: 2px;
            padding-top: 2px;
        }

        label {
            font-weight: bolder;
        }

        .logout-menu {
            display: none;
            position: absolute;
            right: 0;
            background-color: #fff;
            border: 1px solid #ccc;
            border-radius: 5px;
            padding: 10px;
            z-index: 1;
        }

        .admin-user i {
            font-size: 30px;

        }

        .admin-user {
            position: relative;
            display: inline-block;
            cursor: pointer;
            padding: 10px;
            right: -650px;
            border-radius: 5px;
        }

        .admin-user .logout-menu {
            width: fit-content;
        }

        .admin-user .logout-menu:hover {
            background-color: #f9f9f9;
        }

        .admin-user .logout-menu i {
            font-size: 16px;
            color: red;
        }

        .admin-user .logout-menu a {
            text-decoration: none;
            color: red;
            font-size: 14px;
            width: fit-content;
        }

        .admin-user:hover .logout-menu {
            display: block;
        }

        .submenu {
            display: none;
            list-style-type: none;
            padding-left: 20px;
        }

        .submenu li {
            padding: 5px 0;
            margin-left: 10px;
        }

        .submenu li a {
            color: white;
            text-decoration: none;
        }

        .submenu li:hover {
            background-color: #666;
        }

        td img {
            height: 30px;
        }

        .manage-product {
            display: none;
            margin-top: 20px;
        }

        .timkiem {
            border-radius: 8px;
            background-color: #45a049;
            color: white;
        }

        .timkiem:hover {
            background-color: #4CAF50;
        }

        .dangxuat {
            background-color: #333;
            font-size: 15px;
            cursor: pointer;
            padding: 5px;
            color: white;
        }

        .dangxuat:hover {
            background-color: #666;
        }

        .suggestions-box {
            position: absolute;
            background: #4CAF50;
            border: 1px solid #ccc;
            max-height: 200px;
            overflow-y: auto;
            z-index: 100;
        }

        .suggestion-item {
            padding: 5px 10px;
            cursor: pointer;
        }

        .suggestion-item:hover {
            background-color: #f0f0f0;
        }

    </style>
</head>
<body>
<div id="HeaderSection">
    <div class="header">
        <h1 class="title">Admin - Quản Lý Sản Phẩm</h1>
        <div class="admin-user">
            <i class="fas fa-user-circle "></i> <br> Admin
            <div class="logout-menu">
                <form method="post" action="logout">
                    <button class="dangxuat" id="logout1" type="submit"><i
                            class="fas fa-sign-out-alt"></i> Đăng xuất
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>
<div id="ContentSection">
    <div class="container">
        <div class="sidebar">
            <h3>Quản lý</h3>
            <ul>
                <li><i class="fas fa-tachometer-alt icon"></i><a href="DashBoard">Dashboard</a></li>
                <li><i class="fas fa-box icon"></i><a href="QuanLySanPham">Quản lý sản phẩm</a></li>
                <li><i class="fas fa-shopping-cart icon"></i><a href="QuanLyDonHang">Quản lý đơn hàng</a></li>
                <li><i class="fas fa-users icon"></i><a href="QuanLiKhachHang">Quản lý khách hàng</a></li>
                <li><i class="fas fa-comments icon"></i><a href="QuanLiBinhLuanVaDanhGia">Quản lý bình luận và
                    đánh giá</a></li>
                <li onclick="toggleSubMenu()" style="cursor: pointer;"><i class="fas fa-cog icon"></i>Cài đặt</li>
                <ul id="subMenu" class="submenu">
                    <li><i class="fas fa-info-circle icon"></i><a href="QuanLiGioiThieu">Chỉnh sửa thông
                        tin giới thiệu</a></li>
                </ul>
                <form method="post" action="logout">
                    <button class="dangxuat" id="logout" type="submit"><i
                            class="fas fa-sign-out-alt"></i> Đăng xuất
                    </button>
                </form>
            </ul>
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
</div>

</body>
<script>
</script>

</html>