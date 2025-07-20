package controller;

import dal.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import model.Users;

@WebServlet("/OrderActionServlet")
public class OrderActionController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        int orderId = Integer.parseInt(req.getParameter("orderId"));
        OrderDAO dao = new OrderDAO();

        Users user = (Users) req.getSession().getAttribute("user");
        String role = (user != null && user.getRole() != null) ? user.getRole() : "";

        if ("approve".equals(action)) {
            // Người bán duyệt đơn -> Đang giao (StatusID = 2)
            dao.updateOrderStatus(orderId, 2);
            resp.sendRedirect("WaitingConfirmListServlet");
            return;
        } else if ("reject".equals(action)) {
            // Người bán từ chối -> Đã huỷ (StatusID = 5)
            dao.updateOrderStatus(orderId, 5);
            resp.sendRedirect("WaitingConfirmListServlet");
            return;
        } else if ("cancel".equals(action)) {
            // Người mua hủy đơn
            dao.updateOrderStatus(orderId, 5);
            // Popup sẽ hiện dựa vào tham số trên URL, không cần session message nữa
            resp.sendRedirect("MyWaitingOrders.jsp?canceled=1");
            return;
        } else if ("received".equals(action)) {
            // Người mua xác nhận đã nhận hàng (StatusID = 3)
            dao.updateOrderStatus(orderId, 3);
            resp.sendRedirect("InProgress.jsp?received=1");
            return;
        }
        // fallback nếu không đúng action
        resp.sendRedirect("index.jsp");
    }
}
