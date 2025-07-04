<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map" %>
<%@ page import="model.Product" %>
<%@ page import="dal.ProductDAO" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="model.Category" %>
<%@ page import="model.Users" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Chờ xác nhận</title>
</head>
<body>
    <!-- Header với 3 mục -->
    <div class="tabs">
        <button class="function-btn" onclick="window.location.href='PendingOrder.jsp'">Chờ xác nhận</button>
        <button class="function-btn" onclick="window.location.href='InProgress.jsp'">Đang giao</button>
        <button class="function-btn" onclick="window.location.href='Delivered.jsp'">Đã nhận</button>
    </div>

    <!-- Nội dung Chờ xác nhận -->
    <div id="pending">
        <h3>Chờ xác nhận</h3>
        <%
        String errorMessage = (String) session.getAttribute("errorMessage");
        if (errorMessage != null) {
    %>
        <div style="color: red; font-weight: bold; margin-bottom: 12px;"><%= errorMessage %></div>
    <%
            session.removeAttribute("errorMessage");
        }
    %>
        <%
            // Lấy giỏ hàng từ session
            Map<String, Integer> cart = (Map<String, Integer>) session.getAttribute("CART");
            ProductDAO productDAO = new ProductDAO();
            if (cart != null && !cart.isEmpty()) {
        %>
        <form action="ShoppingCartServlet" method="POST">
            <table border="1">
                <thead>
                    <tr>
                        <th>Chọn</th>
                        <th>ID</th>
                        <th>Tên sản phẩm</th>
                        <th>Số lượng</th>
                        <th>Đơn giá</th>
                        <th>Thành tiền</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        // Lặp qua các sản phẩm trong giỏ hàng
                        for (String id : cart.keySet()) {
                            Product product = productDAO.getProductById(Integer.parseInt(id));
                    %>
                    <tr>
                        <td><input type="checkbox" name="selectedItems" value="<%= id %>"></td>
                        <td><%= id %></td>
                        <td><%= product.getName() %></td>
                        <td><input type="number" name="quantity_<%= id %>" value="<%= cart.get(id) %>" /></td>
                        <td><%= product.getPrice() %></td>
                        <td><%= cart.get(id) * product.getPrice() %></td>
                        <td>
                            <button type="submit" value="deleteItem_<%= id %>" name="action">Xóa</button>
                        </td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
            <br/>
            <button type="submit" value="paySelected" name="action">Thanh toán</button>
        </form>
        <% 
            } else {
                out.println("Giỏ hàng của bạn hiện tại chưa có sản phẩm.");
            }
        %>
    </div>

    <!-- Màn hình Đang giao -->
    <div id="inProgress" style="display:none">
        <h3>Đang giao</h3>
        <div id="inProgressItems">
            <%
                // Hiển thị các sản phẩm đã thanh toán cùng thời gian giao hàng 2 phút
                Map<String, Integer> orderedItems = (Map<String, Integer>) session.getAttribute("OrderedItems");
                Map<String, Long> deliveryTimes = (Map<String, Long>) session.getAttribute("DeliveryTimes");

                if (orderedItems != null && !orderedItems.isEmpty()) {
                    for (String id : orderedItems.keySet()) {
                        Product product = productDAO.getProductById(Integer.parseInt(id));
                        long deliveryTime = deliveryTimes.get(id); // Lấy thời gian giao hàng
                        String formattedDeliveryTime = new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm:ss").format(new java.util.Date(deliveryTime));
            %>
            <p><%= product.getName() %> - Thời gian giao: <%= formattedDeliveryTime %></p>
            <%
                    }
                }
            %>
        </div>
    </div>

    <!-- Màn hình Đã nhận -->
    <div id="delivered" style="display:none">
        <h3>Đã nhận</h3>
        <div id="deliveredItems"></div>
    </div>

</body>
</html>
