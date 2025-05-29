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
        String sql = "INSERT INTO Users (FullName, Email, Phone, Password, RoleId, Gender, DateOfBirth, Location) " +
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

}
