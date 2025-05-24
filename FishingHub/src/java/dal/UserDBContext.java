package dal;

import model.Users;
import java.sql.*;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

public class UserDBContext extends DBContext<Users> {

    @Override
    public ArrayList<Users> list() {
        ArrayList<Users> users = new ArrayList<>();
        try {
            String sql = "SELECT * FROM Users";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
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
        } catch (SQLException ex) {
            Logger.getLogger(UserDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return users;
    }

    @Override
    public Users get(int id) {
        try {
            String sql = "SELECT * FROM Users WHERE UserId = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
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
        } catch (SQLException ex) {
            Logger.getLogger(UserDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    @Override
    public void insert(Users user) {
        try {
            String sql = "INSERT INTO Users (FullName, Email, Password, GoogleId, RoleId, Gender, DateOfBirth, Location) "
                       + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, user.getFullName());
            stm.setString(2, user.getEmail());
            stm.setString(3, user.getPassword());
            stm.setString(4, user.getGoogleId());
            stm.setInt(5, user.getRoleId());
            stm.setString(6, user.getGender());
            stm.setDate(7, user.getDateOfBirth());
            stm.setString(8, user.getLocation());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(UserDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public void update(Users user) {
        try {
            String sql = "UPDATE Users SET FullName = ?, Email = ?, Password = ?, GoogleId = ?, RoleId = ?, Gender = ?, DateOfBirth = ?, Location = ? WHERE UserId = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, user.getFullName());
            stm.setString(2, user.getEmail());
            stm.setString(3, user.getPassword());
            stm.setString(4, user.getGoogleId());
            stm.setInt(5, user.getRoleId());
            stm.setString(6, user.getGender());
            stm.setDate(7, user.getDateOfBirth());
            stm.setString(8, user.getLocation());
            stm.setInt(9, user.getUserId());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(UserDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public void delete(Users user) {
        try {
            String sql = "DELETE FROM Users WHERE UserId = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, user.getUserId());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(UserDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
