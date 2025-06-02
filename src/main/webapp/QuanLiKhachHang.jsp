<%--
  Created by IntelliJ IDEA.
  User: Khương
  Date: 1/11/2025
  Time: 11:34 PM
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
    <title>Admin - Quản lý khách hàng</title>
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

        /* Table */
        .customer-list {
            margin-top: 20px;
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .customer-list table {
            width: 100%;
            border-collapse: collapse;
        }

        .customer-list table,
        .customer-list th,
        .customer-list td {
            border: 1px solid #ddd;
        }

        .customer-list th,
        .customer-list td {
            padding: 10px;
            text-align: left;
        }

        .customer-list th {
            background-color: #f2f2f2;
        }

        .customer-list .action-buttons button {
            margin-right: 5px;
        }

        .password-container {
            display: flex;
            align-items: center;
        }

        .password-container input {
            border: none;
            background: none;
            width: 100%;
            pointer-events: none;
        }

        .password-container .toggle-password {
            cursor: pointer;
            margin-left: 5px;
        }

        .list-search {
            display: flex;
            justify-content: space-between;
        }

        .search-container {
            margin-top: 16px;
        }

        .search-container input {
            width: 500px;
            height: 25px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        .search-container button {
            color: white;
            background-color: #ff9800;;
            height: 25px;
            border-radius: 6px;
            cursor: pointer;
            border: none;
            transition: transform 0.3s ease;
        }

        /*.action-buttons button {*/
        /*    background-color: #4CAF50;*/
        /*    color: white;*/
        /*    border: none;*/
        /*    cursor: pointer;*/
        /*    text-align: center;*/
        /*    padding: 5px 10px;*/
        /*    border-radius: 5px;*/
        /*    transform: scale(1.1);*/
        /*}*/

        /*.action-buttons button:hover {*/
        /*    background-color: red;*/
        /*}*/

        #historyTable{
            background-color: #4CAF50;
            height: 50px;
            color: white; /* Màu chữ cho tiêu đề cột */
            font-weight: bold; /* Làm đậm chữ cho tiêu đề */
        }

        #historyTable tr:hover{
            background-color: #e9ecef;

        }

        #customerTable th {
            background-color: #4CAF50;
            height: 50px;
            color: white; /* Màu chữ cho tiêu đề cột */
            font-weight: bold; /* Làm đậm chữ cho tiêu đề */
        }

        #customerTable tr:hover {
            background-color: #e9ecef;

        }

        .action-buttons button {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 8px 12px;
            cursor: pointer;
            border-radius: 4px;
        }

        .action-buttons button:hover {
            background-color: #c82333;
        }

        .search-container button:hover {
            background-color: #4CAF50;
        }

        .modal {
            display: flex;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.4);
            justify-content: center;
            /* Định vị giữa theo chiều ngang */
            align-items: center;
            /* Định vị giữa theo chiều dọc */
        }

        .modal-content {
            background-color: #fefefe;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #888;
            width: 300px;
            /* Chiều rộng của modal */
            border-radius: 8px;
            /* Bo góc cho modal */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            /* Đổ bóng cho modal */
            text-align: center;
        }

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }

        /*button {*/
        /*    background-color: #4CAF50;*/
        /*    !* Màu nền cho nút *!*/
        /*    color: white;*/
        /*    !* Màu chữ cho nút *!*/
        /*    border: none;*/
        /*    !* Không có viền *!*/
        /*    padding: 10px 15px;*/
        /*    !* Padding cho nút *!*/
        /*    text-align: center;*/
        /*    !* Căn giữa chữ trong nút *!*/
        /*    text-decoration: none;*/
        /*    !* Không có gạch chân *!*/
        /*    display: inline-block;*/
        /*    !* Hiển thị inline-block *!*/
        /*    margin: 5px 5px;*/
        /*    !* Khoảng cách giữa các nút *!*/
        /*    cursor: pointer;*/
        /*    !* Con trỏ chuột khi hover *!*/
        /*    border-radius: 5px;*/
        /*    !* Bo góc cho nút *!*/
        /*    transition: transform 0.3s ease;*/
        /*}*/

        /*.button:hover {*/
        /*    background-color: red;*/
        /*    !* Màu nền khi hover *!*/
        /*    transform: scale(1.1);*/
        /*}*/

        .alert-warning {
            background-color: #f8d7da;
            color: #721c24;
            padding: 10px;
            border-radius: 5px;
            margin: 10px;
        }
        .dangxuat {
            background-color: #333;
            font-size: 15px;
            cursor: pointer;
            padding: 5px;
            color: white;
        }
        .alert-warning {
            background-color: #f8d7da;
            color: #721c24;
            padding: 10px;
            border-radius: 5px;
            margin: 10px;
        }

        .dangxuat:hover {
            background-color: #666;
        }
    </style>
</head>

