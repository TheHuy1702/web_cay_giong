<%--
  Created by IntelliJ IDEA.
  User: Khương
  Date: 1/8/2025
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
    <title>Cài đặt</title>
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

        .sidebar ul li:nth-child(5) {
            background-color: #555;
        }

        .sidebar ul li a {
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

        .management-section {
            margin: 10px 20px;
        }

        .management-section h2 {
            margin-bottom: 20px;
            font-size: 24px;
        }

        .management-section .filter-section {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }

        .management-section .filter-section input,
        .management-section .filter-section select {
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .management-section table {
            width: 100%;
            border-collapse: collapse;
        }

        .management-section th,
        .management-section td {
            border: 1px solid #ddd;
            padding: 8px;
        }

        .management-section th {
            background-color: #f2f2f2;
            text-align: left;
        }

        .management-section .delete-button {
            color: #fff;
            background-color: #dc3545;
            border: none;
            padding: 5px 10px;
            cursor: pointer;
            border-radius: 5px;
            margin-left: 30px;
        }

        .management-section .delete-button:hover {
            background-color: #c82333;
        }

        #management-table th {
            background-color: #42c0e7;
        }

        #management-table tr:hover {
            background-color: #e9ecef;
        }

        #management-table button {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 8px 12px;
            cursor: pointer;
            border-radius: 4px;
        }

        #management-table button:hover {
            background-color: #c82333;
        }

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

        .dangxuat:hover {
            background-color: #666;
        }
    </style>
</head>

<body>
<div id="HeaderSection">
    <div class="header">
        <h1 class="title">Admin - Quản lý bình luận và đánh giá</h1>
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
            <div class="management-section">
                <h2>Quản lý bình luận:</h2>
                <div class="filter-section">
                    <form action="QuanLiBinhLuanVaDanhGia" method="get">
                        <label>Chọn sản phẩm:</label>
                        <select name="productID" id="productName" onchange="this.form.submit()">
                            <option value="">Hiển thị tất cả</option>
                            <c:forEach var="product" items="${allProducts}">
                                <option value="${product.productID}"
                                        <c:if test="${product.productID == selectedProductID}">selected</c:if>>
                                        ${product.name}
                                </option>
                            </c:forEach>
                        </select>
                    </form>

                    <form action="QuanLiBinhLuanVaDanhGia" method="GET">
                        <label>Chọn số sao:</label>
                        <select name="starRating" onchange="this.form.submit()">
                            <option value="">Tất cả</option>
                            <option value="1" <c:if test="${selectedRatingStar==1}">selected</c:if>>1 Sao</option>
                            <option value="2" <c:if test="${selectedRatingStar==2}">selected</c:if>>2 Sao</option>
                            <option value="3" <c:if test="${selectedRatingStar==3}">selected</c:if>>3 Sao</option>
                            <option value="4" <c:if test="${selectedRatingStar==4}">selected</c:if>>4 Sao</option>
                            <option value="5" <c:if test="${selectedRatingStar==5}">selected</c:if>>5 Sao</option>
                        </select>
                        <input type="hidden" name="productID" value="${selectedProductID}"/>
                    </form>
                </div>
                <c:if test="${empty listCommentAndReview}">
                    <div class="alert-warning">
                        Không tìm thấy bình luận và đánh giá nào
                    </div>
                </c:if>
                <c:if test="${not empty listCommentAndReview}">
                <table id="management-table">
                    <thead>
                    <tr>
                        <th>Tên</th>
                        <th>Bình luận</th>
                        <th>Số sao đánh giá</th>
                        <th>Xóa bình luận và đánh giá</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="listCommentAndReview" items="${listCommentAndReview}">
                        <tr>
                            <td>${listCommentAndReview.name}</td>
                            <td>${listCommentAndReview.content}</td>
                            <td>${listCommentAndReview.ratingStars}</td>
                            <td>
                                <form action="QuanLiBinhLuanVaDanhGia" method="post" onsubmit="return confirmDelete();">
                                    <input type="hidden" name="commentId"
                                           value="${listCommentAndReview.comAndReID}"/>
                                    <input type="hidden" name="productID" value="${selectedProductID}"/>
                                    <input type="hidden" name="starRating" value="${selectedRatingStar}"/>
                                    <button type="submit" name="action" value="delete">Xóa</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    </c:if>
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
        } else {
            subMenu.style.display = "none";
        }
    }

    function confirmDelete() {
        return confirm("Bạn có chắc chắn muốn xóa khách hàng và user này không?");
    }
</script>
</html>
