<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.util.List"%>
<%@page import="model.OrderDetail"%>
<%@page import="dal.OrderDetailDAO"%>
<%@page import="model.Product"%>
<%@page import="dal.ProductDAO"%>
<%@page import="model.Users"%>
<%
    Users user = (Users) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("Login.jsp");
        return;
    }

    OrderDetailDAO orderDetailDAO = new OrderDetailDAO();
    ProductDAO productDAO = new ProductDAO();
    List<OrderDetail> deliveredItems = orderDetailDAO.getDeliveredOrderDetailsByUserId(user.getUserId());
%>

<!DOCTYPE html>
<html>
<head>
    <title>Đã nhận</title>
</head>
    <div class="tabs">
        <button class="function-btn" onclick="window.location.href='PendingOrder.jsp'">Chờ xác nhận</button>
        <button class="function-btn" onclick="window.location.href='InProgress.jsp'">Đang giao</button>
        <button class="function-btn" onclick="window.location.href='Delivered.jsp'">Đã nhận</button>
    </div>
<body>
    <h3>Đã nhận</h3>
    <% if(deliveredItems != null && !deliveredItems.isEmpty()) { %>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Sản phẩm</th>
            <th>Số lượng</th>
            <th>Giá</th>
            <th>Đánh giá</th>
        </tr>
        <% for(OrderDetail detail : deliveredItems) {
            Product product = productDAO.getProductById(detail.getProductId());
        %>
        <tr>
            <td><%= detail.getId() %></td>
            <td><%= product.getName() %></td>
            <td><%= detail.getCartQuantity() %></td>
            <td><%= detail.getPrice() %></td>
            <td><a href="Rating.jsp?productId=<%= product.getProductId() %>">Đánh giá</a></td>
        </tr>
        <% } %>
    </table>
    <% } else { %>
        Không có sản phẩm nào đã nhận.
    <% } %>
</body>
</html>
