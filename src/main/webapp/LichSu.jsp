<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.HistoryEntry" %>
<%@ page import="java.util.List" %>
<html>
<head>
    <title>Lịch sử thao tác</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>


    <style>
        body {
            background-color: #e8f5e9; /* màu nền xanh lá nhạt */
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        h2 {
            color: #388e3c; /* màu tiêu đề xanh lá đậm */
        }
        .btn-primary {
            background-color: #4caf50;
            border: none;
        }
        .btn-primary:hover {
            background-color: #43a047;
        }
        .table thead {
            background-color: #c8e6c9; /* màu header bảng */
        }
        .table tbody tr:hover {
            background-color: #dcedc8; /* hover màu xanh nhẹ */
        }
    </style>
</head>
<body class="container mt-5">
<h2 class="mb-4"><i class="fas fa-history"></i> Lịch sử thao tác</h2>

<a href="QuanLySanPham" class="btn btn-primary mb-3">
    <i class="fas fa-arrow-left"></i> Quay lại
</a>

<table class="table table-bordered table-hover">
    <thead>
    <tr>
        <th>#</th>
        <th>Hành động</th>
        <th>Tên sản phẩm</th>
        <th>Thời gian</th>
        <th>Người thao tác</th>
        <th>Chi tiết</th>
    </tr>
    </thead>
    <tbody>
    <%
        List<HistoryEntry> histories = (List<HistoryEntry>) request.getAttribute("histories");
        if (histories != null && !histories.isEmpty()) {
            for (HistoryEntry history : histories) {
    %>
    <tr>
        <td><%= history.getId() %></td>
        <td><%= history.getActionType() %></td>
        <td><%= history.getName() %></td>
        <td><%= history.getTimeAction() %></td>
        <td><%= history.getUserAction() %></td>
        <td>
            <button class="btn btn-info btn-sm" onclick='showDetail(<%= history.getOldData() != null ? history.getOldData() : "{}" %>)'>
                Xem chi tiết
            </button>
        </td>
    </tr>
    <%
        }
    } else {
    %>
    <tr>
        <td colspan="6" class="text-center">Không có lịch sử thao tác.</td>
    </tr>
    <% } %>
    </tbody>
</table>
<!-- Modal -->
<div class="modal fade" id="detailModal" tabindex="-1" aria-labelledby="detailModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered"> <!-- Center màn hình -->
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="detailModalLabel">Chi tiết sản phẩm cũ</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
            </div>
            <div class="modal-body" id="modalBodyContent">
                <!-- Nội dung chi tiết sẽ nhét vô đây bằng JS -->
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
            </div>
        </div>
    </div>
</div>
</body>
<script>
    function showDetail(data) {
        try {
            var message = "<ul class='list-group'>";
            for (var key in data) {
                if (data.hasOwnProperty(key)) {
                    message += "<li class='list-group-item'><strong>" + key + ":</strong> " + data[key] + "</li>";
                }
            }
            message += "</ul>";

            document.getElementById('modalBodyContent').innerHTML = message;
            var myModal = new bootstrap.Modal(document.getElementById('detailModal'));
            myModal.show();
        } catch (e) {
            alert("Dữ liệu chi tiết không hợp lệ!");
        }
    }
</script>
</html>
