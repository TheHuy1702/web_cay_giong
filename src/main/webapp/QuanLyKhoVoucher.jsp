<%--
  Created by IntelliJ IDEA.
  User: Khuong
  Date: 5/18/2025
  Time: 12:23 PM
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
            background: #fff;
            max-width: 1200px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgb(0 0 0 / 0.1);
            padding: 24px;
        }

        h1 {
            font-weight: 600;
            font-size: 2rem;
            margin: 0 0 16px 0;
        }

        .header2 {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 24px;
        }

        .btn-add {
            background-color: #1abf18;
            color: white;
            border: none;
            border-radius: 6px;
            padding: 10px 20px;
            font-weight: 600;
            font-size: 1rem;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            transition: background-color 0.2s ease;
        }

        .btn-add:hover,
        .btn-add:focus {
            background-color: #0bd82d;
            outline: none;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            overflow: hidden;
            table-layout: fixed;
            word-wrap: break-word;
        }

        thead {
            background-color: #f3f4f6;
        }

        thead th {
            text-align: left;
            padding: 12px 16px;
            font-weight: bold;
            color: white;
            border-bottom: 1px solid #d1d5db;
            height: 50px;
            background-color: #4CAF50;
        }

        tbody td {
            padding: 12px 16px;
            color: #374151;
            border-bottom: 1px solid #e5e7eb;
            vertical-align: top;
            word-break: break-word;
        }

        tbody tr:last-child td {
            border-bottom: none;
        }

        tbody .actions {
            text-align: center;
        }

        .form-popup {
            display: none;
            position: fixed;
            left: 50%;
            top: 50%;
            transform: translate(-50%, -50%);
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            z-index: 1000;
            width: 90%;
            max-width: 400px;
        }

        .overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 999;
        }

        button.action-btn {
            background: none;
            border: none;
            cursor: pointer;
            font-size: 1.1rem;
            margin: 0 6px;
            padding: 4px;
        }

        button.edit-btn {
            color: #ca8a04;
        }

        button.delete-btn {
            color: #dc2626;
        }

        form label {
            display: block;
            margin-top: 12px;
            font-weight: 600;
            color: #374151;
        }

        form input {
            width: 100%;
            padding: 8px 10px;
            margin-top: 4px;
            border: 1px solid #d1d5db;
            border-radius: 6px;
            font-size: 1rem;
            color: #374151;
        }

        form input:focus {
            outline: none;
            border-color: #2563eb;
            box-shadow: 0 0 0 2px rgba(37, 99, 235, 0.3);
        }

        form button {
            margin-top: 16px;
            width: 45%;
        }

        form .btn-cancel {
            background-color: #6b7280;
            margin-left: 4%;
        }

        form .btn-cancel:hover,
        form .btn-cancel:focus {
            background-color: red;
            outline: none;
        }

        @media (max-width: 768px) {
            .header2 {
                flex-direction: column;
                align-items: flex-start;
            }

            table {
                font-size: 0.8rem;
            }

            form button {
                width: 100%;
                margin-left: 0;
                margin-top: 12px;
            }

            form .btn-cancel {
                margin-left: 0;
            }
        }

        tbody tr,
        tbody td {
            border: 1px solid #d1d5db;
        }

        #voucherTableBody {
            border: 1px solid #d1d5db;
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
            margin-left: 600px;
        }

        .bHis:hover {
            background-color: red;
            color: white;
        }

        .alert-warning {
            background-color: #f8d7da;
            color: #721c24;
            padding: 10px;
            border-radius: 5px;
            margin: 10px;
        }

        .btRedo {
            background-color: #dc3545;
            border: none;
            color: white;
            border-radius: 5px;
            text-align: center;
            cursor: pointer;
        }

        .btRedo:hover {
            background-color: red;
        }
    </style>
</head>

