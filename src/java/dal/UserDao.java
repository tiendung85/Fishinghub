package dal;

import model.Achievement;
import model.Users;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
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
            user.setPhone(rs.getString("Phone")); 
            user.setPassword(rs.getString("Password"));
            user.setGoogleId(rs.getString("GoogleId"));
            user.setRoleId(rs.getInt("RoleId"));
            user.setGender(rs.getString("Gender"));
            user.setDateOfBirth(rs.getDate("DateOfBirth"));
            user.setLocation(rs.getString("Location"));
            user.setCreatedAt(rs.getTimestamp("CreatedAt"));
            user.setLastLoginTime(rs.getTimestamp("LastLoginTime"));
            user.setStatus(rs.getString("Status"));
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
            String sql = "INSERT INTO Users (FullName, Email, Phone, Password, RoleId, Gender, DateOfBirth, Location) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, user.getFullName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPhone());
            ps.setString(4, user.getPassword());
            ps.setInt(5, user.getRoleId());
            ps.setString(6, user.getGender());
            ps.setDate(7, user.getDateOfBirth());
            ps.setString(8, user.getLocation());
            ps.executeUpdate();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Users getByEmailAndPassword(String email, String password) {
    Users user = null;
    try {
        // Dùng TRIM trong SQL để tránh lỗi trailing space (CHAR cột DB hay dính)
        String sql = "SELECT * FROM Users WHERE LTRIM(RTRIM(Email)) = LTRIM(RTRIM(?)) AND LTRIM(RTRIM(Password)) = LTRIM(RTRIM(?))";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setString(1, email);
        ps.setString(2, password);

        // Debug in ra console xem input
        System.out.println(">>> Login Query: " + sql);
        System.out.println(">>> Params: [" + email + ", " + password + "]");

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
            user.setLastLoginTime(rs.getTimestamp("LastLoginTime"));
            user.setStatus(rs.getString("Status"));

            // In log user match
            System.out.println(">>> Login SUCCESS for user: " + user.getEmail());
        } else {
            System.out.println(">>> Login FAILED for: " + email);
        }
        rs.close();
        ps.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
    return user;
}


    public Users getByEmail(String email) {
        String sql = "SELECT * FROM Users WHERE Email = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapUser(rs);
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
                user = mapUser(rs);
            }
            rs.close();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
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

    public void update(Users user) {
    try {
        String sql = "UPDATE Users SET FullName=?, Email=?, Phone=?, Password=?, RoleId=?, Gender=?, DateOfBirth=?, Location=?, LastLoginTime=?, Status=?, lastProfileUpdate=? WHERE UserId=?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setString(1, user.getFullName());
        ps.setString(2, user.getEmail());
        ps.setString(3, user.getPhone());
        ps.setString(4, user.getPassword());
        ps.setInt(5, user.getRoleId());
        ps.setString(6, user.getGender());
        ps.setDate(7, user.getDateOfBirth());
        ps.setString(8, user.getLocation());
        ps.setTimestamp(9, user.getLastLoginTime());
        ps.setString(10, user.getStatus());
        ps.setTimestamp(11, user.getLastProfileUpdate());  // <-- dòng này là trường mới thêm
        ps.setInt(12, user.getUserId());
        ps.executeUpdate();
        ps.close();
    } catch (SQLException e) {
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

    public boolean checkPassword(String email, String currentPassword) {
        try {
            String sql = "SELECT Password FROM Users WHERE Email = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("Password").equals(currentPassword);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Helper để map user
    private Users mapUser(ResultSet rs) throws SQLException {
        Users user = new Users();
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
        user.setLastLoginTime(rs.getTimestamp("LastLoginTime"));
        user.setStatus(rs.getString("Status"));
        return user;
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
      public List<Users> listFiltered(String search, String roleFilter) {
    List<Users> userList = new ArrayList<>();
    String sql = "SELECT * FROM Users WHERE 1=1";
    boolean hasSearch = (search != null && !search.trim().isEmpty());
    boolean hasRole = (roleFilter != null && !roleFilter.trim().isEmpty());

    if (hasSearch) {
        sql += " AND (FullName COLLATE SQL_Latin1_General_CP1_CI_AI LIKE ? OR Email COLLATE SQL_Latin1_General_CP1_CI_AI LIKE ?)";
    }
    if (hasRole) {
        sql += " AND RoleId = ?";
    }

    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        int paramIndex = 1;
        if (hasSearch) {
            String pattern = "%" + search.trim() + "%";
            ps.setString(paramIndex++, pattern); // FullName
            ps.setString(paramIndex++, pattern); // Email
        }
        if (hasRole) {
            ps.setString(paramIndex++, roleFilter.trim());
        }

        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Users user = new Users();
            user.setUserId(rs.getInt("UserId"));
            user.setFullName(rs.getString("FullName"));
            user.setEmail(rs.getString("Email"));
            user.setPhone(rs.getString("Phone"));
            user.setGender(rs.getString("Gender"));
            user.setDateOfBirth(rs.getDate("DateOfBirth"));
            user.setLocation(rs.getString("Location"));
            user.setRoleId(rs.getInt("RoleId"));
            user.setLastLoginTime(rs.getTimestamp("LastLoginTime"));
            // Set status ...
            Timestamp lastLogin = user.getLastLoginTime();
            if (lastLogin != null) {
                long diff = System.currentTimeMillis() - lastLogin.getTime();
                if (diff <= 48 * 60 * 60 * 1000L) { // 48 giờ
                    user.setStatus("Active");
                } else {
                    user.setStatus("Inactive");
                }
            } else {
                user.setStatus("Inactive");
            }
            userList.add(user);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return userList;
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
            user.setLastLoginTime(rs.getTimestamp("lastLoginTime"));
            user.setStatus(rs.getString("status"));
        }
    } catch (Exception e) {
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
       public void updateUser(int userId, String fullName, String email, String phone, String password, String gender, String dateOfBirth, String location, int roleId) {
    String sql = "UPDATE Users SET FullName=?, Email=?, Phone=?, Password=?, Gender=?, DateOfBirth=?, Location=?, RoleId=? WHERE UserId=?";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setString(1, fullName);
        ps.setString(2, email);
        ps.setString(3, phone);
        ps.setString(4, password);
        ps.setString(5, gender);
        ps.setDate(6, java.sql.Date.valueOf(dateOfBirth));
        ps.setString(7, location);
        ps.setInt(8, roleId);
        ps.setInt(9, userId);
        ps.executeUpdate();
    } catch (SQLException e) {
        e.printStackTrace();
    }
}
    
}
