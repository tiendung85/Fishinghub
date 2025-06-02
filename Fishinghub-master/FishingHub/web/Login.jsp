<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login - Fishing Hub</title>
    <link rel="stylesheet" href="assets/css/register.css" />
    <style>
        body {
            min-height: 100vh;
            margin: 0;
            /* Gradient gồm 2 lớp: trên xanh biển, dưới vàng cam */
            background: 
                linear-gradient(to bottom, #e3f0fd 0px, #e3f0fd 220px, #ffd580 250px, #ffa07a 100%);
        }

        .login-box {
            width: 380px;
            margin: 100px auto;
            padding: 36px 40px 30px 40px;
            background: #f0f4ff;
            border-radius: 15px;
            box-shadow: 0 0 24px rgba(0,0,0,0.08);
            text-align: center;
            position: relative;
        }

        .login-top-bar {
            width: 100%;
            height: 8px;
            background: linear-gradient(90deg, #007bff 0%, #00c6fb 100%);
            border-radius: 12px 12px 0 0;
            position: absolute;
            top: 0;
            left: 0;
        }

        .login-box h2 {
            margin-top: 28px;
            margin-bottom: 22px;
            letter-spacing: 2px;
        }

        .login-box input {
            width: 100%;
            padding: 11px;
            margin: 10px 0;
            border: 1.5px solid #cfd9ed;
            border-radius: 7px;
            font-size: 16px;
            background: #fff;
        }

        .login-box button {
            width: 100%;
            padding: 13px;
            margin-top: 14px;
            background: linear-gradient(90deg, #5b6bff 0%, #6bc6ff 100%);
            color: white;
            font-weight: bold;
            border: none;
            border-radius: 9px;
            cursor: pointer;
            font-size: 16px;
            transition: background 0.2s;
        }
        .login-box button:hover {
            background: linear-gradient(90deg, #007bff 0%, #00c6fb 100%);
        }

        .login-options {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin: 12px 0 6px 0;
            font-size: 15px;
        }
        .login-options a {
            color: #4361ee;
            text-decoration: none;
            transition: text-decoration 0.2s;
        }
        .login-options a:hover {
            text-decoration: underline;
        }

        .or-separator {
            margin: 16px 0 12px 0;
            position: relative;
            text-align: center;
            color: #888;
            font-size: 15px;
        }
        .or-separator:before,
        .or-separator:after {
            content: "";
            display: inline-block;
            width: 38%;
            height: 1px;
            background: #dde3ef;
            vertical-align: middle;
            margin: 0 8px;
        }

        .google-btn {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            width: 100%;
            margin-top: 5px;
            padding: 10px;
            border: 1.3px solid #ccc;
            background-color: #fff;
            color: #444;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 500;
            font-size: 16px;
            transition: box-shadow 0.2s;
        }
        .google-btn:hover {
            box-shadow: 0 2px 8px rgba(0,123,255,0.10);
        }
        .google-logo {
            width: 20px;
            height: 20px;
        }

        .error {
            color: #ff3b3b;
            margin-bottom: 13px;
            font-size: 15px;
            font-weight: 500;
        }
    </style>
</head>
<body>

<div class="login-box">
    <div class="login-top-bar"></div>
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

    <div class="login-options">
        <a href="forgot-password" class="forgot-link">Quên mật khẩu?</a>
        <span>|</span>
        <a href="Register" class="register-link">Đăng ký</a>
    </div>

    <div class="or-separator">
        <span>hoặc</span>
    </div>

    <a href="google-login" class="google-btn">
        <img src="assets/img/gg.png" alt="Google logo" class="google-logo" />
        Tiếp tục với Google
    </a>
</div>

</body>
</html>
