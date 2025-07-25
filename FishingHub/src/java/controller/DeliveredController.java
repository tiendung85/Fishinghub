package controller;

import dal.OrderDAO;
import dal.OrderDetailDAO;
import dal.ProductDAO;
import dal.ReviewDAO;
import model.Order;
import model.OrderDetail;
import model.Product;
import model.Users;
import java.io.IOException;
import java.util.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Review;

@WebServlet("/Delivered")
public class DeliveredController extends HttpServlet {
    private OrderDAO orderDAO = new OrderDAO();
    private OrderDetailDAO orderDetailDAO = new OrderDetailDAO();
    private ProductDAO productDAO = new ProductDAO();
    private ReviewDAO reviewDAO = new ReviewDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Users user = (Users) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect("Login.jsp");
            return;
        }
        int userId = user.getUserId();

        // Lấy danh sách đơn hàng đã nhận (StatusID=3)
        List<Order> deliveredOrders = orderDAO.getDeliveredOrders(userId, false);
        List<Map<String, Object>> productsToReview = new ArrayList<>();

        for (Order order : deliveredOrders) {
            List<OrderDetail> details = orderDetailDAO.getDetailByOrderId(order.getId());
            for (OrderDetail detail : details) {
                Product product = productDAO.getProductById(detail.getProductId());
                // Kiểm tra user đã đánh giá sản phẩm này chưa
                boolean reviewed = reviewDAO.hasUserReviewedProduct(userId, product.getProductId(), order.getId());
                    if (!reviewed) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("order", order);
                    map.put("product", product);
                    map.put("detail", detail);
                    productsToReview.add(map);
}

            }
        }
        request.setAttribute("productsToReview", productsToReview);
        request.getRequestDispatcher("Delivered.jsp").forward(request, response);
    }
}