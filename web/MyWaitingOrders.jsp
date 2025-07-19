<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.Order, java.util.*, model.OrderDetail, model.Product" %>
<%
    List<Order> myWaitingOrders = (List<Order>) request.getAttribute("myWaitingOrders");
    Map<Integer, List<Map<String, Object>>> myWaitingOrderProducts = (Map<Integer, List<Map<String, Object>>>) request.getAttribute("myWaitingOrderProducts");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Đơn Đang Chờ Xác Nhận</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f8f9fa; margin: 0; padding: 0; }
        .container { max-width: 1200px; margin: 32px auto; background: white; border-radius: 10px; box-shadow: 0 0 8px #ddd; padding: 32px; }
        h1 { text-align: center; color: #1976d2; }
        .order-block { border-bottom: 1px solid #e0e0e0; margin-bottom: 28px; padding-bottom: 16px; position: relative;}
        .order-meta { font-size: 15px; color: #444; }
        .products-table { width: 100%; margin-top: 8px; border-collapse: collapse; }
        .products-table th, .products-table td { border: 1px solid #d9d9d9; padding: 8px; text-align: center; }
        .products-table th { background: #f1f1f1; }
        .order-sum { font-weight: bold; color: #c00; margin-top: 6px; }
        .method { font-weight: bold; color: #1976d2;}
        .order-actions { position: absolute; right: 10px; top: 6px;}
        .btn { padding: 7px 16px; border: none; border-radius: 5px; font-weight: 600; cursor: pointer;}
        .btn-danger { background: #ff4444; color: white;}
        .modal { display:none; position:fixed; z-index:9999; left:0;top:0;width:100vw;height:100vh;background:rgba(0,0,0,0.4);}
        .modal-content {background:#fff;padding:20px;margin:10% auto;width:350px;border-radius:8px;box-shadow:0 2px 12px #888;}
    </style>
</head>
<body>
<div class="container">
    <h1>Đơn Đang Chờ Xác Nhận</h1>
    <%
    if (myWaitingOrders == null || myWaitingOrders.isEmpty()) {
    %>
    <div style="background:#ccefff;padding:16px;border-radius:6px;margin-bottom:20px;">
        Bạn không có đơn hàng nào đang chờ xác nhận.
    </div>
    <a href="Product.jsp" style="background: #777; color:white; padding:10px 20px; border-radius:6px; text-decoration:none;">← Quay lại trang sản phẩm</a>
    <%
    } else {
        for (Order order : myWaitingOrders) {
            List<Map<String, Object>> products = myWaitingOrderProducts.get(order.getId());
            double sum = 0;
    %>
    <div class="order-block">
        <div class="order-meta">
            <b>Đơn #<%=order.getId()%></b> -
            Thời gian đặt: <%= order.getOrderDate() %> -
            <span class="method">Thanh toán: <%= order.getPaymentMethod() %></span>
        </div>
        <!-- Nút Hủy đơn -->
        <div class="order-actions">
            <button type="button" class="btn btn-danger"
                onclick="showCancelBox(<%=order.getId()%>)">Hủy đơn</button>
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

    <!-- Popup nhập lý do hủy -->
    <div id="cancelBox_<%=order.getId()%>" class="modal">
        <div class="modal-content">
            <form method="post" action="OrderActionServlet">
                <input type="hidden" name="orderId" value="<%=order.getId()%>"/>
                <input type="hidden" name="action" value="cancel"/>
                <label>Lý do hủy đơn:</label>
                <textarea name="reason" required rows="3" style="width:100%;margin-bottom:12px"></textarea>
                <div style="text-align:right;">
                    <button type="button" onclick="closeCancelBox(<%=order.getId()%>)" class="btn" style="background:#aaa;">Huỷ bỏ</button>
                    <button type="submit" class="btn btn-danger">Xác nhận hủy đơn</button>
                </div>
            </form>
        </div>
    </div>
    <%  } // end for order
    } %>
</div>
<script>
function showCancelBox(orderId) {
    document.getElementById("cancelBox_" + orderId).style.display = "block";
}
function closeCancelBox(orderId) {
    document.getElementById("cancelBox_" + orderId).style.display = "none";
}
</script>
</body>
</html>
