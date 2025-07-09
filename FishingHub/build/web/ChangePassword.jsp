<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ page import="model.Users" %>

        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <title>Đổi Mật Khẩu</title>
            <!-- Google Fonts preconnect and import -->
            <link rel="preconnect" href="https://fonts.googleapis.com">
            <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
            <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
            <!-- Bootstrap CSS -->
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
            <!-- Tailwind CSS CDN -->
            <script src="https://cdn.tailwindcss.com"></script>
            <style>
                body {
                    font-family: 'Roboto', sans-serif;
                }
            </style>
        </head>

        <body class="bg-gray-50 min-h-screen flex items-center justify-center">
            <div class="container max-w-md bg-white rounded shadow p-4 mt-5">
                <h2 class="mb-4 text-xl font-bold text-center">Đổi mật khẩu</h2>
                <form action="SendOtpController" method="post">
                    <div class="mb-3">
                        <label class="form-label">Mật khẩu hiện tại:</label>
                        <input type="password" name="currentPassword" class="form-control" required />
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Email đăng ký:</label>
                        <input type="email" name="email" class="form-control" required />
                    </div>
                    <button type="submit" class="btn btn-primary w-full">Gửi mã OTP</button>
                </form>
                <% String error = (String) request.getAttribute("error");
           if (error != null) { %>
                    <div class="alert alert-danger mt-3">
                        <%= error %>
                    </div>
                    <% } %>
            </div>
            <!-- Bootstrap JS -->
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>