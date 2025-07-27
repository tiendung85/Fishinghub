<%@page import="model.Users"%>
<%@page import="model.Review"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dal.ReviewDAO"%>
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
    Review userReview = null;
    if (productId != -1 && user != null) {
        ReviewDAO dao = new ReviewDAO();
        userReview = dao.getReviewByUserAndProduct(user.getUserId(), productId);
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Đánh giá của bạn</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: #f8f9fa;
            font-family: 'Roboto', Arial, sans-serif;
        }
        .container {
            background: #fff;
            max-width: 520px;
            margin: 48px auto 0 auto;
            border-radius: 14px;
            box-shadow: 0 0 12px #c6e2fa;
            padding: 34px 28px;
        }
        h2 {
            color: #0a58ca;
            font-weight: 600;
            text-align: center;
            margin-bottom: 28px;
        }
        .review-info {
            background: #e6f0fa;
            border-radius: 10px;
            padding: 20px;
            margin-top: 18px;
            margin-bottom: 8px;
        }
        .review-info b {
            color: #0a58ca;
        }
        .msg-error {
            color: #e74c3c;
            background: #fff3f2;
            padding: 10px 18px;
            border-radius: 6px;
            margin-top: 18px;
            text-align: center;
        }
        .msg-success {
            color: #228b22;
            background: #e6f9eb;
            padding: 10px 18px;
            border-radius: 6px;
            margin-top: 18px;
            text-align: center;
        }
        img, video {
            margin-top: 10px;
            border-radius: 6px;
            box-shadow: 0 0 8px #c6e2fa;
        }
    </style>
</head>
<body>
<div class="container">
<% if (productId == -1) { %>
    <div class="msg-error">Không xác định được sản phẩm!</div>
<% } else if (user == null) { %>
    <div class="msg-error">Bạn chưa đăng nhập!</div>
<% } else { %>
    <h2>Đánh giá của bạn<br>cho sản phẩm ID: <%= productId %></h2>
    <% if (userReview == null) { %>
        <div class="msg-error">Bạn chưa đánh giá sản phẩm này.</div>
    <% } else { %>
        <div class="review-info">
            <b>Rating:</b> <%= userReview.getRating() %> sao<br>
            <b>Nội dung:</b> <%= userReview.getReviewText() %><br>
            <% if (userReview.getImage() != null) { %>
                <img src="<%= userReview.getImage() %>" style="max-width:150px;"><br>
            <% } %>
            <% if (userReview.getVideo() != null) { %>
                <video width="220" controls>
                    <source src="<%= userReview.getVideo() %>" type="video/mp4">
                </video><br>
            <% } %>
        </div>
    <% } %>
<% } %>
</div>
</body>
</html>