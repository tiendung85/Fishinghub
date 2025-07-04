<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
<<<<<<< HEAD
    <title>Fishing Hub - Đăng kí</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #6b73ff 0%, #00ddeb 100%);
            min-height: 100vh;
            margin: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Poppins', sans-serif;
        }

        .container {
            width: 100vw;
            height: 100vh;
            display: flex;
            background: rgba(255, 255, 255, 0.95);
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            animation: fadeIn 0.6s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .form-section {
            padding: 2.5rem;
            width: 50%;
            overflow-y: auto;
            height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .image-section {
            width: 50%;
            height: 100vh;
            position: relative;
            overflow: hidden;
        }

        .image-section img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            object-position: center;
            display: block;
            transition: transform 0.5s ease;
        }

        .image-section:hover img {
            transform: scale(1.05);
        }

        .fishing-hub-btn {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: #6b73ff;
            font-size: 1.5rem;
            font-weight: 600;
            text-decoration: none;
            margin-bottom: 1.5rem;
            transition: color 0.3s ease;
        }

        .fishing-hub-btn:hover {
            color: #00ddeb;
        }

        .fish {
            width: 24px;
            height: 24px;
            transition: transform 0.3s ease;
        }

        .fishing-hub-btn:hover .fish1 {
            transform: translateX(5px);
        }

        .fishing-hub-btn:hover .fish2 {
            transform: translateX(-5px);
        }

        h2 {
            font-weight: 600;
            color: #1a1a1a;
            margin-bottom: 1.5rem;
            text-align: center;
        }

        .form-label {
            font-weight: 500;
            color: #333;
        }

        .form-control, .form-select {
            border-radius: 8px;
            padding: 0.75rem;
            transition: all 0.3s ease;
        }

        .form-control:focus, .form-select:focus {
            border-color: #6b73ff;
            box-shadow: 0 0 0 0.2rem rgba(107, 115, 255, 0.25);
        }

        .register-btn {
            background: linear-gradient(90deg, #6b73ff, #00ddeb);
            border: none;
            border-radius: 8px;
            padding: 0.75rem;
            font-weight: 600;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
            width: 100%;
        }

        .register-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        }

        .google-btn {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            background: white;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 0.75rem;
            color: #444;
            font-weight: 500;
            text-decoration: none;
            transition: all 0.3s ease;
            width: 100%;
            margin-top: 1rem;
        }

        .google-btn:hover {
            background: #f8f9fa;
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .google-logo {
            width: 20px;
            height: 20px;
        }

        .error {
            color: #dc3545;
            font-size: 0.9rem;
            margin-bottom: 1rem;
            text-align: center;
            animation: shake 0.3s ease-in-out;
        }

        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-5px); }
            75% { transform: translateX(5px); }
        }

        .or-separator {
            display: flex;
            align-items: center;
            text-align: center;
            margin: 1.5rem 0;
            color: #666;
        }

        .or-separator::before,
        .or-separator::after {
            content: '';
            flex: 1;
            border-bottom: 1px solid #ddd;
        }

        .or-separator span {
            padding: 0 1rem;
            font-size: 0.9rem;
        }

        .checkbox-label {
            font-size: 0.9rem;
            color: #666;
            margin: 1rem 0;
        }

        .login-link {
            text-align: center;
            margin-top: 1rem;
            font-size: 0.9rem;
        }

        .login-link a {
            color: #6b73ff;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .login-link a:hover {
            color: #00ddeb;
            text-decoration: underline;
        }

        @media (max-width: 768px) {
            .container {
                flex-direction: column;
                height: auto;
                border-radius: 0;
            }
            .form-section {
                width: 100%;
                height: auto;
                padding: 1.5rem;
            }
            .image-section {
                width: 100%;
                height: 40vh;
            }
        }
    </style>
=======
    <title>Fishing Hub - Register</title>
    <link rel="stylesheet" href="assets/css/register.css" />
>>>>>>> lam
</head>
<body>
<div class="container">
    <div class="form-section">
