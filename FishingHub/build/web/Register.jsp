<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Fishing Hub - Register</title>
    <link rel="stylesheet" href="assets/css/register.css" />
</head>
<body>
<div class="container">
    <div class="form-section">
        <a href="#" class="fishing-hub-btn">
            Fishing Hub
            <svg class="fish fish1" viewBox="0 0 24 24">
                <path fill="#6b73ff" d="M22 12l-4-4v3H2v2h16v3z"/>
            </svg>
            <svg class="fish fish2" viewBox="0 0 24 24">
                <path fill="#6b73ff" d="M22 12l-4-4v3H2v2h16v3z"/>
            </svg>
        </a>
        <h2>Tạo một tài khoản mới</h2>
        <% String error = (String)request.getAttribute("error"); %>
        <% if (error != null) { %>
            <div style="color: red; margin-bottom: 12px;"><%= error %></div>
        <% } %>
        <form action="Register" method="post" id="registerForm" autocomplete="off">
            <label for="fullName">Tên đầy đủ</label>
            <input type="text" id="fullName" name="fullName" placeholder="Enter your full name"
                value="<%= request.getAttribute("fullName") != null ? request.getAttribute("fullName") : "" %>" required>

            <label for="email">Địa chỉ email</label>
            <input type="email" id="email" name="email" placeholder="Enter your email"
                value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>" required>
            
            <label for="phone">Số điện thoại</label>
            <input type="text" id="phone" name="phone" placeholder="Nhập số điện thoại"
                value="<%= request.getAttribute("phone") != null ? request.getAttribute("phone") : "" %>" required>

            <label for="password">Mật khẩu</label>
            <input type="password" id="password" name="password" placeholder="Create a password" required>

            <label for="confirmPassword">Nhập lại mật khẩu</label>
            <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm your password" required>
            <span id="pw-error" style="color: red; font-size: 13px;">
                <%= request.getAttribute("pwError") != null ? request.getAttribute("pwError") : "" %>
            </span>

            <label for="gender">Giới tính</label>
            <select id="gender" name="gender" required>
                <option value="" disabled <%= request.getAttribute("gender") == null ? "selected" : "" %>>Chọn giới tính </option>
                <option value="Male" <%= "Male".equals(request.getAttribute("gender")) ? "selected" : "" %>>Nam</option>
                <option value="Female" <%= "Female".equals(request.getAttribute("gender")) ? "selected" : "" %>>Nữ</option>
                <option value="Other" <%= "Other".equals(request.getAttribute("gender")) ? "selected" : "" %>>Khác</option>
            </select>
            <label for="role">Vai trò</label>
            <select name="role" required>
                <option value="" disabled <%= request.getAttribute("role") == null ? "selected" : "" %>>Chọn vai trò </option>
                <option value="user" <%= "user".equals(request.getAttribute("role")) ? "selected" : "" %>>Người dùng</option>
                <option value="fish_owner" <%= "fish_owner".equals(request.getAttribute("role")) ? "selected" : "" %>>Chủ hồ câu</option>
            </select>

            <label for="dob">Ngày tháng năm sinh</label>
            <input type="date" id="dob" name="dob"
                value="<%= request.getAttribute("dob") != null ? request.getAttribute("dob") : "" %>" required>

            <label for="location">Địa chỉ</label>
            <input type="text" id="location" name="location" placeholder="Enter your location"
                value="<%= request.getAttribute("location") != null ? request.getAttribute("location") : "" %>" required>

            <label class="checkbox-label">
                <input type="checkbox" name="terms" required <%= request.getAttribute("terms") != null ? "checked" : "" %>> Tôi đồng ý với điều khoản sử dụng và chính sách bảo mật.
            </label>

            <button type="submit" class="register-btn">Đăng ký</button>
            
            <div class="or-separator">
                <span>hoặc</span>
            </div>

            <a href="google-login" class="google-btn">
                <img src="assets/img/gg.png" alt="Google logo" class="google-logo" />
                Tiếp tục với Google
            </a>
        </form>
        <p class="login-link">Đã có tài khoản ? <a href="Login.jsp">Đăng nhập</a></p>
    </div>
    <div class="image-section"></div>
</div>
<!-- Script validate phía client -->
<script>
document.getElementById("registerForm").onsubmit = function(e) {
    // Validate số điện thoại
    var phone = document.getElementById("phone").value;
    if (!/^\d{10}$/.test(phone)) {
        alert("Số điện thoại phải gồm đúng 10 chữ số!");
        document.getElementById("phone").focus();
        e.preventDefault();
        return false;
    }

    // Validate ngày sinh >= 18 tuổi
    var dob = document.getElementById("dob").value;
    if (dob) {
        var dobDate = new Date(dob);
        var now = new Date();
        var minBirthDate = new Date();
        minBirthDate.setFullYear(now.getFullYear() - 18);

        if (dobDate > minBirthDate) {
            alert("Bạn phải đủ 18 tuổi trở lên.");
            document.getElementById("dob").focus();
            e.preventDefault();
            return false;
        }
    }
    // Validate mật khẩu và nhập lại mật khẩu
    var pw = document.getElementById("password").value;
    var pw2 = document.getElementById("confirmPassword").value;
    var errorSpan = document.getElementById("pw-error");
    if (pw !== pw2) {
        errorSpan.innerText = "Mật khẩu không khớp!";
        document.getElementById("confirmPassword").focus();
        e.preventDefault();
        return false;
    } else {
        errorSpan.innerText = "";
    }
};
// Hiển thị lỗi mật khẩu không khớp khi gõ realtime
document.getElementById("confirmPassword").addEventListener("input", function() {
    var pw = document.getElementById("password").value;
    var pw2 = document.getElementById("confirmPassword").value;
    var errorSpan = document.getElementById("pw-error");
    if (pw2.length > 0 && pw !== pw2) {
        errorSpan.innerText = "Mật khẩu không khớp!";
    } else {
        errorSpan.innerText = "";
    }
});
</script>
</body>
</html>
