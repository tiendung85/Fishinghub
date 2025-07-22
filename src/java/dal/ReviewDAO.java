package dal;

import model.Review;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReviewDAO extends DBConnect {

    // Lưu review với userId
    public boolean saveReview(Review review) {
    String sql = "INSERT INTO Review (productId, userId, orderId, rating, reviewText, image, video) VALUES (?, ?, ?, ?, ?, ?, ?)";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setInt(1, review.getProductId());
        ps.setInt(2, review.getUserId());
        ps.setInt(3, review.getOrderId());
        ps.setInt(4, review.getRating());
        ps.setString(5, review.getReviewText());
        ps.setString(6, review.getImage());
        ps.setString(7, review.getVideo());
        int result = ps.executeUpdate();
        return result > 0;
    } catch (Exception e) {
        e.printStackTrace();
    }
    return false;
}

    // Lấy đánh giá của 1 user cho 1 sản phẩm
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
            review.setOrderId(rs.getInt("OrderId"));

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
                review.setOrderId(rs.getInt("OrderId"));
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
// Ví dụ ReviewDAO.java
public boolean hasUserReviewedProduct(int userId, int productId, int orderId) {
    String sql = "SELECT COUNT(*) FROM Review WHERE UserId=? AND ProductId=? AND OrderId=?";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setInt(1, userId);
        ps.setInt(2, productId);
        ps.setInt(3, orderId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) return rs.getInt(1) > 0;
    } catch (Exception ex) {
        ex.printStackTrace();
    }
    return false;
}
// Thêm vào ReviewDAO.java
public List<Review> getAllUserReviewedProducts(int userId) {
    List<Review> list = new ArrayList<>();
    String sql = "SELECT * FROM Review WHERE UserId=?";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setInt(1, userId);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Review r = new Review();
            r.setId(rs.getInt("Id"));
            r.setUserId(rs.getInt("UserId"));
            r.setProductId(rs.getInt("ProductId"));
            r.setReviewText(rs.getString("ReviewText"));
            r.setRating(rs.getInt("Rating"));
            r.setImage(rs.getString("Image"));
            r.setVideo(rs.getString("Video"));
            r.setOrderId(rs.getInt("OrderId"));

            // ... bổ sung các trường khác nếu có
            list.add(r);
        }
    } catch (Exception ex) {
        ex.printStackTrace();
    }
    return list;
}
public void insertOrUpdateReview(Review review) {
    // Kiểm tra đã tồn tại review chưa
    Review existing = getReviewByUserAndProduct(review.getUserId(), review.getProductId());
    if (existing == null) {
        // Chưa có thì insert
        String sql = "INSERT INTO Review (ProductId, UserId, Rating, ReviewText, Image, Video, CreatedAt) VALUES (?, ?, ?, ?, ?, ?, GETDATE())";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, review.getProductId());
            ps.setInt(2, review.getUserId());
            ps.setInt(3, review.getRating());
            ps.setString(4, review.getReviewText());
            ps.setString(5, review.getImage());
            ps.setString(6, review.getVideo());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    } else {
        // Có rồi thì update
        String sql = "UPDATE Review SET Rating=?, ReviewText=?, Image=?, Video=?, CreatedAt=GETDATE() WHERE UserId=? AND ProductId=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, review.getRating());
            ps.setString(2, review.getReviewText());
            ps.setString(3, review.getImage());
            ps.setString(4, review.getVideo());
            ps.setInt(5, review.getUserId());
            ps.setInt(6, review.getProductId());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
public Review getReviewByUserAndProduct(int userId, int productId) {
    String sql = "SELECT * FROM Review WHERE UserId = ? AND ProductId = ?";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setInt(1, userId);
        ps.setInt(2, productId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            Review r = new Review();
            r.setId(rs.getInt("Id"));
            r.setUserId(rs.getInt("UserId"));
            r.setProductId(rs.getInt("ProductId"));
            r.setRating(rs.getInt("Rating"));
            r.setReviewText(rs.getString("ReviewText"));
            r.setImage(rs.getString("Image"));
            r.setVideo(rs.getString("Video"));
            r.setOrderId(rs.getInt("OrderId"));
            return r;
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return null;
}
public Review getReviewByUserProductOrder(int userId, int productId, int orderId) {
    String sql = "SELECT * FROM Review WHERE UserId=? AND ProductId=? AND OrderId=?";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setInt(1, userId);
        ps.setInt(2, productId);
        ps.setInt(3, orderId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            Review r = new Review();
            // set các trường cho r...
            r.setId(rs.getInt("Id"));
            r.setUserId(rs.getInt("UserId"));
            r.setProductId(rs.getInt("ProductId"));
            r.setOrderId(rs.getInt("OrderId"));
            r.setRating(rs.getInt("Rating"));
            r.setReviewText(rs.getString("ReviewText"));
            r.setImage(rs.getString("Image"));
            r.setVideo(rs.getString("Video"));
            return r;
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return null;
}
}
