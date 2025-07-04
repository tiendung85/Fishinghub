
package dal;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.CommentReply;

public class CommentReplyDAO extends DBConnect {

    public void addReply(CommentReply reply) {
        String sql = "INSERT INTO CommentReply (CommentId, UserId, Content, CreatedAt) VALUES (?, ?, ?, GETDATE())";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, reply.getCommentId());
            st.setInt(2, reply.getUserId());
            st.setString(3, reply.getContent());
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<CommentReply> getRepliesByCommentId(int commentId) {
        List<CommentReply> list = new ArrayList<>();
        String sql = "SELECT * FROM CommentReply WHERE CommentId = ? ORDER BY CreatedAt ASC";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, commentId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                CommentReply reply = new CommentReply(
                        rs.getInt("ReplyId"),
                        rs.getInt("CommentId"),
                        rs.getInt("UserId"),
                        rs.getString("Content"),
                        rs.getDate("CreatedAt"));
                        // rs.getInt("ParentReplyId"));
                list.add(reply);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}