<body>
<div id="HeaderSection">
    <div class="header">
        <h1 class="title">Admin - Quản lý khách hàng</h1>
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
                    <li class="background"><i class="fas fa-users icon"></i>Quản lý khách hàng</li>
                </a>
                <a href="QuanLiBinhLuanVaDanhGia">
                    <li><i class="fas fa-comments icon"></i>Quản lý bình luận và
                        đánh giá
                    </li>
                </a>
                <a href="QuanLiUser">
                    <li><i class="fas fa-users icon"></i>Quản lý tài khoản
                    </li>
                </a>
                <li onclick="toggleSubMenu()" style="cursor: pointer;"><i class="fas fa-cog icon"></i>Cài đặt</li>
                <ul id="subMenu" class="submenu">

                    <a href="QuanLiGioiThieu">
                        <li><i class="fas fa-info-circle icon"></i>Chỉnh sửa thông
                            tin giới thiệu
                        </li>
                        <li><i class="fas fa-user icon"></i><a href="QuanLiTaiKhoanCuaToi">Thông tin của tôi</a></li>

                    </a>

                </ul>
                <form method="post" action="logout">
                    <button class="dangxuat" id="logout" type="submit"><i
                            class="fas fa-sign-out-alt"></i> Đăng xuất
                    </button>
                </form>
            </ul>
        </div>
        <div class="content">
            <h2>Quản lý khách hàng
                <button onclick="toggleHistory()" style="margin-left: 20px; background-color: #4CAF50; color: white; border: none; padding: 5px 10px; border-radius: 4px;">
                    Lịch sử
                </button>
            </h2>
            <c:if test="${not empty errorMessage}">
                    <div class="alert-warning">
            ${errorMessage}
                    </div>
            </c:if>
            <c:if test="${empty errorMessage}">
            <div class="customer-list">

            <div id="historyTable" style="display: none; margin-top: 20px;">
                <div class="list-search">
                    <h3>Danh sách khách hàng</h3>
                </div>
                <table>
                    <thead>
                    <tr>
                        <th>Mã khách hàng</th>
                        <th>Tên khách hàng</th>
                        <th>Số điện thoại</th>
                        <th>Địa chỉ</th>
                        <th>Tài khoản</th>
                        <th>Mật khẩu</th>
                        <th>Hành động</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:if test="${not empty deleteLogs}">
                        <h3>Lịch sử xoá khách hàng</h3>
                        <ul>
                            <c:forEach var="log" items="${deleteLogs}">
                                <li>${log}</li>
                            </c:forEach>
                        </ul>
                    </c:if>
                    </tbody>
                </table>
            </div>
            </div>
            <div class="customer-list">
                <div class="list-search">
                    <h3>Danh sách khách hàng</h3>
                    <div class="search-container">

                        <form action="QuanLiKhachHang" method="get">
                            <input type="text" name="search"
                                   placeholder="Tìm kiếm khách hàng theo tên, số điện thoại hoặc mã khách hàng...">
                            <button type="submit">Tìm kiếm</button>
                        </form>

                    </div>
                </div>
                <c:if test="${empty customerList}">
                    <div class="alert-warning">
                        Không tìm thấy khách hàng nào
                    </div>
                </c:if>
                <c:if test="${not empty customerList}">
                    <table id="customerTable">
                        <thead>
                        <tr>
                            <th>Mã khách hàng</th>
                            <th>Tên khách hàng</th>
                            <th>Số điện thoại</th>
                            <th>Địa chỉ</th>
                            <th>Tài khoản</th>
                            <th>Mật khẩu</th>
                            <th>Hành động</th>
                        </tr>
                        </thead>
                        <tbody>


                        <c:forEach var="c" items="${customerList}">
                            <tr>
                                <td>${c.customerID}</td>
                                <td>${c.nameCustomer}</td>
                                <td>${c.phone}</td>
                                <td>${c.address}, ${c.district}, ${c.city}</td>
                                <td>${c.user.phone}</td>
                                <td>
                                    <div class="password-container">
                                        <input type="password" value="${c.user.password}" readonly>
                                    </div>
                                </td>
                                <td class="action-buttons">


                                    <form action="QuanLiKhachHang" method="post" onsubmit="return confirmDelete();">
                                        <input type="hidden" name="customerID" value="${c.customerID}">
                                        <button type="submit" name="action" value="delete">Xóa</button>
                                    </form>


                                </td>
                            </tr>
                        </c:forEach>


                        </tbody>
                    </table>
                </c:if>
            </div>
            </c:if>
        </div>
    </div>
</div>
</body>
<script>
    function toggleSubMenu() {
        var subMenu = document.getElementById("subMenu");
        if (subMenu.style.display === "none" || subMenu.style.display === "") {
            subMenu.style.display = "block";
        } else {
            subMenu.style.display = "none";
        }
    }


    function confirmDelete() {
        return confirm("Bạn có chắc chắn muốn xóa khách hàng và user này không?");
    }


        function toggleHistory() {
        var historyTable = document.getElementById("historyTable");
        if (historyTable.style.display === "none" || historyTable.style.display === "") {
        historyTable.style.display = "block";
    } else {
        historyTable.style.display = "none";
    }
    }

</script>

</html>
