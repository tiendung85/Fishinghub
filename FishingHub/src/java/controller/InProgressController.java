package controller;

import dal.OrderDAO;
import dal.OrderDetailDAO;
import dal.ProductDAO;
import model.Order;
import model.OrderDetail;
import model.Product;
import model.Users;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.*;

@WebServlet("/InProgress")
public class InProgressController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // Lấy user hiện tại từ session
        Users user = (Users) req.getSession().getAttribute("user");
        if (user == null) {
            // Nếu chưa đăng nhập chuyển về trang login hoặc index tuỳ dự án
            resp.sendRedirect("login.jsp");
            return;
        }
        int userId = user.getUserId();

        OrderDAO orderDAO = new OrderDAO();
        ProductDAO productDAO = new ProductDAO();
        OrderDetailDAO orderDetailDAO = new OrderDetailDAO();

        // Lấy danh sách đơn hàng đang giao của user (StatusID = 2)
        List<Order> inProgressOrders = orderDAO.getOrdersByUserAndStatus(userId, 2);

        // Chuẩn bị map sản phẩm cho từng đơn
        Map<Integer, List<Map<String, Object>>> inProgressOrderProducts = new HashMap<>();
        for (Order order : inProgressOrders) {
            List<OrderDetail> details = orderDetailDAO.getDetailByOrderId(order.getId());
            List<Map<String, Object>> products = new ArrayList<>();
            for (OrderDetail d : details) {
                Product p = productDAO.getProductById(d.getProductId());
                Map<String, Object> map = new HashMap<>();
                map.put("product", p);
                map.put("detail", d);
                products.add(map);
            }
            inProgressOrderProducts.put(order.getId(), products);
        }

        req.setAttribute("inProgressOrders", inProgressOrders);
        req.setAttribute("inProgressOrderProducts", inProgressOrderProducts);
        req.getRequestDispatcher("InProgress.jsp").forward(req, resp);
    }
}