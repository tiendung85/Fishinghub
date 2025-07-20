<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.Order, java.util.*" %>
<%
    List<Order> notReviewedOrders = (List<Order>) request.getAttribute("notReviewedOrders");
    List<Order> reviewedOrders = (List<Order>) request.getAttribute("reviewedOrders");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Đơn hàng đã nhận</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { font-family: 'Roboto', sans-serif; background-color: #f8f9fa; }
        .container { max-width: 1200px; margin: 32px auto; background: white; border-radius: 10px; box-shadow: 0 0 8px #ddd; padding: 32px; }
        .order-block { border-bottom: 1px solid #e0e0e0; margin-bottom: 28px; padding-bottom: 16px; }
        .order-meta { font-size: 15px; color: #444; }
        .btn-review { background: #007bff; color: white; border:none; padding: 7px 16px; border-radius: 5px; font-weight: 600; }
        .reviewed { background: #e3ffe5; color: #449d44;}
    </style>
</head>
<body>
<div class="container">
    <h1 style="color:#007bff;">Đơn hàng đã nhận (chờ đánh giá)</h1>
    <% if (notReviewedOrders == null || notReviewedOrders.isEmpty()) { %>
        <div class="alert alert-info">Không có đơn hàng nào cần đánh giá.</div>
    <% } else {
        for (Order order : notReviewedOrders) { %>
            <div class="order-block">
                <div class="order-meta">
                    <b>Đơn #<%=order.getId()%></b> - Thời gian đặt: <%= order.getOrderDate() %>
                </div>
                <!-- Thêm thông tin sản phẩm nếu muốn -->
                <form method="post" action="ReviewServlet">
                    <input type="hidden" name="orderId" value="<%=order.getId()%>"/>
                    <button type="submit" class="btn-review">Đánh giá</button>
                </form>
            </div>
    <%  } } %>

    <h1 style="color:#27ae60;">Đơn hàng đã nhận (đã đánh giá)</h1>
    <% if (reviewedOrders == null || reviewedOrders.isEmpty()) { %>
        <div class="alert alert-success">Chưa có đơn nào đã đánh giá.</div>
    <% } else {
        for (Order order : reviewedOrders) { %>
            <div class="order-block reviewed">
                <div class="order-meta">
                    <b>Đơn #<%=order.getId()%></b> - Thời gian đặt: <%= order.getOrderDate() %>
                    <span class="badge bg-success">Đã đánh giá</span>
                </div>
            </div>
    <%  } } %>
</div>
</body>
</html>
