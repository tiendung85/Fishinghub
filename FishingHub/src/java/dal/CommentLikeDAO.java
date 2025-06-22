package dal;

import java.sql.*;
import model.CommentLike;

public class CommentLikeDAO extends DBConnect {

    public boolean addLike(int commentId, int userId) {
        String sql = "INSERT INTO CommentLike (CommentId, UserId) VALUES (?, ?)";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, commentId);
            st.setInt(2, userId);
            return st.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean removeLike(int commentId, int userId) {
        String sql = "DELETE FROM CommentLike WHERE CommentId = ? AND UserId = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, commentId);
            st.setInt(2, userId);
            return st.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean hasLiked(int commentId, int userId) {
        String sql = "SELECT COUNT(*) FROM CommentLike WHERE CommentId = ? AND UserId = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, commentId);
            st.setInt(2, userId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public int getLikeCount(int commentId) {
        String sql = "SELECT COUNT(*) FROM CommentLike WHERE CommentId = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, commentId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}