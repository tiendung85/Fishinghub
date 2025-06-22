package dal;

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
            String sql = "INSERT INTO Users (FullName, Email, Phone, Password, RoleId, Gender, DateOfBirth, Location) "
                    +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
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
}