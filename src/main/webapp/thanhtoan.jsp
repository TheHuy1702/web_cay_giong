<%@ page import="org.json.JSONObject" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="Ảnh/anhlogo.jpg" type="image/x-icon">
    <title>Thanh Toán</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function () {
            // Lấy danh sách tỉnh khi trang được tải
            $.get("address?type=provinces", function (data) {
                $.each(data, function (index, province) {
                    $('#provinceSelect').append($('<option>', {
                        value: province.ProvinceID,
                        text: province.ProvinceName
                    }));
                });
            });

            // Khi tỉnh được chọn, lấy danh sách quận
            $('#provinceSelect').change(function () {
                var provinceId = $(this).val();
                // console.log("Selected provinceId:", provinceId);
                $('#districtSelect').empty().append($('<option>', {value: "", text: "Chọn quận"}));
                $('#wardSelect').empty().append($('<option>', {value: "", text: "Chọn xã"}));

                if (provinceId) {
                    $.get("address?type=districts&id=" + provinceId, function (data) {
                        $.each(data, function (index, district) {
                            $('#districtSelect').append($('<option>', {
                                value: district.id,
                                text: district.name
                            }));
                        });
                    }).fail(function () {
                        console.log("Lỗi khi lấy quận.");
                    });
                }
            });

            // Khi quận được chọn, lấy danh sách xã/phường
            $('#districtSelect').change(function () {
                var districtId = $(this).val();
                $('#wardSelect').empty().append($('<option>', {value: "", text: "Chọn xã"}));

                if (districtId) {
                    $.get("address?type=wards&id=" + districtId, function (data) {
                        $.each(data, function (index, ward) {
                            $('#wardSelect').append($('<option>', {
                                value: ward.id,
                                text: ward.name
                            }));
                        });
                    }).fail(function () {
                        console.log("Lỗi khi lấy xã/phường.");
                    });
                }
            });
            // Cập nhật tên khi tỉnh, quận, xã được chọn
            $('#provinceSelect, #districtSelect, #wardSelect').change(function () {
                $('#provinceName').val($('#provinceSelect option:selected').text());
                $('#districtName').val($('#districtSelect option:selected').text());
                $('#wardName').val($('#wardSelect option:selected').text());
            });
        });
    </script>
    <style>
        body {
            margin: 0;
            padding: 0;
            background-color: beige;
            background-size: cover;
            font-family: sans-serif, Tahoma;
        }

        .container {
            width: 80%;
            margin: 0 auto;
            padding-top: 20px;
        }

        .header {
            display: flex;
            align-items: center;
            background-color: #4CAF50;
            color: white;
            padding: 10px;
            font-size: 18px;
        }

        .header a {
            color: black;
            text-decoration: none;
            margin-right: 10px;
            font-size: 24px;
            position: absolute;
            left: 30px;
            top: 20px;
        }

        .header span {
            margin-left: 50px;
        }

        .address-section,
        .payment-section,
        .total-section {
            background-color: white;
            padding: 20px;
            margin-top: 10px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .address-info {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .change-link {
            color: #4CAF50;
            text-decoration: none;
            font-weight: bold;
            cursor: pointer;
        }

        .table-container {
            margin-top: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th,
        td {
            padding: 12px;
            text-align: left;
            background-color: white;
        }

        .product-info {
            display: flex;
            align-items: center;
        }

        .product-image {
            width: 80px;
            height: 80px;
            background-color: #ddd;
            display: inline-block;
            margin-right: 10px;
            background-size: cover;
        }

        .product-name {
            font-weight: bold;
        }

        .price,
        .total-price {
            color: red;
            font-weight: bold;
        }

        .payment-methods {
            display: flex;
            justify-content: space-around;
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            margin-top: 20px;
        }

        .payment-methods button {
            background-color: #f0f0f0;
            border: 1px solid #ccc;
            padding: 10px 20px;
            cursor: pointer;
            border-radius: 5px;
            color: #333;
            margin: 5px;
        }

        .payment-methods button:hover {
            background-color: #45a049;
            transform: scale(1.02);
            transition: all 0.3s ease;
        }

        .payment-methods button.selected {
            background-color: #4CAF50;
            color: white;
        }

        .payment-methods button.selected::after {
            content: "✓";
            margin-left: 8px;
            color: white;
            font-weight: bold;
        }

        .total-section {
            font-weight: bold;
            font-size: 16px;
        }

        .total-section .order-button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            font-size: 16px;
            display: block;
            margin-top: 20px;
            text-align: center;
        }

        .total-section .order-button:hover {
            background-color: red;
            transform: scale(1.02);
        }

        .popup-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            justify-content: center;
            align-items: center;
            z-index: 1000;
        }

        .popup-content {
            width: 400px;
            padding: 20px;
            background-color: white;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
            display: flex;
            flex-direction: column;
            align-items: stretch;
        }

        .popup-header {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 15px;
            text-align: center;
        }

        .popup-input {
            width: 100%;
            padding: 8px;
            margin-top: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }

        .popup-buttons {
            display: flex;
            justify-content: space-between;
            margin-top: 10px;
        }

        .popup-buttons button {
            width: 48%;
            padding: 10px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            font-size: 14px;
        }

        .cancel-button {
            background-color: #ccc;
            color: white;
            transition: transform 0.5s ease;
        }

        .cancel-button:hover {
            background-color: darkred;
            transform: scale(1.05);
        }

        .save-button {
            margin: 5px;
            background-color: #4caf50;
            color: white;
            transition: transform 0.5s ease;
        }

        .save-button:hover {
            background-color: #0a670d;
            transform: scale(1.05);
        }

        .confirm-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            justify-content: center;
            align-items: center;
            z-index: 1000;
        }

        .confirm-content {
            background: white;
            padding: 20px;
            border-radius: 5px;
            text-align: center;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
        }

        .confirm-buttons {
            margin-top: 15px;
        }

        .confirm-button,
        .cancel-button {
            padding: 10px 20px;
            margin: 5px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .confirm-button {
            background-color: #4CAF50;
            color: white;
        }

        .confirm-buttons .confirm-button, .confirm-buttons .cancel-button {
            transition: transform 0.5s ease;
        }

        .confirm-buttons .confirm-button:hover, .confirm-buttons .cancel-button:hover {
            transform: scale(1.1);
        }

        .cancel-button {
            background-color: #f44336;
            color: white;
        }

        #bank-info {
            display: none;
            padding: 10px;
            margin-top: 10px;
            background-color: white;
        }

        #card-info {
            display: none;
            padding: 10px;
            margin-top: 10px;
            background-color: white;
        }

        .ok-button {
            cursor: pointer;
            font-size: 18px;
            width: 35%;
            background-color: #45a049;
            margin: auto;
            border-radius: 5px;
            border: none;
            padding-top: 5px;
            transition: transform 0.5s ease;
            color: white;
        }

        .ok-button:hover {
            background-color: red;
            transform: scale(1.1);
        }

        .unshow {
            display: none;
        }

        .popup-input,
        select {
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 14px;
        }
        .discount-section {
            background-color: white;
            padding: 20px;
            margin-top: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .discount-label {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 10px;
            display: block;
        }

        .discount-form {
            display: flex;
            align-items: center;
        }

        .discount-select {
            flex: 1;
            padding: 10px;
            margin-right: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
        }

        .apply-button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }

        .apply-button:hover {
            background-color: #45a049;
        }
    </style>
