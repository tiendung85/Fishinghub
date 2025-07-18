<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.Users" %>
<%
    Users user = (Users) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("Login.jsp");
        return;
    }
    // Lấy thông báo từ session (nếu có), rồi remove luôn để tránh hiển thị lại sau reload
    String successMessage = (String) session.getAttribute("successMessage");
    if (successMessage != null) {
        session.removeAttribute("successMessage");
%>
<script>
    alert("<%= successMessage %>");
</script>
<%
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Hồ sơ cá nhân</title>
    <!-- Google Fonts preconnect and import -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com/3.4.16"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.6.0/remixicon.min.css">
    <style>
        body { background: #f6f8fa; font-family: 'Roboto', Arial, sans-serif; }
        .update-btn { background-color: #1E88E5; color: white; padding: 12px 24px; border-radius: 8px; font-size: 16px; cursor: pointer; border: none; width: 100%; }
        .avatar-box { width: 100px; height: 100px; margin: 20px auto; border-radius: 50%; overflow: hidden; display: flex; align-items: center; justify-content: center; cursor: pointer; border: 2px solid #ddd; }
        .avatar-box img { width: 100%; height: 100%; object-fit: cover; }
        .profile-title { font-size: 24px; font-weight: bold; color: #1E88E5; margin-bottom: 24px; }
        .input-box input { width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 8px; }
        .input-box { margin-bottom: 15px; }
    </style>
</head>
<body class="bg-gray-50 min-h-screen">
    <!-- Header with Search -->
    <div class="header bg-white px-4 py-3 flex justify-between items-center shadow">
        <div class="logo">
            <a href="Home.jsp" class="text-3xl font-['Pacifico'] text-primary">FishingHub</a>
        </div>
        <div class="search-bar flex items-center gap-2">
            <input type="text" class="form-control" placeholder="Search for products, brands, and more">
            <button class="btn btn-outline-secondary"><i class="ri-search-line"></i></button>
        </div>
        <div class="user-profile">
            <div class="profile-functions flex gap-2">
                <button class="btn btn-outline-primary" onclick="window.location.href='ChangePassword.jsp'">Đổi mật khẩu</button>
                <button class="btn btn-outline-success" onclick="window.location.href='Feedback.jsp'">Góp ý</button>
            </div>
        </div>
    </div>

    <!-- Profile content -->
    <div class="profile-container max-w-2xl mx-auto bg-white rounded shadow p-4 mt-8">
        <div class="profile-title text-center">Hồ sơ cá nhân</div>
        <!-- Avatar: click để đổi -->
        <div class="avatar-box" onclick="document.getElementById('avatarInput').click();">
            <input type="file" id="avatarInput" accept="image/*" style="display:none;" onchange="previewAvatar(this)">
            <img src="assets/img/avatar-default.png" alt="Avatar" id="mainAvatar">
        </div>
        <div style="text-align:center; color:#888; font-size:13px; margin-bottom:14px;"></div>
        <form action="EditProfileController" method="post">
            <div class="profile-info flex flex-wrap gap-4">
                <div class="input-box flex-1 min-w-[220px]">
                    <label for="fullName" class="form-label">Họ tên:</label>
                    <input type="text" name="fullName" value="<%= user.getFullName() %>" required>
                </div>
                <div class="input-box flex-1 min-w-[220px]">
                    <label for="gender" class="form-label">Giới tính:</label>
                    <input type="text" name="gender" value="<%= user.getGender() %>" required>
                </div>
                <div class="input-box flex-1 min-w-[220px]">
                    <label for="dob" class="form-label">Ngày sinh:</label>
                    <input type="date" name="dateOfBirth" value="<%= (user.getDateOfBirth() != null) ? user.getDateOfBirth().toString() : "" %>" required>
                </div>
                <div class="input-box flex-1 min-w-[220px]">
                    <label for="phone" class="form-label">Số điện thoại:</label>
                    <input type="text" name="phone" value="<%= user.getPhone() %>" required>
                </div>
                <div class="input-box flex-1 min-w-[220px]">
                    <label for="location" class="form-label">Địa chỉ:</label>
                    <input type="text" name="location" value="<%= user.getLocation() %>" required>
                </div>
                <div class="input-box flex-1 min-w-[220px]">
                    <label for="email" class="form-label">Email:</label>
                    <input type="email" value="<%= user.getEmail() %>" readonly>
                </div>
                <div class="input-box flex-1 min-w-[220px]">
                    <label for="role" class="form-label">Vai trò:</label>
                    <input type="text" value="<%= user.getRole() %>" readonly>
                </div>
            </div>
            <button type="submit" class="update-btn mt-3">Cập nhật thông tin</button>
        </form>
    </div>
    <script>
        function previewAvatar(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function(e) {
                    document.getElementById('mainAvatar').src = e.target.result;
                };
                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
