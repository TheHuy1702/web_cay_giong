<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Quản lí tài khoản người dùng</title>
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
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
            /* display: none; */
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

        .container3 {
            width: 600px;
            background-color: #fff;
            padding: 20px;
            margin-left: 400px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .container3 label {
            font-size: 20px;
        }

        .container3 p {
            font-size: 18px;
        }

        .container3 a {
            font-size: 18px;
        }

        .container3 input[type="text"],
        .container3 input[type="email"],
        .container3 input[type="number"] {
            width: 100%;
            padding: 10px;
            font-size: 18px;
            margin-top: 5px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
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
            background-color: #4CAF50;
            /* Màu nền cho tiêu đề cột */
            color: white;
            /* Màu chữ cho tiêu đề cột */
            font-weight: bold;
            /* Làm đậm chữ cho tiêu đề */

        }

        tbody tr:hover {
            background-color: #f1f1f1;
            /* Hiệu ứng hover cho hàng */
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



        /* thay doi*/
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
                <a href="QuanLiGioiThieu">
                    <li><i class="fas fa-info-circle icon"></i>Chỉnh sửa
                        thông
                        tin giới thiệu</li>
                </a>

                <li onclick="toggleSubMenuTK()" style="cursor: pointer;"><i
                        class="fas fa-users icon"></i>Quản lí tài khoản</li>
                <ul id="subMenuTK" class="subMenuTK">

                    <a href="QuanLiGioiThieu">
                        <li><i class="fas fa-users icon"></i>Quản lý tài khoản người dùng</li>
                    </a>

                    <a href="#">
                        <li><i class="fas fa-users icon"></i>Quản lý tài khoản được phân
                            quyền</li>
                    </a>
                    <a href="#">
                        <li><i class="fas fa-users icon"></i>Phân quyền tài khoản </li>
                    </a>


                </ul>


                <li onclick="toggleSubMenu()" style="cursor: pointer;"><i
                        class="fas fa-cog icon"></i>Cài đặt</li>
                <ul id="subMenu" class="submenu">

                    <a href="#">
                        <li class="background"><i class="fas fa-user icon"></i>Hồ sơ của
                            tôi</li>
                    </a>
                    <a href="send-otp-email">
                        <li><i class="fas fa-lock icon"></i>Đổi mật khẩu </li>
                    </a>
                    <a href="QRServlet">
                        <li><i class="fas fa-building-columns"></i>Ngân hàng</li>
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
            <h2>Hồ Sơ Của Tôi</h2>
            <div class="container2">
                <div class="container3">
                    <p style="font-size: 25px; text-align: center; padding-bottom: 5px;"><strong>Cập
                        nhật thông tin tài khoản</strong></p>

                    <form style="padding-bottom: 10px; padding-top: 10px;" id="usernameForm"
                          action="taiKhoanCuaToi" method="POST">
                        <label><strong>Tên:</strong></label>
                        <p>${customer.nameCustomer123}<a class="change-link"
                                                         onclick="openNamePopup()">Thay Đổi</a></p>
                        <div class="popup-overlay" id="name-popup">

                            <div class="popup-content">
                                <div class="popup-header">Thay đổi tên</div>
                                <input type="text" id="name" class="popup-input"
                                       placeholder="Nhập tên mới" name="name" required>
                                <div class="popup-buttons">
                                    <button type="button" class="cancel-button"
                                            onclick="closeNamePopup()">Hủy</button>
                                    <button type="submit" class="save-button">Lưu</button>
                                </div>
                            </div>

                        </div>
                    </form>

                    <label>Email:</label>
                    <p>${u.email}
                        <a class="change-link" href="send-otp-email?action=updateEmail&type=admin" onclick="openEmailPopup()">Thay Đổi</a>
                    </p>

                    <div class="popup-overlay" id="email-popup">
                        <form id="emailCus" action="UpdateEmail" method="POST">
                            <input type="hidden" name="type" value="admin">

                            <div class="popup-content">
                                <div class="popup-header">Thay đổi Email</div>
                                <input type="email" id="email" class="popup-input" placeholder="Nhập Email mới" name="nameEmail" required>
                                <div class="popup-buttons">
                                    <button type="button" class="cancel-button" onclick="closeEmailPopup()">Hủy</button>
                                    <button type="submit" class="save-button">Lưu</button>
                                </div>
                            </div>
                        </form>
                    </div>



                    <label>Số điện thoại</label>
                    <p>${customer.phone}<a class="change-link" href="send-otp-email?action=updatePhone&type=admin" onclick="openPhonePopup()">Thay Đổi</a></p>
                    <div class="popup-overlay" id="phone-popup">
                        <form id="phoneCus" action="UpdatePhoneAdmin" method="POST">
                            <div class="popup-content">
                                <div class="popup-header">Thay đổi số điện thoại</div>
                                <input type="number" id="phone" class="popup-input" placeholder="Nhập Số điện thoại mới" name="phone"
                                       required>
                                <div class="popup-buttons">
                                    <button type="button" class="cancel-button" onclick="closePhonePopup()">Hủy</button>
                                    <button type="submit" class="save-button">Lưu</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>

            </div>


        </div>
    </div>
</div>
</body>
<script>
    function toggleSubMenu() {
        var subMenu = document.getElementById("subMenu");
        subMenu.style.display = "block";
        subMenuTK.style.display = "none";

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



    function openEmailPopup() {
        document.getElementById('email-popup').style.display = 'flex';
    }
    function openPhonePopup() {
        document.getElementById('phone-popup').style.display = 'flex';
    }

    function closeEmailPopup() {
        document.getElementById('email-popup').style.display = 'none';
    }
    function closePhonePopup() {
        document.getElementById('phone-popup').style.display = 'none';
    }

    function closeNamePopup() {
        document.getElementById('name-popup').style.display = 'none';
    }
    function openNamePopup() {
        document.getElementById('name-popup').style.display = 'flex';
    }
</script>

</html>