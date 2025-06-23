package dal;

import model.PostLike;
import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.text.SimpleDateFormat;
import model.Users;

public class PostLikeDAO extends DBConnect {

    // Thêm like cho bài viết
    public void addLike(int postId, int userId) {
        String sql = "INSERT INTO PostLike (PostId, UserId, LikedAt) VALUES (?, ?, ?)";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, postId);
            st.setInt(2, userId);
            st.setTimestamp(3, new Timestamp(new Date().getTime()));
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Xóa like khỏi bài viết
    public void removeLike(int postId, int userId) {
        String sql = "DELETE FROM PostLike WHERE PostId = ? AND UserId = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, postId);
            st.setInt(2, userId);
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Kiểm tra xem người dùng đã like bài viết chưa
    public boolean hasLiked(int postId, int userId) {
        String sql = "SELECT COUNT(*) FROM PostLike WHERE PostId = ? AND UserId = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, postId);
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

    // Đếm số lượt like của bài viết
    public int countLikesByPostId(int postId) {
        String sql = "SELECT COUNT(*) FROM PostLike WHERE PostId = ?";
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

    private String getTimeAgo(Timestamp timestamp) {
        long timeInMillis = System.currentTimeMillis() - timestamp.getTime();
        long minutes = timeInMillis / (60 * 1000);
        long hours = timeInMillis / (60 * 60 * 1000);
        long days = timeInMillis / (24 * 60 * 60 * 1000);

        if (minutes < 1) {
            return "Vừa xong";
        } else if (minutes < 60) {
            return minutes + " phút trước";
        } else if (hours < 24) {
            return hours + " giờ trước";
        } else if (days < 30) {
            return days + " ngày trước";
        } else {
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
            return sdf.format(timestamp);
        }
    }
}