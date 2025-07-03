<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.*, model.Users" %>
<%
    List<Users> userList = (List<Users>) request.getAttribute("userList");
    if (userList == null) userList = new ArrayList<>();
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Admin User Manager</title>
    <link rel="stylesheet" href="assets/css/admin.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
</head>
<body>
<header class="admin-header">
    <span class="material-icons">manage_accounts</span>
    <span style="font-weight:bold;font-size:20px;">Admin User Manager</span>
    <nav class="admin-nav" style="float:right;">
        <a href="Home.jsp">Dashboard</a>
        <a href="AddUser.jsp">Add User</a>
        <a href="EditUser.jsp">Edit User</a>
        <a href="UserManager">User List</a>
        <a href="Permissions.jsp">Permissions</a>
    </nav>
</header>

<!-- T?m ki?m v? l?c theo vai tr? -->
<form action="UserManager" method="get">
    <input type="text" name="searchQuery" placeholder="Search users..." style="padding:8px;width:250px;border-radius:6px;border:1px solid #ddd;">
    <select name="role" style="padding:8px;border-radius:6px;border:1px solid #ddd;margin-left:10px;">
        <option value="">All Roles</option>
        <option value="1" <c:if test="${param.role == '1'}">selected</c:if>>User</option>
        <option value="2" <c:if test="${param.role == '2'}">selected</c:if>>FishOwner</option>
        <option value="3" <c:if test="${param.role == '3'}">selected</c:if>>Admin</option>
    </select>
    <button type="submit" style="padding:8px;border-radius:6px;background:#FF3B3B;color:white;border:none;margin-left:10px;">Filter</button>
</form>

<!-- Danh s?ch ng??i d?ng -->
<table class="table" style="margin-top:20px;">
    <thead>
        <tr>
            <th>Name</th>
            <th>Email</th>
            <th>Role</th>
            <th>Status</th>
            <th>Actions</th>
        </tr>
    </thead>
        <tbody>
            <c:forEach var="user" items="${userList}">
    <tr>
        <td>${user.getFullName()}</td>
        <td>${user.getEmail()}</td>
        <td>${user.getRole()}</td>
        <td>
            <span class="${user.status == 'Active' ? 'status-active' : 'status-inactive'}">
                ${user.status}
            </span>
        </td>
        <td>
<form action="UserManager" method="get" style="display:inline;">
    <input type="hidden" name="userId" value="${user.getUserId()}">
    <input type="hidden" name="action" value="view">
    <button type="submit" class="btn btn-primary">View</button>
</form>
<form action="UserManager" method="get" style="display:inline;">
    <input type="hidden" name="userId" value="${user.getUserId()}">
    <input type="hidden" name="action" value="edit">
    <button type="submit" class="btn btn-warning">Edit</button>
</form>
            <form action="UserManager" method="post" style="display:inline;">
                <input type="hidden" name="userId" value="${user.getUserId()}">
                <input type="hidden" name="action" value="delete">
                <button type="submit" class="btn btn-danger">Delete</button>
            </form>
        </td>
    </tr>
</c:forEach>
        </tbody>
    </table>    
</div>
</body>
</html>