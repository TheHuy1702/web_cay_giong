<%--
  Created by IntelliJ IDEA.
  User: Khương
  Date: 1/8/2025
  Time: 6:52 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giới thiệu - OnH2K</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="icon" href="Ảnh/anhlogo.jpg" type="image/x-icon">
    <style>
        body {
            margin: 0;
            font-family: sans-serif, Tahoma;
            background-color: #ddd;
        }

        #headerSection {
            margin: auto;
        }

        #contentSection {
            margin: auto;
        }

        #footerSection {
            margin: auto;
        }

        .header {
            background-color: #8BC34A;
            padding: 10px;
            height: 150px;
            text-align: center;
            color: white;
            overflow: hidden;
            /* Ẩn nội dung ra ngoài khung */
        }

        .header .logo {
            font-size: 40px;
            font-weight: bold;
            background: linear-gradient(90deg, rgb(114, 249, 254), #FAEBD7, hotpink, #FFFF00, #FF4500, #00FFFF, #7B68EE, #00B0FF);
            /* Gradient màu sắc */
            background-clip: text;
            -webkit-background-clip: text;
            color: transparent;
            text-shadow: -3px -3px 1px #FFFFE0;
            position: relative;
            display: inline-block;
            padding-top: 50px;
            animation: bounce 1s infinite;
            /* Hiệu ứng nhảy */
        }

        .header .heart {
            color: #45a049;
            font-size: 26px;
            position: absolute;
            top: 27px;
            transform: rotate(45deg);
            /* Xoay 45 độ */

        }

        .tree-icon {
            color: #4CAF50;
            font-size: 26px;
            position: absolute;
        }

        .tree-left {
            transform: rotate(-80deg);
            /* Xoay 80 độ */
            left: -30px;
            /* Đưa ra ngoài logo */

        }

        .tree-right {
            transform: rotate(45deg);
            /* Xoay 45 độ */
            right: -45px;
            /* Đưa ra ngoài logo */
            top: 60px;
        }

        .tree-top {


            transform: rotate(-10deg);
            /* Xoay 10 độ */
            top: 25px;
        }

        .header p {
            margin: 0;
            font-size: 14px;
        }

        .navbar {
            display: flex;
            background-color: #4CAF50;
            padding: 0px;
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
            margin-top: 24px;
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
            padding-left: 100px;
            padding-right: 100px;
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

        /* gợi ý cho tìm kiếm */
        .search-suggestions {
            margin-right: 54px;
            margin-top: 38px;
            position: absolute;
            background-color: #ffffff;
            border: 1px solid #ccc;
            /* Màu viền tương tự các phần khác */
            border-radius: 5px;
            /* Thêm bo góc để mềm mại */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            /* Thêm hiệu ứng đổ bóng */
            max-height: 250px;
            /* Tăng chiều cao tối đa để phù hợp hơn */
            overflow-y: auto;
            width: 220px;
            /* Để phù hợp với chiều rộng container */
            z-index: 200;
            /* Tăng z-index để chắc chắn hiển thị trên các thành phần khác */
        }

        .search-suggestions a {
            display: block;
            padding: 10px 12px;
            /* Điều chỉnh padding cho cân đối */
            font-size: 14px;
            /* Cỡ chữ nhỏ gọn */
            text-decoration: none;
            color: #333;
            /* Màu chữ đậm hơn một chút */
            transition: background-color 0.3s ease, color 0.3s ease;
            /* Hiệu ứng mượt */
            text-align: left;
        }

        .search-suggestions a:hover {
            background-color: #f5f5f5;
            /* Màu nền khi hover đồng bộ với giao diện */
            color: #45a049;
            /* Đồng bộ với màu hover của navbar */
        }

        .navbar .icons {
            display: flex;
            align-items: center;
        }

        .navbar .icons a {
            padding: 0 10px;
        }

        /* .navbar .search-container .fa-search {
            display: flex;
        } */
        .main-content section {
            /*margin-bottom: 20px;*/
            padding: 20px;
            background-color: white;
            border-bottom: 1px solid    black;
            /*border-radius: 8px;*/
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        /*.main-content > section {*/
        /*    margin-top: 20px;*/
        /*}*/

        .breadcrumb {
            padding-top: 10px;
            padding-bottom: 10px;
            border-bottom: 1px solid    black;
            background-color: white;
        }

        .breadcrumb a:first-child {
            text-decoration: none;
            color: black;
            margin-left: 20px;
        }

        .breadcrumb a:first-child:hover {
            cursor: pointer;
            color: #45a049;

            /* Thay đổi màu sắc khi di chuột */
        }

        h2 {
            color: #4CAF50;
        }

        ul {
            list-style-type: none;
            padding: 0;
        }

        ul li {
            padding: 5px 0;
        }

        .custom-bg {
            background-color: #8BC34A;
            border-top-left-radius: 8px;
            border-top-right-radius: 8px;
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

        .text-color {
            color: red;
            display: inline;
        }

        .text {
            display: inline;
        }

        section:last-child h2 {
            color: #f34545;
        }

        section:last-child b {
            display: flex;
            justify-content: center;
            align-items: center;
            background: linear-gradient(90deg, #ff6347, #ffa500, #ffd700, #adff2f, #32cd32);
            background-clip: text;
            -webkit-background-clip: text;
            /* Hỗ trợ cho trình duyệt WebKit */
            -webkit-text-fill-color: transparent;
            /* Ẩn màu chữ gốc */
            animation-name: changeColor;
            animation-duration: 3s;
            animation-timing-function: ease-in-out;
            animation-iteration-count: infinite;
            font-size: 20px;
        }

        section:last-child p {
            font-weight: 550;
            color: rgb(110, 106, 106);
        }

        section .highlight {
            font-size: 20px;
            font-weight: bold;
            background: linear-gradient(90deg, #76FF03, #ea7cdf, #23a8ea, #FFEA00, #FF6D00, #00B0FF);
            background-clip: text;
            -webkit-background-clip: text;
            color: transparent;
            /* Ẩn màu chữ gốc */
            text-shadow: 2px 2px 5px rgba(255, 255, 255, 0.8);
        }

        .title-highlight {
            font-size: 30px;
            font-weight: bold;
            background: linear-gradient(90deg, #32cd32, #e651d7, #75b2d0, #d8ce5a, #1f36e3ba, #14df2f);
            background-clip: text;
            -webkit-background-clip: text;
            color: transparent;
            /* Ẩn màu chữ gốc */
            text-shadow: 2px 2px 5px rgba(255, 255, 255, 0.8);
        }

        @keyframes changeColor {
            0% {
                transform: scale(1);
            }

            50% {
                transform: scale(1.05);
            }

            100% {
                transform: scale(1);
            }
        }

        /* quay về đầu trang*/
        .back-to-top {
            position: fixed;
            background: linear-gradient(45deg, #6bff6b, rgb(126, 189, 206), white);
            bottom: -60px;
            right: 20px;
            border: none;
            color: green;
            padding: 10px;
            border-radius: 5px;
            cursor: pointer;
            display: none;
            display: flex;
            flex-direction: column;
            align-items: center;
            transition: bottom 0.5s ease, transform 0.5s ease;
            box-shadow: 0px 0px 14px 0px rgb(255, 255, 255);

        }

        .back-to-top:hover {
            background-color: #8BC34A;
            color: white;
            transform: scale(1.1);
        }

        /*chữ chạy từ trái sang phải*/
        .marquee-content {
            animation: marquee 20s linear infinite;
        }

        @keyframes marquee {
            0% {
                transform: translateX(100%);
            }

            100% {
                transform: translateX(-100%);
            }
        }

        .emoji {
            font-size: 30px;
            /* Kích thước biểu tượng */
            position: relative;
            /* Để định vị màu trái tim */
            display: inline-block;
            /* Để hiệu ứng hoạt động chính xác */
            animation: bounce 1s infinite;
            /* Hiệu ứng nhảy */
        }

        .emoji .face {
            color: gold;
            /* Màu hồng cho mặt cười */
        }

        .emoji .heart {
            font-size: 16px;
            /* Kích thước trái tim */
            color: red;
            /* Màu đỏ cho trái tim */
            position: absolute;
            /* Đặt trái tim lên trên mặt cười */
            left: 16px;
            /* Điều chỉnh vị trí của trái tim */
            top: 16px;
            /* Đặt trái tim ở vị trí thích hợp */
        }

        @keyframes bounce {

            0%,
            20%,
            50%,
            80%,
            100% {
                transform: translateY(0);
                /* Tại vị trí ban đầu */
            }

            40% {
                transform: translateY(-20px);
                /* Nhảy lên 20px */
            }

            60% {
                transform: translateY(-10px);
                /* Nhảy lên 10px */
            }
        }

        .emoji2 {
            font-size: 30px;
            /* Kích thước biểu tượng */
            position: relative;
            /* Để định vị màu trái tim */
            display: inline-block;
            /* Để hiệu ứng hoạt động chính xác */
            animation: bounce2 1s infinite;
            /* Hiệu ứng nhảy */
        }

        .emoji2 .face {
            color: gold;
            /* Màu hồng cho mặt cười */
        }

        .emoji2 .heart {
            font-size: 16px;
            /* Kích thước trái tim */
            color: red;
            /* Màu đỏ cho trái tim */
            position: absolute;
            /* Đặt trái tim lên trên mặt cười */
            left: 16px;
            /* Điều chỉnh vị trí của trái tim */
            top: 16px;
            /* Đặt trái tim ở vị trí thích hợp */
        }

        @keyframes bounce2 {

            0%,
            20%,
            50%,
            80%,
            100% {
                transform: translateY(-10px);
                /* Tại vị trí ban đầu */
            }

            40% {
                transform: translateY(20px);
                /* Nhảy lên 20px */
            }

            60% {
                transform: translateY(0px);
                /* Nhảy lên 10px */
            }
        }

        /* CSS cho nút Đăng Xuất */
        .dangxuat {
            background-color: #4CAF50; /* Màu nền cam */
            color: white; /* Màu chữ trắng */
            padding: 10px 20px; /* Khoảng cách bên trong */
            border: none; /* Không viền */
            border-radius: 5px; /* Bo góc */
            font-size: 16px; /* Kích thước chữ */
            cursor: pointer; /* Con trỏ chuột khi hover */
            transition: background-color 0.3s, transform 0.3s; /* Hiệu ứng chuyển màu và phóng to */
        }

        .dangxuat:hover {
            color: red; /* Màu nền khi hover */
            transform: scale(1.01); /* Phóng to khi hover */
        }
    </style>
</head>

<body>
<div id="headerSection">
    <div class="header">
        <div class="logo">
            <i class="fas fa-tree tree-icon tree-left"></i>
            <i class="fas fa-tree tree-icon tree-right"></i>
            <i class="fas fa-tree tree-icon tree-top"></i>
            OneH2K <i class="fas fa-heart heart"></i> <i class="fas fa-heart heart"></i> <i
                class="fas fa-heart heart"></i>
        </div>
        <div class="marquee-content">Chào mừng bạn đến với cửa hàng bán cây giống số 1 Việt Nam
            <div class="emoji">
                <i class="fas fa-kiss-wink-heart face"></i>
                <i class="fas fa-heart heart"></i>
            </div>
            <div class="emoji2">
                <i class="fas fa-kiss-wink-heart face"></i>
                <i class="fas fa-heart heart"></i>
            </div>
            <div class="emoji">
                <i class="fas fa-kiss-wink-heart face"></i>
                <i class="fas fa-heart heart"></i>
            </div>
            <div class="emoji">
                <i class="fas fa-kiss-wink-heart face" style="margin-left: 520px;"></i>
                <i class="fas fa-heart heart" style="margin-left: 520px;"></i>
            </div>
            <div class="emoji2">
                <i class="fas fa-kiss-wink-heart face"></i>
                <i class="fas fa-heart heart"></i>
            </div>
            <div class="emoji">
                <i class="fas fa-kiss-wink-heart face"></i>
                <i class="fas fa-heart heart"></i>
            </div>
        </div>
    </div>
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
        </div>
        <div class="icons">
            <a href="show-cart"><span>Giỏ Hàng ${sessionScope.cart!=null?sessionScope.cart.totalQuantity:0} <i
                    class="fas fa-shopping-cart"></i></span></a>
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
<div id="contentSection" class="main-content">
    <div class="breadcrumb">
        <a href="TrangChu">Trang chủ</a>/<a><b>Giới thiệu</b></a>
    </div>

    <section>
        <div>
            <div>
                <h2>${introductionList[0].sectionName}</h2>
            </div>
            <p>${introductionList[0].content}</p>
        </div>
    </section>
    <section>
        <div>
            <h2>${introductionList[1].sectionName}</h2>
            <p>${introductionList[1].content}</p>
        </div>
    </section>

    <section>
        <div>
            <h2>${introductionList[2].sectionName}</h2>
            <p>${introductionList[2].content}</p>
        </div>
    </section>

    <section>
        <div id="customerService">
            <h2>${introductionList[3].sectionName}</h2>
            <p>${introductionList[3].content}</p>
        </div>
    </section>

    <section>
        <div>
            <h2>${introductionList[4].sectionName}</h2>
            <p>${introductionList[4].content}</p>
        </div>
    </section>
    <section>
        <div>
            <h2>${introductionList[5].sectionName}</h2>
            <p>${introductionList[5].content}</p>
        </div>
    </section>
</div>
<div id="footerSection" class="custom-bg">
    <footer class="footer-container">
        <div class="contact-info">
            <h2>Liên hệ chúng tôi</h2>
            <p><i class="fas fa-map-marker-alt"></i> DC: Cư xá C, Trường đại học Nông Lâm, Khu phố 6, Phường Linh
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
<button class="back-to-top" id="backToTop"><i class="fas fa-arrow-up"></i>
    <div>Lên đầu trang</div>
</button>
</body>
<script>
    // quay về đầu trang
    // Hiện nút khi cuộn xuống
    window.onscroll = function () {
        const button = document.getElementById('backToTop');
        if (document.body.scrollTop > 100 || document.documentElement.scrollTop > 100) {
            button.style.bottom = "20px";
        } else {
            button.style.bottom = "-60px";
        }
    };

    // Cuộn lên đầu trang khi nhấn nút
    document.getElementById('backToTop').onclick = function () {
        window.scrollTo({top: 0, behavior: 'smooth'});
    };

</script>

</html>