<<<<<<< HEAD
       
        <h2>Tạo một tài khoản mới</h2>
        <% String error = (String)request.getAttribute("error");
           if (error != null) { %>
            <div class="error"><%= error %></div>
        <% } %>
        <form action="Register" method="post" id="registerForm">
            <div class="mb-3">
                <label for="fullName" class="form-label">Tên đầy đủ</label>
                <input type="text" id="fullName" name="fullName" class="form-control" placeholder="Enter your full name" required>
            </div>
            <div class="mb-3">
                <label for="email" class="form-label">Địa chỉ email</label>
                <input type="email" id="email" name="email" class="form-control" placeholder="Enter your email" required>
            </div>
            <div class="mb-3">
                <label for="phone" class="form-label">Số điện thoại</label>
                <input type="text" id="phone" name="phone" class="form-control" placeholder="Nhập số điện thoại" required>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Mật khẩu</label>
                <input type="password" id="password" name="password" class="form-control" placeholder="Create a password" required>
            </div>
            <div class="mb-3">
                <label for="confirmPassword" class="form-label">Nhập lại mật khẩu</label>
                <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" placeholder="Confirm your password" required>
            </div>
            <div class="mb-3">
                <label for="gender" class="form-label">Giới tính</label>
                <select id="gender" name="gender" class="form-select" required>
                    <option value="" disabled selected>Chọn giới tính</option>
                    <option value="Male">Nam</option>
                    <option value="Female">Nữ</option>
                    <option value="Other">Khác</option>
                </select>
            </div>
            <div class="mb-3">
                <label for="role" class="form-label">Vai trò</label>
                <select name="role" class="form-select" required>
                    <option value="" disabled selected>Chọn vai trò</option>
                    <option value="user">Người dùng</option>
                    <option value="fish_owner">Chủ hồ câu</option>
                </select>
            </div>
            <div class="mb-3">
                <label for="dob" class="form-label">Ngày tháng năm sinh</label>
                <input type="date" id="dob" name="dob" class="form-control" required>
            </div>
            <div class="mb-3">
                <label for="location" class="form-label">Địa chỉ</label>
                <input type="text" id="location" name="location" class="form-control" placeholder="Enter your location" required>
            </div>
            <div class="mb-3 checkbox-label">
                <input type="checkbox" name="terms" required> By proceeding, you agree to the Terms of Service and Privacy Notice.
            </div>
            <button type="submit" class="register-btn">Đăng ký</button>
            <div class="or-separator">
                <span>hoặc</span>
            </div>
            <a href="google-login-url" class="google-btn">
=======
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
>>>>>>> lam
                <img src="assets/img/gg.png" alt="Google logo" class="google-logo" />
                Tiếp tục với Google
            </a>
        </form>
<<<<<<< HEAD
        <p class="login-link">Đã có tài khoản? <a href="Login.jsp">Đăng nhập</a></p>
    </div>
    <div class="image-section">
        <img src="assets/img/fisherman.jpg" alt="Fisherman scene" />
    </div>
</div>
<!-- Bootstrap JS and Popper.js -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- Client-side validation -->
<script>
document.getElementById("registerForm").onsubmit = function(e) {
    // Validate phone number
=======
        <p class="login-link">Đã có tài khoản ? <a href="Login.jsp">Đăng nhập</a></p>
    </div>
    <div class="image-section"></div>
</div>
<!-- Script validate phía client -->
<script>
document.getElementById("registerForm").onsubmit = function(e) {
    // Validate số điện thoại
>>>>>>> lam
    var phone = document.getElementById("phone").value;
    if (!/^\d{10}$/.test(phone)) {
        alert("Số điện thoại phải gồm đúng 10 chữ số!");
        document.getElementById("phone").focus();
        e.preventDefault();
        return false;
    }

<<<<<<< HEAD
    // Validate age >= 18
=======
    // Validate ngày sinh >= 18 tuổi
>>>>>>> lam
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
<<<<<<< HEAD
};
</script>
</body>
</html>
=======
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
>>>>>>> lam
