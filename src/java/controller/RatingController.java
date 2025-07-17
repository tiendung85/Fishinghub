package controller;

import dal.ReviewDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Review;
import model.Users;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/RatingServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,
    maxFileSize = 10 * 1024 * 1024,        // 10MB cho mỗi file
    maxRequestSize = 12 * 1024 * 1024      // 12MB tổng form
)
public class RatingController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        int productId = Integer.parseInt(request.getParameter("productId"));
        int rating = Integer.parseInt(request.getParameter("rating"));
        String reviewText = request.getParameter("reviewText");
        if (reviewText.length() > 500) {
            session.setAttribute("message", "Nội dung đánh giá không được vượt quá 500 ký tự.");
            response.sendRedirect("RatingProduct.jsp?productId=" + productId);
            return;
        }

        // File xử lý
        String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        String imagePath = null, videoPath = null;

        Part imagePart = request.getPart("image");
        if (imagePart != null && imagePart.getSize() > 0) {
            if (imagePart.getSize() > 2 * 1024 * 1024) {
                session.setAttribute("message", "Ảnh vượt quá 2MB.");
                response.sendRedirect("RatingProduct.jsp?productId=" + productId);
                return;
            }
            String imageFileName = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
            imagePart.write(uploadPath + File.separator + imageFileName);
            imagePath = "uploads/" + imageFileName;
        }

        Part videoPart = request.getPart("video");
        if (videoPart != null && videoPart.getSize() > 0) {
            if (videoPart.getSize() > 10 * 1024 * 1024) {
                session.setAttribute("message", "Video vượt quá 10MB.");
                response.sendRedirect("RatingProduct.jsp?productId=" + productId);
                return;
            }
            String videoFileName = Paths.get(videoPart.getSubmittedFileName()).getFileName().toString();
            videoPart.write(uploadPath + File.separator + videoFileName);
            videoPath = "uploads/" + videoFileName;
        }

        // Lưu đánh giá
        Review review = new Review();
        review.setProductId(productId);
        review.setUserId(user.getUserId());
        review.setRating(rating);
        review.setReviewText(reviewText);
        review.setImage(imagePath);
        review.setVideo(videoPath);

        ReviewDAO reviewDAO = new ReviewDAO();
        boolean success = reviewDAO.saveReview(review);

        // --- CẬP NHẬT SESSION ---
        Map<String, Integer> deliveredItems = (Map<String, Integer>) session.getAttribute("DeliveredItems");
        Map<String, Integer> ratedItems = (Map<String, Integer>) session.getAttribute("RatedItems");
        if (deliveredItems == null) deliveredItems = new HashMap<>();
        if (ratedItems == null) ratedItems = new HashMap<>();
        String productIdStr = String.valueOf(productId);
        if (deliveredItems.containsKey(productIdStr)) {
            ratedItems.put(productIdStr, deliveredItems.get(productIdStr));
            deliveredItems.remove(productIdStr);
        }
        session.setAttribute("DeliveredItems", deliveredItems);
        session.setAttribute("RatedItems", ratedItems);

        // Thông báo
        if (success) {
            session.setAttribute("message", "Đánh giá sản phẩm thành công!");
        } else {
            session.setAttribute("message", "Có lỗi xảy ra khi lưu đánh giá!");
        }
        response.sendRedirect("ViewReview.jsp?productId=" + productId);
    }
}
