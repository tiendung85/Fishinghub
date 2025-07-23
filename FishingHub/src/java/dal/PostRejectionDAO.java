package dal;

import model.PostRejection;
import java.sql.*;

public class PostRejectionDAO extends DBConnect{
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
}