<body>
<div id="HeaderSection">
    <div class="header">
        <h1 class="title">Admin - Quản lý kho voucher</h1>
        <div class="admin-user">
            <i class="fas fa-user-circle "></i> <br> Admin
            <div class="logout-menu">
                <form method="post" action="logout">
                    <button class="dangxuat" id="logout1" type="submit"><i class="fas fa-sign-out-alt"></i> Đăng
                        xuất
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
                <a href="QuanLiKhoVoucher">
                    <li class="background"><i class="fas fa-tag icon"></i>Quản lý kho voucher</li>
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
                    <button class="dangxuat" id="logout" type="submit"><i class="fas fa-sign-out-alt"></i> Đăng xuất
                    </button>
                </form>
            </ul>
        </div>
        <div class="content">
            <div class="management-section">
                <h2>Quản lý kho Voucher:</h2>
                <c:if test="${not empty errorMessage}">
                    <div class="alert-warning">
                            ${errorMessage}
                    </div>
                </c:if>
                <c:if test="${empty errorMessage}">
                    <div class="container2" role="main">
                        <div class="header2">
                            <h1></h1>

                            <c:if test="${!canDelete}">
                                <button class="bHis" style="background-color: #cfcfcf; border: none;" title="Bạn không có quyền này" type="button" disabled>Lịch sử xóa</button>
                            </c:if>
                            <c:if test="${canDelete}">
                                <button class="bHis" id="toggleButton" onclick="toggleHistory()">Lịch sử xóa</button>
                            </c:if>
                            <c:if test="${!canAdd}">
                                <button class="btn-add" style="background-color: #cfcfcf; border: none;" title="Bạn không có quyền này" disabled>
                                    <i class="fas fa-plus" aria-hidden="true"></i>Thêm Voucher
                                </button>
                            </c:if>
                            <c:if test="${canAdd}">
                                <button id="addVoucherBtn" class="btn-add" onclick="showForm('add')">
                                    <i class="fas fa-plus" aria-hidden="true"></i>Thêm Voucher
                                </button>
                            </c:if>
                        </div>

                        <div id="historySection" style="display: ${showHistory ? 'block' : 'none'};">
                            <h2>Lịch sử xóa Voucher:</h2>
                            <c:if test="${empty listHisVoucher}">
                                <div class="alert-warning">
                                    Không có lịch sử xóa Voucher nào.
                                </div>
                            </c:if>
                            <c:if test="${not empty listHisVoucher}">
                                <table id="history-table">
                                    <thead>
                                    <tr>
                                        <th scope="col">Mã giảm giá</th>
                                        <th scope="col">Mô tả</th>
                                        <th scope="col">Giá trị tối thiểu</th>
                                        <th scope="col">Ngày bắt đầu</th>
                                        <th scope="col">Ngày kết thúc</th>
                                        <th scope="col">Giảm bao nhiêu %</th>
                                        <th scope="col" style="text-align:center;">Thao Tác</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="v" items="${listHisVoucher}">
                                        <tr>
                                            <td>${v.code}</td>
                                            <td>${v.description}</td>
                                            <td><fmt:formatNumber value="${v.minOrderValue}" type="number"
                                                                  pattern="#,##0 VND"/></td>
                                            <td>${v.startDate}</td>
                                            <td>${v.endDate}</td>
                                            <td>${v.percentDecrease}</td>
                                            <td>
                                                <form action="QuanLyVoucher" method="post"
                                                      onsubmit="return confirmRestore();">
                                                    <input type="hidden" name="vID"
                                                           value="${v.iD}"/>
                                                    <button class="btRedo" type="submit" name="action"
                                                            value="redo">Khôi phục
                                                    </button>
                                                    <button class="btRedo" type="submit" name="action"
                                                            value="deleteReal">Xóa vĩnh viễn
                                                    </button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </c:if>
                        </div>
                        <c:if test="${empty listVoucher}">
                            <div class="alert-warning">
                                Không tìm thấy bình luận và đánh giá nào
                            </div>
                        </c:if>
                        <c:if test="${not empty listVoucher}">
                            <div style="overflow-x:auto;">
                                <table>
                                    <thead>
                                    <tr>
                                        <th scope="col">Mã giảm giá</th>
                                        <th scope="col">Mô tả</th>
                                        <th scope="col">Giá trị tối thiểu</th>
                                        <th scope="col">Ngày bắt đầu</th>
                                        <th scope="col">Ngày kết thúc</th>
                                        <th scope="col">Giảm bao nhiêu %</th>
                                        <th scope="col" style="text-align:center;">Thao Tác</th>
                                    </tr>
                                    </thead>
                                    <tbody id="voucherTableBody">
                                    <c:forEach var="v" items="${listVoucher}">
                                        <tr>
                                            <td class="code">${v.code}</td>
                                            <td class="description">${v.description}</td>
                                            <td class="value"><fmt:formatNumber value="${v.minOrderValue}" type="number"
                                                                                pattern="#,##0 VND"/></td>
                                            <td class="date">${v.startDate}</td>
                                            <td class="date">${v.endDate}</td>
                                            <td class="percentDecrease">${v.percentDecrease}</td>
                                            <td class="actions">
                                                <input type="hidden" name="voucherId" id="voucherId" value="${v.iD}">

                                                <c:if test="${!canEdit}">
                                                    <button class="action-btn edit-btn" title="Bạn không thể chỉnh sửa">
                                                        <i class="fas fa-edit" aria-hidden="true" style="color: #cfcfcf;"></i>
                                                    </button>
                                                </c:if>
                                                <c:if test="${canEdit}">
                                                    <button class="action-btn edit-btn" title="Chỉnh sửa"
                                                            onclick="showForm('edit', this)">
                                                        <i class="fas fa-edit" aria-hidden="true"></i>
                                                    </button>
                                                </c:if>
                                                <form action="QuanLyVoucher" method="post"
                                                      onsubmit="return deleteVoucher();">
                                                    <input type="hidden" name="voucherId" value="${v.iD}">
                                                    <c:if test="${!canDelete}">
                                                        <button type="button"
                                                                class="action-btn delete-btn" title="Bạn không có quyền này">
                                                            <i class="fas fa-trash-alt" aria-hidden="true" style="color: #cfcfcf;"></i>
                                                        </button>
                                                    </c:if>
                                                    <c:if test="${canDelete}">
                                                        <button type="submit" name="actionDelete" value="delete"
                                                                class="action-btn delete-btn" title="Xóa">
                                                            <i class="fas fa-trash-alt" aria-hidden="true"></i>
                                                        </button>
                                                    </c:if>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:if>
                    </div>
                </c:if>
                <div class="overlay" id="overlay" onclick="hideForm()"></div>
                <div class="form-popup" id="voucherForm" role="dialog" aria-modal="true"
                     aria-labelledby="formTitle">
                    <h2 id="formTitle">Thêm Voucher Mới</h2>
                    <form id="voucherFormElement" action="QuanLyVoucher" method="post">
                        <label for="codeInput">Mã Giảm Giá:</label>
                        <input type="text" id="codeInput" name="code" required autocomplete="off"/>
                        <label for="descriptionInput">Mô Tả:</label>
                        <input type="text" id="descriptionInput" name="description" required autocomplete="off"/>
                        <label for="minValueInput">Giá Trị Tối Thiểu:</label>
                        <input type="number" id="minValueInput" name="minValue" required min="0"/>
                        <label for="startDateInput">Ngày Bắt Đầu:</label>
                        <input type="datetime-local" id="startDateInput" name="startDate" required/>
                        <label for="endDateInput">Ngày Kết Thúc:</label>
                        <input type="datetime-local" id="endDateInput" name="endDate" required/>
                        <label for="percentDecreaseInput">Giảm bao nhiêu %:</label>
                        <input type="number" id="percentDecreaseInput" name="percentDecrease" required min="0" max="100"/>
                        <input type="hidden" id="formAction" name="action" value="add"/>
                        <button type="submit" class="btn-add" id="submitBtn">Thêm Voucher</button>
                        <button type="button" class="btn-add btn-cancel" onclick="hideForm()">Hủy</button>
                    </form>
                </div>


            </div>
        </div>
    </div>
