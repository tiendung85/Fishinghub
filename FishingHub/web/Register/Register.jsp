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
        <h2>Create Your Account</h2>
        <form action="register" method="post">
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

            <button type="submit" class="register-btn">Register</button>
        </form>
        <p class="login-link">Already have an account? <a href="login.jsp">Login</a></p>
    </div>
    <div class="image-section"></div>
</div>
</body>
</html>
