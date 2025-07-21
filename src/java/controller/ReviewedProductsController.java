package controller;

import dal.OrderDetailDAO;
import dal.ProductDAO;
import dal.ReviewDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.OrderDetail;
import model.Product;
import model.Review;
import model.Users;

@WebServlet("/ReviewedProducts")
public class ReviewedProductsController extends HttpServlet {
    private ReviewDAO reviewDAO = new ReviewDAO();
    private ProductDAO productDAO = new ProductDAO();
    private OrderDetailDAO orderDetailDAO = new OrderDetailDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Users user = (Users) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect("Login.jsp");
            return;
        }
        int userId = user.getUserId();
        // Lấy danh sách review của user này
        List<Review> reviewedList = reviewDAO.getAllUserReviewedProducts(userId);

        // Tạo danh sách map để chứa thông tin chi tiết từng sản phẩm đã đánh giá
        List<Map<String, Object>> reviewedProducts = new ArrayList<>();
        for (Review r : reviewedList) {
            Map<String, Object> map = new HashMap<>();
            Product product = productDAO.getProductById(r.getProductId());
            OrderDetail detail = orderDetailDAO.getDetailByUserAndProduct(userId, r.getProductId());
            map.put("product", product);
            map.put("review", r);
            map.put("detail", detail);
            reviewedProducts.add(map);
        }
        request.setAttribute("reviewedProducts", reviewedProducts);
        request.getRequestDispatcher("ReviewedProducts.jsp").forward(request, response);
    }
}
