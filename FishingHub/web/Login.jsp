<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login - Fishing Hub</title>
    <link rel="stylesheet" href="assets/css/register.css" />
    <style>
        .login-box {
            width: 350px;
            margin: 120px auto;
            padding: 30px 40px;
            background: #f0f4ff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            text-align: center;
        }

        .login-box h2 {
            margin-bottom: 20px;
        }

        .login-box input {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 6px;
        }

        .login-box button {
            width: 100%;
            padding: 12px;
            margin-top: 10px;
            background-color: #6b73ff;
            color: white;
            font-weight: bold;
            border: none;
            border-radius: 8px;
            cursor: pointer;
        }

        .google-btn {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            width: 100%;
            margin-top: 20px;
            padding: 10px;
            border: 1px solid #ccc;
            background-color: white;
            color: #444;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 500;
        }

        .google-logo {
            width: 18px;
            height: 18px;
        }

        .error {
            color: red;
            margin-bottom: 10px;
            font-size: 14px;
        }
    </style>
</head>
<body>

<div class="login-box">
    <h2>Login</h2>

    <!-- Hiển thị lỗi nếu có -->
    <c:if test="${not empty error}">
        <p class="error">${error}</p>
    </c:if>

    <form action="login" method="post">
    <input type="text" name="email" placeholder="Email or Username" required />
    <input type="password" name="password" placeholder="Password" required />
    <button type="submit">Đăng nhập</button>
</form>

<div style="margin: 15px 0 5px 0;">
    <a href="forgot-password" class="forgot-link">Quên mật khẩu?</a>
     <a href="Register" class="forgot-link">Đăng ký</a>
</div>

<div class="or-separator">
    <span>hoặc</span>
</div>


    <a href="google-login" class="google-btn">
        <img src="assets/img/gg.png" alt="Google logo" class="google-logo" />
        Tiếp tục với google
    </a>
</div>

</body>
</html>