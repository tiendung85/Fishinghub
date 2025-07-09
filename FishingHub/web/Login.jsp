<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Đăng nhập - Fishing Hub</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #6b73ff 0%, #00ddeb 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Poppins', sans-serif;
        }

        .login-box {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            padding: 2.5rem;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            max-width: 400px;
            width: 100%;
            animation: fadeIn 0.6s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .login-box h2 {
            font-weight: 600;
            color: #1a1a1a;
            margin-bottom: 1.5rem;
            text-align: center;
        }

        .form-control {
            border-radius: 8px;
            padding: 0.75rem;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            border-color: #6b73ff;
            box-shadow: 0 0 0 0.2rem rgba(107, 115, 255, 0.25);
        }

        .btn-primary {
            background: linear-gradient(90deg, #6b73ff, #00ddeb);
            border: none;
            border-radius: 8px;
            padding: 0.75rem;
            font-weight: 600;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .btn-primary:hover {
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
            transition: all 0.3s ease;
            text-decoration: none;
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

        .forgot-link, .register-link {
            color: #6b73ff;
            text-decoration: none;
            font-size: 0.9rem;
            transition: color 0.3s ease;
        }

        .forgot-link:hover, .register-link:hover {
            color: #00ddeb;
            text-decoration: underline;
        }

        .links {
            display: flex;
            justify-content: space-between;
            margin: 1rem 0;
        }
    </style>
</head>
<body>
<div class="login-box">
    <h2>Đăng nhập</h2>

    <!-- Display error if present -->
    <c:if test="${not empty error}">
        <p class="error">${error}</p>
    </c:if>

    <form action="login" method="post">
        <div class="mb-3">
            <input type="text" name="email" class="form-control" placeholder="Email or Username" required />
        </div>
        <div class="mb-3">
            <input type="password" name="password" class="form-control" placeholder="Password" required />
        </div>
        <button type="submit" class="btn btn-primary w-100">Đăng nhập</button>
    </form>

    <div class="links">
        <a href="forgot-password" class="forgot-link">Quên mật khẩu?</a>
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

<!-- Bootstrap JS and Popper.js -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>