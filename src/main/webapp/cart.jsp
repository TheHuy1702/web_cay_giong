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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
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
            width: 80%;
            margin: 0 auto;
            padding-top: 20px;
        }

        .header {
            display: flex;
            align-items: center;
            background-color: #4caf50;
            color: white;
            padding: 10px;
            font-size: 18px;
            position: relative;
        }

        .ten {
            color: black;
        }

        .header span {
            margin-left: 40px;
        }

        .back-button {
            position: absolute;
            left: 30px;
            top: 20px;
            color: black;
            font-size: 24px;
            text-decoration: none;
        }

        .table-container {
            margin-top: 20px;
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
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
    </style>
</head>

<body>

<div class="container">
    <div class="header">
        <div class="ten">OneH2K</div>
        <span>Giỏ Hàng</span>
    </div>
    <a class="back-button" href="TrangChu"><i class="fas fa-home"></i></a>

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
    <div class="total-container">
   <span>
    Tổng Giá: <fmt:formatNumber value="${sessionScope.cart.total}" type="number" pattern="#,##0 VND"/>
   </span>
        <a class="buy-btn" href="thanhtoan">
            Mua Ngay
        </a>
    </div>


</div>

</body>
<script>
    function confirmDelete() {
        return confirm("Bạn có chắc chắn muốn xóa sản phẩm này khỏi giỏ hàng?");
    }
</script>
</html>
