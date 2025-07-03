<%@ page contentType="text/html" pageEncoding="UTF-8" %>Add commentMore actions
<%@ page import="model.Users" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đổi Mật Khẩu</title>
</head>
<body>
    <h2>Đổi mật khẩu</h2>

    <form action="SendOtpController" method="post">
        <label>Mật khẩu hiện tại:</label>
        <input type="password" name="currentPassword" required /><br/>

        <label>Email đăng ký:</label>
        <input type="email" name="email" required /><br/>

        <button type="submit">Gửi mã OTP</button>
    </form>

    <% String error = (String) request.getAttribute("error");
       if (error != null) { %>
        <div style="color:red"><%= error %></div>
    <% } %>
</body>Add commentMore actions
</html>