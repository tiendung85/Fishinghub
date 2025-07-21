<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.Order, java.util.*, model.OrderDetail, model.Product" %>
<%
    List<Map<String, Object>> productsToReview = (List<Map<String, Object>>) request.getAttribute("productsToReview");
%>
<!DOCTYPE html>
<html>
    <style>
.tabs {
    display: flex;
    justify-content: center;
    margin-bottom: 20px;
}

.tabs .btn-tab {
    background-color: #87CEFA;
    border: none;
    color: white;
    padding: 10px 20px;
    margin: 0 5px;
    font-size: 16px;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

.tabs .btn-tab.active {
    background-color: #007BFF; /* Đậm hơn để nhận biết nút hiện tại */
}

.tabs .btn-tab:hover {
    background-color: #5aaef9;
}
</style>
<div class="tabs">
    <button class="btn-tab" onclick="window.location.href='MyWaitingOrders'">Chờ xác nhận</button>
    <button class="btn-tab" onclick="window.location.href='InProgress'">Đang giao</button>
    <button class="btn-tab active" onclick="window.location.href='Delivered'">Đã giao</button>
</div>
<head>
    <title>Đơn hàng đã nhận (chờ đánh giá)</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .container { max-width: 900px; margin: 32px auto; background: white; border-radius: 10px; box-shadow: 0 0 8px #ddd; padding: 32px; }
        .btn-review { background: #007bff; color: white; border:none; padding: 7px 16px; border-radius: 5px; font-weight: 600; }
    </style>
</head>
<body>
<div class="container">
    <h1>Đơn hàng đã nhận (chờ đánh giá)</h1>
    <table class="table table-bordered">
        <tr>
            <th>Mã đơn</th>
            <th>Tên sản phẩm</th>
            <th>Số lượng</th>
            <th>Đánh giá</th>
        </tr>
        <%
        if (productsToReview == null || productsToReview.isEmpty()) {
        %>
        <tr>
            <td colspan="4">Không còn sản phẩm nào chờ đánh giá.</td>
        </tr>
        <%
        } else {
            for (Map<String, Object> map : productsToReview) {
                Order order = (Order) map.get("order");
                Product product = (Product) map.get("product");
                OrderDetail detail = (OrderDetail) map.get("detail");
        %>
        <tr>
            <td><%= order.getId() %></td>
            <td><%= product.getName() %></td>
            <td><%= detail.getCartQuantity() %></td>
            <td>
                <form method="get" action="Review.jsp" style="margin:0;">
                    <input type="hidden" name="productId" value="<%= product.getProductId() %>"/>
                    <button type="submit" class="btn-review">Đánh giá</button>
                </form>
            </td>
        </tr>
        <%
            }
        }
        %>
    </table>
    <a href="ReviewedProducts" class="btn btn-success">Sản phẩm đã đánh giá</a>
</div>
</body>
</html>
