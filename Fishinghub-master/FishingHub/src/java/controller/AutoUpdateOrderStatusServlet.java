package controller;

import dal.OrderDAO;
import model.Order;
import model.Users;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;

@WebServlet("/AutoUpdateOrderStatus")
public class AutoUpdateOrderStatusServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        int userId = user.getUserId();
        OrderDAO orderDAO = new OrderDAO();

        // Lấy tất cả các đơn hàng đang giao (StatusID = 2)
        List<Order> inProgressOrders = orderDAO.getOrdersByUserIdAndStatus(userId, 2);

        long now = System.currentTimeMillis();
        for (Order order : inProgressOrders) {
            Timestamp deliveryTime = order.getDeliveryTime(); // Giả sử đã có trường này ở model.Order
            if (deliveryTime != null && now >= deliveryTime.getTime()) {
                orderDAO.updateOrderStatus(order.getId(), 3); // 3 = Đã nhận
            }
        }
        // Sau khi update xong thì forward sang Delivered.jsp
        request.getRequestDispatcher("Delivered.jsp").forward(request, response);
    }
}
