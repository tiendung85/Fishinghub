package model;
public class Permission {
    private int permissionId;
    private String permissionName;
    public Permission(int permissionId, String permissionName) {
        this.permissionId = permissionId;
        this.permissionName = permissionName;
    }
    public int getPermissionId() { return permissionId; }
    public void setPermissionId(int id) { this.permissionId = id; }
    public String getPermissionName() { return permissionName; }
    public void setPermissionName(String name) { this.permissionName = name; }
}
