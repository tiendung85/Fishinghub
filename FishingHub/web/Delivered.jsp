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

                    <head>
                        <meta charset="UTF-8">
                        <title>Đã nhận & Đã đánh giá</title>
                        <!-- Google Fonts preconnect and import -->
                        <link rel="preconnect" href="https://fonts.googleapis.com">
                        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
                        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
                        <!-- Bootstrap CSS -->
                        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
                        <!-- Tailwind CSS CDN -->
                        <script src="https://cdn.tailwindcss.com"></script>
                        <style>
                            body {
                                font-family: 'Roboto', sans-serif;
                            }
                            
                            .tabs .active {
                                background: #0d6efd;
                                color: #fff;
                            }
                        </style>
                    </head>

                    <body class="bg-gray-50 min-h-screen py-4">
                        <div class="container bg-white rounded shadow p-4">
                            <div class="tabs mb-4 flex gap-2">
                                <button class="btn btn-outline-primary" onclick="window.location.href='InProgress.jsp'">Đang giao</button>
                                <button class="btn btn-outline-success active" onclick="window.location.href='Delivered.jsp'">Đã nhận</button>
                            </div>

                            <h3 class="mb-3 text-xl font-bold">Đã nhận</h3>
                            <% if (!deliveredItems.isEmpty()) {
            ProductDAO productDAO = new ProductDAO();
            for (String id : deliveredItems.keySet()) {
                if (!ratedItems.containsKey(id)) {
                    Product product = productDAO.getProductById(Integer.parseInt(id));
        %>
                                <div class="alert alert-success flex justify-between items-center mb-2">
                                    <span><%= product.getName() %> - Đã giao thành công</span>
                                    <a href="RatingProduct.jsp?productId=<%= id %>" class="btn btn-sm btn-warning ms-2">Đánh giá</a>
                                </div>
                                <% }}} else { %>
                                    <div class="alert alert-info">Không có sản phẩm nào đã nhận.</div>
                                    <% } %>

                                        <h3 class="mt-4 text-xl font-bold">Đã đánh giá</h3>
                                        <% if (!ratedItems.isEmpty()) {
            ProductDAO productDAO = new ProductDAO();
            for (String id : ratedItems.keySet()) {
                Product product = productDAO.getProductById(Integer.parseInt(id));
        %>
                                            <div class="alert alert-secondary flex justify-between items-center mb-2">
                                                <span><%= product.getName() %></span>
                                                <a href="ViewReview.jsp?productId=<%= id %>" class="btn btn-sm btn-outline-primary ms-2">Xem đánh giá</a>
                                            </div>
                                            <% }} else { %>
                                                <div class="alert alert-info">Chưa có sản phẩm nào được đánh giá.</div>
                                                <% } %>
                                                    <div class="mt-4">
                                                        <a href="ShopingCart.jsp" class="text-primary">&larr; Quay lại trang sản phẩm</a>
                                                    </div>
                        </div>
                        <!-- Bootstrap JS -->
                        <script src