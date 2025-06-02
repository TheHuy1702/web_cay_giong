<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giỏ hàng</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="icon" href="Ảnh/anhlogo.jpg" type="image/x-icon">
    <style>
        body {
            margin: 0;
            padding: 0;
            background: beige;
            background-size: cover;
            font-family: tahoma, sans-serif;
        }

        .container {
            margin: 0 auto;
            padding-top: 20px;
            min-height: 460px;
        }

        .header {
            display: flex;
            align-items: center;
            background-color: #4caf50;
            color: white;
            font-size: 16px;
            position: relative;
        }

        .cart {
            height: 50px;
            color: limegreen;
            justify-content: center;
            align-items: center;
            text-align: center;
            font-weight: 1.5;
            font-size: 20px;
        }

        .header span {
            margin-left: 40px;
        }

        .navbar {
            display: flex;
            background-color: #4CAF50;
            align-items: center;
        }

        .navbar a {
            color: white;
            padding: 24px 20px;
            text-decoration: none;
            text-align: center;
        }

        .navbar a:hover {
            background-color: #45a049;
        }

        .navbar .dropdown {
            position: relative;
            display: inline-block;
        }

        .navbar .dropdown-content {
            margin-top: 22px;
            display: none;
            position: absolute;
            background-color: #4CAF50;
            min-width: 160px;
            box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
            z-index: 1;
        }

        .navbar .dropdown-content a {
            color: white;
            padding: 12px 16px;
            text-decoration: none;
            display: block;
            text-align: left;
        }

        .navbar .dropdown-content a:hover {
            background-color: #45a049;
        }

        .navbar .dropdown:hover .dropdown-content {
            display: block;
        }

        .navbar .search-container {
            flex-grow: 1;
            display: flex;
            justify-content: center;
            margin-top: -6px;
            margin-right: 300px;
            margin-left: 200px;

        }

        .navbar input[type=text] {
            padding: 6px;
            margin-top: 8px;
            font-size: 17px;
            border: none;
            border-radius: 4px;
        }

        .navbar .search-container button {
            padding: 6px 10px;
            margin-top: 8px;
            margin-right: 16px;
            background: #ddd;
            font-size: 17px;
            border: none;
            cursor: pointer;
            border-radius: 4px;
        }

        .navbar .search-container button:hover {
            background: #ccc;
        }

        .navbar .icons {
            display: flex;
            align-items: center;
        }

        .navbar .icons a {
            padding: 0 10px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th,
        td {
            padding: 12px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }

        .product-info {
            display: flex;
            align-items: center;
        }

        .product-image {
            width: 70px;
            height: 70px;
            background-color: #ddd;
            background-size: cover;
            margin-right: 10px;
        }

        .product-name {
            font-weight: bold;
        }

        .product-name a {
            color: black;
            text-decoration: none;
        }

        .price,
        .total-price {
            color: red;
            font-weight: bold;
        }

        .quantity-input {
            width: 40px;
            text-align: center;
        }

        .total-row {
            font-weight: bold;
            text-align: right;
        }

        .total-row td {
            padding-top: 20px;
            border-top: 2px solid #f2f2f2;
        }

        .footer-buttons {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding-top: 20px;
        }

        .footer-buttons input[type="checkbox"] {
            margin-right: 5px;
        }

        .button {
            background-color: #4caf50;
            color: white;
            padding: 10px 20px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            font-size: 16px;
        }

        .button:hover {
            background-color: red;
            transform: scale(1.02);
            transition: all 0.3s ease;
        }

        .product-info:hover {
            background-color: #f5f5f5;
            cursor: pointer;
        }

        .notification {
            position: fixed;
            top: 20px;
            right: 20px;
            background-color: rgba(0, 0, 0, 0.7);
            color: white;
            padding: 10px 20px;
            border-radius: 5px;
            font-size: 16px;
            display: none;
            animation: fadeInOut 3s forwards;
        }

        .notification.error {
            background-color: #f44336;
        }

        .notification.success {
            background-color: rgb(10, 241, 164);
        }

        @keyframes fadeInOut {
            0% {
                opacity: 0;
            }

            10% {
                opacity: 1;
            }

            90% {
                opacity: 1;
            }

            100% {
                opacity: 0;
            }
        }

        #cart-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        #cart-table th, #cart-table td {
            padding: 15px;
            text-align: left;
        }

        #cart-table th {
            background-color: #343a40;
            color: #fff;
        }

        #cart-table tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        .product-info {
            display: flex;
            align-items: center;
        }

        .product-image img {
            border-radius: 8px;
            margin-right: 15px;
        }

        .product-name {
            font-weight: 700;
        }

        .price, .total-price {
            color: #28a745;
            font-weight: 700;
        }

        .quantity-input {
            width: 60px;
            padding: 5px;
            border: 1px solid #ced4da;
            border-radius: 4px;
        }

        .delete-btn {
            color: darkred;
            cursor: pointer;
            transition: transform 0.3s ease;
        }

        .delete-btn:hover {
            transform: scale(1.1);
            color: red;
        }

        .total-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 20px;
            font-size: 1.2em;
            font-weight: 700;
            margin-bottom: 20px;
        }

        .buy-btn {
            display: inline-block;
            padding: 10px 20px;
            background-color: red;
            color: #fff;
            text-align: center;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
        }

        .buy-btn:hover {
            background-color: darkred;
        }

        .xoa {
            cursor: pointer;
            border: none;
            border-radius: 7px;
        }

        #footerSection {
            margin-top: 20px;
            margin: auto;
        }

        .custom-bg {
            background-color: #8BC34A;
        }

        .footer-container {
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            align-items: start;
            text-align: center;
            padding: 20px;
            color: white;
        }

        .footer-container h2 {
            font-size: 20px;
            color: white;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .footer-container p {
            margin-bottom: 10px;
        }

        .footer-container a {
            color: white;
            text-decoration: underline;
        }

        .footer-container .contact-info {
            flex: 1;
        }

        .footer-container .map {
            flex: 1;
            display: flex;
            margin-top: -200px;
            margin-left: 100px;
        }

        .footer-container .map iframe {
            width: 250px;
            height: 175px;
            border: 1px solid white;
            margin-top: 10px;
            border-radius: 6px;
        }

        .footer-container .separator {
            display: none;
            margin: 10px 0px;
        }

        .footer-container .credits {
            flex: 1;
            text-align: right;
        }

        .footer-container .credits p {
            margin-bottom: 0.5rem;
        }

        @media (min-width: 768px) {
            .footer-container {
                flex-direction: row;
                text-align: left;
            }

            .footer-container .separator {
                display: block;
                border-left: 1px solid white;
                height: 200px;
            }
        }


        .alert-warning {
            height: 160px;
            color: red;
            font-size: 25px;
            justify-content: center;
            align-items: center;
            text-align: center;
        }

    </style>
</head>

<body>

<div class="container">
    <div class="cart">Giỏ Hàng</div>
    <div class="header">
        <div class="navbar">
            <a href="TrangChu"><i class="fas fa-home"></i> TRANG CHỦ</a>
            <div class="dropdown">
                <a href="#"><i class="fas fa-seedling"></i> SẢN PHẨM <i class="fa fa-caret-down"></i></a>
                <div class="dropdown-content">
                    <a href="category?cid=1">GIỐNG CÂY ĂN QUẢ</a>
                    <a href="category?cid=2">GIỐNG CÂY CẢNH</a>
                    <a href="category?cid=3">GIỐNG CÂY DƯỢC LIỆU</a>
                    <a href="category?cid=4">GIỐNG HOA</a>
                    <a href="category?cid=6">GIỐNG CÂY MỚI LẠ</a>
                    <a href="category?cid=5">GIỐNG CÂY CÔNG NGHIỆP</a>
                </div>
            </div>
            <a href="GioiThieu">GIỚI THIỆU</a>


            <div class="search-container">
                <form method="get" action="TrangChu">
                    <input type="text" placeholder="Tìm kiếm..." id="search-input" name="search"
                           value="${ser}">
                    <button type="submit"><i class="fa fa-search"></i></button>
                </form>
            </div>


            <div class="icons">
                <div id="user-info">
                    <c:choose>
                        <c:when test="${not empty sessionScope.user}">
            <span id="user-welcome" style="color: white;">
                Xin chào, <c:out value="${sessionScope.user.name}"/>
            </span>
                            <i class="fas fa-user" id="user-icon"
                               style="color: white; background-color: #ddd; padding: 7px; border-radius: 100%;"></i>
                            <form method="post" action="logout">
                                <button class="dangxuat" id="logout" type="submit">ĐĂNG XUẤT</button>
                            </form>
                        </c:when>
                        <c:otherwise>
                            <span id="user-welcome" style="display: none; color: white;"></span>
                            <i class="fas fa-user" id="user-icon"
                               style="display: none; color: white; background-color: #ddd; padding: 7px; border-radius: 100%;"></i>
                            <a href="login" id="login-link">ĐĂNG NHẬP</a>
                            <a href="register" id="register-link">ĐĂNG KÝ</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
    <table id="cart-table">
        <tr>
            <th>
                Sản Phẩm
            </th>
            <th>
                Đơn Giá
            </th>
            <th>
                Số Lượng
            </th>
            <th>
                Số Tiền
            </th>
            <th>
                Hành Động
            </th>
        </tr>

        <c:forEach var="p" items="${sessionScope.cart.list}">
            <tr>
                <td>
                    <div class="product-info">
                        <div class="product-image">

                            <a href="ChiTietSanPham?pid=${p.productID}"> <img alt="${p.name}" height="70"
                                                                              src="${p.imageMain}"
                                                                              width="70"/></a>
                        </div>
                        <div class="product-name">
                            <a href="ChiTietSanPham?pid=${p.productID}">${p.name}</a>
                        </div>
                    </div>
                </td>
                <td class="price">
                    <fmt:formatNumber value="${p.price}" type="number" pattern="#,##0 VND"/>
                </td>
                <td>
                    <form id="addToCartForm" action="update-cart" method="post">
                        <input type="hidden" name="pid" value="${p.productID}"/>
                        <input type="hidden" name="kho" value="${p.stock}"/>
                        <input type="number" class="quantity-input" value="${p.quantity}" min="1" name="soluong"
                               onchange="this.form.submit()"/>
                    </form>
                </td>

                <td class="total-price">
                    <fmt:formatNumber value="${p.price * p.quantity}" type="number" pattern="#,##0 VND"/>

                </td>
                <td>
                    <form action="del-cart" method="post" onsubmit="return confirmDelete();">
                        <input type="hidden" name="pid" value="${p.productID}"/>
                        <button class="xoa" type="submit" name="action" value="delete"><i
                                class="fas fa-trash delete-btn"></i>
                        </button>
                    </form>
                </td>
            </tr>
        </c:forEach>
    </table>
    <c:if test="${empty sessionScope.cart.list}">
        <div class="alert-warning">
            Chưa chọn sản phẩm
        </div>
    </c:if>
    <div class="total-container">
   <span>
    Tổng Giá: <fmt:formatNumber value="${sessionScope.cart.total}" type="number" pattern="#,##0 VND"/>
   </span>
        <c:if test="${not empty sessionScope.cart.list}">
            <a class="buy-btn" href="thanhtoan">
                Mua Ngay
            </a>
        </c:if>
        <c:if test="${empty sessionScope.cart.list}">
            <a class="buy-btn" href="TrangChu" title="Bạn chưa có sản phẩm nào trong giỏ hàng, bấm vào đây để về trang chủ">
                Mua Ngay
            </a>
        </c:if>
    </div>
</div>
<div id="footerSection" class="custom-bg">
    <footer class="footer-container">
        <div class="contact-info">
            <h2>Liên hệ chúng tôi</h2>
            <p><i class="fas fa-map-marker-alt"></i> DC: Cư xá C, Trường đại học Nông Lâm, Khu phố 6, Phường
                Linh
                Trung, TP. Thủ Đức, TP. Hồ Chí Minh</p>
            <p><i class="fas fa-phone-alt"></i> SĐT liên hệ: 0707188079</p>
            <p><i class="fas fa-envelope"></i> EMAIL: <a
                    href="mailto:22130000@st.hcmuaf.edu.vn">22130000@st.hcmuaf.edu.vn</a></p>
            <p><i class="fas fa-globe"></i> WEBSITE: <a href="https://OneH2K.vn">https://OneH2K.vn</a></p>
        </div>
        <div class="separator"></div>
        <div class="credits">
            <p>&copy; 2024 OneH2K.Vn |</p>
            <p>Cửa hàng bán cây giống</p>
            <p style="padding-top: 20px;">___________________</p>
            <p class="text-sm" style="padding-top: 40px;">Thiết kế bởi OneH2K</p>
            <div class="map">
                <iframe
                        src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d1959.1072550471563!2d106.78855811579251!3d10.871282831661734!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x317527b5a31ff523%3A0x4ab7fc7a54bec4a4!2zQ8awIHjDoSBDLCBLVFggVHLGsOG7nW5nIMSQ4bqhaSBo4buNYyBOw7RuZyBMw6Jt!5e0!3m2!1svi!2s!4v1732027299631!5m2!1svi!2s"
                        allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
            </div>
        </div>
    </footer>
</div>

</body>
<script>
    function confirmDelete() {
        return confirm("Bạn có chắc chắn muốn xóa sản phẩm này khỏi giỏ hàng?");
    }
</script>
</html>