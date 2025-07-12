package dal;

import model.Review;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReviewDAO extends DBConnect {

    public boolean saveReview(Review review) {
        String sql = "INSERT INTO Review (productId, userId, rating, reviewText, image, video) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, review.getProductId());
            ps.setInt(2, review.getUserId());
            ps.setInt(3, review.getRating());
            ps.setString(4, review.getReviewText());
            ps.setString(5, review.getImage());
            ps.setString(6, review.getVideo());
            int result = ps.executeUpdate();
            return result > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public Review getReviewByProductIdAndUserId(int productId, int userId) {
        Review review = null;
        try {
            String sql = "SELECT TOP 1 * FROM Review WHERE productId = ? AND userId = ? ORDER BY id DESC";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, productId);
            ps.setInt(2, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                review = new Review();
                review.setId(rs.getInt("id"));
                review.setProductId(rs.getInt("productId"));
                review.setUserId(rs.getInt("userId"));
                review.setRating(rs.getInt("rating"));
                review.setReviewText(rs.getString("reviewText"));
                review.setImage(rs.getString("image"));
                review.setVideo(rs.getString("video"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return review;
    }

    // (Tùy chọn) Lấy tất cả review của 1 sản phẩm
    public List<Review> getReviewsByProductId(int productId) {
        List<Review> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM Review WHERE productId = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Review review = new Review();
                review.setId(rs.getInt("id"));
                review.setProductId(rs.getInt("productId"));
                review.setUserId(rs.getInt("userId"));
                review.setRating(rs.getInt("rating"));
                review.setReviewText(rs.getString("reviewText"));
                review.setImage(rs.getString("image"));
                review.setVideo(rs.getString("video"));
                list.add(review);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Review getReviewByProductId(int productId) {
        Review review = null;
        try {
            String sql = "SELECT * FROM Review WHERE productId = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                review = new Review();
                review.setId(rs.getInt("id"));
                review.setProductId(rs.getInt("productId"));
                review.setUserId(rs.getInt("userId"));
                review.setRating(rs.getInt("rating"));
                review.setReviewText(rs.getString("reviewText"));
                review.setImage(rs.getString("image"));
                review.setVideo(rs.getString("video"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return review;
    }
}