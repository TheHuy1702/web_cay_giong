<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết đơn hàng</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"></link>
    <style>
        body {
            font-family: Tahoma, sans-serif;
            background-color: #f3f4f6;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 800px;
            margin: 40px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            font-size: 2rem;
            margin-bottom: 20px;
        }

        .order-details, .product-details {
            margin-bottom: 20px;
        }

        .order-details p, .product-details p {
            font-size: 1rem;
            margin-bottom: 10px;
        }

        .product-item {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
            padding: 10px;
            border: 1px solid #e5e7eb;
            border-radius: 8px;
            background-color: #f9fafb;
        }

        .product-item img {
            width: 100px;
            height: 100px;
            object-fit: cover;
            border-radius: 8px;
            margin-right: 20px;
        }

        .product-item div {
            flex: 1;
        }

        .total-amount {
            font-size: 1.25rem;
            font-weight: bold;
            margin-bottom: 20px;
        }

        .button-container {
            display: flex;
            justify-content: space-between;
        }

        .button {
            display: block;
            width: 48%;
            padding: 15px;
            text-align: center;
            background-color: #4CAF50;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: bold;
            border: none;
            cursor: pointer;
        }

        .button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Chi tiết đơn hàng</h2>
    <div class="order-details">
        <p><strong>Mã đơn hàng:</strong> ${order.orderId}</p>
        <p><strong>Trạng thái đơn hàng:</strong> ${order.status}</p>
        <p><strong>Thời gian đặt hàng:</strong> ${order.orderDate}</p>
        <p><strong>Tên người mua:</strong> ${customer.nameCustomer}</p>
        <p><strong>Số điện thoại:</strong> ${customer.phone}</p>
        <p><strong>Địa chỉ:</strong> ${customer.address}, ${customer.district}, ${customer.city}</p>
    </div>
    <div class="product-details">
        <h3 class="text-2xl font-semibold mb-4">Chi tiết sản phẩm</h3>
        <c:forEach var="oi" items="${orderItems}">
            <div class="product-item">
                <img src="${products[oi.productID-1].imageMain}"
                     alt="Hình ảnh sản phẩm ${products[oi.productID-1].name}">
                <div>
                    <p><strong>Mã chi tiết đơn hàng:</strong> ${oi.itemID}</p>
                    <p><strong>Mã sản phẩm:</strong> ${products[oi.productID-1].productID}</p>
                    <p><strong>Tên sản phẩm:</strong> ${products[oi.productID-1].name}</p>
                    <p><strong>Số lượng:</strong> ${oi.quantity}</p>
                    <p><strong>Tổng giá:</strong> ${oi.quantity} x <fmt:formatNumber value="${products[oi.productID-1].price}" type="number" pattern="#,##0 VND"/>
                        = <fmt:formatNumber value="${oi.quantity*products[oi.productID-1].price}" type="number" pattern="#,##0 VND"/></p>
                </div>
            </div>
        </c:forEach>
    </div>
    <div class="total-amount">
        <p><strong>Tổng tiền:</strong> <fmt:formatNumber value="${order.totalAMount}" type="number"
                                                         pattern="#,##0 VND"/></p>
    </div>
    <div class="button-container">
        <a href="QuanLyDonHang" class="button">Quay lại</a>
        <button class="button" onclick="printInvoice()">In hóa đơn</button>
    </div>
</div>

<script>
    function printInvoice() {
        const printContents = `
            <h2>Hóa đơn</h2>
            <p><strong>Mã đơn hàng:</strong> ${order.orderId}</p>
            <hr style="border: 1px dashed  #ccc; margin: 20px 0;">
            <p><strong>Từ:</strong> Cư xá C, Trường đại học Nông Lâm, Khu phố 6, Phường Linh Trung, TP. Thủ Đức, TP. Hồ Chí Minh</p>
            <p><strong>Đến:</strong> ${customer.nameCustomer}, ${customer.address}, ${customer.district}, ${customer.city}</p>
            <hr style="border: 1px dashed  #ccc; margin: 20px 0;">
            <h3>Nội dung hàng (Tổng số lượng sản phẩm:${totalQuantity})</h3>
            <c:forEach var="oi" items="${orderItems}">
                    <p> ${products[oi.productID-1].name},Giá: <fmt:formatNumber value="${products[oi.productID-1].price}" type="number" pattern="#,##0 VND"/>, SL: ${oi.quantity}, Thành tiền:<fmt:formatNumber value="${oi.quantity*products[oi.productID-1].price}" type="number" pattern="#,##0 VND"/></p>
            </c:forEach>
            <hr style="border: 1px dashed  #ccc; margin: 20px 0;">
            <p><strong>Tổng tiền thu:</strong><fmt:formatNumber value="${order.totalAMount}" type="number" pattern="#,##0 VND"/></p>
        `;

        const originalContents = document.body.innerHTML;
        document.body.innerHTML = printContents;
        window.print();
        document.body.innerHTML = originalContents;
    }
</script>
</body>
</html>