<%--
  Created by IntelliJ IDEA.
  User: Khương
  Date: 1/8/2025
  Time: 7:54 PM
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
    <title>Admin - Chỉnh Sửa Giới thiệu</title>
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
            width: 1200px;
        }

        #contentSection {
            margin: auto;
            width: 1200px;
        }

        #footerSection {
            margin: auto;
            width: 1200px;
        }

        .header {
            background-color: #8BC34A;
            padding: 10px;
            height: 150px;
            text-align: center;
            color: white;
            overflow: hidden;
        }

        .header h1 {
            margin: 0;
            font-size: 40px;
            color: #FFCDD2;
            text-align: center;
            padding-top: 50px;
        }

        .header p {
            margin: 0;
            font-size: 14px;
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

        .navbar {
            background-color: #4CAF50;
            padding: 10px;

        }

        .navbar i {
            color: white;
            text-decoration: none;
            transition: transform 0.3s ease;
        }

        .navbar i:hover {
            transform: scale(1.1);
        }

        .navbar a {
            color: white;
            text-decoration: none;
            transition: transform 0.3s ease;
        }

        /* Main content */
        .main-content section {
            margin-bottom: 20px;
            padding: 20px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .main-content > section {
            margin-top: 20px;
        }

        .breadcrumb {
            margin-top: 10px;
            width: max-content;
            margin-left: 20px;
            margin-bottom: 7px;
        }

        .breadcrumb a:first-child {
            text-decoration: none;
            color: black;
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

        .conclusion h2 {
            color: #f34545;
        }

        .conclusion .art-word {
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

        .conclusion p {
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

        .submit-save {
            margin-top: 20px;
        }

        .submit-save button {
            position: fixed;
            bottom: 30px;
            left: 20px;
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: transform 0.3s ease;
        }

        .submit-save button:hover {
            background-color: #45a049;
            transform: scale(1.05);
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

        .managerIntro .sectionName {
            font-size: 25px;
            font-weight: bold;
            color: green;
            margin-bottom: 20px;
            width: calc(100% - 20px);
            min-height: 30px;
            resize: none;
            font-family: sans-serif, Tahoma;
        }

        .managerIntro .content {
            margin-bottom: 20px;
            font-size: 18px;
            font-weight: 500;
            width: calc(100% - 20px);
            min-height: 30px;
            resize: none;
            font-family: sans-serif, Tahoma;

        }

        .managerIntro .submit {
            text-align: center;
        }

        .managerIntro .submit button {
            margin-bottom: 20px;
            background-color: red;
            font-size: 18px;
            color: white;
            padding: 6px 14px;
            cursor: pointer;
            border-radius: 5px;
            border: 1px solid red;
            transition: transform 0.5s ease;
        }

        .managerIntro .submit button:hover {
            background-color: darkred;
            transform: scale(1.1);
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
        <div class="marquee-content">QUẢN LÝ TRANG GIỚI THIỆU
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
        <a href="DashBoard"><i class="fas fa-home"></i> TRANG CHỦ ADMIN</a>
    </div>
</div>
<div id="contentSection" class="main-content">
    <nav class="breadcrumb">
        <a href="DashBoard">Dashboard</a>/<a><b>Chỉnh sửa Giới thiệu</b></a>
    </nav>

    <form action="QuanLiGioiThieu" method="post">
        <c:forEach var="intro" items="${introductionList}">
            <section>
                <div class="managerIntro">
                    <input class="sectionName" type="text" name="sectionName" value="${intro.sectionName}" required>
                    <textarea class="content" name="content" required
                              oninput="autoResize(this)">${intro.content}</textarea>
                    <input type="hidden" name="introID" value="${intro.introID}">
                    <div class="submit">
                        <button type="submit">Cập nhật</button>
                    </div>
                </div>
            </section>
        </c:forEach>
    </form>

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

    function autoResize(textarea) {
        // Đặt chiều cao về auto để tính toán chính xác
        textarea.style.height = 'auto';
        // Đặt chiều cao bằng chiều cao cuộn
        textarea.style.height = (textarea.scrollHeight) + 'px';
    }

    // Tự động điều chỉnh chiều cao cho tất cả các textarea khi tải trang
    window.onload = function () {
        const textareas = document.querySelectorAll('textarea');
        textareas.forEach(autoResize);
    };
</script>

</html>
