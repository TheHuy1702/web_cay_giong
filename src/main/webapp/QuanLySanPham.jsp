<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html lang="vi">
<head>
    <title>Admin - Web Bán Cây Giống</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="icon" href="Ảnh/anhlogo.jpg" type="image/x-icon">
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
        .alert-warning {
            background-color: #f8d7da;
            color: #721c24;
            padding: 10px;
            border-radius: 5px;
            margin: 10px;
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
            <button style="border-radius: 5px; background-color: #45a049; padding-bottom: 2px; padding-top: 2px; cursor: pointer;"
                    onclick="toggleManageProduct()">Thêm sản
                phẩm
            </button>
            <a href="LichSu" class="btn btn-secondary" style="margin-left: 10px;">
                <i class="fas fa-history"></i> Lịch sử
            </a>
            <form action="QuanLySanPham" method="post">
                <div class="manage-product">
                    <h2>Thêm sản phẩm</h2>
                    <div class="form-group">
                        <label for="product-name">Tên sản phẩm</label>
                        <input type="text" id="product-name" name="addname" required>
                    </div>
                    <div class="form-group">
                        <label for="product-price">Giá sản phẩm</label>
                        <input type="number" id="product-price" name="addprice" required>
                    </div>
                    <div class="form-group">
                        <label for="product-price">Số lượng sản phẩm</label>
                        <input type="number" id="product-sl" name="addstock" required>
                    </div>
                    <div class="form-group">
                        <label for="product-image-main">Ảnh sản phẩm chính</label>
                        <input type="file" id="product-image-main" name="addimageMan" required>  

                        <img id="preview-image-main" src="" alt="Preview">
                    </div>
                    <div class="form-group">
                        <label for="product-images">Ảnh sản phẩm phụ</label>
                        <input type="file" id="product-images" multiple>
                        <div id="preview-images"></div>
                    </div>
                    <div class="form-group">
                        <label for="product-category">Danh mục sản phẩm</label>
                        <select id="product-category" name="addcategoryID" required>
                            <option value="1">Cây ăn quả</option>
                            <option value="2">Cây cảnh</option>
                            <option value="3">Cây dược liệu</option>
                            <option value="4">Hoa</option>
                            <option value="5">Cây công nghiệp</option>
                            <option value="6">Cây mới lạ</option>
                        </select>
                    </div>
                    <div class="form-group-child">
                        <label for="product-category-child">Danh mục sản phẩm</label>
                        <select id="product-category-child" name="product-category-child">
                            <option value="1">Giống cây mít</option>
                            <option value="Giống cây xoài">Giống cây xoài</option>
                            <option value="Giống cây ổi">Giống cây ổi</option>
                            <option value="Giống cây hồng">Giống cây hồng</option>
                            <option value="Giống cây chanh">Giống cây chanh</option>
                            <option value="Giống cây bưởi">Giống cây bưởi</option>
                            <option value="Giống cây cam, quýt">Giống cây cam, quýt</option>
                            <option value="Giống cây mận">Giống cây mận</option>
                            <option value="Giống cây khác">Giống cây khác</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="product-description">Giới thiệu </label>
                        <textarea id="product-description" name="addintroduce" rows="4"></textarea>
                    </div>
                    <div class="form-group">
                        <label for="product-description">Thông tin sản phẩm </label>
                        <textarea id="product-information" name="addinfoPro" rows="4"></textarea>
                    </div>
                    <div class="form-group">
                        <button name="action" value="them" type="submit">Thêm sản phẩm</button>
                    </div>
                </div>
            </form>
            <div class="product-list">
                <div class="head-list">
                    <h2>Danh sách sản phẩm</h2>
                    <div class="search-container">
                        <form method="get" action="QuanLySanPham">
                            <input type="text" placeholder="Tìm kiếm..." id="search-input" name="search"
                                   value="${ser}" autocomplete="off">
                            <button type="submit"><i class="fa fa-search"></i></button>
                            <div id="suggestions" class="suggestions-box"></div>
                        </form>
                    </div>
                </div>

                <c:if test="${not empty productsSearch}">


                    <table>
                        <thead>
                        <tr>
                            <th>Tên sản phẩm</th>
                            <th>Giá</th>
                            <th>Số lượng</th>
                            <th>Ảnh sản phẩm chính</th>
                            <th>Ảnh sản phẩm phụ</th>
                            <th>Danh mục</th>
                            <th>Giới thiệu</th>
                            <th>Thông tin sản phẩm</th>
                            <th>Hành động</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="product" items="${productsSearch}">

                            <tr>
                                <td>${product.name}</td>
                                <td><fmt:formatNumber value="${product.price}" type="number" pattern="#,##0 VND"/></td>
                                <td>${product.stock}</td>
                                <td><img alt="${product.name}" height="50"
                                         src="${product.imageMain}" width="50"/></td>


                                <td>
                                    <div class="subimgen">
                                        <c:forEach var="sim" items="${subImages}">
                                            <c:if test="${product.productID == sim.productID}">
                                                <img alt="${sim.imageID}" height="50"
                                                     src="${sim.imageSub}" width="50"/>
                                            </c:if>
                                        </c:forEach>
                                    </div>
                                </td>


                                <td>${dsCategories[product.categoryID-1].nameCategory}</td>
                                <td>${product.introduce}</td>
                                <td>${product.infoPro}</td>
                                <td>
                                    <form action="QuanLySanPham" method="post" onsubmit="return confirmDelete();">
                                        <input type="hidden" name="productIdXoa" value="${product.productID}">
                                        <button type="submit" name="action" value="delet">Xóa</button>
                                    </form>


                                </td>
                            </tr>
                        </c:forEach>
                        <!-- Thêm các sản phẩm khác tại đây -->
                        </tbody>
                    </table>

                </c:if>

                <c:if test="${empty products}">
                    Không có sản phẩm nào
                </c:if>

                <c:if test="${not empty products}">


                    <table>
                        <thead>
                        <tr>
                            <th>Tên sản phẩm</th>
                            <th>Giá</th>
                            <th>Số lượng</th>
                            <th>Ảnh sản phẩm chính</th>
                            <th>Ảnh sản phẩm phụ</th>
                            <th>Danh mục</th>
                            <th>Giới thiệu</th>
                            <th>Thông tin sản phẩm</th>
                            <th>Hành động</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="product" items="${products}">

                            <tr>
                                <td>${product.name}</td>
                                <td><fmt:formatNumber value="${product.price}" type="number" pattern="#,##0 VND"/></td>
                                <td>${product.stock}</td>
                                <td><img alt="${product.name}" height="50"
                                         src="${product.imageMain}" width="50"/></td>


                                <td>
                                    <div class="subimgen">
                                        <c:forEach var="sim" items="${subImages}">
                                            <c:if test="${product.productID == sim.productID}">
                                                <img alt="${sim.imageID}" height="50"
                                                     src="${sim.imageSub}" width="50"/>
                                            </c:if>
                                        </c:forEach>
                                    </div>
                                </td>


                                <td>${dsCategories[product.categoryID-1].nameCategory}</td>
                                <td>${product.introduce}</td>
                                <td>${product.infoPro}</td>
                                <td>
                                    <form action="QuanLySanPham" method="post" onsubmit="return confirmDelete();">
                                        <input type="hidden" name="productIdXoa" value="${product.productID}">
                                        <button type="submit" name="action" value="delet">Xóa</button>
                                    </form>
                                    <form action="QuanLySanPham" method="post" onsubmit="return confirmEdit();" onclick="addEditEvent()">
                                        <input type="hidden" name="productIdSua" value="${product.productID}">
                                        <button type="submit" name="action" value="update">Sửa</button>
                                    </form>


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

</body>
<script>
    function toggleManageProduct() {
        const manageSection = document.querySelector('.manage-product');
        manageSection.style.display = manageSection.style.display === 'none' || manageSection.style.display === '' ? 'block' : 'none';
    }

    function confirmDelete() {
        return confirm("Bạn có chắc chắn muốn xóa sản phẩm này không?");
    }

    function confirmEdit() {
        return confirm("Bạn có chắc chắn muốn sửa sản phẩm này không? ");
    }

    // Lấy các phần tử cần thiết
    const parentSelect = document.getElementById('product-category');
    const childFormGroup = document.querySelector('.form-group-child');

    // Thêm sự kiện thay đổi cho select cha
    parentSelect.addEventListener('change', function () {
        // Kiểm tra giá trị của select cha
        if (this.value === 'Cây ăn quả') {
            // Hiển thị form-group-child
            childFormGroup.style.display = 'block';
        } else {
            // Ẩn form-group-child
            childFormGroup.style.display = 'none';
        }
    });

    function addEditEvent(editButton) {
        editButton.addEventListener('click', function () {
            const manageSection = document.querySelector('.manage-product');
            manageSection.style.display = manageSection.style.display === 'none' || manageSection.style.display === '' ? 'block' : 'none';
            addButton.textContent = "Cập nhật sản phẩm";
            // Đổi nút thành "Cập nhật sản phẩm"
        });
    }

    document.getElementById("product-image-main").addEventListener("change", function (event) {
        const preview = document.getElementById("preview-image-main");
        const file = event.target.files[0];
        if (file) {
            preview.src = URL.createObjectURL(file);
        }
    });
    function toggleSubMenu() {
        var subMenu = document.getElementById("subMenu");
        if (subMenu.style.display === "none" || subMenu.style.display === "") {
            subMenu.style.display = "block";
        } else {
            subMenu.style.display = "none";
        }
    }

    // gợi ý tìm kiếm
    const input = document.getElementById("search-input");
    const suggestionsBox = document.getElementById("suggestions");

    input.addEventListener("keyup", function () {
        const query = this.value.trim();
        if (query.length === 0) {
            suggestionsBox.innerHTML = "";
            return;
        }

        fetch("SuggestServlet?query=" + encodeURIComponent(query))
            .then(response => response.json())
            .then(data => {
                suggestionsBox.innerHTML = "";
                data.forEach(name => {
                    const div = document.createElement("div");
                    div.classList.add("suggestion-item");
                    div.textContent = name;
                    div.addEventListener("click", () => {
                        input.value = name;
                        suggestionsBox.innerHTML = "";
                    });
                    suggestionsBox.appendChild(div);
                });
            });
    });

    document.addEventListener("click", function (e) {
        if (!e.target.closest(".search-container")) {
            suggestionsBox.innerHTML = "";
        }
    });
</script>

</html>