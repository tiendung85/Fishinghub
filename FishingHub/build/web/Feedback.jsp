<%@page contentType="text/html" pageEncoding="UTF-8"%>Add commentMore actions
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
</head>
<body>
    <h2>Gửi góp ý cho hệ thống</h2>
    <form action="FeedbackController" method="post">
        <div>
            <label>Họ tên người góp ý:</label>
            <input type="text" name="fullname" value="<%= user.getFullName() %>" readonly>
        </div>
        <div>
            <label>Email:</label>
            <input type="email" name="email" value="<%= user.getEmail() %>" readonly>
        </div>
        <div>
            <label>Nội dung góp ý:</label><br>
            <textarea name="content" rows="5" cols="50" required></textarea>
        </div>
        <br>
        <button type="submit">Gửi góp ý</button>
    </form>

    <% if (request.getAttribute("success") != null) { %>
        <p style="color: green"><%= request.getAttribute("success") %></p>
    <% } %>

    <% if (request.getAttribute("error") != null) { %>
        <p style="color: red"><%= request.getAttribute("error") %></p>
    <% } %>
</body>
</html>