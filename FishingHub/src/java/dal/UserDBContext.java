package dal;

import model.Users;
import java.sql.*;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

public class UserDBContext extends DBConnect<Users> {

    @Override
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
            Logger.getLogger(UserDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return users;
    }

    @Override
    public Users get(int id) {
        try {
            String sql = "SELECT * FROM Users WHERE UserId = ?";
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
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
                return user;
            }
            rs.close();
            stmt.close();
        } catch (SQLException ex) {
            Logger.getLogger(UserDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    @Override
    public void insert(Users user) {
        try {
            String sql = "INSERT INTO Users (FullName, Email, Password, GoogleId, RoleId, Gender, DateOfBirth, Location) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            try (PreparedStatement stmt = connection.prepareStatement(sql)) {
                stmt.setString(1, user.getFullName());
                stmt.setString(2, user.getEmail());
                stmt.setString(3, user.getPassword());
                stmt.setString(4, user.getGoogleId());
                stmt.setInt(5, user.getRoleId());
                stmt.setString(6, user.getGender());
                stmt.setDate(7, user.getDateOfBirth());
                stmt.setString(8, user.getLocation());
                stmt.executeUpdate();
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public void update(Users user) {
        try {
            String sql = "UPDATE Users SET FullName = ?, Email = ?, Password = ?, GoogleId = ?, RoleId = ?, Gender = ?, DateOfBirth = ?, Location = ? WHERE UserId = ?";
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, user.getFullName());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPassword());
            stmt.setString(4, user.getGoogleId());
            stmt.setInt(5, user.getRoleId());
            stmt.setString(6, user.getGender());
            stmt.setDate(7, user.getDateOfBirth());
            stmt.setString(8, user.getLocation());
            stmt.setInt(9, user.getUserId());
            stmt.executeUpdate();
            stmt.close();
        } catch (SQLException ex) {
            Logger.getLogger(UserDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public void delete(Users user) {
        try {
            String sql = "DELETE FROM Users WHERE UserId = ?";
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, user.getUserId());
            stmt.executeUpdate();
            stmt.close();
        } catch (SQLException ex) {
            Logger.getLogger(UserDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
