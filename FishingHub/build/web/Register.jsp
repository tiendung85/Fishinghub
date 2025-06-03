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
        <% String error = (String)request.getAttribute("error");
           if (error != null) { %>
            <div style="color: red; margin-bottom: 12px;"><%= error %></div>
        <% } %>
        <form action="Register" method="post" id="registerForm">
            <label for="fullName">Tên đầy đủ</label>
            <input type="text" id="fullName" name="fullName" placeholder="Enter your full name" required>

            <label for="email">Địa chỉ email</label>
            <input type="email" id="email" name="email" placeholder="Enter your email" required>
            
            <label for="phone">Số điện thoại</label>
            <input type="text" id="phone" name="phone" placeholder="Nhập số điện thoại" required>

            <label for="password">Mật khẩu</label>
            <input type="password" id="password" name="password" placeholder="Create a password" required>

            <label for="confirmPassword">Nhập lại mật khẩu</label>
            <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm your password" required>

            <label for="gender">Giới tính</label>
            <select id="gender" name="gender" required>
                <option value="" disabled selected>Chọn giới tính </option>
                <option value="Male">Nam</option>
                <option value="Female">Nữ</option>
                <option value="Other">Khác</option>
            </select>
            <label for="role">Vai trò</label>
            <select name="role" required>
                <option value="" disabled selected>Chọn vai trò </option>
                <option value="user">Người dùng</option>
                <option value="fish_owner">Chủ hồ câu</option>
            </select>

            <label for="dob">Ngày tháng năm sinh</label>
            <input type="date" id="dob" name="dob" required>

            <label for="location">Địa chỉ</label>
            <input type="text" id="location" name="location" placeholder="Enter your location" required>

            <label class="checkbox-label">
                <input type="checkbox" name="terms" required> By proceeding, you agree to the Terms of Service and Privacy Notice.
            </label>

            <button type="submit" class="register-btn">Đăng ký</button>
            
            <div class="or-separator">
                <span>hoặc</span>
            </div>

            <a href="google-login-url" class="google-btn">
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
};
</script>
</body>
</html>