package controller;

import dal.OrderDAO;
import dal.OrderDetailDAO;
import dal.ProductDAO;
import model.Order;
import model.OrderDetail;
import model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.*;

@WebServlet("/WaitingConfirmListServlet")
public class WaitingConfirmListController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        OrderDAO orderDAO = new OrderDAO();
        ProductDAO productDAO = new ProductDAO();
        List<Order> orders = orderDAO.getAllWaitingConfirmOrders();
        Map<Integer, List<Map<String, Object>>> orderProducts = new HashMap<>();
        OrderDetailDAO orderDetailDAO = new OrderDetailDAO(); // Move outside the loop for efficiency
        for (Order order : orders) {
            List<OrderDetail> details = orderDetailDAO.getDetailByOrderId(order.getId());
            List<Map<String, Object>> products = new ArrayList<>();
            for (OrderDetail d : details) {
                Product p = productDAO.getProductById(d.getProductId());
                Map<String, Object> map = new HashMap<>();
                map.put("product", p);
                map.put("detail", d);
                products.add(map);
            }
            orderProducts.put(order.getId(), products);
        }
        request.setAttribute("orders", orders);
        request.setAttribute("orderProducts", orderProducts);
        request.getRequestDispatcher("WaitingConfirmList.jsp").forward(request, response);
    }
}
