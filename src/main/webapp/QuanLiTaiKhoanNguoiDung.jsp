<%--
  Created by IntelliJ IDEA.
  User: Khương
  Date: 3/22/2025
  Time: 9:23 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Quản lí tài khoản người dùng</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="icon" href="Ảnh/anhlogo.jpg" type="image/x-icon">
    <style>
        body {
            font-family: sans-serif, Tahoma;
            background-color: #f4f4f4;
            margin: 0;

        }

        #HeaderSection {
            margin: auto;
        }

        #ContentSection {
            margin: auto;
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

        .content {
            width: 80%;
            padding: 20px;
        }

        .content h2 {
            margin-top: 0;
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

        .subMenuTK {
            display: none;
            list-style-type: none;
            padding-left: 20px;
        }

        .subMenuTK li {
            padding: 5px 0;
            margin-left: 10px;
        }

        .subMenuTK li a {
            color: white;
            text-decoration: none;
        }

        .subMenuTK li:hover {
            background-color: #666;
        }

        /* Table */
        .container2 {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .header2 {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .header2 input[type="text"] {
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            width: 450px;
            position: relative;
        }

        .header2 input[type="text"]::placeholder {
            color: #aaa;
        }

        .header2 select {
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            margin-left: 10px;
        }

        .header2 button {
            padding: 10px 20px;
            background-color: #ff9800;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .header2 .right {
            display: flex;
            align-items: center;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        table th,
        table td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        table th {
            /*background-color: #f9f9f9;*/
            background-color: #4CAF50; /* Màu nền cho tiêu đề cột */
            color: white; /* Màu chữ cho tiêu đề cột */
            font-weight: bold; /* Làm đậm chữ cho tiêu đề */

        }
        tbody tr:hover {
            background-color: #f1f1f1; /* Hiệu ứng hover cho hàng */
        }

        .dropdown {
            position: relative;
            display: inline-block;
        }

        .dropdown-content {
            display: none;
            position: absolute;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            z-index: 1;
            min-width: 150px;
        }

        .dropdown-content button {
            color: #000;
            padding: 10px 20px;
            text-decoration: none;
            display: flex;
            align-items: center;
            font-size: 14px;
        }

        .dropdown-content button i {
            margin-right: 10px;
        }

        .dropdown-content button:hover {
            background-color: #f1f1f1;
            color: #ff9800;
        }

        .dropdown:hover .dropdown-content {
            display: block;
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
    </style>
</head>

<body>
<div id="HeaderSection">
    <div class="header">
        <h1 class="title">Admin - Quản lý tài khoản người dùng</h1>
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
                <a href="DashBoard">
                    <li><i class="fas fa-tachometer-alt icon"></i>Dashboard</li>
                </a>
                <a href="QuanLySanPham">
                    <li><i class="fas fa-box icon"></i>Quản lý sản phẩm</li>
                </a>
                <a href="QuanLyDonHang">
                    <li><i class="fas fa-shopping-cart icon"></i>Quản lý đơn hàng</li>
                </a>
                <a href="QuanLiKhachHang">
                    <li><i class="fas fa-users icon"></i>Quản lý khách hàng</li>
                </a>
                <a href="QuanLiBinhLuanVaDanhGia">
                    <li><i class="fas fa-comments icon"></i>Quản lý bình luận và
                        đánh giá
                    </li>
                </a>
                <li onclick="toggleSubMenuTK()" style="cursor: pointer;"><i class="fas fa-users icon"></i>Quản lí tài khoản</li>
                <ul id="subMenuTK" class="subMenuTK">

                    <li class="background"><i class="fas fa-users icon"></i><a href="QuanLiGioiThieu">Quản lý tài khoản người dùng
                    </a></li>

                    <li><i class="fas fa-user icon"></i><a href="#">Quản lý tài khoản được phân quyền</a></li>

                </ul>


                <li onclick="toggleSubMenu()" style="cursor: pointer;"><i class="fas fa-cog icon"></i>Cài đặt</li>
                <ul id="subMenu" class="submenu">

                    <li><i class="fas fa-info-circle icon"></i><a href="QuanLiGioiThieu">Chỉnh sửa thông
                        tin giới thiệu
                    </a></li>

                    <li><i class="fas fa-user icon"></i><a href="#">Thông tin của tôi</a></li>

                </ul>
                <form method="post" action="logout">
                    <button class="dangxuat" id="logout" type="submit"><i
                            class="fas fa-sign-out-alt"></i> Đăng xuất
                    </button>
                </form>
            </ul>
        </div>
        <div class="content">
            <h2>Quản lý tài khoản</h2>
            <div class="container2">
                <div class="header2">
                    <form action="QuanLyDonHang" method="get">
                        <input type="text" name="keyword"
                               placeholder="Tìm kiếm số điện thoại..." value="${keyword}">
                        <button type="submit">Tìm kiếm</button>
                    </form>
                    <div class="right">
                        <form method="get" action="QuanLyDonHang">
                            <select name="sortBy" onchange="this.form.submit()">
                                <option value="desc" ${sortBy == 'desc' ? 'selected' : ''}>Mới nhất</option>
                                <option value="asc" ${sortBy == 'asc' ? 'selected' : ''}>Cũ nhất</option>
                            </select>
                        </form>
                    </div>
                </div>
                <table>
                    <thead>
                    <tr>
                        <th>Tài khoản</th>
                        <th>Ngày tạo</th>
                        <th>Email</th>
                        <th>Giới tính</th>
                        <th>Trạng thái</th>
                        <th>Xóa/dừng hoạt động</th>
                        <th>Nâng quyền</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="o" items="${orders}">
                        <tr>
                            <td>1</td>
                            <td>2</td>
                            <td>3</td>
                            <td>4</td>
                            <td>5</td>
                            <td>6</td>
                            <td>7</td>
                        </tr>
                    </c:forEach>

                    </tbody>
                </table>
            </div>


        </div>
    </div>
</div>
</body>
<script>
    function toggleSubMenu() {
        var subMenu = document.getElementById("subMenu");
        if (subMenu.style.display === "none" || subMenu.style.display === "") {
            subMenu.style.display = "block";
            subMenuTK.style.display = "none";
        } else {
            subMenu.style.display = "none";
        }
    }
    function toggleSubMenuTK() {
        var subMenuTK = document.getElementById("subMenuTK");
        if (subMenuTK.style.display === "none" || subMenuTK.style.display === "") {
            subMenuTK.style.display = "block";
            subMenu.style.display = "none";
        } else {
            subMenuTK.style.display = "none";
        }
    }
</script>
</html>
