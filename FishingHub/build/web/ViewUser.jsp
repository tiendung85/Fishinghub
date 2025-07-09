<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>View User</title>
    <link rel="stylesheet" href="assets/css/style.css" />
</head>
<body>
    <div class="container">
        <h2>Chi tiết người dùng</h2>
        <table>
            <tr>
                <td><strong>Tên đầy đủ:</strong></td>
                <td>${user.fullName}</td> <!-- Sử dụng JSP EL để truy cập đối tượng user -->
            </tr>
            <tr>
                <td><strong>Email:</strong></td>
                <td>${user.email}</td> <!-- Dùng JSP EL -->
            </tr>
            <tr>
                <td><strong>Số điện thoại:</strong></td>
                <td>${user.phone}</td> <!-- Dùng JSP EL -->
            </tr>
            <tr>
                <td><strong>Giới tính:</strong></td>
                <td>${user.gender}</td> <!-- Dùng JSP EL -->
            </tr>
            <tr>
                <td><strong>Ngày sinh:</strong></td>
                <td>${user.dateOfBirth}</td> <!-- Dùng JSP EL -->
            </tr>
            <tr>
                <td><strong>Địa chỉ:</strong></td>
                <td>${user.location}</td> <!-- Dùng JSP EL -->
            </tr>
            <tr>
                <td><strong>Vai trò:</strong></td>
                <td>${user.role}</td> <!-- Dùng JSP EL -->
            </tr>
        </table>
        <a href="UserManager" class="btn btn-secondary">Trở lại</a>
    </div>
</body>
</html>