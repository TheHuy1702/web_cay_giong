<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="icon" href="Ảnh/anhlogo.jpg" type="image/x-icon">
    <style>
        body {
            font-family: sans-serif, Tahoma;
            background-color: #f4f4f4;
            margin: 0;

        }

        #HeaderSection {
            margin-left: auto;
            margin-right: auto;
            margin-top: 0;
        }

        #ContentSection {
            margin-left: auto;
            margin-right: auto;
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

        .head-content {
            display: flex;
        }


        .revenue-filter {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
        }

        .dashboard-cards {
            display: flex;
            gap: 5px;
            flex-wrap: wrap;
        }

        .card {
            background-color: white;
            padding: 22px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 29%;
            text-align: center;
        }

        .card h3 {
            margin-top: 0;
        }

        .card p {
            font-size: 24px;
            margin: 10px 0;
        }

        .chart-container {
            margin-top: 20px;
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
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
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>

<body>
<div id="HeaderSection">
    <div class="header">
        <h1 class="title">Admin - Dashboard</h1>
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
                    <li class="background"><i class="fas fa-tachometer-alt icon"></i>Dashboard</li>
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
                <li onclick="toggleSubMenu()" style="cursor: pointer;"><i class="fas fa-cog icon"></i>Cài đặt</li>
                <ul id="subMenu" class="submenu">

                    <a href="QuanLiGioiThieu">
                        <li><i class="fas fa-info-circle icon"></i>Chỉnh sửa thông
                            tin giới thiệu
                        </li>
                    </a>

                </ul>
                <form method="post" action="logout">
                    <button class="dangxuat" id="logout" type="submit"><i class="fas fa-sign-out-alt icon"></i>Đăng xuất
                    </button>
                </form>
            </ul>
        </div>
        <div class="content">
            <div class="head-content"></div>
            <h2>Dashboard</h2>
            <div class="dashboard-cards">
                <div class="card">
                    <h3>Tổng số sản phẩm</h3>

                    <p>${productsSL}</p>

                </div>
                <div class="card">
                    <h3>Tổng số đơn hàng</h3>
                    <p>${ordersSL}</p>
                </div>
                <div class="card">
                    <h3>Tổng số khách hàng</h3>
                    <p>${userSL}</p>
                </div>
                <div class="card" id="monthlyRevenueCard">
                    <h3>Doanh thu tháng</h3>
                    <p id="monthlyRevenueTotal"><fmt:formatNumber value="${totalRevenue}" type="number"
                                                                  pattern="#,##0 VND"/></p>
                </div>

                <div class="card" id="topProductCard">
                    <h3>Giống cây bán chạy nhất</h3>
                    <p id="topProduct">${productBestSelling}</p>
                </div>

                <div class="card">
                    <h3>Đơn hàng mới</h3>
                    <p>${newOrders}</p>
                </div>
            </div>
            <div class="chart-container">
                <h3>Biểu đồ doanh thu trong tháng</h3>
                <canvas id="monthlyRevenueChart"></canvas>
                <%
                    // Lấy dữ liệu từ request
                    List<Integer> revenueList = (List<Integer>) request.getAttribute("revenueList");
                %>
            </div>
            <div class="chart-container">
                <h3>Biểu đồ số lượng sản phẩm bán ra</h3>
                <canvas id="productSalesChart"></canvas>
                <%
                    Map<String, Integer> salesData = (Map<String, Integer>) request.getAttribute("salesData");
                    String labels = "";
                    String data = "";
                    String colors = "";

                    // Màu sắc cho từng danh mục
                    String[] backgroundColors = {
                            "rgba(255, 99, 132, 0.2)", "rgba(54, 162, 235, 0.2)", "rgba(255, 206, 86, 0.2)",
                            "rgba(75, 192, 192, 0.2)", "rgba(153, 102, 255, 0.2)", "rgba(255, 159, 64, 0.2)"
                    };
                    String[] borderColors = {
                            "rgba(255, 99, 132, 1)", "rgba(54, 162, 235, 1)", "rgba(255, 206, 86, 1)",
                            "rgba(75, 192, 192, 1)", "rgba(153, 102, 255, 1)", "rgba(255, 159, 64, 1)"
                    };
                    int colorIndex = 0;

                    for (Map.Entry<String, Integer> entry : salesData.entrySet()) {
                        labels += "\"" + entry.getKey() + "\",";
                        data += entry.getValue() + ",";
                        colors += "\"" + backgroundColors[colorIndex % backgroundColors.length] + "\",";
                        colorIndex++;
                    }

                    labels = labels.endsWith(",") ? labels.substring(0, labels.length() - 1) : labels;
                    data = data.endsWith(",") ? data.substring(0, data.length() - 1) : data;
                    colors = colors.endsWith(",") ? colors.substring(0, colors.length() - 1) : colors;
                %>
            </div>
        </div>
    </div>
</div>
</body>
<script>
    // Truyền dữ liệu từ backend sang frontend
    const revenueData = <%= revenueList %>; // Chuyển List<Integer> sang mảng JavaScript

    const monthlyRevenueCtx = document.getElementById('monthlyRevenueChart').getContext('2d');
    const monthlyRevenueChart = new Chart(monthlyRevenueCtx, {
        type: 'bar',
        data: {
            labels: ['Tuần 1', 'Tuần 2', 'Tuần 3', 'Tuần 4'], // Nhãn tuần
            datasets: [{
                label: 'Doanh thu (VND)',
                data: revenueData, // Sử dụng dữ liệu từ backend
                backgroundColor: 'rgba(75, 192, 192, 0.2)',
                borderColor: 'rgba(75, 192, 192, 1)',
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });

    const productSalesCtx = document.getElementById('productSalesChart').getContext('2d');
    const productSalesChart = new Chart(productSalesCtx, {
        type: 'pie',
        data: {
            labels: [<%= labels %>],
            datasets: [{
                label: 'Số lượng sản phẩm bán ra',
                data: [<%= data %>],
                backgroundColor: [<%= colors %>],
                borderColor: [<%= colors.replace("0.2", "1") %>],
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: {
                    position: 'top',
                },
                tooltip: {
                    callbacks: {
                        label: function (tooltipItem) {
                            return tooltipItem.label + ': ' + tooltipItem.raw + ' sản phẩm';
                        }
                    }
                }
            }
        }
    });

    <%--const labels = <%= request.getAttribute("labels") %>; // Nhãn (tháng)--%>
    <%--const data = <%= request.getAttribute("data") %>; // Dữ liệu khách hàng--%>

    <%--// Vẽ biểu đồ bằng Chart.js--%>
    <%--const newCustomersCtx = document.getElementById('newCustomersChart').getContext('2d');--%>
    <%--const newCustomersChart = new Chart(newCustomersCtx, {--%>
    <%--    type: 'line',--%>
    <%--    data: {--%>
    <%--        labels: labels, // Sử dụng nhãn từ JSP--%>
    <%--        datasets: [{--%>
    <%--            label: 'Số lượng khách hàng mới',--%>
    <%--            data: data, // Sử dụng dữ liệu từ JSP--%>
    <%--            backgroundColor: 'rgba(153, 102, 255, 0.2)',--%>
    <%--            borderColor: 'rgba(153, 102, 255, 1)',--%>
    <%--            borderWidth: 1--%>
    <%--        }]--%>
    <%--    },--%>
    <%--    options: {--%>
    <%--        scales: {--%>
    <%--            y: {--%>
    <%--                beginAtZero: true--%>
    <%--            }--%>
    <%--        }--%>
    <%--    }--%>
    <%--});--%>
</script>
</html>