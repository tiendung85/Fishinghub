<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map,java.util.HashMap" %>
<%@ page import="model.Product" %>
<%@ page import="dal.ProductDAO" %>

<%
    Map<String, Integer> orderedItems = (Map<String, Integer>) session.getAttribute("OrderedItems");
    Map<String, Long> deliveryTimes = (Map<String, Long>) session.getAttribute("DeliveryTimes");
    Map<String, Integer> deliveredItems = (Map<String, Integer>) session.getAttribute("DeliveredItems");
    Map<String, Integer> ratedItems = (Map<String, Integer>) session.getAttribute("RatedItems");

    if (orderedItems == null) orderedItems = new HashMap<>();
    if (deliveryTimes == null) deliveryTimes = new HashMap<>();
    if (deliveredItems == null) deliveredItems = new HashMap<>();
    if (ratedItems == null) ratedItems = new HashMap<>();

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

    session.setAttribute("OrderedItems", orderedItems);
    session.setAttribute("DeliveryTimes", deliveryTimes);
    session.setAttribute("DeliveredItems", deliveredItems);
    session.setAttribute("RatedItems", ratedItems);
%>

<!DOCTYPE html>
<html>
<head><title>Đã nhận & Đã đánh giá</title></head>
<body>
<div class="tabs">
    <button onclick="window.location.href='PendingOrder.jsp'">Chờ xác nhận</button>
    <button onclick="window.location.href='InProgress.jsp'">Đang giao</button>
    <button onclick="window.location.href='Delivered.jsp'">Đã nhận</button>
</div>

<h3>Đã nhận</h3>
<% if (!deliveredItems.isEmpty()) {
    ProductDAO productDAO = new ProductDAO();
    for (String id : deliveredItems.keySet()) {
        if (!ratedItems.containsKey(id)) {
            Product product = productDAO.getProductById(Integer.parseInt(id)); %>
    <p><%= product.getName() %> - Đã giao thành công
    <a href="RatingProduct.jsp?productId=<%= id %>">Đánh giá</a></p>
<% }}} else { %>Không có sản phẩm nào đã nhận.<% } %>

<h3>Đã đánh giá</h3>
<% if (!ratedItems.isEmpty()) {
    ProductDAO productDAO = new ProductDAO();
    for (String id : ratedItems.keySet()) {
        Product product = productDAO.getProductById(Integer.parseInt(id)); %>
    <p><%= product.getName() %> - <a href="ViewReview.jsp?productId=<%= id %>">Xem đánh giá</a></p>
<% }} else { %>Chưa có sản phẩm nào được đánh giá.<% } %>
</body>
</html>
