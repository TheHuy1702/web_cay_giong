<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.Product" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:useBean id="product" scope="request" class="vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.Product" />

<html>
<head>
    <title>Sửa sản phẩm</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f5f7fa;
            padding: 40px;
        }

        .container {
            max-width: 700px;
            margin: auto;
            background: #fff;
            border-radius: 10px;
            padding: 30px 40px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 30px;
        }

        form label {
            display: block;
            margin-top: 15px;
            margin-bottom: 5px;
            font-weight: bold;
            color: #555;
        }

        form input[type="text"],
        form input[type="number"],
        form select,
        form textarea {
            width: 100%;
            padding: 10px;
            border-radius: 6px;
            border: 1px solid #ccc;
            font-size: 14px;
            box-sizing: border-box;
        }

        form textarea {
            resize: vertical;
            min-height: 80px;
        }

        form input[type="submit"] {
            margin-top: 20px;
            width: 100%;
            padding: 12px;
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        form input[type="submit"]:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Sửa thông tin sản phẩm</h2>
    <form action="QuanLySanPham" method="post" enctype="multipart/form-data">
        <input type="hidden" name="action" value="capnhat" />
        <input type="hidden" name="productID" value="${product.productID}" />

        <label>Tên sản phẩm:</label>
        <input type="text" name="name" value="${product.name}" required />

        <label>Giá:</label>
        <input type="number" name="price" step="1000" value="${product.price}" required />

        <label>Ảnh hiện tại:</label><br/>
        <img src="${pageContext.request.contextPath}/${product.imageMain}" alt="Ảnh hiện tại" style="max-width: 200px; border-radius: 6px; margin-bottom: 10px;" />

        <input type="hidden" name="oldImage" value="${product.imageMain}" />
        <label>Chọn ảnh mới (nếu muốn thay đổi):</label>
        <input type="file" name="imageMain" accept="image/*" />



        <label>Số lượng:</label>
        <input type="number" name="stock" value="${product.stock}" required />

        <label>Danh mục:</label>
        <select name="categoryID">
            <c:forEach var="cate" items="${dsCategories}">
                <option value="${cate.categoryID}" ${cate.categoryID == product.categoryID ? 'selected' : ''}>
                        ${cate.nameCategory}
                </option>
            </c:forEach>
        </select>

        <label>Giới thiệu:</label>
        <textarea name="introduce">${product.introduce}</textarea>

        <label>Thông tin chi tiết:</label>
        <textarea name="infoPro">${product.infoPro}</textarea>

        <input type="submit" value="Cập nhật sản phẩm" />
    </form>
</div>

</body>
</html>
