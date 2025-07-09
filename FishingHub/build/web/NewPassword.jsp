<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="vi">

    <head>
        <meta charset="UTF-8">
        <title>Nhập mật khẩu mới</title>
    </head>

    <body>
        <h2>Nhập mật khẩu mới</h2>

        <form action="NewPasswordController" method="post">
            <label>Mật khẩu mới:</label>
            <input type="password" name="newPassword" required /><br/>

            <label>Xác nhận lại:</label>
            <input type="password" name="confirmPassword" required /><br/>

            <button type="submit">Cập nhật mật khẩu</button>
        </form>

        <% String error = (String) request.getAttribute("error");
       if (error != null) { %>
            <div style="color:red">
                <%= error %>
            </div>
            <% } %>
    </body>

    </html>