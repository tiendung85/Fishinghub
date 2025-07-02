<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Users"%>
<%
    Users user = (Users) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("Login.jsp");
        return;
    }
    String productId = request.getParameter("productId");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Đánh giá sản phẩm</title>
</head>
<body>
    <form action="RatingServlet" method="post" enctype="multipart/form-data">
        <input type="hidden" name="productId" value="<%= productId %>">

        <label for="rating">Chọn số sao:</label>
        <select name="rating" id="rating">
            <option value="5">5 sao</option>
            <option value="4">4 sao</option>
            <option value="3">3 sao</option>
            <option value="2">2 sao</option>
            <option value="1">1 sao</option>
        </select><br/>

        <label for="reviewText">Mô tả đánh giá:</label><br/>
        <textarea name="reviewText" id="reviewText" rows="4" cols="50"></textarea><br/>

        <label for="image">Ảnh đánh giá:</label>
        <input type="file" name="image"><br/>

        <label for="video">Video đánh giá:</label>
        <input type="file" name="video"><br/>

        <button type="submit">Gửi đánh giá</button>
    </form>
</body>
</html>
