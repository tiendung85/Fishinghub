package dal;

import java.sql.*;
import java.util.*;
import model.PostComment;

public class PostCommentDAO extends DBConnect {

    public boolean addComment(PostComment comment) {
        String sql = "INSERT INTO PostComment (PostId, UserId, Content, CreatedAt) VALUES (?, ?, ?, GETDATE())";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, comment.getPostId());
            st.setInt(2, comment.getUserId());
            st.setString(3, comment.getContent());
            return st.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<PostComment> getCommentsByPostId(int postId) {
        List<PostComment> comments = new ArrayList<>();
        String sql = "SELECT * FROM PostComment WHERE PostId = ? ORDER BY CreatedAt DESC";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, postId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                PostComment comment = new PostComment(
                        rs.getInt("CommentId"),
                        rs.getInt("PostId"),
                        rs.getInt("UserId"),
                        rs.getString("Content"),
                        rs.getTimestamp("CreatedAt"));
                comments.add(comment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return comments;
    }

    public int countCommentsByPostId(int postId) {
        String sql = "SELECT COUNT(*) FROM PostComment WHERE PostId = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, postId);
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
