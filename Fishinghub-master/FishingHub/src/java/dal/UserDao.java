package dal;

import model.Achievement;
import java.util.List;
import model.Users;
import java.sql.*;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

public class UserDao extends DBConnect {

    public ArrayList<Users> list() {
        ArrayList<Users> users = new ArrayList<>();
        try {
            String sql = "SELECT * FROM Users";
            PreparedStatement stmt = connection.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Users user = new Users();
                user.setUserId(rs.getInt("UserId"));
                user.setFullName(rs.getString("FullName"));
                user.setEmail(rs.getString("Email"));
                user.setPassword(rs.getString("Password"));
                user.setGoogleId(rs.getString("GoogleId"));
                user.setRoleId(rs.getInt("RoleId"));
                user.setGender(rs.getString("Gender"));
                user.setDateOfBirth(rs.getDate("DateOfBirth"));
                user.setLocation(rs.getString("Location"));
                user.setCreatedAt(rs.getTimestamp("CreatedAt"));
                users.add(user);
            }
            rs.close();
            stmt.close();
        } catch (SQLException ex) {
            Logger.getLogger(UserDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return users;
    }

    public void insert(Users user) {
        try {
            String sql = "INSERT INTO Users (FullName, Email, Phone, Password, RoleId, Gender, DateOfBirth, Location,Avatar) "
                    +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?,?)";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, user.getFullName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPhone());
            ps.setString(4, user.getPassword());
            ps.setInt(5, user.getRoleId());
            ps.setString(6, user.getGender());
            ps.setDate(7, user.getDateOfBirth());
            ps.setString(8, user.getLocation());
            ps.setString(9, user.getAvatar());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Users getByEmailAndPassword(String email, String password) {
        Users user = null;
        try {
            String sql = "SELECT * FROM Users WHERE Email = ? AND Password = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user = new Users();
                user.setUserId(rs.getInt("UserId"));
                user.setFullName(rs.getString("FullName"));
                user.setEmail(rs.getString("Email"));
                user.setPhone(rs.getString("Phone")); // Nếu có field Phone
                user.setPassword(rs.getString("Password"));
                user.setGoogleId(rs.getString("GoogleId"));
                user.setRoleId(rs.getInt("RoleId"));
                user.setGender(rs.getString("Gender"));
                user.setDateOfBirth(rs.getDate("DateOfBirth"));
                user.setLocation(rs.getString("Location"));
                user.setCreatedAt(rs.getTimestamp("CreatedAt"));
                user.setAvatar(rs.getString("Avatar"));
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    public Users getByEmail(String email) {
        String sql = "SELECT * FROM Users WHERE email = ?";
        try (
                PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Users user = new Users();
                user.setUserId(rs.getInt("userId")); // hoặc tên cột đúng trong DB của bạn
                user.setFullName(rs.getString("fullName"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setPassword(rs.getString("password"));
                user.setGoogleId(rs.getString("googleId"));
                user.setRoleId(rs.getInt("roleId"));
                user.setGender(rs.getString("gender"));
                user.setDateOfBirth(rs.getDate("dateOfBirth")); // đúng với model
                user.setLocation(rs.getString("location"));
                user.setCreatedAt(rs.getTimestamp("createdAt"));
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Users getUserById(int userId) {
        Users user = null;
        try {
            String sql = "SELECT * FROM Users WHERE UserId = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user = new Users();
                user.setUserId(rs.getInt("UserId"));
                user.setFullName(rs.getString("FullName"));
                user.setEmail(rs.getString("Email"));
                user.setPhone(rs.getString("Phone"));
                user.setPassword(rs.getString("Password"));
                user.setGoogleId(rs.getString("GoogleId"));
                user.setRoleId(rs.getInt("RoleId"));
                user.setGender(rs.getString("Gender"));
                user.setDateOfBirth(rs.getDate("DateOfBirth"));
                user.setLocation(rs.getString("Location"));
                user.setCreatedAt(rs.getTimestamp("CreatedAt"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }
    
    public void saveResetToken(String email, String code, java.sql.Timestamp expiresAt) {
    String sql = "INSERT INTO password_reset (email, code, expires_at, used) VALUES (?, ?, ?, 0)";
    try {
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setString(1, email);
        ps.setString(2, code);
        ps.setTimestamp(3, expiresAt);
        ps.executeUpdate();
        ps.close();
    } catch (SQLException e) {
        e.printStackTrace();
    }
}
public boolean checkResetToken(String email, String code) {
    String sql = "SELECT * FROM password_reset WHERE email = ? AND code = ? AND used = 0 AND expires_at > GETDATE()";
    try {
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setString(1, email);
        ps.setString(2, code);
        ResultSet rs = ps.executeQuery();
        boolean found = rs.next();
        rs.close();
        ps.close();
        return found;
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return false;
}
public void updatePassword(String email, String newPassword) {
    String sql = "UPDATE Users SET Password = ? WHERE Email = ?";
    try {
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setString(1, newPassword);
        ps.setString(2, email);
        ps.executeUpdate();
        ps.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
}
public void markResetTokenUsed(String email, String code) {
    String sql = "UPDATE password_reset SET used = 1 WHERE email = ? AND code = ?";
    try {
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setString(1, email);
        ps.setString(2, code);
        ps.executeUpdate();
        ps.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
}
public boolean checkEmailExists(String email) {
    String sql = "SELECT 1 FROM Users WHERE Email = ?";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setString(1, email);
        ResultSet rs = ps.executeQuery();
        boolean exists = rs.next();
        rs.close();
        return exists;
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return false;
}
public List<Achievement> getAchievementsByUserId(int userId) {
    List<Achievement> list = new ArrayList<>();
    String sql = "SELECT * FROM Achievement WHERE UserId = ?";
    try {
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, userId);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Achievement a = new Achievement();
            a.setAchievementId(rs.getInt("AchievementId"));
            a.setUserId(rs.getInt("UserId"));
            a.setFishId(rs.getInt("FishId"));
            a.setImage(rs.getString("Image"));
            a.setDescription(rs.getString("Description"));
            a.setDateAchieved(rs.getDate("DateAchieved"));
            try { a.setPoints(rs.getInt("Points")); } catch (Exception ex) {}
            list.add(a);
        }
        rs.close();
        ps.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}
public void updateAvatar(int userId, String avatarPath) {
    String sql = "UPDATE Users SET avatar = ? WHERE userId = ?";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setString(1, avatarPath);
        ps.setInt(2, userId);
        ps.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    }
}
public void delete(int userId) {
    String sql = "DELETE FROM Users WHERE UserId = ?";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setInt(1, userId);
        ps.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    }
}
public void update(Users user) {
    try {
        String sql = "UPDATE Users SET FullName=?, Email=?, Phone=?, Password=?, RoleId=?, Gender=?, DateOfBirth=?, Location=?, Avatar=?, LastLoginTime=?, Status=? WHERE UserId=?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setString(1, user.getFullName());
        ps.setString(2, user.getEmail());
        ps.setString(3, user.getPhone());
        ps.setString(4, user.getPassword());
        ps.setInt(5, user.getRoleId());
        ps.setString(6, user.getGender());
        ps.setDate(7, user.getDateOfBirth());
        ps.setString(8, user.getLocation());
        ps.setString(9, user.getAvatar());
        ps.setTimestamp(10, user.getLastLoginTime());
        ps.setString(11, user.getStatus()); // Lưu lại trạng thái
        ps.setInt(12, user.getUserId());
        ps.executeUpdate();  // Cập nhật vào DB
    } catch (SQLException e) {
        e.printStackTrace();
    }
}
public void updatePermissions(int userId, boolean canPost, boolean canComment, boolean canCreateEvent) {
    String sql = "UPDATE Permissions SET CanPost = ?, CanComment = ?, CanCreateEvent = ? WHERE UserId = ?";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setBoolean(1, canPost);
        ps.setBoolean(2, canComment);
        ps.setBoolean(3, canCreateEvent);
        ps.setInt(4, userId);
        ps.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    }
}
    // Phương thức lấy danh sách người dùng đã được lọc
    public List<Users> listFiltered(String searchQuery, String roleFilter) {
        List<Users> userList = new ArrayList<>();
        String sql = "SELECT * FROM Users WHERE 1=1";

        if (searchQuery != null && !searchQuery.isEmpty()) {
            sql += " AND fullName LIKE ?";
        }

        if (roleFilter != null && !roleFilter.isEmpty()) {
            sql += " AND roleId = ?";
        }

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            int paramIndex = 1;

            if (searchQuery != null && !searchQuery.isEmpty()) {
                ps.setString(paramIndex++, "%" + searchQuery + "%");  // Tìm kiếm theo tên
            }

            if (roleFilter != null && !roleFilter.isEmpty()) {
                ps.setString(paramIndex++, roleFilter);  // Lọc theo vai trò
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Users user = new Users();
                user.setUserId(rs.getInt("userId"));
                user.setFullName(rs.getString("fullName"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setGender(rs.getString("gender"));
                user.setDateOfBirth(rs.getDate("dateOfBirth"));
                user.setLocation(rs.getString("location"));
                user.setRoleId(rs.getInt("roleId"));
                user.setAvatar(rs.getString("avatar"));
                user.setStatus(rs.getString("status"));
                user.setLastLoginTime(rs.getTimestamp("lastLoginTime"));
                userList.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return userList;
    }
        public boolean checkPassword(String email, String currentPassword) {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = getConnection();
            String sql = "SELECT password FROM users WHERE email = ?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, email);
            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                String storedPassword = resultSet.getString("password");
                // So sánh mật khẩu hiện tại với mật khẩu trong cơ sở dữ liệu
                return storedPassword.equals(currentPassword);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } 
        return false;
    }
    public void updatePasswordByEmail(String email, String newPassword) {
    String sql = "UPDATE Users SET Password = ? WHERE Email = ?";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setString(1, newPassword);
        ps.setString(2, email);
        ps.executeUpdate();
    } catch (SQLException e) {
        e.printStackTrace();
    }
}
public Users getUserByEmail(String email) {
    Users user = null;
    try {
        String sql = "SELECT * FROM Users WHERE Email = ?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setString(1, email);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            user = new Users();
            user.setUserId(rs.getInt("UserId"));
            user.setFullName(rs.getString("FullName"));
            user.setEmail(rs.getString("Email"));
            user.setPhone(rs.getString("Phone"));
            user.setPassword(rs.getString("Password"));
            user.setGoogleId(rs.getString("GoogleId"));
            user.setRoleId(rs.getInt("RoleId"));
            user.setGender(rs.getString("Gender"));
            user.setDateOfBirth(rs.getDate("DateOfBirth"));
            user.setLocation(rs.getString("Location"));
            user.setCreatedAt(rs.getTimestamp("CreatedAt"));
            user.setAvatar(rs.getString("Avatar"));
            user.setLastLoginTime(rs.getTimestamp("lastLoginTime"));
            user.setStatus(rs.getString("status"));
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return user;
}

}

