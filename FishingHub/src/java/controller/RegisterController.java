package controller;

import model.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "RegisterController", urlPatterns = {"/register"})
public class RegisterController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy dữ liệu từ form
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String fishingSkillLevel = request.getParameter("fishingSkillLevel");
        String terms = request.getParameter("terms");

        // Kiểm tra điều kiện đơn giản
        if(fullName == null || fullName.isEmpty() ||
           email == null || email.isEmpty() ||
           password == null || password.isEmpty() ||
           !password.equals(confirmPassword) ||
           fishingSkillLevel == null || fishingSkillLevel.isEmpty() ||
           terms == null) {
            request.setAttribute("error", "Please fill all fields correctly and accept terms.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Tạo đối tượng Users
        Users newUser = new Users(fullName, email, password, fishingSkillLevel, true);

        // Ở đây bạn có thể thêm logic lưu vào DB (hiện demo in ra console)
        System.out.println("New user registered: " + newUser.getFullName() + " - " + newUser.getEmail());

        // Chuyển hướng sang trang đăng nhập hoặc trang thành công
        response.sendRedirect("login.jsp");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("register.jsp");
    }
}
