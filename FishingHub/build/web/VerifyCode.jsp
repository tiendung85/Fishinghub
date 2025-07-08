<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Xác nhận mã OTP</title>
    <style>
        body { background: #f6f7fb; font-family: 'Segoe UI', Arial, sans-serif; }
        .center-box {
            width: 350px;
            margin: 100px auto;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 2px 24px 0 rgba(44,62,80,.12);
            padding: 32px 28px;
            text-align: center;
        }
        .center-box h2 { margin-bottom: 20px; color: #2d4fa0; }
        .center-box input {
            width: 100%;
            padding: 12px;
            margin: 10px 0 16px 0;
            border-radius: 6px;
            border: 1px solid #dbe2ef;
            background: #f7fafc;
            font-size: 15px;
        }
        .center-box button {
            width: 100%;
            padding: 12px;
            background: #3468f7;
            border: none;
            color: #fff;
            font-weight: 600;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
            margin-bottom: 5px;
        }
        .center-box a { color: #2d4fa0; font-size: 14px; text-decoration: none;}
        .error { color: #dc3545; font-size: 14px; margin-bottom: 8px; }
        .msg { color: #119750; font-size: 14px; margin-bottom: 8px;}
    </style>
</head>
<body>
<div class="center-box">
    <h2>Nhập mã xác nhận</h2>
    <form action="verify-code" method="post">
        <input type="hidden" name="email" value="${email}" />
        <input type="text" name="code" placeholder="Nhập mã xác nhận vừa nhận" required />
        <button type="submit">Xác nhận</button>
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