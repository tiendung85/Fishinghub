package controller;

import dal.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/OrderActionServlet")
public class OrderActionController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        int orderId = Integer.parseInt(req.getParameter("orderId"));
        String reason = req.getParameter("reason"); // null nếu ko có
        OrderDAO dao = new OrderDAO();

        if ("accept".equals(action)) {
            // Chuyển trạng thái sang Đang giao hàng (StatusID=2)
            dao.updateOrderStatus(orderId, 2);
        } else if ("reject".equals(action)) {
            // Chuyển trạng thái sang Đã hủy (StatusID=5) và cập nhật lý do
            dao.updateOrderStatusAndReason(orderId, 5, reason);
        } else if ("cancel".equals(action)) {
            // Người dùng hủy đơn chờ xác nhận
            dao.updateOrderStatusAndReason(orderId, 5, reason);
        }
        // Có thể kiểm tra vai trò, hoặc redirect về trang phù hợp hơn
        resp.sendRedirect("WaitingConfirmListServlet");
    }
}
