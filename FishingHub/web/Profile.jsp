<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.Users" %>
<%
    Users user = (Users) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("Login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Hồ sơ cá nhân</title>
    <link rel="stylesheet" href="assets/css/profile.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.6.0/remixicon.min.css">
    <style>
        body { background: #f6f8fa; font-family: 'Roboto', Arial, sans-serif; }
        .header {
            background-color: #fff;
            padding: 20px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .profile-container {
            max-width: 800px;
            margin: 40px auto;
            background: #fff;
            padding: 20px;
            border-radius: 14px;
            box-shadow: 0 2px 20px #0001;
        }
        .profile-title {
            font-size: 24px;
            font-weight: bold;
            color: #1E88E5;
            margin-bottom: 24px;
        }
        .avatar-box {
            width: 100px;
            height: 100px;
            margin: 20px auto;
            border-radius: 50%;
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
        }
        .avatar-box img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .profile-info {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            gap: 20px;
            font-size: 16px;
        }
        .profile-info div {
            flex: 1 1 45%;
        }
        .profile-info label {
            font-weight: bold;
        }
        .profile-info .value {
            color: #111;
            font-weight: 500;
        }
        .input-box input {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 8px;
        }
        .input-box {
            margin-bottom: 15px;
        }
        .update-btn {
            background-color: #1E88E5;
            color: white;
            padding: 12px 24px;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
            border: none;
            width: 100%;
        }
    </style>
</head>
<body>

<!-- Header with Search -->
 <div class="header">
    <div class="logo">
        <a href="Home.jsp" class="text-3xl font-bold text-primary">FishingHub</a>
    </div>
    <div class="search-bar">
        <input type="text" placeholder="Search for products, brands, and more">
        <button><i class="ri-search-line"></i></button>
    </div>
    <div class="user-profile">
        <!-- 3 chức năng -->
        <div class="profile-functions">
            <button class="function-btn" onclick="window.location.href='ChangePassword.jsp'">Đổi mật khẩu</button>
            <button class="function-btn" onclick="window.location.href='ShoppingCart.jsp'">Giỏ hàng</button>
            <button class="function-btn" onclick="window.location.href='Feedback.jsp'">Góp ý</button>
        </div>
    </div>
</div>

<!-- Profile content -->
<div class="profile-container">
    <div class="profile-title">Hồ sơ cá nhân</div>

    <!-- Avatar: click để đổi -->
    <div class="avatar-box" onclick="document.getElementById('avatarInput').click();">
        <form id="avatarForm" action="Profile" method="post" enctype="multipart/form-data" style="display:inline;">
            <input type="file" id="avatarInput" name="avatar" accept="image/*" style="display:none;" onchange="this.form.submit()">
            <img src="<%= (user.getAvatar() != null && !user.getAvatar().isEmpty()) ? user.getAvatar() : "assets/img/avatar-default.png" %>" alt="Avatar" id="mainAvatar">
        </form>
    </div>
    <div style="text-align:center; color:#888; font-size:13px; margin-bottom:14px;">
        Nhấn vào avatar để thay đổi ảnh từ máy tính
    </div>

    <form action="EditProfileController" method="post">Add commentMore actions
        <div class="profile-info">
            <div class="input-box">
                <label for="fullName">Họ tên:</label>
                <input type="text" name="fullName" value="<%= user.getFullName() %>" required>
            </div>
            <div class="input-box">
                <label for="email">Email:</label>
                <input type="email" value="<%= user.getEmail() %>" readonly>
            </div>
            <div class="input-box">
                <label for="role">Vai trò:</label>
                <input type="text" value="<%= user.getRole() %>" readonly>
            </div>
            <div class="input-box">
                <label for="dob">Ngày sinh:</label>
                <input type="text" value="<%= (user.getDateOfBirth() != null) ? user.getDateOfBirth().toString() : "" %>" readonly>
            </div>
            <div class="input-box">
                <label for="location">Địa chỉ:</label>
                <input type="text" name="location" value="<%= user.getLocation() %>" required>Add commentMore actions
            </div>
        </div>
   

   
        <button type="submit" class="update-btn">Cập nhật thông tin</button>
    </form>
    <% if (request.getAttribute("successMessage") != null) { %>Add commentMore actions
    <script>
        alert("<%= request.getAttribute("successMessage") %>");
        window.location.href = "Profile";
    </script>
    <% } %>
</div>

</body>
</html>