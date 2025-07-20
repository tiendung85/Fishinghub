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
</head>
<body>
<h2>Đánh giá sản phẩm</h2>
<% if (productId == -1) { %>
    <div style="color: red;">Không xác định được sản phẩm để đánh giá!</div>
<% } else { %>
<form action="ReviewController" method="post" enctype="multipart/form-data">
    <input type="hidden" name="productId" value="<%= productId %>">

    <label>Đánh giá (1-5 sao):</label>
    <input type="number" name="rating" min="1" max="5" required><br>

    <label>Nội dung đánh giá (tối đa 500 ký tự):</label><br>
    <textarea name="reviewText" maxlength="500" required style="width:300px;height:80px"></textarea><br>

    <label>Chọn ảnh (≤ 2MB):</label>
    <input type="file" name="image" accept="image/*"><br>

    <label>Chọn video (≤ 10MB):</label>
    <input type="file" name="video" accept="video/*"><br>

    <button type="submit">Gửi đánh giá</button>
</form>
<% } %>
<%
    String message = (String) session.getAttribute("message");
    if (message != null) {
        out.println("<div style='color:red;'>" + message + "</div>");
        session.removeAttribute("message");
    }
%>
</body>
</html>
