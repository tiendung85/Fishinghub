<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Chỉnh sửa thông tin người dùng</title>
    <style>
        body { background: #f6f8fa; font-family: Arial,sans-serif; }
        .container { background: #fff; margin: 40px auto; border-radius: 10px; box-shadow: 0 2px 18px #ccc4; padding: 40px; max-width: 530px; }
        h2 { color: #2341a6; font-size: 1.5rem; }
        label { font-weight: 500; display:block; margin: 16px 0 3px 0; }
        input, select { width: 100%; padding: 8px 11px; border-radius: 5px; border: 1px solid #b6b6c1; font-size: 1rem; margin-bottom: 6px; }
        button { background: #2341a6; color: #fff; border: none; border-radius: 5px; padding: 10px 32px; font-size: 1.1rem; margin-top: 18px; }
        .permission-section { margin-top: 28px; border-top: 1px solid #eee; padding-top: 18px; }
        .perm-list td { padding: 3px 12px 3px 0; }
    </style>
</head>
<body>
<div class="container">
    <h2>Chỉnh sửa thông tin người dùng</h2>
    <form action="EditUser" method="post">
        <input type="hidden" name="userId" value="${user.userId}">
        <label>Tên đầy đủ</label>
        <input type="text" name="fullName" value="${user.fullName}" required>
        <label>Email</label>
        <input type="email" name="email" value="${user.email}" required>
        <label>Số điện thoại</label>
        <input type="text" name="phone" value="${user.phone}" required>
        <label>Mật khẩu</label>
        <input type="password" name="password" value="${user.password}" required>
        <label>Giới tính</label>
        <select name="gender">
            <option value="Nam" <c:if test="${user.gender=='Nam'}">selected</c:if>>Nam</option>
            <option value="Nữ" <c:if test="${user.gender=='Nữ'}">selected</c:if>>Nữ</option>
            <option value="Male" <c:if test="${user.gender=='Male'}">selected</c:if>>Male</option>
            <option value="Female" <c:if test="${user.gender=='Female'}">selected</c:if>>Female</option>
        </select>
        <label>Ngày sinh</label>
        <input type="date" name="dob" value="${user.dateOfBirth}" required>
        <label>Địa chỉ</label>
        <input type="text" name="location" value="${user.location}" required>
        <label>Vai trò</label>
        <input type="text" name="roleId" value="${user.roleId}" readonly>

        <!-- Phần quản lý quyền -->
        <div class="permission-section">
            <h3>Phân quyền người dùng</h3>
            <table class="perm-list">
                <tr>
                    <th>Quyền</th>
                    <th>Cấm quyền này?</th>
                </tr>
               <c:forEach var="perm" items="${allPermissions}">
    <tr>
        <td>${perm.permissionName}</td>
        <td>
            <c:choose>
                <c:when test="${deniedPermissionsSet.contains(perm.permissionId)}">
                    <input type="checkbox" name="denyPermission"
                           value="${perm.permissionId}" checked />
                </c:when>
                <c:otherwise>
                    <input type="checkbox" name="denyPermission"
                           value="${perm.permissionId}" />
                </c:otherwise>
            </c:choose>
        </td>
    </tr>
</c:forEach>

            </table>
        </div>
        <button type="submit">Cập nhật</button>
    </form>
</div>
</body>
</html>
