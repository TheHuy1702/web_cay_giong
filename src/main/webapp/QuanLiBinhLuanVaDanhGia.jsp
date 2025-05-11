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
    <title>Admin - Quản lý Bình luận và đánh giá</title>
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

        .sidebar ul li:nth-child(5) {
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

        .management-section {
            margin: 0;
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

        /*.management-section .delete-button {*/
        /*    color: #fff;*/
        /*    background-color: #dc3545;*/
        /*    border: none;*/
        /*    padding: 5px 10px;*/
        /*    cursor: pointer;*/
        /*    border-radius: 5px;*/
        /*    margin-left: 30px;*/
        /*}*/

        /*.management-section .delete-button:hover {*/
        /*    background-color: #c82333;*/
        /*}*/

        table th,
        table td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        #management-table th, #history-table th {
            height: 50px;
            background-color: #4CAF50; /* Màu nền cho tiêu đề cột */
            color: white; /* Màu chữ cho tiêu đề cột */
            font-weight: bold; /* Làm đậm chữ cho tiêu đề */
        }

        #management-table tr:hover, #history-table tr:hover {
            background-color: #e9ecef;
        }


        #management-table button, #history-table button {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 8px 12px;
            cursor: pointer;
            border-radius: 4px;
        }

        #management-table button:hover, #history-table button:hover {
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

        .container2 {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        #historySection {
            display: none;
            margin-bottom: 20px;
        }

        .bHis {
            border-radius: 10px;
            background-color: #dc3545;
            border: 2px solid #dc3545;
            height: 40px;
            color: white;
            font-weight: 550;
            cursor: pointer;
        }

        .bHis:hover {
            background-color: red;
            color: white;
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
                    <li class="background"><i class="fas fa-comments icon"></i>Quản lý bình luận và
                        đánh giá
                    </li>
                </a>
                <a href="QuanLiUser">
                    <li><i class="fas fa-users icon"></i>Quản lý tài khoản
                    </li>
                </a>
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
            <div class="management-section">
                <h2>Quản lý bình luận:</h2>
                <div class="container2">
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
                        <button class="bHis" onclick="toggleHistory()">Lịch sử xóa</button>
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
                    <div id="historySection" style="display: ${showHistory ? 'block' : 'none'};">
                        <h2>Lịch sử xóa bình luận và đánh giá:</h2>
                        <c:if test="${empty historyList}">
                            <div class="alert-warning">
                                Không có lịch sử xóa bình luận và đánh giá.
                            </div>
                        </c:if>
                        <c:if test="${not empty historyList}">
                            <table id="history-table">
                                <thead>
                                <tr>
                                    <th>Tên</th>
                                    <th>Bình luận</th>
                                    <th>Số sao đánh giá</th>
                                    <th>Thao tác</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="historyItem" items="${historyList}">
                                    <tr>
                                        <td>${historyItem.name}</td>
                                        <td>${historyItem.content}</td>
                                        <td>${historyItem.ratingStars}</td>
                                        <td>
                                            <form action="QuanLiBinhLuanVaDanhGia" method="post"
                                                  onsubmit="return confirmRestore();">
                                                <input type="hidden" name="commentIdHis"
                                                       value="${historyItem.comAndReID}"/>
                                                <button type="submit" name="action" value="redo">Khôi phục</button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </c:if>
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
                                    <form action="QuanLiBinhLuanVaDanhGia" method="post"
                                          onsubmit="return confirmDelete();">
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
        return confirm("Bạn có chắc chắn muốn xóa bình luận và đánh giá này không?");
    }

    function toggleHistory() {
        var historySection = document.getElementById("historySection");
        if (historySection.style.display === "none" || historySection.style.display === "") {
            historySection.style.display = "block";
        } else {
            historySection.style.display = "none";
        }
    }

    function confirmRestore() {
        return confirm("Bạn có chắc chắn muốn khôi phục bình luận và đánh giá này không?");
    }
</script>
</html>
