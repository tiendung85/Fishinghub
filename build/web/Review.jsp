<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.Users" %>
<%
    Users user = (Users) session.getAttribute("user");
    String productIdRaw = request.getParameter("productId");
    int productId = -1;
    try {
        if (productIdRaw != null && productIdRaw.matches("\\d+")) {
            productId = Integer.parseInt(productIdRaw);
        }
    } catch (Exception ex) {
        productId = -1;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Đánh giá sản phẩm</title>
    <!-- Bootstrap CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: #f8f9fa;
            font-family: 'Roboto', Arial, sans-serif;
        }
        .container {
            background: #fff;
            max-width: 500px;
            margin: 48px auto 0 auto;
            border-radius: 14px;
            box-shadow: 0 0 12px #c6e2fa;
            padding: 32px 28px;
        }
        h2 {
            color: #0a58ca;
            font-weight: 600;
            text-align: center;
            margin-bottom: 28px;
        }
        label {
            color: #0056b3;
            font-weight: 500;
            margin-top: 10px;
        }
        input[type="number"], textarea, input[type="file"] {
            width: 100%;
            margin-bottom: 14px;
        }
        .btn-review {
            background: #007bff;
            color: #fff;
            padding: 10px 32px;
            border-radius: 8px;
            border: none;
            font-weight: 600;
            margin-top: 10px;
            transition: background 0.2s;
        }
        .btn-review:hover {
            background: #0056b3;
        }
        .msg-error {
            color: #e74c3c;
            background: #fff3f2;
            padding: 10px 18px;
            border-radius: 6px;
            margin-top: 12px;
            text-align: center;
        }
        .msg-success {
            color: #228b22;
            background: #e6f9eb;
            padding: 10px 18px;
            border-radius: 6px;
            margin-top: 12px;
            text-align: center;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Đánh giá sản phẩm</h2>
    <% if (productId == -1) { %>
        <div class="msg-error">Không xác định được sản phẩm để đánh giá!</div>
    <% } else { %>
    <form action="ReviewController" method="post" enctype="multipart/form-data">
        <input type="hidden" name="productId" value="<%= productId %>">

        <label>Đánh giá (1-5 sao):</label>
        <input type="number" class="form-control" name="rating" min="1" max="5" required>

        <label>Nội dung đánh giá (tối đa 500 ký tự):</label>
        <textarea class="form-control" name="reviewText" maxlength="500" required style="height:80px"></textarea>

        <label>Chọn ảnh (≤ 2MB):</label>
        <input type="file" class="form-control" name="image" accept="image/*">

        <label>Chọn video (≤ 10MB):</label>
        <input type="file" class="form-control" name="video" accept="video/*">

        <button type="submit" class="btn-review">Gửi đánh giá</button>
    </form>
    <% } %>
    <%
        String message = (String) session.getAttribute("message");
        if (message != null) {
            out.println("<div class='msg-error'>" + message + "</div>");
            session.removeAttribute("message");
        }
    %>
</div>
</body>
</html>
