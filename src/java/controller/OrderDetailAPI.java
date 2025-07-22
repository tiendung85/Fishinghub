
import dal.OrderDAO;
import dal.OrderDetailDAO;
import dal.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import model.Order;
import model.OrderDetail;
import model.Product;



@WebServlet(name = "OrderDetailAPI", urlPatterns = {"/OrderDetailAPI"})
public class OrderDetailAPI extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    String orderIdStr = request.getParameter("orderId");
    response.setContentType("text/html;charset=UTF-8");
    try {
        if (orderIdStr == null) {
            response.getWriter().write("<div style='color:red;'>Không có mã đơn hàng hợp lệ!</div>");
            return;
        }
        int orderId = Integer.parseInt(orderIdStr);

        OrderDAO orderDAO = new OrderDAO();
        OrderDetailDAO detailDAO = new OrderDetailDAO();
        ProductDAO productDAO = new ProductDAO();

        Order order = orderDAO.getOrderById(orderId);
        if (order == null) {
            response.getWriter().write("<div style='color:red;'>Không tìm thấy đơn hàng này!</div>");
            return;
        }
        List<OrderDetail> detailList = detailDAO.getDetailByOrderId(orderId);

        StringBuilder html = new StringBuilder();
        html.append("<h2 style='font-size:18px;font-weight:600;margin-bottom:12px'>Đơn hàng #ORD-").append(order.getId()).append("</h2>");
        html.append("<div style='margin-bottom:10px;'><b>Khách hàng:</b> ").append(order.getCustomerName()).append("</div>");
        html.append("<div style='margin-bottom:16px;'><b>Ngày đặt:</b> ")
            .append(new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm").format(order.getOrderDate())).append("</div>");
        html.append("<table style='width:100%;border-collapse:collapse;font-size:14px;'><tr>")
            .append("<th align='left'>Ảnh</th><th align='left'>Sản phẩm</th><th>SL</th><th>Giá</th><th>Thành tiền</th></tr>");
        for (OrderDetail d : detailList) {
            Product p = productDAO.getProductById(d.getProductId());
            html.append("<tr>")
                .append("<td><img src='").append(p.getImage()).append("' width='50' style='border-radius:6px'/></td>")
                .append("<td>").append(p.getName()).append("</td>")
                .append("<td align='center'>").append(d.getCartQuantity()).append("</td>")
                .append("<td align='right'>").append(String.format("%,.0f", d.getPrice())).append(" ₫</td>")
                .append("<td align='right'>").append(String.format("%,.0f", d.getPrice()*d.getCartQuantity())).append(" ₫</td>")
                .append("</tr>");
        }
        html.append("</table>");
        html.append("<div style='margin-top:16px;text-align:right;font-size:16px;font-weight:600;'>Tổng tiền: ")
            .append(String.format("%,.0f", order.getTotal())).append(" ₫</div>");
        response.getWriter().write(html.toString());
    } catch (Exception e) {
        response.getWriter().write("<div style='color:red;'>Không lấy được chi tiết đơn hàng.<br>Chi tiết lỗi: " + e.getMessage() + "</div>");
    }
}

}
