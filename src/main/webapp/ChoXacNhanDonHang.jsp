<%--
  Created by IntelliJ IDEA.
  User: Khương
  Date: 3/30/2025
  Time: 11:42 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>

<head>
  <meta charset="utf-8" />
  <meta content="width=device-width, initial-scale=1.0" name="viewport" />
  <title>
    OneH2K
  </title>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet" />
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f3f4f6;
      margin: 0;
      padding: 0;
    }

    header {
      background-color: #4CAF50;
      color: white;
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 10px 20px;
    }

    header h1 {
      margin: 0;
      font-size: 24px;
    }

    .user {
      position: relative;
      cursor: pointer;
    }

    .user i {
      font-size: 24px;
    }

    .user .logout-menu {
      display: none;
      position: absolute;
      right: 0;
      top: 40px;
      background-color: white;
      border: 1px solid #ccc;
      border-radius: 5px;
      padding: 10px;
      box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
    }

    .user:hover .logout-menu {
      display: block;
    }

    .logout-menu button {
      background: none;
      border: none;
      padding: 10px;
      text-align: left;
      width: 100%;
      cursor: pointer;
    }

    .logout-menu button:hover {
      background-color: #f9f9f9;
    }

    main {
      display: flex;
      padding: 20px;
    }

    aside {
      width: 25%;
      background-color: white;
      padding: 20px;
      border-radius: 5px;
      box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
    }

    aside h3 {
      margin-top: 0;
    }

    aside a {
      display: block;
      color: black;
      padding: 10px 0;
      text-decoration: none;
    }

    aside a:hover {
      color: #4CAF50;
    }

    .account .dropdown-content {
      position: relative;
      left: 0;
      top: 0;
      min-width: 150px;
      padding-left: 20px;
      border-radius: 5px;
    }

    .account:hover .dropdown-content {
      display: block;
    }

    .account .dropdown-content a {
      color: black;
      padding: 10px 15px;
      text-decoration: none;
      display: block;
      white-space: nowrap;
    }

    .account .dropdown-content a:hover {
      color: #4CAF50;
    }

    section {
      width: 75%;
      background-color: white;
      padding: 20px;
      border-radius: 5px;
      box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
      margin-left: 20px;
    }

    .nav ul {
      display: flex;
      padding: 0;
      margin: 0;
      list-style: none;
      border-bottom: 1px solid #e5e7eb;
    }

    .nav li {
      padding: 10px 20px;
    }

    .nav a {
      text-decoration: none;
      color: #4b5563;
    }

    .nav a.active {
      color: #ef4444;
      border-bottom: 2px solid #ef4444;
    }

    .header,
    .footerSub {
      padding: 20px;
      border-bottom: 1px solid #e5e7eb;
    }

    .header .left {
      display: flex;
      align-items: center;
    }

    .header .left i {
      font-size: 24px;
      margin-right: 10px;
    }

    .header .right button {
      margin-left: 10px;
      padding: 5px 10px;
      border: none;
      border-radius: 5px;
      cursor: pointer;
    }

    .header .right .shop {
      background-color: #e5e7eb;
      color: #4b5563;
    }

    .content {
      padding: 20px;
    }

    .content .item {
      display: flex;
      margin-bottom: 20px;
    }

    .content .item img {
      width: 100px;
      height: 100px;
      object-fit: cover;
    }

    .content .item .details {
      margin-left: 20px;
      flex: 1;
    }

    .content .item .details h2 {
      margin: 0;
      color: #4b5563;
    }

    .content .item .details p {
      margin: 5px 0;
      color: #6b7280;
    }

    .content .item .price {
      text-align: right;
    }

    .content .item .price .original {
      text-decoration: line-through;
      color: #9ca3af;
    }

    .content .item .price .discounted {
      color: #ef4444;
      font-size: 20px;
    }

    .content .note {
      color: #6b7280;
    }

    .content .note .date {
      color: #3b82f6;
    }

    .footerSub {
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    .footerSub .total {
      color: #ef4444;
      font-size: 20px;
    }

    .footerSub .actions button {
      margin-left: 10px;
      padding: 10px 20px;
      border: none;
      border-radius: 5px;
      cursor: pointer;
    }

    .footerSub .actions .contact {
      background-color: #ef4444;
      color: white;
    }

    .footerSub .actions .cancel {
      background-color: #e5e7eb;
      color: #4b5563;
    }

    footer {
      background-color: #4CAF50;
      color: white;
      padding: 20px;
      margin-top: 20px;
    }

    footer .footer-container {
      display: flex;
      flex-direction: column;
      justify-content: space-between;
      align-items: start;
      text-align: center;
    }

    footer .footer-container h2 {
      font-size: 20px;
      color: white;
      font-weight: bold;
      margin-bottom: 10px;
    }

    footer .footer-container p {
      margin-bottom: 10px;
    }

    footer .footer-container a {
      color: white;
      text-decoration: underline;
    }

    footer .footer-container .contact-info {
      flex: 1;
    }

    footer .footer-container .map {
      flex: 1;
      display: flex;
      margin-top: 20px;
    }

    footer .footer-container .map iframe {
      width: 250px;
      height: 175px;
      border: 1px solid white;
      margin-top: 10px;
      border-radius: 6px;
    }

    footer .footer-container .separator {
      display: none;
      margin: 10px 0px;
    }

    footer .footer-container .credits {
      flex: 1;
      text-align: right;
    }

    footer .footer-container .credits p {
      margin-bottom: 0.5rem;
    }

    @media (min-width: 768px) {
      footer .footer-container {
        flex-direction: row;
        text-align: left;
      }

      footer .footer-container .separator {
        display: block;
        border-left: 1px solid white;
        height: 200px;
      }
    }

    .back-to-top {
      position: fixed;
      background: #4CAF50;
      bottom: 20px;
      right: 20px;
      border: none;
      color: white;
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
      background-color: #45a049;
      transform: scale(1.1);
    }
  </style>
</head>

<body>
<header>
  <h1>
    TÀI KHOẢN CỦA TÔI
  </h1>
  <div class="user">
    <i class="fas fa-user-circle">
    </i>
    <br />
    ${sessionScope.user.name}
    <div class="logout-menu">
      <form action="logout" method="post">
        <button type="submit">
          Thông tin tài khoản
        </button>
        <hr />
        <button type="submit">
          Đơn mua
        </button>
        <hr />
        <button type="submit">
          <i class="fas fa-sign-out-alt">
          </i>
          Đăng xuất
        </button>
      </form>
    </div>
  </div>
</header>
<main>
  <aside>
    <h3>
      Menu
    </h3>
    <a href="#">
      Trang Chủ
    </a>
    <div class="account">
      <a href="#">
        Tài Khoản Của Tôi
      </a>
      <div class="dropdown-content">
        <a href="#">
          Hồ Sơ
        </a>
        <a href="#">
          Ngân Hàng
        </a>
        <a href="#">
          Địa Chỉ
        </a>
        <a href="#">
          Đổi Mật Khẩu
        </a>
      </div>
    </div>
    <a href="#" style="color: red; font-weight: bold;">
      Đơn mua
    </a>
  </aside>
  <section>
    <div class="nav">
      <ul>
        <li>
          <a href="#">
            Tất cả
          </a>
        </li>
        <li>
          <a class="active" href="#">
            Chờ xác nhận (1)
          </a>
        </li>
        <li>
          <a href="#">
            Chờ giao hàng
          </a>
        </li>
        <li>
          <a href="#">
            Hoàn thành
          </a>
        </li>
        <li>
          <a href="#">
            Đã hủy
          </a>
        </li>
      </ul>
    </div>
    <div class="header">
      <div class="left">
        <i class="fas fa-store">
        </i>
        <span>
                        Phụ Tùng Nguyễn (2)
                    </span>
      </div>
      <div class="right">
        <button class="shop">
          Xem Shop
        </button>
      </div>
    </div>
    <div class="content">
      <div class="item">
        <img alt="Gương chiếu hậu xe Wave" height="100"
             src="https://storage.googleapis.com/a1aa/image/1D61S1-gC7TwBfgk8zv6EvND3RtPf2wcjgP_t7FCc_4.jpg"
             width="100" />
        <div class="details">
          <h2>
            Gương chiếu hậu xe Wave cặp trái phải (có bán lẻ bên trái và phải) gắn được nhiều xe honda
            REN THUẬN
          </h2>
          <p>
            Phân loại hàng: 1 cái Trái
          </p>
          <p>
            x1
          </p>
        </div>
        <div class="price">
          <p class="original">
            ₫19.055
          </p>
          <p class="discounted">
            ₫15.800
          </p>
        </div>
      </div>
      <div class="note">
        Đơn hàng sẽ được chuẩn bị và chuyển đi trước
        <span class="date">
                        29-03-2025
                    </span>
        .
      </div>
    </div>
    <div class="footerSub">
      <div class="total">
        Thành tiền: ₫15.800
      </div>
      <div class="actions">
        <button class="contact">
          Liên Hệ Người Bán
        </button>
        <button class="cancel">
          Hủy Đơn Hàng
        </button>
      </div>
    </div>
  </section>
</main>
<footer>
  <div class="footer-container">
    <div class="contact-info">
      <h2>
        Liên hệ chúng tôi
      </h2>
      <p>
        <i class="fas fa-map-marker-alt">
        </i>
        DC: Cư xá C, Trường đại học Nông Lâm, Khu phố 6, Phường Linh Trung, TP. Thủ Đức, TP. Hồ Chí Minh
      </p>
      <p>
        <i class="fas fa-phone-alt">
        </i>
        SĐT liên hệ: 0707188079
      </p>
      <p>
        <i class="fas fa-envelope">
        </i>
        EMAIL:
        <a href="mailto:22130000@st.hcmuaf.edu.vn">
          22130000@st.hcmuaf.edu.vn
        </a>
      </p>
      <p>
        <i class="fas fa-globe">
        </i>
        WEBSITE:
        <a href="https://OneH2K.vn">
          https://OneH2K.vn
        </a>
      </p>
    </div>
    <div class="separator">
    </div>
    <div class="credits">
      <p>
        © 2024 OneH2K.Vn |
      </p>
      <p>
        Cửa hàng bán cây giống
      </p>
      <p style="padding-top: 20px;">
        ___________________
      </p>
      <p class="text-sm" style="padding-top: 40px;">
        Thiết kế bởi OneH2K
      </p>
      <div class="map">
        <iframe allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"
                src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d1959.1072550471563!2d106.78855811579251!3d10.871282831661734!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x317527b5a31ff523%3A0x4ab7fc7a54bec4a4!2zQ8awIHjDoSBDLCBLVFggVHLGsOG7nW5nIMSQ4bqhaSBo4buNYyBOw7RuZyBMw6Jt!5e0!3m2!1svi!2s!4v1732027299631!5m2!1svi!2s">
        </iframe>
      </div>
    </div>
  </div>
</footer>
<button class="back-to-top" id="backToTop">
  <i class="fas fa-arrow-up">
  </i>
  <div>
    Lên đầu trang
  </div>
</button>
</body>

</html>
