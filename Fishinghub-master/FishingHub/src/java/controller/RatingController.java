package controller;

import dal.ReviewDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.Review;
import model.Users;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

@WebServlet("/RatingServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
    maxFileSize = 1024 * 1024 * 10,       // 10MB
    maxRequestSize = 1024 * 1024 * 50     // 50MB
)
public class RatingController extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        Users user = (Users) request.getSession().getAttribute("user");

        if (user == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        int productId = Integer.parseInt(request.getParameter("productId"));
        int rating = Integer.parseInt(request.getParameter("rating"));
        String reviewText = request.getParameter("reviewText");

        Part imagePart = request.getPart("image");
        Part videoPart = request.getPart("video");

        String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        String imagePath = null, videoPath = null;

        // Xử lý upload ảnh
        if (imagePart != null && imagePart.getSize() > 0) {
            String imageFileName = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
            imagePart.write(uploadPath + File.separator + imageFileName);
            imagePath = "uploads/" + imageFileName;
        }

        // Xử lý upload video
        if (videoPart != null && videoPart.getSize() > 0) {
            String videoFileName = Paths.get(videoPart.getSubmittedFileName()).getFileName().toString();
            videoPart.write(uploadPath + File.separator + videoFileName);
            videoPath = "uploads/" + videoFileName;
        }

        // Lưu thông tin vào database
        Review review = new Review();
        review.setProductId(productId);
        review.setRating(rating);
        review.setReviewText(reviewText);
        review.setImage(imagePath);
        review.setVideo(videoPath);

        ReviewDAO reviewDAO = new ReviewDAO();
        boolean success = reviewDAO.saveReview(review);

        if (success) {
            request.setAttribute("message", "Đánh giá sản phẩm thành công!");
        } else {
            request.setAttribute("message", "Có lỗi xảy ra khi lưu đánh giá!");
        }

        request.getRequestDispatcher("Delivered.jsp").forward(request, response);
    }
}
