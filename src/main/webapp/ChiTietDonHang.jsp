<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết đơn hàng</title>
    <style>
        body {
            font-family: Tahoma, sans-serif;
            background-color: beige;
        }

        #detailsContent {
            width: 50%;
            margin: 0 auto;
            border: 5px solid #ccc;
            padding: 20px;
            background-color: #ddd;
        }

        h2 {
            text-align: center;
        }

        p {
            margin-bottom: 10px;
        }

        button {
            margin-top: 10px;
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 5px;
        }

        button:hover {
            background-color: #45a049;
        }

        a {
            color: white;
            text-decoration: none;
        }

        a:hover {
            color: white;
        }
    </style>
</head>
<body>
<div id="detailsContent">
    <h2>Chi tiết đơn hàng</h2>
    <p><strong>Mã đơn hàng: ${order.orderId}</strong></p>
    <p><strong>Trạng thái đơn hàng: ${order.status}</strong></p>
    <p><strong>Thời gian đặt hàng: ${order.orderDate}</strong></p>
    <p><strong>Tên người mua: ${customer.nameCustomer}</strong></p>
    <p><strong>Số điện thoại: ${customer.phone}</strong></p>
    <p><strong>Địa chỉ: ${customer.address}, ${customer.district}, ${customer.city}</strong></p>
    <c:forEach var="oi" items="${orderItems}">
        <p><strong>Tên sản phẩm: ${products[oi.productID-1].name}</strong></p>
        <p><strong>Số lượng: ${oi.quantity}</strong></p>
    </c:forEach>
    <p><strong>Tổng tiền: <fmt:formatNumber value="${order.totalAMount}" type="number" pattern="#,##0 VND"/></strong>
    </p>
    <button><a href="QuanLyDonHang">Quay lại</a></button>
</div>
</body>
</html>