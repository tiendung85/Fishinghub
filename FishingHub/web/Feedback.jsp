<%@ page contentType="text/html" pageEncoding="UTF-8"%>
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
                <title>Góp ý</title>
                <!-- Google Fonts preconnect and import -->
                <link rel="preconnect" href="https://fonts.googleapis.com">
                <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
                <link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet">
                <!-- Bootstrap CSS -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
                <!-- Tailwind CSS CDN -->
                <script src="https://cdn.tailwindcss.com"></script>
                <style>
                    body {
                        font-family: 'Roboto', sans-serif;
                        background: #f6f9fc;
                    }
                </style>
            </head>

            <body class="bg-gray-50 min-h-screen flex items-center justify-center">
                <div class="container max-w-lg bg-white rounded shadow p-4 mt-5">
                    <h2 class="mb-4 text-xl font-bold text-center">Gửi góp ý cho hệ thống</h2>
                    <form action="FeedbackController" method="post">
                        <div class="mb-3">
                            <label class="form-label">Họ tên người góp ý:</label>
                            <input type="text" name="fullname" value="<%= user.getFullName() %>" class="form-control" readonly>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Email:</label>
                            <input type="email" name="email" value="<%= user.getEmail() %>" class="form-control" readonly>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Nội dung góp ý:</label>
                            <textarea name="content" rows="5" class="form-control" required></textarea>
                        </div>
                        <button type="submit" class="btn btn-primary w-full">Gửi góp ý</button>
                    </form>
                    <% if (request.getAttribute("success") != null) { %>
                        <div class="alert alert-success mt-3">
                            <%= request.getAttribute("success") %>
                        </div>
                        <% } %>
                            <% if (request.getAttribute("error") != null) { %>
                                <div class="alert alert-danger mt-3">
                                    <%= request.getAttribute("error") %>
                                </div>
                                <% } %>
                </div>
                <!-- Bootstrap JS -->
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>