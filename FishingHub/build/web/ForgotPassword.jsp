<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Quên mật khẩu</title>
    <style>
        body {
            background: linear-gradient(135deg, #6b73ff 0%, #00ddeb 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Poppins', sans-serif;
            margin: 0;
        }
        .center-box {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            padding: 2.5rem;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            max-width: 400px;
            width: 100%;
            animation: fadeIn 0.6s ease-in-out;
            text-align: center;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .center-box h2 {
            font-weight: 600;
            color: #1a1a1a;
            margin-bottom: 1.5rem;
            font-size: 24px;
        }
        .center-box input {
            width: 100%;
            padding: 0.75rem;
            margin: 10px 0 16px 0;
            border-radius: 8px;
            border: 1px solid #ddd;
            background: #fff;
            font-size: 15px;
            transition: all 0.3s ease;
            box-sizing: border-box;
        }
        .center-box input:focus {
            outline: none;
            border-color: #6b73ff;
            box-shadow: 0 0 0 0.2rem rgba(107, 115, 255, 0.25);
            transform: scale(1.02);
        }
        .center-box button {
            width: 100%;
            padding: 0.75rem;
            background: linear-gradient(90deg, #6b73ff, #00ddeb);
            border: none;
            color: #fff;
            font-weight: 600;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
            margin-bottom: 10px;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        .center-box button:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        }
        .center-box button:active {
            transform: translateY(0);
            box-shadow: none;
        }
        .center-box a {
            color: #6b73ff;
            font-size: 14px;
            text-decoration: none;
            transition: color 0.3s ease;
        }
        .center-box a:hover {
            color: #00ddeb;
            text-decoration: underline;
        }
        .error {
            color: #dc3545;
            font-size: 0.9rem;
            margin-bottom: 1rem;
            text-align: center;
            animation: shake 0.3s ease-in-out;
        }
        .msg {
            color: #119750;
            font-size: 0.9rem;
            margin-bottom: 1rem;
            text-align: center;
            animation: slideIn 0.5s ease-in-out;
        }
        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-5px); }
            75% { transform: translateX(5px); }
        }
        @keyframes slideIn {
            from { opacity: 0; transform: translateX(-10px); }
            to { opacity: 1; transform: translateX(0); }
        }
    </style>
</head>
<body>
<div class="center-box">
    <h2>Quên mật khẩu</h2>
    <form action="forgot-password" method="post">
        <input type="email" name="email" placeholder="Nhập email đã đăng ký" required />
        <button type="submit">Gửi mã xác nhận</button>
    </form>
    <a href="login">← Quay lại đăng nhập</a>
    <div>
        <c:if test="${not empty error}">
            <div class="error">${error}</div>
        </c:if>
        <c:if test="${not empty msg}">
            <div class="msg">${msg}</div>
        </c:if>
    </div>
</div>
</body>
</html>