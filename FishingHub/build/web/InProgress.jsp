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

    long now = System.currentTimeMillis();

    // Tự động chuyển sang đã giao nếu hết thời gian
    Map<String, Integer> tempOrdered = new HashMap<>(orderedItems);
    for (String id : tempOrdered.keySet()) {
        long deliveryTime = deliveryTimes.get(id);
        if (now >= deliveryTime) {
            deliveredItems.put(id, orderedItems.get(id));
            orderedItems.remove(id);
            deliveryTimes.remove(id);
        }
    }

    // Xử lý huỷ đơn
    String cancelId = request.getParameter("cancelNow");
    if (cancelId != null && orderedItems.containsKey(cancelId)) {
        long timeLeft = deliveryTimes.get(cancelId) - now;
        if (timeLeft > 60000) {
            String reason = request.getParameter("reason_" + cancelId);
            if (reason != null && !reason.trim().isEmpty()) {
                cancelledItems.put(cancelId, reason.trim());
                orderedItems.remove(cancelId);
                deliveryTimes.remove(cancelId);
                session.setAttribute("CancelledItems", cancelledItems);
                out.println("<script>alert('Huỷ giao hàng thành công');location='InProgress.jsp';</script>");
                return;
            } else {
                out.println("<script>alert('Bạn phải nhập lý do huỷ đơn.');location='InProgress.jsp';</script>");
                return;
            }
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

                    <head>
                        <meta charset="UTF-8">
                        <title>Đang giao</title>
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
                        <script>
                            function validateCancelForm(form) {
                                const textarea = form.querySelector("textarea");
                                if (!textarea.value.trim()) {
                                    alert("Vui lòng nhập lý do huỷ đơn hàng.");
                                    textarea.focus();
                                    return false;
                                }
                                return true;
                            }
                        </script>
                    </head>

                    <body class="bg-gray-50 min-h-screen py-4">
                        <div class="container bg-white rounded shadow p-4">
                            <div class="tabs mb-4 flex gap-2">
                                <button class="btn btn-outline-primary active" onclick="window.location.href='InProgress.jsp'">Đang giao</button>
                                <button class="btn btn-outline-success" onclick="window.location.href='Delivered.jsp'">Đã nhận</button>
                            </div>
                            <h3 class="mb-3 text-xl font-bold">Đang giao</h3>
                            <% if (!orderedItems.isEmpty()) {
            ProductDAO productDAO = new ProductDAO();
        %>
                                <div class="list-group mb-4">
                                    <% for (String id : orderedItems.keySet()) {
                long timeLeft = deliveryTimes.get(id) - now;
                Product product = productDAO.getProductById(Integer.parseInt(id));
            %>
                                        <div class="list-group-item flex flex-col md:flex-row md:items-center justify-between gap-2">
                                            <div>
                                                <span class="fw-bold"><%= product.getName() %></span>
                                                <span class="text-muted ms-2">Giao trước: <%= new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm:ss").format(new java.util.Date(deliveryTimes.get(id))) %></span>
                                            </div>
                                            <% if (timeLeft > 60000) { %>
                                                <form method="post" class="flex flex-col md:flex-row gap-2 items-center" onsubmit="return validateCancelForm(this);">
                                                    <textarea name="reason_<%= id %>" class="form-control w-64" placeholder="Lý do huỷ..." required></textarea>
                                                    <button type="submit" name="cancelNow" value="<%= id %>" class="btn btn-danger">Huỷ</button>
                                                </form>
                                                <% } %>
                                        </div>
                                        <% } %>
                                </div>
                                <% } else { %>
                                    <div class="alert alert-info">Không có sản phẩm nào đang giao.</div>
                                    <% } %>

                                        <h3 class="mt-4 text-xl font-bold">Đã huỷ</h3>
                                        <% if (!cancelledItems.isEmpty()) {
            ProductDAO productDAO = new ProductDAO();
        %>
                                            <div class="list-group">
                                                <% for (String id : cancelledItems.keySet()) {
                Product product = productDAO.getProductById(Integer.parseInt(id));
            %>
                                                    <div class="list-group-item">
                                                        <span class="fw-bold"><%= product.getName() %></span>
                                                        <span class="text-danger ms-2">Lý do: <%= cancelledItems.get(id) %></span>
                                                    </div>
                                                    <% } %>
                                            </div>
                                            <% } else { %>
                                                <div class="alert alert-info">Không có sản phẩm nào đã huỷ.</div>
                                                <% } %>
                                                    <div class="mt-4">
                                                        <a href="ShopingCart.jsp" class="text-primary">&larr; Quay lại trang sản phẩm</a>
                                                    </div>
                        </div>
                        <!-- Bootstrap JS -->