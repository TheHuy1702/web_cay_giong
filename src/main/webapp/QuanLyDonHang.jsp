<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Quản lí đơn hàng</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="icon" href="Ảnh/anhlogo.jpg" type="image/x-icon">
    <style>
        body {
            font-family: sans-serif, Tahoma;
            background-color: #f4f4f4;
            margin: 0;

        }

        #HeaderSection {
            width: 1200px;
            margin: auto;
        }

        #ContentSection {
            width: 1200px;
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
            right: -540px;
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
            background-color: #f9f9f9;
        }

        .status {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 4px;
            font-size: 12px;
        }

        .status-confirmed {
            border: 2px solid green;
            padding: 5px;
            background-color: #4caf50;
            border-radius: 5px;
            text-align: center;
            font-weight: bold;
        }

        .status-pending {
            border: 2px solid yellow;
            padding: 5px;
            background-color: #ffeb3b;
            border-radius: 5px;
            text-align: center;
            font-weight: bold;
        }

        .status-cancelled {
            border: 2px solid red;
            padding: 5px;
            background-color: #f44336;
            border-radius: 5px;
            text-align: center;
            font-weight: bold;
        }

        .status.confirmed {
            background-color: #4caf50;
            color: #fff;
        }

        .status.cancelled {
            background-color: #f44336;
            color: #fff;
        }

        .action-button {
            padding: 5px 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            background-color: #fff;
            cursor: pointer;
        }

        .action-button:hover {
            background-color: #f1f1f1;
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

        /*.modal {*/
        /*    display: none;*/
        /*    position: fixed;*/
        /*    z-index: 1;*/
        /*    left: 0;*/
        /*    top: 0;*/
        /*    !*width: 100%;*!*/
        /*    !*height: 100%;*!*/
        /*    overflow: auto;*/
        /*    background-color: rgb(0, 0, 0);*/
        /*    background-color: rgba(0, 0, 0, 0.4);*/
        /*    padding-top: 60px;*/
        /*}*/

        .modal-content {
            background-color: #fefefe;
            margin: 5% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            max-width: 600px;
            border-radius: 8px;
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

        .modal-content {
            /*margin: auto;*/
            margin-top: -200px;
        }

        /*.modal {*/
        /*  display: none;*/
        /*  position: fixed;*/
        /*  z-index: 1;*/
        /*  left: 0;*/
        /*  top: 0;*/
        /*  width: 100%;*/
        /*  height: 100%;*/
        /*  overflow: auto;*/
        /*  background-color: rgb(0,0,0);*/
        /*  background-color: rgba(0,0,0,0.4);*/
        /*}*/

        /*.modal-content {*/
        /*  background-color: #fefefe;*/
        /*  margin: 15% auto;*/
        /*  padding: 20px;*/
        /*  border: 1px solid #888;*/
        /*  width: 50%;*/
        /*}*/

        /*.close {*/
        /*  color: #aaa;*/
        /*  float: right;*/
        /*  font-size: 28px;*/
        /*  font-weight: bold;*/
        /*}*/

        /*.close:hover,*/
        /*.close:focus {*/
        /*  color: black;*/
        /*  text-decoration: none;*/
        /*  cursor: pointer;*/
        /*}*/
        #orderDetails {
            display: none; /* Ẩn mặc định */
            position: fixed; /* Đặt vị trí cố định */
            z-index: 1000; /* Đảm bảo nó nằm trên các phần tử khác */
            left: 0;
            top: 0;
            width: 100%; /* Chiếm toàn bộ chiều rộng */
            height: 100%; /* Chiếm toàn bộ chiều cao */
            background-color: rgba(0, 0, 0, 0.5); /* Nền mờ */
            justify-content: center; /* Căn giữa theo chiều ngang */
            align-items: center; /* Căn giữa theo chiều dọc */
        }

        #detailsContent {
            background-color: #fefefe; /* Nền của khung chi tiết */
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            max-width: 600px;
            border-radius: 8px;
            position: relative; /* Để có thể sử dụng cho nút đóng */
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
        <h1 class="title">Admin - Quản lý đơn hàng</h1>
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
                    <li class="background"><i class="fas fa-shopping-cart icon"></i>Quản lý đơn hàng</li>
                </a>
                <a href="QuanLiKhachHang">
                    <li><i class="fas fa-users icon"></i>Quản lý khách hàng</li>
                </a>
                <a href="QuanLiBinhLuanVaDanhGia">
                    <li><i class="fas fa-comments icon"></i>Quản lý bình luận và
                        đánh giá
                    </li>
                </a>
                <li onclick="toggleSubMenu()" style="cursor: pointer;"><i class="fas fa-cog icon"></i>Cài đặt</li>
                <ul id="subMenu" class="submenu">

                    <a href="QuanLiGioiThieu">
                        <li><i class="fas fa-info-circle icon"></i>Chỉnh sửa thông
                            tin giới thiệu
                        </li>
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
            <h2>Quản lý đơn hàng</h2>
            <div class="container2">
                <div class="header2">
                    <form action="QuanLyDonHang" method="get">
                        <input type="text" name="keyword"
                               placeholder="Tìm kiếm theo mã đơn hàng, số điện thoại..." value="${keyword}">
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
                        <th>Mã</th>
                        <th>Ngày tạo</th>
                        <th>Người mua</th>
                        <th>Tên sản phẩm</th>
                        <th>Giá</th>
                        <th>Trạng thái</th>
                        <th>Thao tác</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="o" items="${orders}">
                        <tr>
                            <td><a style="text-decoration: none; color:black;"
                                   href="ChiTietDonHang?orderID=${o.orderID}">${o.orderID}</a></td>
                            <td>${o.orderDate}</td>
                            <td>
                                <a style="text-decoration: none; color:black;"
                                   href="ChiTietDonHang?orderID=${o.orderID}">${o.nameCustomer}-${o.phone}</a>
                            </td>
                            <td><a style="text-decoration: none; color:black;"
                                   href="ChiTietDonHang?orderID=${o.orderID}">${o.name}</a>
                            </td>
                            <td><fmt:formatNumber value="${o.totalAmount}" type="number" pattern="#,##0 VND"/></td>
                            <td>

                                <div class="<c:choose>
                    <c:when test="${o.status == 'Đã Xác Nhận'}">status-confirmed</c:when>
                    <c:when test="${o.status == 'Chờ Xác Nhận'}">status-pending</c:when>
                    <c:when test="${o.status == 'Đã Huỷ'}">status-cancelled</c:when>
                </c:choose>">
                                        ${o.status}
                                </div>
                            </td>
                            <td>
                                <div class="dropdown">
                                    <button class="action-button">Thao tác</button>
                                    <div class="dropdown-content">
                                        <form method="post" action="QuanLyDonHang">
                                            <input type="hidden" name="orderID" value="${o.orderID}">
                                            <button type="submit" value="xacNhan"
                                                    name="action"><i
                                                    class="fas fa-check"></i>Xác nhận đơn hàng
                                            </button>
                                            <button type="submit" value="huyDon" name="action"><i
                                                    class="fas fa-times"></i>Hủy đơn hàng
                                            </button>

                                        </form>
                                    </div>
                                </div>
                            </td>
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
</script>
</html>