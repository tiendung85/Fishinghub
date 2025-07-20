<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List, model.Review" %>
<%
    List<Review> reviewedList = (List<Review>) request.getAttribute("reviewedList");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Sản phẩm đã đánh giá</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { font-family: 'Roboto', sans-serif; background-color: #f8f9fa; }
        .container { max-width: 900px; margin: 40px auto; background: white; border-radius: 10px; box-shadow: 0 0 8px #ddd; padding: 32px; }
        table { width: 100%; margin-top: 16px; }
        th, td { padding: 8px; border-bottom: 1px solid #ddd; text-align: center; }
        th { background: #f1f1f1; }
        .btn-view { background: #28a745; color: white; border:none; padding: 6px 16px; border-radius: 5px; font-weight: 600; }
    </style>
</head>
<body>
<div class="container">
    <h2>Sản phẩm đã đánh giá</h2>
    <% if (reviewedList == null || reviewedList.isEmpty()) { %>
        <div class="alert alert-info">Bạn chưa đánh giá sản phẩm nào.</div>
    <% } else { %>
        <table>
            <tr>
                <th>Mã sản phẩm</th>
                <th>Rating</th>
                <th>Nội dung</th>
                <th>Chi tiết</th>
            </tr>
            <% for (Review review : reviewedList) { %>
            <tr>
                <td><%= review.getProductId() %></td>
                <td><%= review.getRating() %> sao</td>
                <td><%= review.getReviewText() %></td>
                <td>
                    <form method="get" action="ViewReview.jsp" style="margin:0;">
                        <input type="hidden" name="productId" value="<%= review.getProductId() %>"/>
                        <button type="submit" class="btn-view">Xem đánh giá</button>
                    </form>
                </td>
            </tr>
            <% } %>
        </table>
    <% } %>
    <div style="margin-top: 24px;">
        <a href="Delivered" class="btn btn-primary">Quay lại Đơn hàng đã nhận</a>
    </div>
</div>
</body>
</html>
