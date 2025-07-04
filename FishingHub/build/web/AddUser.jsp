<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Thêm người dùng</title>
    <link rel="stylesheet" href="assets/css/register.css" />
</head>
<body>
<header class="admin-header">
    <nav class="admin-nav">
        <a href="UserManager">Quay lại danh sách người dùng</a>
    </nav>
</header>

<div class="table-container" style="width:60%;margin:auto;">
    <h2>Thêm người dùng mới</h2>
    <form action="AddUser" method="post">
        <label for="fullName">Tên đầy đủ</label>
        <input type="text" id="fullName" name="fullName" placeholder="Nhập tên đầy đủ" required><br><br>

        <label for="email">Địa chỉ email</label>
        <input type="email" id="email" name="email" placeholder="Nhập email" required><br><br>

        <label for="phone">Số điện thoại</label>
        <input type="text" id="phone" name="phone" placeholder="Nhập số điện thoại" required><br><br>

        <label for="password">Mật khẩu</label>
        <input type="password" id="password" name="password" placeholder="Tạo mật khẩu" required><br><br>

        <label for="confirmPassword">Nhập lại mật khẩu</label>
        <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Xác nhận mật khẩu" required><br><br>

        <label for="gender">Giới tính</label>
        <select id="gender" name="gender" required>
            <option value="Male">Nam</option>
            <option value="Female">Nữ</option>
            <option value="Other">Khác</option>
        </select><br><br>

        <label for="role">Vai trò</label>
        <select name="role" required>
            <option value="1">Người dùng</option>
            <option value="2">Chủ hồ câu</option>
            <option value="3">Admin</option>
        </select><br><br>

        <label for="dob">Ngày tháng năm sinh</label>
        <input type="date" id="dob" name="dob" required><br><br>

        <label for="location">Địa chỉ</label>
        <input type="text" id="location" name="location" placeholder="Nhập địa chỉ" required><br><br>

        <label class="checkbox-label">
            <input type="checkbox" name="terms" required> Tôi đồng ý với điều khoản sử dụng và chính sách bảo mật.
        </label><br><br>

        <button type="submit">Thêm người dùng</button>
    </form>
</div>
</body>
</html>
