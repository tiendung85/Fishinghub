<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="dal.ReviewDAO" %>
<%@ page import="model.Review" %>
<%@ page import="model.Users" %>
<%
    int productId = Integer.parseInt(request.getParameter("productId"));
    Users user = (Users) session.getAttribute("user");
    int userId = user.getUserId();
    ReviewDAO reviewDAO = new ReviewDAO();
    Review review = reviewDAO.getReviewByProductIdAndUserId(productId, userId);
%>
<!DOCTYPE html>
<html>
<head>
    <title>Chi tiết đánh giá sản phẩm</title>
</head>
<body>
    <h2>Chi tiết đánh giá sản phẩm</h2>
    <%
        if (review != null) {
    %>
        <p><strong>Đánh giá:</strong> <%= review.getRating() %> sao</p>
        <p><strong>Nội dung:</strong> <%= review.getReviewText() %></p>
        <% if (review.getImage() != null) { %>
            <p><img src="<%= request.getContextPath() + "/" + review.getImage() %>" alt="Ảnh đánh giá" style="max-width:250px;"/></p>
        <% } %>
        <% if (review.getVideo() != null) { %>
            <p><video src="<%= request.getContextPath() + "/" + review.getVideo() %>" controls style="max-width:350px;"></video></p>
        <% } %>
    <%
        } else {
    %>
        <p>Không tìm thấy đánh giá cho sản phẩm này.</p>
    <%
        }
    %>
    <a href="Delivered.jsp">Quay lại</a>
</body>
</html>
