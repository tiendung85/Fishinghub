<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Nhập OTP</title>
</head>
<body>
    <h2>Nhập mã OTP</h2>

    <form action="VerifyOtpController" method="post">
        <label>Mã OTP:</label>
        <input type="text" name="otp" required /><br/>
        <button type="submit">Xác nhận</button>
    </form>

    <% String error = (String) request.getAttribute("error");
       if (error != null) { %>
        <div style="color:red"><%= error %></div>
    <% } %>
</body>
</html>
