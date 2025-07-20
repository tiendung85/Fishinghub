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
<head><title>Đánh giá của bạn</title></head>
<body>
<% if (productId == -1) { %>
    <div style="color:red;">Không xác định được sản phẩm!</div>
<% } else if (user == null) { %>
    <div style="color:red;">Bạn chưa đăng nhập!</div>
<% } else { %>
    <h2>Đánh giá của bạn cho sản phẩm ID: <%= productId %></h2>
    <% if (userReview == null) { %>
        <p>Bạn chưa đánh giá sản phẩm này.</p>
    <% } else { %>
        <ul>
            <li>
                <b>Rating:</b> <%= userReview.getRating() %> sao<br>
                <b>Nội dung:</b> <%= userReview.getReviewText() %><br>
                <% if (userReview.getImage() != null) { %>
                    <img src="<%= userReview.getImage() %>" style="max-width:150px;"><br>
                <% } %>
                <% if (userReview.getVideo() != null) { %>
                    <video width="200" controls>
                        <source src="<%= userReview.getVideo() %>" type="video/mp4">
                    </video><br>
                <% } %>
            </li>
        </ul>
    <% } %>
<% } %>
</body>
</html>
