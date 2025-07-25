<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, model.Product, model.Review, model.OrderDetail" %>
<%
    List<Map<String, Object>> reviewedProducts = (List<Map<String, Object>>) request.getAttribute("reviewedProducts");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Sản phẩm đã đánh giá</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .container { max-width: 900px; margin: 32px auto; background: white; border-radius: 10px; box-shadow: 0 0 8px #ddd; padding: 32px; }
        .btn-detail { background: #28a745; color: white; border:none; padding: 7px 16px; border-radius: 5px; font-weight: 600; }
    </style>
</head>
<body>
<div class="container">
    <h2>Sản phẩm đã đánh giá</h2>
    <table class="table table-bordered">
        <tr>
            <th>Tên sản phẩm</th>
            <th>Số lượng</th>
            <th>Thành tiền</th>
            <th>Rating</th>
            <th>Nội dung</th>
            <th>Chi tiết</th>
        </tr>
        <%
        if (reviewedProducts == null || reviewedProducts.isEmpty()) {
        %>
        <tr>
            <td colspan="6">Chưa có sản phẩm nào đã đánh giá.</td>
        </tr>
        <%
        } else {
            for (Map<String, Object> map : reviewedProducts) {
                Product product = (Product) map.get("product");
                Review review = (Review) map.get("review");
                OrderDetail detail = (OrderDetail) map.get("detail");
        %>
        <tr>
            <td><%= product != null ? product.getName() : "N/A" %></td>
            <td><%= detail != null ? detail.getCartQuantity() : "" %></td>
            <td>
                <%
                if (detail != null) {
                    double subtotal = detail.getCartQuantity() * detail.getPrice();
                    out.print(String.format("%,.0f", subtotal) + "₫");
                }
                %>
            </td>
            <td><%= review.getRating() %> sao</td>
            <td><%= review.getReviewText() %></td>
            <td>
                <form method="get" action="ViewReview.jsp" style="margin:0;">
                    <input type="hidden" name="productId" value="<%= review.getProductId() %>"/>
                    <button type="submit" class="btn-detail">Xem đánh giá</button>
                </form>
            </td>
        </tr>
        <%
            }
        }
        %>
    </table>
    <a href="Delivered" class="btn btn-primary">Quay lại Đơn hàng đã nhận</a>
</div>
</body>
</html>