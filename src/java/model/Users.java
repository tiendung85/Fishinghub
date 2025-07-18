package model;

import java.sql.Date;
import java.sql.Timestamp;

public class Users {
    private int userId;
    private String fullName;
    private String email;
    private String phone;      
    private String password;
    private String googleId;
    private int roleId;
    private String gender;
    private Date dateOfBirth;
    private String location;
    private Timestamp createdAt;
    private Timestamp lastLoginTime;
    private String status;
    private Timestamp lastProfileUpdate;   // <-- Trường mới

    public Users() {}

    // Constructor đầy đủ
    public Users(int userId, String fullName, String email, String phone, String password, String googleId,
                 int roleId, String gender, Date dateOfBirth, String location, Timestamp createdAt,
                 Timestamp lastLoginTime, Timestamp lastProfileUpdate) {
        this.userId = userId;
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.password = password;
        this.googleId = googleId;
        this.roleId = roleId;
        this.gender = gender;
        this.dateOfBirth = dateOfBirth;
        this.location = location;
        this.createdAt = createdAt;
        this.lastLoginTime = lastLoginTime;
        this.lastProfileUpdate = lastProfileUpdate;
    }

    // Constructor khi đăng ký
    public Users(String fullName, String email, String phone, String password, int roleId,
                 String gender, Date dateOfBirth, String location) {
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.password = password;
        this.roleId = roleId;
        this.gender = gender;
        this.dateOfBirth = dateOfBirth;
        this.location = location;
        this.googleId = null;
        this.createdAt = null;
    }

    // Getter và Setter
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getGoogleId() { return googleId; }
    public void setGoogleId(String googleId) { this.googleId = googleId; }

    public int getRoleId() { return roleId; }
    public void setRoleId(int roleId) { this.roleId = roleId; }

    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }

    public Date getDateOfBirth() { return dateOfBirth; }
    public void setDateOfBirth(Date dateOfBirth) { this.dateOfBirth = dateOfBirth; }

    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public Timestamp getLastLoginTime() { return lastLoginTime; }
    public void setLastLoginTime(Timestamp lastLoginTime) { this.lastLoginTime = lastLoginTime; }

    public void setStatus(String status) { this.status = status; }
    public String getStatus() { return status; }

    public Timestamp getLastProfileUpdate() { return lastProfileUpdate; }
    public void setLastProfileUpdate(Timestamp lastProfileUpdate) { this.lastProfileUpdate = lastProfileUpdate; }

    // Phương thức lấy tên vai trò người dùng
    public String getRole() {
        switch (this.roleId) {
            case 1:
                return "User";
            case 2:
                return "FishOwner";
            case 3:
                return "Admin";
            default:
                return "Unknown";
        }
    }

    @Override
    public String toString() {
        return "Users{" +
                "userId=" + userId +
                ", fullName='" + fullName + '\'' +
                ", email='" + email + '\'' +
                ", phone='" + phone + '\'' +
                ", password='" + password + '\'' +
                ", googleId='" + googleId + '\'' +
                ", roleId=" + roleId +
                ", gender='" + gender + '\'' +
                ", dateOfBirth=" + dateOfBirth +
                ", location='" + location + '\'' +
                ", createdAt=" + createdAt +
                ", lastLoginTime=" + lastLoginTime +
                ", lastProfileUpdate=" + lastProfileUpdate +
                '}';
    }
}
