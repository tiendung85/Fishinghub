package dal;

import model.PostNotification;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PostNotificationDAO extends DBConnect {

    public void saveNotification(PostNotification notification) {
        String query = "INSERT INTO PostNotification (PostId, ReceiverId, Message) VALUES (?, ?, ?)";

        try (
                PreparedStatement stmt = connection.prepareStatement(query)) {

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
        String query = "SELECT * FROM PostNotification WHERE ReceiverId = ? ORDER BY CreatedAt DESC";

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
                notifications.add(notification);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return notifications;
    }
}