</head>

<body>

<div class="container">
    <div class="header">
        <a href="show-cart" class="back-btn"><i class="fas fa-arrow-left"></i></a>
        <span>OneH2K / Thanh toán</span>
    </div>

    <div class="address-section">
        <div class="address-info">

            <div id="address-display">
                <p><strong>Địa chỉ nhận hàng</strong></p>
                <p> ${customer.nameCustomer} - ${customer.phone}</p>
                <p>${customer.address}, ${customer.district}, ${customer.city}</p>
            </div>

            <c:if test="${empty customer}">
                <p>Thêm thông tin khách hàng</p>
            </c:if>

            <a class="change-link" onclick="openPopup()">Thay Đổi</a>
        </div>
    </div>

    <div class="popup-overlay" id="address-popup">
        <form method="post" action="UpdateAddress">
            <div class="popup-content">
                <div class="popup-header">Thay đổi địa chỉ nhận hàng</div>
                <input type="text" id="full-name" class="popup-input" placeholder="Họ tên người nhận" name="fullName"
                       required>
                <input type="text" id="phone-number" class="popup-input" placeholder="Số điện thoại" name="phoneNumber"
                       required>
                <input type="text" id="address" class="popup-input" placeholder="Số nhà, tên đường"
                       name="address"
                       required>
                <input type="hidden" id="provinceName" name="provinceName">
                <input type="hidden" id="districtName" name="districtName">
                <input type="hidden" id="wardName" name="wardName">

                <select id="provinceSelect" name="provinceId">
                    <option value="">Chọn tỉnh</option>
                </select>
                <label for="districtSelect">Quận/Huyện:</label>
                <select id="districtSelect" name="districtId">
                    <option value="">Chọn quận</option>
                </select>
                <label for="wardSelect">Xã/Phường:</label>
                <select id="wardSelect" name="wardCode">
                    <option value="">Chọn xã</option>
                </select>

                <div class="popup-buttons">
                    <button type="button" class="cancel-button" onclick="closePopup()">Hủy</button>
                    <button type="submit" class="save-button">Lưu</button>
                </div>
            </div>
        </form>
    </div>


    <div class="table-container">
        <table>
            <thead>
            <tr>
                <th>Sản phẩm</th>
                <th>Đơn giá</th>
                <th>Số lượng</th>
                <th>Thành tiền</th>
            </tr>
            </thead>
            <tbody id="product-list">

            <c:forEach var="p" items="${sessionScope.cart.list}">

                <form method="post" action="UpdateAddress">
                    <input type="hidden" id="prodName" name="prodName" value="${p.name}">
                    <input type="hidden" id="prodQuantity" name="prodQuantity" value="${p.quantity}">
                </form>

                <tr>
                    <td>
                        <div class="product-info">
                            <div class="product-image">
                                <img alt="${p.name}" height="70"
                                     src="${p.imageMain}"
                                     width="70"/>
                            </div>
                            <div class="product-name">
                                    ${p.name}
                            </div>
                        </div>
                    </td>
                    <td class="price">
                        <fmt:formatNumber value="${p.price}" type="number" pattern="#,##0 VND"/>
                    </td>
                    <td>
                            ${p.quantity}
                    </td>
                    <td class="total-price">
                        <fmt:formatNumber value="${p.price * p.quantity}" type="number" pattern="#,##0 VND"/>
                    </td>
                </tr>
            </c:forEach>


            </tbody>
        </table>
    </div>
    <div class="discount-section">
        <label for="discountSelect" class="discount-label">Chọn mã giảm giá:</label>
        <form action="ApplyDiscount" method="POST" class="discount-form">
            <select name="code" id="discountSelect" class="discount-select">
                <option value="0.0">Chọn mã giảm giá</option>
                <c:forEach var="discount" items="${availableDiscounts}">
                    <option value="${discount.code}">${discount.description} - Giá trị đơn hàng tối thiểu <fmt:formatNumber value="${discount.minOrderValue}"
                                                                                                                                                      type="number" pattern="#,##0 VND"/></option>
                </c:forEach>
            </select>
            <button type="submit" class="apply-button">Áp dụng</button>
        </form>
    </div>

    <div class="total-section">
        <table>
            <tr>
                <td>Tổng tiền hàng:</td>
                <td id="total-price" class="total-price"><fmt:formatNumber value="${sessionScope.cart.total}"
                                                                           type="number" pattern="#,##0 VND"/></td>
            </tr>
            <tr>
                <td>Phí vận chuyển:</td>
                <td class="total-price">
                    <p><fmt:formatNumber
                            value="${serviceFee}" type="number" pattern="#,##0 VND"/></p>
                </td>
            </tr>
            <tr>
                <td>Giảm giá:</td>
                <td class="total-price">
                    <c:if test="${not empty param.giamGia}">
                        <p><fmt:formatNumber value="${param.giamGia}" type="number" pattern="#,##0 VND"/></p>
                    </c:if>
                    <c:if test="${empty param.giamGia}">
                        <p><fmt:formatNumber value="0" type="number" pattern="#,##0 VND"/></p>
                    </c:if>
                </td>
            </tr>
            <tr>
                <td><strong>Tổng thanh toán:</strong></td>
                <td id="final-total" class="total-price"><strong><fmt:formatNumber
                        value="${sessionScope.cart.total+serviceFee+param.giamGia}" type="number" pattern="#,##0 VND"/></strong></td>
            </tr>
        </table>
        <form action="Order" method="POST" onsubmit="return confirmThanhToan();">
            <input type="hidden" name="orderTotalAmount"  value="${sessionScope.cart.total+serviceFee+param.giamGia}"/>
            <input type="hidden" name="orderShipFee" value="${serviceFee}"/>
            <button class="order-button" type="submit">Đặt hàng</button>
        </form>
    </div>
</div>
</body>

<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/js/all.min.js"></script>


<script>
    function openPopup() {
        document.getElementById('address-popup').style.display = 'flex';
    }

    function closePopup() {
        document.getElementById('address-popup').style.display = 'none';
    }

    function confirmThanhToan() {
        return confirm("Bạn có chắc chắn muốn đặt hàng hay không?");
    }
</script>

</html>
