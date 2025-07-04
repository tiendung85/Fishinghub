<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Manager</title>
    <style>
        body {
            background: #fafbfc;
        }
        .header-bar {
            display: flex;
            align-items: center;
            justify-content: center;
            background: #2359c5;
            padding: 18px 0;
            margin-bottom: 30px;
            box-shadow: 0 2px 10px rgba(100,120,180,0.07);
            position: relative;
        }
        .logo {
            height: 42px;
            width: 42px;
            margin-right: 16px;
            border-radius: 50%;
            background: #fff;
            border: 2px solid #2359c5;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 26px;
            color: #2359c5;
            font-weight: bold;
            position: absolute;
            left: 40px;
        }
        .header-title {
            font-size: 2.1rem;
            color: #fff;
            font-weight: bold;
            letter-spacing: 2px;
        }
        .action-bar {
            display: flex;
            justify-content: flex-end;
            align-items: center;
            width: 90%;
            margin: 0 auto 18px auto;
            gap: 10px;
        }
        .action-bar a {
            text-decoration: none;
            padding: 8px 18px;
            background: #2359c5;
            color: #fff;
            border-radius: 6px;
            font-size: 1rem;
            font-weight: 500;
            transition: 0.2s;
            border: 1px solid #2359c5;
        }
        .action-bar a:hover {
            background: #fff;
            color: #2359c5;
            border: 1px solid #2359c5;
        }
        .search-bar {
            width: 95%;
            margin: 0 auto 16px auto;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        .search-bar form {
            display: flex;
            gap: 10px;
            align-items: center;
        }
        .search-bar input, .search-bar select {
            padding: 7px 12px;
            border: 1px solid #aaa;
            border-radius: 5px;
            font-size: 1rem;
        }
        .search-bar button {
            padding: 7px 18px;
            border-radius: 5px;
            background: #2359c5;
            color: #fff;
            border: 1px solid #2359c5;
            font-weight: 500;
            cursor: pointer;
            transition: 0.2s;
        }
        .search-bar button:hover {
            background: #fff;
            color: #2359c5;
        }
        table {
            border-collapse: collapse;
            width: 95%;
            margin: 0 auto 30px auto;
            background: #fff;
            box-shadow: 0 1px 8px rgba(0,0,0,0.04);
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px 12px;
            text-align: left;
        }
        th {
            background-color: #e8eefd;
            font-weight: bold;
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        .action-btn {
            margin-right: 7px;
            padding: 5px 13px;
            border: 1px solid #2359c5;
            border-radius: 5px;
            color: #2359c5;
            background: #fff;
            font-size: 0.98rem;
            font-weight: 500;
            cursor: pointer;
            transition: 0.2s;
            text-decoration: none;
            display: inline-block;
        }
        .action-btn.edit {
            border-color: #2ca421;
            color: #2ca421;
        }
        .action-btn.edit:hover {
            background: #2ca421;
            color: #fff;
        }
        .action-btn.delete {
            border-color: #e0342b;
            color: #e0342b;
        }
        .action-btn.delete:hover {
            background: #e0342b;
            color: #fff;
        }
        @media (max-width: 1000px) {
            table, .action-bar, .search-bar {
                width: 100%;
            }
            .logo {
                left: 10px;
            }
        }
    </style>
</head>
<body>

<div class="header-bar">
    <div class="logo">👤</div>
    <div class="header-title">User Manager</div>
</div>

<div class="action-bar">
    <a href="AddUser.jsp">Add User</a>
    <a href="Home.jsp">HomePage</a>
    <a href="UserManager.jsp">User List</a>
</div>
<div class="search-bar">
    <form method="get" action="UserManager">
        <input type="text" name="search" placeholder="Search by name..." value="${param.search != null ? param.search : ''}" />
        <select name="role">
            <option value="">All roles</option>
            <c:forEach var="role" items="${roles}">
                <option value="${role.roleId}" <c:if test="${param.role == (role.roleId + '')}">selected</c:if>>
                    ${role.roleName}
                </option>
            </c:forEach>
        </select>
        <button type="submit">Search</button>
    </form>
</div>
<table>
    <tr>
        <th>UserId</th>
        <th>FullName</th>
        <th>Email</th>
        <th>Phone</th>
        <th>Role</th>
        <th>Gender</th>
        <th>DateOfBirth</th>
        <th>Location</th>
        <th>LastLogin</th>
        <th>Status</th>
        <th>Action</th>
    </tr>
    <c:forEach var="u" items="${userList}">
        <tr>
            <td>${u.userId}</td>
            <td>${u.fullName}</td>
            <td>${u.email}</td>
            <td>${u.phone}</td>
            <td>${u.role}</td>
            <td>${u.gender}</td>
            <td>${u.dateOfBirth}</td>
            <td>${u.location}</td>
            <td>${u.lastLoginTime}</td>
            <td>${u.status}</td>
            <td>
                <a class="action-btn edit" href="EditUser?userId=${u.userId}">Edit</a>
                <a class="action-btn delete"
   href="deleteUser?userId=${u.userId}"
   onclick="return confirm('Delete user: ${u.fullName}?');">
   Delete
</a>

            </td>
        </tr>
    </c:forEach>
</table>

</body>
</html>
