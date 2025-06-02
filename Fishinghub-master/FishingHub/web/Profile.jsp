<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.Users" %>
<%
    Users currentUser = (Users) session.getAttribute("user");
    if (currentUser == null) {
        response.sendRedirect("Login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Hồ sơ cá nhân</title>
    <link rel="stylesheet" href="assets/css/profile.css" />
</head>
<body>
    <div class="profile-container">
        <h2>Thông tin cá nhân</h2>
        <p><b>Họ và tên:</b> <%= currentUser.getFullName() %></p>
        <p><b>Email:</b> <%= currentUser.getEmail() %></p>
        <p><b>Số điện thoại:</b> <%= currentUser.getPhone() %></p>
        <p><b>Giới tính:</b> <%= currentUser.getGender() %></p>
        <p><b>Ngày sinh:</b> <%= currentUser.getDob() %></p>
        <p><b>Địa chỉ:</b> <%= currentUser.getLocation() %></p>
        <p><b>Vai trò:</b> <%= currentUser.getRole() %></p>
    </div>
</body>
</html>
