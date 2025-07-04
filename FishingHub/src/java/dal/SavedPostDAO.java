package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Post;

public class SavedPostDAO extends DBConnect {
    public boolean isSaved(int userId, int postId) {
        String sql = "SELECT 1 FROM SavedPost WHERE UserId=? AND PostId=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, userId);
            st.setInt(2, postId);
            ResultSet rs = st.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean savePost(int userId, int postId) {
        String sql = "INSERT INTO SavedPost (UserId, PostId) VALUES (?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, userId);
            st.setInt(2, postId);
            return st.executeUpdate() > 0;
        } catch (SQLException e) {
            return false;
        }
    }

    public boolean unsavePost(int userId, int postId) {
        String sql = "DELETE FROM SavedPost WHERE UserId=? AND PostId=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, userId);
            st.setInt(2, postId);
            return st.executeUpdate() > 0;
        } catch (SQLException e) {
            return false;
        }
    }

    public List<Post> getSavedPostsByUser(int userId) {
        List<Post> posts = new ArrayList<>();
        String sql = "SELECT p.* FROM SavedPost sp JOIN Post p ON sp.PostId = p.PostId WHERE sp.UserId = ? AND p.Status = N'đã duyệt' ORDER BY sp.SavedAt DESC";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, userId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Post post = new Post();
                int postId = rs.getInt("PostId");
                post.setPostId(postId);
                post.setUserId(rs.getInt("UserId"));
                post.setTopic(rs.getString("Topic"));
                post.setTitle(rs.getString("Title"));
                post.setContent(rs.getString("Content"));
                post.setCreatedAt(rs.getTimestamp("CreatedAt"));

                // Lấy ảnh
                String imageSql = "SELECT ImagePath FROM Image WHERE PostId = ?";
                PreparedStatement imageSt = connection.prepareStatement(imageSql);
                imageSt.setInt(1, postId);
                ResultSet imageRs = imageSt.executeQuery();
                while (imageRs.next()) {
                    post.addImage(imageRs.getString("ImagePath"));
                }
                imageRs.close();
                imageSt.close();

                // Lấy video
                String videoSql = "SELECT VideoPath FROM Video WHERE PostId = ?";
                PreparedStatement videoSt = connection.prepareStatement(videoSql);
                videoSt.setInt(1, postId);
                ResultSet videoRs = videoSt.executeQuery();
                while (videoRs.next()) {
                    post.addVideo(videoRs.getString("VideoPath"));
                }
                videoRs.close();
                videoSt.close();

                posts.add(post);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }
}