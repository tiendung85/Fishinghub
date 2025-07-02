<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map, java.util.HashMap" %>
<%@ page import="model.Product" %>
<%@ page import="dal.ProductDAO" %>

<%
    Map<String, Integer> orderedItems = (Map<String, Integer>) session.getAttribute("OrderedItems");
    Map<String, Long> deliveryTimes = (Map<String, Long>) session.getAttribute("DeliveryTimes");
    Map<String, Integer> deliveredItems = (Map<String, Integer>) session.getAttribute("DeliveredItems");
    Map<String, String> cancelledItems = (Map<String, String>) session.getAttribute("CancelledItems");
    if (orderedItems == null) orderedItems = new HashMap<>();
    if (deliveryTimes == null) deliveryTimes = new HashMap<>();
    if (deliveredItems == null) deliveredItems = new HashMap<>();
    if (cancelledItems == null) cancelledItems = new HashMap<>();

    // Xử lý tự chuyển khi hết thời gian giao
    long now = System.currentTimeMillis();
    Map<String, Integer> tempOrdered = new HashMap<>(orderedItems);
    for (String id : tempOrdered.keySet()) {
        long deliveryTime = deliveryTimes.get(id);
        if (now >= deliveryTime) {
            deliveredItems.put(id, orderedItems.get(id));
            orderedItems.remove(id);
            deliveryTimes.remove(id);
        }
    }

    // Xử lý huỷ
    String cancelId = request.getParameter("cancelNow");
    if (cancelId != null && orderedItems.containsKey(cancelId)) {
        long timeLeft = deliveryTimes.get(cancelId) - now;
        if (timeLeft > 60000) {
            String reason = request.getParameter("reason_" + cancelId);
            cancelledItems.put(cancelId, reason);
            orderedItems.remove(cancelId);
            deliveryTimes.remove(cancelId);
            session.setAttribute("CancelledItems", cancelledItems);
            out.println("<script>alert('Huỷ giao hàng thành công');location='InProgress.jsp';</script>");
        } else {
            out.println("<script>alert('Đã quá thời gian được phép huỷ');</script>");
        }
    }

    session.setAttribute("OrderedItems", orderedItems);
    session.setAttribute("DeliveryTimes", deliveryTimes);
    session.setAttribute("DeliveredItems", deliveredItems);
%>

<!DOCTYPE html>
<html>
<head><title>Đang giao</title></head>
<body>
<div class="tabs">
    <button onclick="window.location.href='PendingOrder.jsp'">Chờ xác nhận</button>
    <button onclick="window.location.href='InProgress.jsp'">Đang giao</button>
    <button onclick="window.location.href='Delivered.jsp'">Đã nhận</button>
</div>

<h3>Đang giao</h3>
<% if (!orderedItems.isEmpty()) {
    ProductDAO productDAO = new ProductDAO();
    for (String id : orderedItems.keySet()) {
        long timeLeft = deliveryTimes.get(id) - now;
        Product product = productDAO.getProductById(Integer.parseInt(id)); %>
    <p><%= product.getName() %> - Giao trước: 
    <%= new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm:ss").format(new java.util.Date(deliveryTimes.get(id))) %>
    <% if (timeLeft > 60000) { %>
        <form method="post" style="display:inline">
            <textarea name="reason_<%= id %>" placeholder="Lý do huỷ..."></textarea>
            <button type="submit" name="cancelNow" value="<%= id %>">Huỷ</button>
        </form>
    <% } %></p>
<% }} else { %>Không có sản phẩm nào đang giao.<% } %>

<h3>Đã huỷ</h3>
<% if (!cancelledItems.isEmpty()) {
    ProductDAO productDAO = new ProductDAO();
    for (String id : cancelledItems.keySet()) {
        Product product = productDAO.getProductById(Integer.parseInt(id)); %>
    <p><%= product.getName() %> - Lý do: <%= cancelledItems.get(id) %></p>
<% }} else { %>Không có sản phẩm nào đã huỷ.<% } %>
</body>
</html>
