package controller;

import dal.ProductDAO;
import dal.ReviewDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import model.Review;
import model.Users;

@WebServlet("/ReviewedProducts")
public class ReviewedProductsController extends HttpServlet {
    private ReviewDAO reviewDAO = new ReviewDAO();
    private ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Users user = (Users) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect("Login.jsp");
            return;
        }
        int userId = user.getUserId();
        // Lấy tất cả các review của user này (mỗi sản phẩm chỉ 1 review cho mỗi đơn hàng)
        List<Review> reviewedList = reviewDAO.getAllUserReviewedProducts(userId);
        request.setAttribute("reviewedList", reviewedList);
        request.getRequestDispatcher("ReviewedProducts.jsp").forward(request, response);
    }
}
