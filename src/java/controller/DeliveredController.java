package controller;

import dal.OrderDAO;
import model.Order;
import model.Users;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.*;

@WebServlet("/Delivered")
public class DeliveredController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Users user = (Users) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        OrderDAO orderDAO = new OrderDAO();
        // Lấy đơn đã nhận, chưa đánh giá
        List<Order> notReviewed = orderDAO.getDeliveredOrders(user.getUserId(), false);
        // Lấy đơn đã nhận, đã đánh giá
        List<Order> reviewed = orderDAO.getDeliveredOrders(user.getUserId(), true);

        request.setAttribute("notReviewedOrders", notReviewed);
        request.setAttribute("reviewedOrders", reviewed);

        request.getRequestDispatcher("Delivered.jsp").forward(request, response);
    }
}
