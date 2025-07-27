package dal;

import model.PostRejection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PostRejectionDAO extends DBConnect {
    public void saveRejection(PostRejection rejection) {
        String query = "INSERT INTO PostRejections (PostId, Reason) VALUES (?, ?)";

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, rejection.getPostId());
            stmt.setString(2, rejection.getReason());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<PostRejection> getRejectionsByPost(int postId) {
        List<PostRejection> rejections = new ArrayList<>();
        String query = "SELECT * FROM PostRejections WHERE PostId = ? ORDER BY RejectedAt DESC";

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, postId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                PostRejection rejection = new PostRejection();
                rejection.setRejectionId(rs.getInt("RejectionId"));
                rejection.setPostId(rs.getInt("PostId"));
                rejection.setReason(rs.getString("Reason"));
                rejection.setRejectedAt(rs.getTimestamp("RejectedAt"));
                rejections.add(rejection);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return rejections;
    }

    public List<PostRejection> getAllRejections(String search, String date) {
        List<PostRejection> rejections = new ArrayList<>();
        String query = "SELECT pr.* FROM PostRejections pr JOIN Post p ON pr.PostId = p.PostId WHERE 1=1";
        if (search != null && !search.trim().isEmpty()) {
            query += " AND p.Title LIKE ?";
        }
        if (date != null && !date.trim().isEmpty()) {
            query += " AND CAST(pr.RejectedAt AS DATE) = ?";
        }
        query += " ORDER BY pr.RejectedAt DESC";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            int idx = 1;
            if (search != null && !search.trim().isEmpty()) {
                stmt.setString(idx++, "%" + search + "%");
            }
            if (date != null && !date.trim().isEmpty()) {
                stmt.setString(idx++, date);
            }
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                PostRejection rejection = new PostRejection();
                rejection.setRejectionId(rs.getInt("RejectionId"));
                rejection.setPostId(rs.getInt("PostId"));
                rejection.setReason(rs.getString("Reason"));
                rejection.setRejectedAt(rs.getTimestamp("RejectedAt"));
                rejections.add(rejection);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rejections;
    }
}