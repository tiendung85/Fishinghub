package dal;

import java.sql.*;
import java.util.*;
import model.Permission;

public class UserPermissionDAO extends DBConnect {
    // Lấy tất cả quyền
    public List<Permission> getAllPermissions() {
        List<Permission> list = new ArrayList<>();
        String sql = "SELECT * FROM Permission";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Permission(rs.getInt("permissionId"), rs.getString("permissionName")));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }
    // Lấy quyền mặc định theo role
    public List<Permission> getPermissionsByRole(int roleId) {
        List<Permission> list = new ArrayList<>();
        String sql = "SELECT p.* FROM Permission p JOIN RolePermission rp ON p.permissionId = rp.permissionId WHERE rp.roleId = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, roleId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Permission(rs.getInt("permissionId"), rs.getString("permissionName")));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }
    // Lấy quyền bị cấm của user
    public List<Integer> getDeniedPermissionsByUser(int userId) {
        List<Integer> denied = new ArrayList<>();
        String sql = "SELECT permissionId FROM UserDeniedPermission WHERE userId=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) denied.add(rs.getInt(1));
        } catch (Exception e) { e.printStackTrace(); }
        return denied;
    }
    // Lấy quyền thực tế user có
    public List<Permission> getActualPermissions(int userId, int roleId) {
        List<Permission> rolePerms = getPermissionsByRole(roleId);
        List<Integer> denied = getDeniedPermissionsByUser(userId);
        List<Permission> result = new ArrayList<>();
        for (Permission p : rolePerms) {
            if (!denied.contains(p.getPermissionId()))
                result.add(p);
        }
        return result;
    }
    // Cập nhật quyền bị cấm cho user (admin chọn cấm quyền nào, sẽ lưu vào bảng này)
    public void setDeniedPermissions(int userId, List<Integer> deniedPermissionIds) {
        try {
            // Xóa quyền bị cấm cũ
            String del = "DELETE FROM UserDeniedPermission WHERE userId=?";
            PreparedStatement ps = connection.prepareStatement(del);
            ps.setInt(1, userId);
            ps.executeUpdate();
            // Thêm mới
            if (deniedPermissionIds != null) {
                for (int pid : deniedPermissionIds) {
                    String ins = "INSERT INTO UserDeniedPermission(userId, permissionId) VALUES (?,?)";
                    PreparedStatement ps2 = connection.prepareStatement(ins);
                    ps2.setInt(1, userId);
                    ps2.setInt(2, pid);
                    ps2.executeUpdate();
                    ps2.close();
                }
            }
            ps.close();
        } catch (Exception e) { e.printStackTrace(); }
    }
    public boolean isDeniedPermission(int userId, int permissionId) {
    String sql = "SELECT 1 FROM UserDeniedPermission WHERE userId = ? AND permissionId = ?";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setInt(1, userId);
        ps.setInt(2, permissionId);
        ResultSet rs = ps.executeQuery();
        return rs.next();
    } catch (Exception e) {
        e.printStackTrace();
    }
    return false;
}

}
