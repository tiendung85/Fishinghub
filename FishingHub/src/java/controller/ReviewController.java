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

@WebServlet("/ReviewController")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,
    maxFileSize = 10 * 1024 * 1024,
    maxRequestSize = 12 * 1024 * 1024
)
public class ReviewController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        String productIdRaw = request.getParameter("productId");
        int productId = -1;
        try {
            if (productIdRaw != null && productIdRaw.matches("\\d+")) {
                productId = Integer.parseInt(productIdRaw);
            }
        } catch (Exception ex) {
            productId = -1;
        }

        if (productId == -1) {
            session.setAttribute("message", "Thiếu mã sản phẩm để đánh giá.");
            response.sendRedirect("Delivered.jsp");
            return;
        }

        int rating = 0;
        try {
            rating = Integer.parseInt(request.getParameter("rating"));
        } catch (Exception e) {
            rating = 0;
        }
        String reviewText = request.getParameter("reviewText");
        if (reviewText == null) reviewText = "";

        if (reviewText.length() > 500) {
            session.setAttribute("message", "Nội dung đánh giá không được vượt quá 500 ký tự.");
            response.sendRedirect("Review.jsp?productId=" + productId);
            return;
        }

        String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        String imagePath = null, videoPath = null;

        Part imagePart = request.getPart("image");
        if (imagePart != null && imagePart.getSize() > 0) {
            if (imagePart.getSize() > 2 * 1024 * 1024) {
                session.setAttribute("message", "Ảnh vượt quá 2MB.");
                response.sendRedirect("Review.jsp?productId=" + productId);
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
                response.sendRedirect("Review.jsp?productId=" + productId);
                return;
            }
            String videoFileName = Paths.get(videoPart.getSubmittedFileName()).getFileName().toString();
            videoPart.write(uploadPath + File.separator + videoFileName);
            videoPath = "uploads/" + videoFileName;
        }

        Review review = new Review();
        review.setProductId(productId);
        review.setUserId(user.getUserId());
        review.setRating(rating);
        review.setReviewText(reviewText);
        review.setImage(imagePath);
        review.setVideo(videoPath);

        ReviewDAO reviewDAO = new ReviewDAO();
        boolean success = reviewDAO.saveReview(review);

        if (success) {
            session.setAttribute("message", "Đánh giá sản phẩm thành công!");
        } else {
            session.setAttribute("message", "Có lỗi xảy ra khi lưu đánh giá!");
        }
        response.sendRedirect("Delivered");
    }
}