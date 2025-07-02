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
    <title>Đang giao</title>
</head>
<body>
    <!-- Header với 3 mục -->
    <div class="tabs">
        <button class="function-btn" onclick="window.location.href='PendingOrder.jsp'">Chờ xác nhận</button>
        <button class="function-btn" onclick="window.location.href='InProgress.jsp'">Đang giao</button>
        <button class="function-btn" onclick="window.location.href='Delivered.jsp'">Đã nhận</button>
    </div>

    <!-- Nội dung Đang giao -->
    <div id="inProgress">
        <h3>Đang giao</h3>
        <%
            Map<String, Integer> orderedItems = (Map<String, Integer>) session.getAttribute("OrderedItems");
            Map<String, Long> deliveryTimes = (Map<String, Long>) session.getAttribute("DeliveryTimes");
            ProductDAO productDAO = new ProductDAO();
            Map<String, Integer> deliveredItems = new HashMap<>();

            if (orderedItems != null && !orderedItems.isEmpty()) {
                for (String id : orderedItems.keySet()) {
                    long currentTime = System.currentTimeMillis();
                    long deliveryTime = deliveryTimes.get(id); // Lấy thời gian giao hàng

                    // Kiểm tra xem thời gian giao hàng đã hết chưa
                    if (currentTime >= deliveryTime) {
                        Product product = productDAO.getProductById(Integer.parseInt(id));
                        deliveredItems.put(id, orderedItems.get(id)); // Thêm vào danh sách Đã nhận
                        orderedItems.remove(id); // Xóa khỏi Đang giao
                    }
                }

                // Cập nhật lại session
                session.setAttribute("OrderedItems", orderedItems);
                session.setAttribute("DeliveredItems", deliveredItems);
            }
        %>
        <div id="inProgressItems">
            <%
                if (!orderedItems.isEmpty()) {
                    for (String id : orderedItems.keySet()) {
                        Product product = productDAO.getProductById(Integer.parseInt(id));
            %>
            <p><%= product.getName() %> - Thời gian giao: <%= new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm:ss").format(new java.util.Date(deliveryTimes.get(id))) %></p>
            <%
                    }
                } else {
                    out.println("Không có sản phẩm nào đang giao.");
                }
            %>
        </div>
    </div>

    <!-- Màn hình Đã nhận -->
    <div id="delivered">
        <h3>Đã nhận</h3>
        <div id="deliveredItems">
            <%
                if (!deliveredItems.isEmpty()) {
                    for (String id : deliveredItems.keySet()) {
                        Product product = productDAO.getProductById(Integer.parseInt(id));
            %>
            <p><%= product.getName() %> - Đã giao thành công</p>
            <%
                    }
                } else {
                    out.println("Không có sản phẩm nào đã nhận.");
                }
            %>
        </div>
    </div>

</body>
</html>
