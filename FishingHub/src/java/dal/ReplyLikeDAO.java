package dal;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.ReplyLike;

import dal.DBConnect;

public class ReplyLikeDAO extends DBConnect {

    // Kiểm tra người dùng đã like phản hồi chưa
    public boolean hasLiked(int replyId, int userId) {
        String sql = "SELECT 1 FROM ReplyLike WHERE ReplyId = ? AND UserId = ?";
        try (
                PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, replyId);
            ps.setInt(2, userId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next(); // Nếu có dòng -> đã like
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean like(int replyId, int userId) {
        String sql = "INSERT INTO ReplyLike (ReplyId, UserId, LikedAt) VALUES (?, ?, ?)";
        try (
                PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, replyId);
            ps.setInt(2, userId);
            ps.setTimestamp(3, new Timestamp(System.currentTimeMillis()));
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean unlike(int replyId, int userId) {
        String sql = "DELETE FROM ReplyLike WHERE ReplyId = ? AND UserId = ?";
        try (
                PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, replyId);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public int getLikeCount(int replyId) {
        String sql = "SELECT COUNT(*) FROM ReplyLike WHERE ReplyId = ?";
        try (
                PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, replyId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
}
