<%--
  Created by IntelliJ IDEA.
  User: Khương
  Date: 3/28/2025
  Time: 11:04 AM
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
    <title>Admin - Quản lí tài khoản được phân quyền</title>
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

        .alert-warning {
            background-color: #f8d7da;
            color: #721c24;
            padding: 10px;
            border-radius: 5px;
            margin: 10px;
        }

        /* Modal styles */
        #permissionModal {
            position: fixed;
            inset: 0;
            background-color: rgba(0, 0, 0, 0.5);
            display: none;
            align-items: center;
            justify-content: center;
            z-index: 9999;
            overflow-y: auto;
            padding: 20px;
            box-sizing: border-box;
        }

        #permissionModal.active {
            display: flex;
        }

        #permissionModal .modal-content {
            background-color: white;
            border-radius: 8px;
            max-width: 900px;
            width: 100%;
            max-height: 90vh;
            overflow-y: auto;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
            display: flex;
            flex-direction: column;
            box-sizing: border-box;
        }

        #permissionModal header {
            padding: 16px 24px;
            border-bottom: 1px solid #e5e7eb;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-sizing: border-box;
        }

        #permissionModal header h3 {
            margin: 0;
            font-size: 1.25rem;
            font-weight: 700;
            color: #111827;
        }

        #permissionModal header button.close-btn {
            background: none;
            border: none;
            font-size: 1.5rem;
            cursor: pointer;
            color: #6b7280;
            transition: color 0.2s ease;
        }

        #permissionModal header button.close-btn:hover,
        #permissionModal header button.close-btn:focus {
            color: #111827;
            outline: none;
        }

        #permissionModal form {
            padding: 20px 24px 24px 24px;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            box-sizing: border-box;
        }

        #permissionModal form p {
            margin: 0 0 16px 0;
            font-weight: 600;
            color: #374151;
        }

        #permissionModal table {
            width: 100%;
            border-collapse: collapse;
            font-size: 0.95rem;
        }

        #permissionModal thead tr {
            background-color: #f3f4f6;
            font-weight: 600;
            color: #374151;
        }

        #permissionModal th, #permissionModal td {
            border: 1px solid #d1d5db;
            padding: 10px 12px;
            text-align: center;
            vertical-align: middle;
            box-sizing: border-box;
        }

        #permissionModal td:first-child {
            text-align: left;
        }

        #permissionModal input[type="checkbox"] {
            width: 18px;
            height: 18px;
            cursor: pointer;
        }

        #permissionModal .form-actions {
            margin-top: 20px;
            display: flex;
            justify-content: flex-end;
            gap: 12px;
            box-sizing: border-box;
        }

        #permissionModal .form-actions button,
        #permissionModal .form-actions input[type="submit"] {
            padding: 10px 20px;
            font-size: 1rem;
            border-radius: 6px;
            cursor: pointer;
            border: none;
            transition: background-color 0.2s ease;
            box-sizing: border-box;
        }

        #permissionModal .form-actions button.cancel-btn {
            background-color: #e5e7eb;
            color: #374151;
        }

        #permissionModal .form-actions button.cancel-btn:hover,
        #permissionModal .form-actions button.cancel-btn:focus {
            background-color: #d1d5db;
            outline: none;
        }

        #permissionModal .form-actions input[type="submit"] {
            background-color: #16a34a;
            color: white;
        }

        #permissionModal .form-actions input[type="submit"]:hover,
        #permissionModal .form-actions input[type="submit"]:focus {
            background-color: #15803d;
            outline: none;
        }

        td.text-center {
            text-align: center;
        }

        td.text-center button {
            padding: 5px;
            background-color: #cf3636;
            color: white;
            border-radius: 10px;
            cursor: pointer;
            border: none;
        }

        td.text-center button:hover {
            background-color: red;
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
                <li onclick="toggleSubMenuTK()" style="cursor: pointer;"><i class="fas fa-users icon"></i>Quản lí tài
                    khoản
                </li>
                <ul id="subMenuTK" class="subMenuTK">

                    <li class="background"><i class="fas fa-users icon"></i><a href="QuanLiTaiKhoanUser">Quản lý tài
                        khoản người dùng
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
                    <form action="QuanLiTaiKhoanDuocPhanQuyen" method="get">
                        <input type="text" name="keyword"
                               placeholder="Tìm kiếm số tên, điện thoại..." value="${keyword}">
                        <button type="submit">Tìm kiếm</button>
                    </form>
                    <div class="right">
                        <form method="get" action="QuanLiTaiKhoanDuocPhanQuyen">
                            <select name="sortBy" onchange="this.form.submit()">
                                <option value="desc" ${sortBy == 'desc' ? 'selected' : ''}>Mới nhất</option>
                                <option value="asc" ${sortBy == 'asc' ? 'selected' : ''}>Cũ nhất</option>
                            </select>
                        </form>
                    </div>
                </div>
                <c:if test="${empty users}">
                    <div class="alert-warning">
                        Không tìm thấy tài khoản với tìm kiếm là "${keyword}" nào!
                    </div>
                </c:if>
                <c:if test="${not empty users}">
                    <table>
                        <thead>
                        <tr>
                            <th>Tài khoản</th>
                            <th>Ngày tạo</th>
                            <th>Email</th>
                            <th>Số điện thoại</th>
                            <th>Trạng thái</th>
                            <th>Phân quyền</th>
                            <th>Dừng hoạt động</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="u" items="${users}">
                            <tr>
                                <td>${u.name}</td>
                                <td>${u.createAt}</td>
                                <td>${u.email}</td>
                                <td>${u.phone}</td>
                                <td>${u.status}</td>
                                <td class="text-center">
                                    <button
                                            type="button"
                                            class="permission-btn"
                                            onclick="openPermissionForm('${u.userID}', '${u.name}')"
                                            aria-label="Phân quyền cho tài khoản ${u.name}"
                                    >
                                        Phân quyền
                                    </button>
                                </td>
                                <td class="text-center">
                                    <button>Dừng hoạt động</button>
                                </td>
                            </tr>
                        </c:forEach>

                        </tbody>
                    </table>
                </c:if>
            </div>


        </div>
    </div>
</div>


<div
        id="permissionModal"
        role="dialog"
        aria-modal="true"
        aria-labelledby="modalTitle"
        aria-describedby="modalDesc"
        tabindex="-1"
>
    <div class="modal-content">
        <header>
            <h3 id="modalTitle">Phân quyền cho tài khoản</h3>
            <button
                    type="button"
                    aria-label="Đóng"
                    onclick="closePermissionForm()"
                    class="close-btn"
            >
                <i class="fas fa-times"></i>
            </button>
        </header>
        <form id="permissionForm" action="QuanLiTaiKhoanDuocPhanQuyen" method="post">
            <input type="hidden" name="userId" id="userIdInput" value=""/>
            <p id="modalDesc">Phân quyền cho người dùng: <span id="userName"></span></p>
            <table>
                <thead>
                <tr>
                    <th>Trang</th>
                    <th>Xem</th>
                    <th>Thêm</th>
                    <th>Sửa</th>
                    <th>Xóa/Dừng hoạt động</th>
                    <th>All</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>DashBoard</td>
                    <td><input type="checkbox" name="DashBoard_view" class="perm-checkbox" data-group="DashBoard"/></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td>QuanLySanPham</td>
                    <td><input type="checkbox" name="QuanLySanPham_view"  class="perm-checkbox" data-group="QuanLySanPham"  /></td>
                    <td><input type="checkbox" name="QuanLySanPham_add"  class="perm-checkbox" data-group="QuanLySanPham"/></td>
                    <td><input type="checkbox" name="QuanLySanPham_edit" class="perm-checkbox" data-group="QuanLySanPham"/></td>
                    <td><input type="checkbox" name="QuanLySanPham_delete" class="perm-checkbox" data-group="QuanLySanPham"/></td>
                    <td><input type="checkbox" class="perm-all" data-group="QuanLySanPham" aria-label="Chọn tất cả quyền QuanLySanPham"/></td>
                </tr>
                <tr>
                    <td>QuanLyDonHang</td>
                    <td><input type="checkbox" name="QuanLyDonHang_view" id="QuanLyDonHang_view" class="perm-checkbox" data-group="QuanLyDonHang"/></td>
                    <td></td>
                    <td><input type="checkbox" name="QuanLyDonHang_edit" class="perm-checkbox" data-group="QuanLyDonHang"/></td>
                    <td></td>
                    <td><input type="checkbox" class="perm-all" data-group="QuanLyDonHang" aria-label="Chọn tất cả quyền QuanLyDonHang"/></td>
                </tr>
                <tr>
                    <td>QuanLiKhachHang</td>
                    <td><input type="checkbox" name="QuanLiKhachHang_view" class="perm-checkbox" data-group="QuanLiKhachHang"/></td>
                    <td></td>
                    <td></td>
                    <td><input type="checkbox" name="QuanLiKhachHang_delete" class="perm-checkbox" data-group="QuanLiKhachHang"/></td>
                    <td><input type="checkbox" class="perm-all" data-group="QuanLiKhachHang" aria-label="Chọn tất cả quyền QuanLiKhachHang"/></td>
                </tr>
                <tr>
                    <td>QuanLiBinhLuanVaDanhGia</td>
                    <td><input type="checkbox" name="QuanLiBinhLuanVaDanhGia_view" class="perm-checkbox" data-group="QuanLiBinhLuanVaDanhGia"/></td>
                    <td></td>
                    <td></td>
                    <td><input type="checkbox" name="QuanLiBinhLuanVaDanhGia_delete" class="perm-checkbox" data-group="QuanLiBinhLuanVaDanhGia"/></td>
                    <td><input type="checkbox" class="perm-all" data-group="QuanLiBinhLuanVaDanhGia" aria-label="Chọn tất cả quyền QuanLiBinhLuanVaDanhGia"/></td>
                </tr>
                <tr>
                    <td>QuanLiTaiKhoanNguoiDung</td>
                    <td><input type="checkbox" name="QuanLiTaiKhoanNguoiDung_view" class="perm-checkbox" data-group="QuanLiTaiKhoanNguoiDung"/></td>
                    <td></td>
                    <td><input type="checkbox" name="QuanLiTaiKhoanNguoiDung_edit" class="perm-checkbox" data-group="QuanLiTaiKhoanNguoiDung"/></td>
                    <td><input type="checkbox" name="QuanLiTaiKhoanNguoiDung_delete" class="perm-checkbox" data-group="QuanLiTaiKhoanNguoiDung"/></td>
                    <td><input type="checkbox" class="perm-all" data-group="QuanLiTaiKhoanNguoiDung" aria-label="Chọn tất cả quyền QuanLiTaiKhoanNguoiDung"/></td>
                </tr>
                <tr>
                    <td>QuanLiTaiKhoanDuocPhanQuyen</td>
                    <td><input type="checkbox" name="QuanLiTaiKhoanDuocPhanQuyen_view" class="perm-checkbox" data-group="QuanLiTaiKhoanDuocPhanQuyen"/></td>
                    <td></td>
                    <td><input type="checkbox" name="QuanLiTaiKhoanDuocPhanQuyen_edit" class="perm-checkbox" data-group="QuanLiTaiKhoanDuocPhanQuyen"/></td>
                    <td><input type="checkbox" name="QuanLiTaiKhoanDuocPhanQuyen_delete" class="perm-checkbox" data-group="QuanLiTaiKhoanDuocPhanQuyen"/></td>
                    <td><input type="checkbox" class="perm-all" data-group="QuanLiTaiKhoanDuocPhanQuyen" aria-label="Chọn tất cả quyền QuanLiTaiKhoanDuocPhanQuyen"/></td>
                </tr>
                <tr>
                    <td>QuanLiTrangGioiThieu</td>
                    <td><input type="checkbox" name="QuanLiTrangGioiThieu_view" class="perm-checkbox" data-group="QuanLiTrangGioiThieu"/></td>
                    <td></td>
                    <td><input type="checkbox" name="QuanLiTrangGioiThieu_edit" class="perm-checkbox" data-group="QuanLiTrangGioiThieu"/></td>
                    <td></td>
                    <td><input type="checkbox" class="perm-all" data-group="QuanLiTrangGioiThieu" aria-label="Chọn tất cả quyền QuanLiTrangGioiThieu"/></td>
                </tr>
                <tr>
                    <td>QuanLyKhoVoucher</td>
                    <td><input type="checkbox" name="QuanLyKhoVoucher_view" class="perm-checkbox" data-group="QuanLyKhoVoucher"/></td>
                    <td><input type="checkbox" name="QuanLyKhoVoucher_add" class="perm-checkbox" data-group="QuanLyKhoVoucher"/></td>
                    <td><input type="checkbox" name="QuanLyKhoVoucher_edit" class="perm-checkbox" data-group="QuanLyKhoVoucher"/></td>
                    <td><input type="checkbox" name="QuanLyKhoVoucher_delete" class="perm-checkbox" data-group="QuanLyKhoVoucher"/></td>
                    <td><input type="checkbox" class="perm-all" data-group="QuanLyKhoVoucher" aria-label="Chọn tất cả quyền QuanLyKhoVoucher"/></td>
                </tr>
                </tbody>
            </table>
            <div style="margin: 10px 0;">
                <input type="checkbox" id="allpermission" name="allpermission" onclick="toggleAllPermissions(this)">
                <label for="allpermission"><strong>Toàn quyền</strong></label>
            </div>
            <br/>
            <div class="form-actions">
                <button type="button" onclick="closePermissionForm()" class="cancel-btn">Hủy</button>
                <input type="submit" value="Lưu phân quyền"/>
            </div>
        </form>
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

    // Permission modal open/close
    const permissionsData = {
    <c:forEach var="u" items="${users}">
    ${u.userID}: [<c:forEach var="perm" items="${requestScope['permissions_'.concat(u.userID)]}">"${perm}",</c:forEach>],
    </c:forEach>
    };

    function openPermissionForm(userId, userName) {
        // Lấy permissions của user từ biến JavaScript
        var userIdInput = document.getElementById('userIdInput');
        var userNameSpan = document.getElementById('userName');

        userIdInput.value = userId;
        userNameSpan.textContent = userName;

        const userPermissions = permissionsData[userId] || [];

        // Tích checkbox nếu có quyền
        document.querySelector('[name="DashBoard_view"]').checked = userPermissions.includes('DashBoard_view');
        document.querySelector('[name="QuanLySanPham_view"]').checked = userPermissions.includes('QuanLySanPham_view');
        document.querySelector('[name="QuanLySanPham_add"]').checked = userPermissions.includes('QuanLySanPham_add');
        document.querySelector('[name="QuanLySanPham_edit"]').checked = userPermissions.includes('QuanLySanPham_edit');
        document.querySelector('[name="QuanLySanPham_delete"]').checked = userPermissions.includes('QuanLySanPham_delete');
        document.querySelector('[name="QuanLyDonHang_view"]').checked = userPermissions.includes('QuanLyDonHang_view');
        document.querySelector('[name="QuanLyDonHang_edit"]').checked = userPermissions.includes('QuanLyDonHang_edit');
        document.querySelector('[name="QuanLiKhachHang_view"]').checked = userPermissions.includes('QuanLiKhachHang_view');
        document.querySelector('[name="QuanLiKhachHang_delete"]').checked = userPermissions.includes('QuanLiKhachHang_delete');
        document.querySelector('[name="QuanLiBinhLuanVaDanhGia_view"]').checked = userPermissions.includes('QuanLiBinhLuanVaDanhGia_view');
        document.querySelector('[name="QuanLiBinhLuanVaDanhGia_delete"]').checked = userPermissions.includes('QuanLiBinhLuanVaDanhGia_delete');
        document.querySelector('[name="QuanLiTaiKhoanNguoiDung_view"]').checked = userPermissions.includes('QuanLiTaiKhoanNguoiDung_view');
        document.querySelector('[name="QuanLiTaiKhoanNguoiDung_edit"]').checked = userPermissions.includes('QuanLiTaiKhoanNguoiDung_edit');
        document.querySelector('[name="QuanLiTaiKhoanNguoiDung_delete"]').checked = userPermissions.includes('QuanLiTaiKhoanNguoiDung_delete');
        document.querySelector('[name="QuanLiTaiKhoanDuocPhanQuyen_view"]').checked = userPermissions.includes('QuanLiTaiKhoanDuocPhanQuyen_view');
        document.querySelector('[name="QuanLiTaiKhoanDuocPhanQuyen_edit"]').checked = userPermissions.includes('QuanLiTaiKhoanDuocPhanQuyen_edit');
        document.querySelector('[name="QuanLiTaiKhoanDuocPhanQuyen_delete"]').checked = userPermissions.includes('QuanLiTaiKhoanDuocPhanQuyen_delete');
        document.querySelector('[name="QuanLiTrangGioiThieu_view"]').checked = userPermissions.includes('QuanLiTrangGioiThieu_view');
        document.querySelector('[name="QuanLiTrangGioiThieu_edit"]').checked = userPermissions.includes('QuanLiTrangGioiThieu_edit');
        document.querySelector('[name="QuanLyKhoVoucher_view"]').checked = userPermissions.includes('QuanLyKhoVoucher_view');
        document.querySelector('[name="QuanLyKhoVoucher_add"]').checked = userPermissions.includes('QuanLyKhoVoucher_add');
        document.querySelector('[name="QuanLyKhoVoucher_edit"]').checked = userPermissions.includes('QuanLyKhoVoucher_edit');
        document.querySelector('[name="QuanLyKhoVoucher_delete"]').checked = userPermissions.includes('QuanLyKhoVoucher_delete');

        // Mở modal
        document.getElementById('permissionModal').style.display = 'flex';
        document.body.style.overflow = 'hidden';
    }








    function closePermissionForm() {
        var modal = document.getElementById('permissionModal');
        modal.style.display = 'none';
        document.body.style.overflow = ''; // Restore scroll
    }

    // Close modal on ESC key
    document.addEventListener('keydown', function (e) {
        if (e.key === 'Escape') {
            var modal = document.getElementById('permissionModal');
            if (modal.style.display === 'flex') {
                closePermissionForm();
            }
        }
    });

    // Close modal if clicking outside the modal content
    document.getElementById('permissionModal').addEventListener('click', function (e) {
        if (e.target === this) {
            closePermissionForm();
        }
    });

    // Handle "All" checkbox logic
    var permAllCheckboxes = document.querySelectorAll('.perm-all');
    permAllCheckboxes.forEach(function (allCheckbox) {
        allCheckbox.addEventListener('change', function () {
            var group = this.getAttribute('data-group');
            var checkboxes = document.querySelectorAll('input.perm-checkbox[data-group="' + group + '"]');
            checkboxes.forEach(function (cb) {
                cb.checked = allCheckbox.checked;
            });
        });
    });

    // If any individual checkbox is unchecked, uncheck the "All" checkbox for that group
    var permCheckboxes = document.querySelectorAll('.perm-checkbox');
    permCheckboxes.forEach(function (cb) {
        cb.addEventListener('change', function () {
            var group = this.getAttribute('data-group');
            var allCheckbox = document.querySelector('input.perm-all[data-group="' + group + '"]');
            var groupCheckboxes = document.querySelectorAll('input.perm-checkbox[data-group="' + group + '"]');
            var allChecked = true;
            groupCheckboxes.forEach(function (c) {
                if (!c.checked) allChecked = false;
            });
            if (allCheckbox) {
                allCheckbox.checked = allChecked;
            }
        });
    });


    function toggleAllPermissions(source) {
        const checkboxes = document.querySelectorAll('input[type=checkbox]:not(#allpermission)');
        checkboxes.forEach(cb => cb.checked = source.checked);
    }

    document.addEventListener('DOMContentLoaded', () => {
        const checkboxes = document.querySelectorAll('input[type=checkbox]:not(#allpermission)');
        checkboxes.forEach(cb => {
            cb.addEventListener('change', () => {
                const allChecked = [...checkboxes].every(c => c.checked);
                document.getElementById('allpermission').checked = allChecked;
            });
        });
    });
</script>
</html>

