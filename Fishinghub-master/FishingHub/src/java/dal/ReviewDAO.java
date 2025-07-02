package dal;

import model.Review;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class ReviewDAO extends DBConnect {

    public boolean saveReview(Review review) {
        String sql = "INSERT INTO Review (productId, rating, reviewText, image, video) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, review.getProductId());
            ps.setInt(2, review.getRating());
            ps.setString(3, review.getReviewText());
            ps.setString(4, review.getImage());
            ps.setString(5, review.getVideo());

            int result = ps.executeUpdate();
            return result > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
