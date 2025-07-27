<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.Order, java.util.*, model.OrderDetail, model.Product" %>
<%
    List<Order> waitingOrders = (List<Order>) request.getAttribute("waitingOrders");
    Map<Integer, List<Map<String, Object>>> waitingOrderProducts = (Map<Integer, List<Map<String, Object>>>) request.getAttribute("waitingOrderProducts");
%>
<!DOCTYPE html>
<html>
<style>
.tabs {
    display: flex;
    justify-content: center;
    margin-bottom: 20px;
}

.tabs .btn-tab {
    background-color: #87CEFA;
    border: none;
    color: white;
    padding: 10px 20px;
    margin: 0 5px;
    font-size: 16px;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

.tabs .btn-tab.active {
    background-color: #007BFF; /* Đậm hơn để nhận biết nút hiện tại */
}

.tabs .btn-tab:hover {
    background-color: #5aaef9;
}
</style>
<div class="tabs">
    <button class="btn-tab active" onclick="window.location.href='MyWaitingOrders'">Chờ xác nhận</button>
    <button class="btn-tab" onclick="window.location.href='InProgress'">Đang giao</button>
    <button class="btn-tab" onclick="window.location.href='Delivered'">Đã nhận</button>
</div>

    <title>Đơn hàng chờ xác nhận</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { font-family: 'Roboto', sans-serif; background-color: #f8f9fa; }
        .container { max-width: 1200px; margin: 32px auto; background: white; border-radius: 10px; box-shadow: 0 0 8px #ddd; padding: 32px; }
        .order-block { border-bottom: 1px solid #e0e0e0; margin-bottom: 28px; padding-bottom: 16px; position: relative;}
        .order-meta { font-size: 15px; color: #444; }
        .products-table { width: 100%; margin-top: 8px; border-collapse: collapse; }
        .products-table th, .products-table td { border: 1px solid #d9d9d9; padding: 8px; text-align: center; }
        .products-table th { background: #f1f1f1; }
        .order-sum { font-weight: bold; color: #c00; margin-top: 6px; }
        .btn-danger { background: #ff4444; color: white; border:none; padding: 7px 16px; border-radius: 5px; font-weight: 600; cursor: pointer;}
        .modal { display:none; position:fixed; z-index:9999; left:0;top:0;width:100vw;height:100vh;background:rgba(0,0,0,0.4);}
        .modal-content {background:#fff;padding:20px;margin:10% auto;width:350px;border-radius:8px;box-shadow:0 2px 12px #888;}
        /* Toast Notification */
        .toast { visibility: hidden; min-width: 250px; margin-left: -125px; background-color: #4CAF50;
            color: white; text-align: center; border-radius: 8px; padding: 16px; position: fixed;
            z-index: 99999; left: 50%; top: 40px; font-size: 17px; box-shadow: 0 2px 8px #888;
            opacity: 0; transition: opacity 0.3s, visibility 0.3s; }
        .toast.show { visibility: visible; opacity: 1; }
    </style>
</head>
<body>
<div class="container">
    <h1 style="color:#007bff;">Đơn hàng chờ xác nhận của bạn</h1>
    <%
    if (waitingOrders == null || waitingOrders.isEmpty()) {
    %>
    <div class="alert alert-info">Không có đơn hàng nào chờ xác nhận.</div>
    <%
    } else {
        for (Order order : waitingOrders) {
            List<Map<String, Object>> products = waitingOrderProducts.get(order.getId());
            double sum = 0;
    %>
    <div class="order-block">
        <div class="order-meta">
            <b>Đơn #<%=order.getId()%></b> -
            Thời gian đặt: <%= order.getOrderDate() %> -
            <span class="method">Thanh toán: <%= order.getPaymentMethod() %></span>
        </div>
        <form method="post" action="OrderActionServlet" style="position: absolute; right: 10px; top: 6px;">
            <input type="hidden" name="orderId" value="<%= order.getId() %>"/>
            <input type="hidden" name="action" value="cancel"/>
            <button type="button" class="btn-danger" onclick="showCancelBox(<%=order.getId()%>)">Hủy đơn</button>
        </form>
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

    <!-- Modal xác nhận hủy -->
    <div id="cancelBox_<%=order.getId()%>" class="modal">
        <div class="modal-content">
            <form method="post" action="OrderActionServlet">
                <input type="hidden" name="orderId" value="<%=order.getId()%>"/>
                <input type="hidden" name="action" value="cancel"/>
                <p>Bạn chắc chắn muốn hủy đơn hàng này?</p>
                <div style="text-align:right;">
                    <button type="button" onclick="closeCancelBox(<%=order.getId()%>)" class="btn" style="background:#aaa;">Huỷ</button>
                    <button type="submit" class="btn-danger">Xác nhận hủy</button>
                </div>
            </form>
        </div>
    </div>
    <%  } // end for order
    } %>

    <!-- Toast notification popup -->
    <div id="toast" class="toast"></div>
</div>

<script>
function showCancelBox(orderId) {
    document.getElementById("cancelBox_" + orderId).style.display = "block";
}
function closeCancelBox(orderId) {
    document.getElementById("cancelBox_" + orderId).style.display = "none";
}

// Toast notification
function showToast(msg) {
    var toast = document.getElementById("toast");
    toast.innerText = msg;
    toast.className = "toast show";
    toast.style.display = "block";
    setTimeout(function() {
        toast.className = toast.className.replace("show", "");
        toast.style.display = "none";
    }, 2000);
}

// Khi nhận về ?canceled=1 sẽ hiện toast thành công
window.onload = function() {
    const urlParams = new URLSearchParams(window.location.search);
    if (urlParams.get('canceled') === '1') {
        showToast("Hủy đơn hàng thành công!");
        // Xóa tham số để toast không hiện lại khi reload
        if (window.history.replaceState) {
            let url = window.location.href.split('?')[0];
            window.history.replaceState({}, document.title, url);
        }
    }
};
</script>
</body>
</html>