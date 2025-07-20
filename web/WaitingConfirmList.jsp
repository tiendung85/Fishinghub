<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.Order, java.util.*, model.OrderDetail, model.Product" %>
<%
    List<Order> orders = (List<Order>) request.getAttribute("orders");
    Map<Integer, List<Map<String, Object>>> orderProducts = (Map<Integer, List<Map<String, Object>>>) request.getAttribute("orderProducts");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Đơn Hàng Chờ Xác Nhận</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f8f9fa; margin: 0; padding: 0; }
        .container { max-width: 1200px; margin: 32px auto; background: white; border-radius: 10px; box-shadow: 0 0 8px #ddd; padding: 32px; }
        h1 { text-align: center; color: #007bff; }
        .order-block { border-bottom: 1px solid #e0e0e0; margin-bottom: 28px; padding-bottom: 16px; position: relative;}
        .order-meta { font-size: 15px; color: #444; }
        .products-table { width: 100%; margin-top: 8px; border-collapse: collapse; }
        .products-table th, .products-table td { border: 1px solid #d9d9d9; padding: 8px; text-align: center; }
        .products-table th { background: #f1f1f1; }
        .order-sum { font-weight: bold; color: #c00; margin-top: 6px; }
        .method { font-weight: bold; color: #1976d2;}
        .order-actions { position: absolute; right: 10px; top: 6px;}
        .btn { padding: 7px 16px; border: none; border-radius: 5px; font-weight: 600; cursor: pointer;}
        .btn-success { background: #43b543; color: white;}
        .btn-danger { background: #ff4444; color: white;}
        /* Popup modal */
        .modal { display:none; position:fixed; z-index:9999; left:0;top:0;width:100vw;height:100vh;background:rgba(0,0,0,0.4);}
        .modal-content {background:#fff;padding:20px;margin:10% auto;width:350px;border-radius:8px;box-shadow:0 2px 12px #888;}
    </style>
</head>
<body>
<div class="container">
    <h1>Đơn Hàng Chờ Xác Nhận</h1>
    <%
    if (orders == null || orders.isEmpty()) {
    %>
    <div style="background:#ccefff;padding:16px;border-radius:6px;margin-bottom:20px;">
        Không có đơn hàng nào chờ xác nhận.
    </div>
    <a href="Product.jsp" style="background: #777; color:white; padding:10px 20px; border-radius:6px; text-decoration:none;">← Quay lại trang sản phẩm</a>
    <%
    } else {
        for (Order order : orders) {
            List<Map<String, Object>> products = orderProducts.get(order.getId());
            double sum = 0;
    %>
    <div class="order-block">
        <div class="order-meta">
            <b>Đơn #<%=order.getId()%></b> -
            Thời gian đặt: <%= order.getOrderDate() %> -
            <span class="method">Thanh toán: <%= order.getPaymentMethod() %></span>
        </div>
        <!-- Nút Chấp thuận / Từ chối -->
        <div class="order-actions">
            <form method="post" action="OrderActionServlet" style="display:inline;">
                <input type="hidden" name="orderId" value="<%= order.getId() %>"/>
                <input type="hidden" name="action" value="approve"/>
                <button type="submit" class="btn btn-success">Chấp thuận</button>
            </form>
            <button type="button" class="btn btn-danger"
                onclick="showRejectBox(<%=order.getId()%>)">Từ chối</button>
        </div>
        <table class="products-table">
            <tr>
                <th>Tên sản phẩm</th>
                <th>Số lượng</th>
                <th>Đơn giá</th>
                <th>Thành tiền</th>
            </tr>
            <%
            if (products != null && !products.isEmpty()) {
                for (Map<String, Object> pmap : products) {
                    Product product = (Product) pmap.get("product");
                    OrderDetail d = (OrderDetail) pmap.get("detail");
                    sum += d.getSubtotal();
            %>
            <tr>
                <td><%=product != null ? product.getName() : "N/A"%></td>
                <td><%=d.getCartQuantity()%></td>
                <td><%=String.format("%,.0f", d.getPrice())%>₫</td>
                <td><%=String.format("%,.0f", d.getSubtotal())%>₫</td>
            </tr>
            <%  }
            } else { %>
            <tr>
                <td colspan="4" style="color:gray;">Không có sản phẩm nào trong đơn này!</td>
            </tr>
            <% } %>
        </table>
        <div class="order-sum">Tổng đơn: <%=String.format("%,.0f", sum)%>₫</div>
    </div>

    <!-- Popup nhập lý do từ chối -->
    <div id="rejectBox_<%=order.getId()%>" class="modal">
        <div class="modal-content">
            <form method="post" action="OrderActionServlet">
                <input type="hidden" name="orderId" value="<%=order.getId()%>"/>
                <input type="hidden" name="action" value="reject"/>
                <label>Lý do từ chối:</label>
                <textarea name="reason" required rows="3" style="width:100%;margin-bottom:12px"></textarea>
                <div style="text-align:right;">
                    <button type="button" onclick="closeRejectBox(<%=order.getId()%>)" class="btn" style="background:#aaa;">Huỷ</button>
                    <button type="submit" class="btn btn-danger">Xác nhận từ chối</button>
                </div>
            </form>
        </div>
    </div>
    <%  } // end for order
    } %>
</div>

<script>
function showRejectBox(orderId) {
    document.getElementById("rejectBox_" + orderId).style.display = "block";
}
function closeRejectBox(orderId) {
    document.getElementById("rejectBox_" + orderId).style.display = "none";
}
</script>
</body>
</html>
