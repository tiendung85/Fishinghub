package dal;

import model.PostNotification;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PostNotificationDAO extends DBConnect {

    public void saveNotification(PostNotification notification) {
        String query = "INSERT INTO PostNotification (PostId, ReceiverId, Message) VALUES (?, ?, ?)";

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, notification.getPostId());
            stmt.setInt(2, notification.getReceiverId());
            stmt.setString(3, notification.getMessage());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<PostNotification> getNotificationsByUser(int userId) {
        List<PostNotification> notifications = new ArrayList<>();
        String query = "SELECT pn.*, p.Status as PostStatus FROM PostNotification pn JOIN Post p ON pn.PostId = p.PostId WHERE pn.ReceiverId = ? ORDER BY pn.CreatedAt DESC";

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                PostNotification notification = new PostNotification();
                notification.setNotificationId(rs.getInt("NotificationId"));
                notification.setPostId(rs.getInt("PostId"));
                notification.setReceiverId(rs.getInt("ReceiverId"));
                notification.setMessage(rs.getString("Message"));
                notification.setIsRead(rs.getBoolean("IsRead"));
                notification.setCreatedAt(rs.getTimestamp("CreatedAt"));
                notification.setStatus(rs.getString("PostStatus"));
                notifications.add(notification);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return notifications;
    }

  public List<PostNotification> getAllNotifications(String search, String date) {
        List<PostNotification> notifications = new ArrayList<>();
        // Lấy tất cả thông báo trước, sau đó lọc những thông báo không phải like/comment
        String query = "SELECT pn.* FROM PostNotification pn JOIN Post p ON pn.PostId = p.PostId " +
                      "WHERE pn.Message NOT LIKE '%thích%' AND pn.Message NOT LIKE '%like%' AND " +
                      "pn.Message NOT LIKE '%bình%' AND pn.Message NOT LIKE '%comment%' AND " +
                      "pn.Message NOT LIKE '%đã thích%'";
        
        if (search != null && !search.trim().isEmpty()) {
            query += " AND p.Title LIKE ?";
        }
        if (date != null && !date.trim().isEmpty()) {
            query += " AND CAST(pn.CreatedAt AS DATE) = ?";
        }
        query += " ORDER BY pn.CreatedAt DESC";
        
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
                PostNotification notification = new PostNotification();
                notification.setNotificationId(rs.getInt("NotificationId"));
                notification.setPostId(rs.getInt("PostId"));
                notification.setReceiverId(rs.getInt("ReceiverId"));
                notification.setMessage(rs.getString("Message"));
                notification.setIsRead(rs.getBoolean("IsRead"));
                notification.setCreatedAt(rs.getTimestamp("CreatedAt"));
                notifications.add(notification);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return notifications;
    }

    public void markAllAsRead(int userId) {
        String query = "UPDATE PostNotification SET IsRead = 1 WHERE ReceiverId = ? AND IsRead = 0";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, userId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}