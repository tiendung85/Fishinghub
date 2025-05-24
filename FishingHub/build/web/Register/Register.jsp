<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Fishing Hub - Register</title>
    <style>
        /* CSS giữ nguyên từ bạn gửi */
        * {
            box-sizing: border-box;
        }
        body, html {
            margin: 0; padding: 0;
            font-family: Arial, sans-serif;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            background: url('${pageContext.request.contextPath}/assets/img/hero-bg.jpg') no-repeat center center/cover;
        }
        .container {
            background: white;
            width: 700px;
            max-width: 95%;
            display: flex;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 0 20px rgba(0,0,0,0.2);
        }
        .form-section {
            padding: 30px;
            width: 60%;
        }
        .form-section h2 {
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-top: 15px;
            font-weight: bold;
        }
        input[type=text], input[type=email], input[type=password], select, input[type=date] {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
        }
        .checkbox-label {
            margin-top: 15px;
            font-weight: normal;
        }
        .checkbox-label input {
            margin-right: 8px;
        }
        button {
            margin-top: 25px;
            width: 100%;
            padding: 12px;
            background-color: #6b73ff;
            border: none;
            border-radius: 8px;
            color: white;
            font-weight: bold;
            cursor: pointer;
            font-size: 16px;
        }
        button:hover {
            background-color: #575fcf;
        }
        .login-link {
            margin-top: 15px;
            font-size: 14px;
            color: #777;
            text-align: center;
        }
        .login-link a {
            color: #6b73ff;
            text-decoration: none;
        }
        .login-link a:hover {
            text-decoration: underline;
        }
        .image-section {
            width: 40%;
            background: url('${pageContext.request.contextPath}/assets/img/fisherman.jpg') no-repeat center center/cover;
        }
        @media (max-width: 768px) {
            .container {
                flex-direction: column;
                width: 90%;
            }
            .form-section, .image-section {
                width: 100%;
                height: 250px;
            }
            .image-section {
                display: none;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="form-section">
        <button type="button" style="margin-bottom: 20px; border: 1px solid #6b73ff; background: white; color: #6b73ff; border-radius: 8px; padding: 10px 15px; cursor: default;">Fishing Hub</button>
        <h2>Create Your Account</h2>

        <!-- Hiển thị lỗi nếu có -->
        <c:if test="${not empty error}">
            <div style="color: red; margin-bottom: 15px;">${error}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/Register" method="post">
            <label for="fullName">Full Name</label>
            <input type="text" id="fullName" name="fullName" placeholder="Enter your full name" required>

            <label for="email">Email Address</label>
            <input type="email" id="email" name="email" placeholder="Enter your email" required>

            <label for="password">Password</label>
            <input type="password" id="password" name="password" placeholder="Create a password" required>

            <label for="confirmPassword">Confirm Password</label>
            <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm your password" required>

            <label for="gender">Gender</label>
            <select id="gender" name="gender" required>
                <option value="" disabled selected>Select gender</option>
                <option value="Male">Male</option>
                <option value="Female">Female</option>
                <option value="Other">Other</option>
            </select>

            <label for="dob">Date Of Birth</label>
            <input type="date" id="dob" name="dob" required>

            <label for="location">Location</label>
            <input type="text" id="location" name="location" placeholder="Enter your location" required>

            <label class="checkbox-label">
                <input type="checkbox" name="terms" required> By proceeding, you agree to the Terms of Service and Privacy Notice.
            </label>

            <button type="submit">Register</button>
        </form>
        <p class="login-link">Already have an account? <a href="${pageContext.request.contextPath}/login.jsp">Login</a></p>
    </div>
    <div class="image-section"></div>
</div>
</body>
</html>
