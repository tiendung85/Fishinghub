package model;

import java.sql.Date;
import java.sql.Timestamp;

public class Users {

    private int userId;
    private String fullName;
    private String email;
    private String phone;      // Thêm trường này
    private String password;
    private String googleId;
    private int roleId;
    private String gender;
    private Date dateOfBirth;
    private String location;
    private Timestamp createdAt;

    public Users() {
    }

    // Constructor đầy đủ
    // Constructor dùng khi đăng ký (không có userId, googleId, createdAt)
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

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
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

    @Override
    public String toString() {

        return "Users{"
                + "userId=" + userId
                + ", fullName='" + fullName + '\''
                + ", email='" + email + '\''
                + ", phone='" + phone + '\''
                + ", password='" + password + '\''
                + ", googleId='" + googleId + '\''
                + ", roleId=" + roleId
                + ", gender='" + gender + '\''
                + ", dateOfBirth=" + dateOfBirth
                + ", location='" + location + '\''
                + ", createdAt=" + createdAt
                + '}';
    }
}
