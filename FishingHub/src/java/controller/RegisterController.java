package controller;

import model.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Date;

@WebServlet(name = "RegisterController", urlPatterns = {"/register"})
public class RegisterController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy tham số từ form
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String roleIdStr = request.getParameter("roleId");
        String gender = request.getParameter("gender");
        String dobStr = request.getParameter("dob");
        String location = request.getParameter("location");
        String terms = request.getParameter("terms");

        // Validate dữ liệu cơ bản
        if(fullName == null || fullName.isEmpty() ||
           email == null || email.isEmpty() ||
           password == null || password.isEmpty() ||
           !password.equals(confirmPassword) ||
           roleIdStr == null || roleIdStr.isEmpty() ||
           gender == null || gender.isEmpty() ||
           dobStr == null || dobStr.isEmpty() ||
           location == null || location.isEmpty() ||
           terms == null) {
            request.setAttribute("error", "Please fill all fields correctly and accept terms.");
            request.getRequestDispatcher("Register/Register.jsp").forward(request, response);
            return;
        }

        // Chuyển đổi dữ liệu
        int roleId = 0;
        try {
            roleId = Integer.parseInt(roleIdStr);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid role selected.");
            request.getRequestDispatcher("Register/Register.jsp").forward(request, response);
            return;
        }

        Date dob = null;
        try {
            dob = Date.valueOf(dobStr); // yyyy-MM-dd
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", "Invalid date of birth.");
            request.getRequestDispatcher("Register/Register.jsp").forward(request, response);
            return;
        }

        // Tạo đối tượng Users mới (googleId, createdAt để null)
        Users newUser = new Users(fullName, email, password, roleId, gender, dob, location);

        // TODO: Thêm code lưu newUser vào database

        System.out.println("New user registered: " + newUser.getFullName() + " - " + newUser.getEmail());

        // Redirect sang trang đăng nhập
        response.sendRedirect("login.jsp");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("Register/Register.jsp");
    }
}
