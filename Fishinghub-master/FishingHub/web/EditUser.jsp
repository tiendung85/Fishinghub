<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Chỉnh sửa người dùng</title>
    <script>
        // Hàm hiển thị thông báo và chuyển hướng
        function showAlertAndRedirect() {
            alert("Cập nhật thành công!");
            window.location.href = "UserManager";  // Chuyển về trang UserManager
        }
    </script>
</head>
<body>
    <div class="container">
        <h2>Chỉnh sửa thông tin người dùng</h2>
        <form action="EditUserController" method="post" onsubmit="showAlertAndRedirect()">
            <!-- Đảm bảo truyền userId chính xác vào input hidden -->
            <input type="hidden" name="id" value="${user.userId}">

            <label for="fullName">Tên đầy đủ</label>
            <input type="text" name="fullName" value="${user.fullName}" required>

            <label for="email">Email</label>
            <input type="email" name="email" value="${user.email}" required>

            <label for="phone">Số điện thoại</label>
            <input type="text" name="phone" value="${user.phone}" required>

            <label for="password">Mật khẩu</label>
            <input type="password" name="password" value="${user.password}">

            <label for="gender">Giới tính</label>
            <input type="text" name="gender" value="${user.gender}" required>

            <label for="dob">Ngày sinh</label>
            <input type="date" name="dob" value="${user.dateOfBirth}" required>

            <label for="location">Địa chỉ</label>
            <input type="text" name="location" value="${user.location}" required>

            <label for="role">Vai trò</label>
            <select name="role">
                <option value="user" <c:if test="${user.role == 'user'}">selected</c:if>>Người dùng</option>
                <option value="fish_owner" <c:if test="${user.role == 'fish_owner'}">selected</c:if>>Chủ hồ câu</option>
            </select>

            <button type="submit">Cập nhật</button>
        </form>
    </div>
</body>
</html>
