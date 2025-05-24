package model;

import java.sql.Date;
import java.sql.Timestamp;

public class Users {
    private int userId;
    private String fullName;
    private String email;
    private String password;
    private String googleId;
    private int roleId;
    private String gender;
    private Date dateOfBirth;
    private String location;
    private Timestamp createdAt;

    public Users() {}

    // Constructor (có thể thêm/bớt nếu cần)
    public Users(int userId, String fullName, String email, String password, String googleId,
                 int roleId, String gender, Date dateOfBirth, String location, Timestamp createdAt) {
        this.userId = userId;
        this.fullName = fullName;
        this.email = email;
        this.password = password;
        this.googleId = googleId;
        this.roleId = roleId;
        this.gender = gender;
        this.dateOfBirth = dateOfBirth;
        this.location = location;
        this.createdAt = createdAt;
    }

    // Constructor dùng khi đăng ký (không có userId, googleId, createdAt)
    public Users(String fullName, String email, String password, int roleId,
                 String gender, Date dateOfBirth, String location) {
        this.fullName = fullName;
        this.email = email;
        this.password = password;
        this.roleId = roleId;
        this.gender = gender;
        this.dateOfBirth = dateOfBirth;
        this.location = location;
        this.googleId = null;
        this.createdAt = null;
    }

    // Getter và Setter

    public int getUserId() {
        return userId;
    }
    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getFullName() {
        return fullName;
    }
    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }

    public String getGoogleId() {
        return googleId;
    }
    public void setGoogleId(String googleId) {
        this.googleId = googleId;
    }

    public int getRoleId() {
        return roleId;
    }
    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }

    public String getGender() {
        return gender;
    }
    public void setGender(String gender) {
        this.gender = gender;
    }

    public Date getDateOfBirth() {
        return dateOfBirth;
    }
    public void setDateOfBirth(Date dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public String getLocation() {
        return location;
    }
    public void setLocation(String location) {
        this.location = location;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}