</div>
</body>
<script>
    let editingRow = null;

    function showForm(mode, btn = null) {
        const form = document.getElementById("voucherForm");
        const overlay = document.getElementById("overlay");
        const formTitle = document.getElementById("formTitle");
        const submitBtn = document.getElementById("submitBtn");
        const formAction = document.getElementById("formAction");
        const codeInput = document.getElementById("codeInput");
        const descriptionInput = document.getElementById("descriptionInput");
        const minValueInput = document.getElementById("minValueInput");
        const startDateInput = document.getElementById("startDateInput");
        const endDateInput = document.getElementById("endDateInput");
        const percentDecreaseInput = document.getElementById("percentDecreaseInput");

        if (mode === 'add') {
            formTitle.textContent = "Thêm Voucher Mới";
            submitBtn.textContent = "Thêm Voucher";
            formAction.value = "add";
            editingRow = null;
            // Clear inputs
            codeInput.value = "";
            descriptionInput.value = "";
            minValueInput.value = "";
            startDateInput.value = "";
            endDateInput.value = "";
            percentDecreaseInput.value = "";
            codeInput.disabled = false;
        } else if (mode === 'edit' && btn) {
            formTitle.textContent = "Chỉnh Sửa Voucher";
            submitBtn.textContent = "Lưu Thay Đổi";
            formAction.value = "edit";
            editingRow = btn.closest("tr");

            // Lấy dữ liệu từ hàng hiện tại
            const voucherId = editingRow.querySelector('input[name="voucherId"]').value;
            const code = editingRow.querySelector(".code").textContent.trim();
            const description = editingRow.querySelector(".description").textContent.trim();
            const valueText = editingRow.querySelector(".value").textContent.trim();
            const percentDecrease = editingRow.querySelector(".percentDecrease").textContent.trim();
            // Xử lý giá trị tối thiểu
            const minValue = valueText.replace(/[^0-9]/g, ''); // Loại bỏ tất cả ký tự không phải số

            // Lấy ngày bắt đầu và kết thúc
            const startDate = editingRow.querySelectorAll(".date")[0].textContent.trim();
            const endDate = editingRow.querySelectorAll(".date")[1].textContent.trim();

            // Chuyển đổi định dạng ngày tháng về định dạng datetime-local
            const startDateTime = new Date(startDate).toISOString().slice(0, 16);
            const endDateTime = new Date(endDate).toISOString().slice(0, 16);

            // Gán giá trị vào các ô nhập liệu
            codeInput.value = code;
            descriptionInput.value = description;
            minValueInput.value = minValue;
            startDateInput.value = startDateTime;
            endDateInput.value = endDateTime;
            percentDecreaseInput.value = percentDecrease;
            // Xóa các ô nhập liệu ẩn cũ nếu có
            const existingIdInput = document.getElementById('voucherIdInput');
            if (existingIdInput) {
                existingIdInput.remove();
            }
            // Tạo ô nhập liệu ẩn để lưu voucherId
            const idInput = document.createElement('input');
            idInput.type = 'hidden';
            idInput.name = 'voucherId'; // Tên tham số sẽ được gửi
            idInput.id = 'voucherIdInput';
            idInput.value = voucherId; // Gán giá trị id
            document.getElementById('voucherFormElement').appendChild(idInput);
            codeInput.disabled = false; // Cho phép chỉnh sửa mã
        }

        form.style.display = "block";
        overlay.style.display = "block";
        codeInput.focus();
    }

    function hideForm() {
        const form = document.getElementById("voucherForm");
        const overlay = document.getElementById("overlay");
        form.style.display = "none";
        overlay.style.display = "none";
        editingRow = null;
    }

    // Optional: confirm delete
    function deleteVoucher() {
        return confirm("Xóa voucher này sẽ không thể khôi phục lại. Bạn có chắc chắn muốn xóa không?");
    }

    function toggleHistory() {
        var historySection = document.getElementById("historySection");
        var toggleButton = document.getElementById("toggleButton");
        if (historySection.style.display === "none" || historySection.style.display === "") {
            historySection.style.display = "block";
            toggleButton.textContent = "Đóng lịch sử xóa"; // Thay đổi văn bản khi mở
        } else {
            historySection.style.display = "none";
            toggleButton.textContent = "Lịch sử xóa"; // Đặt lại văn bản khi đóng
        }
    }

    function confirmRestore() {
        return confirm("Bạn có chắc chắn muốn khôi phục bình luận và đánh giá này không?");
    }
</script>
</html>
