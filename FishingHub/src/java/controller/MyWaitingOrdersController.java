package controller;

import dal.OrderDAO;
import dal.OrderDetailDAO;
import dal.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Order;
import model.OrderDetail;
import model.Product;
import model.Users;

import java.io.IOException;
import java.util.*;

@WebServlet("/MyWaitingOrders")
public class MyWaitingOrdersController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Users user = (Users) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect("Login.jsp");
            return;
        }
        int userId = user.getUserId();
        OrderDAO orderDAO = new OrderDAO();
        ProductDAO productDAO = new ProductDAO();
        OrderDetailDAO orderDetailDAO = new OrderDetailDAO();

        List<Order> waitingOrders = orderDAO.getOrdersByUserIdAndStatus(userId, 1); // 1: chờ xác nhận
        Map<Integer, List<Map<String, Object>>> waitingOrderProducts = new HashMap<>();

        for (Order order : waitingOrders) {
            List<OrderDetail> details = orderDetailDAO.getDetailByOrderId(order.getId());
            List<Map<String, Object>> products = new ArrayList<>();
            for (OrderDetail d : details) {
                Product p = productDAO.getProductById(d.getProductId());
                Map<String, Object> map = new HashMap<>();
                map.put("product", p);
                map.put("detail", d);
                products.add(map);
            }
            waitingOrderProducts.put(order.getId(), products);
        }

        request.setAttribute("waitingOrders", waitingOrders);
        request.setAttribute("waitingOrderProducts", waitingOrderProducts);
        request.getRequestDispatcher("MyWaitingOrders.jsp").forward(request, response);
    }
}