package controller;

import dal.UserDBContext;
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

    private UserDBContext userDB = new UserDBContext();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy tham số từ form
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String gender = request.getParameter("gender");
        String dobStr = request.getParameter("dob");
        String location = request.getParameter("location");
        String terms = request.getParameter("terms"); // checkbox

        // Debug log giá trị checkbox terms
        System.out.println("Checkbox terms value: " + terms);

        // Validate cơ bản
        if (fullName == null || fullName.isEmpty() ||
            email == null || email.isEmpty() ||
            password == null || password.isEmpty() ||
            confirmPassword == null || !password.equals(confirmPassword) ||
            gender == null || gender.isEmpty() ||
            dobStr == null || dobStr.isEmpty() ||
            location == null || location.isEmpty() ||
            terms == null || !terms.equals("on")) {

            request.setAttribute("error", "Please fill all fields correctly and accept terms.");
            request.getRequestDispatcher("/Register/Register.jsp").forward(request, response);
            return;
        }

        // Chuyển đổi kiểu ngày sinh
        Date dob = null;
        try {
            dob = Date.valueOf(dobStr);
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", "Invalid date of birth.");
            request.getRequestDispatcher("/Register/Register.jsp").forward(request, response);
            return;
        }

        // RoleId mặc định cho user mới, giả sử roleId 3 là user
        int roleId = 3;

        // Tạo object người dùng mới
        Users newUser = new Users(fullName, email, password, roleId, gender, dob, location);

        // Lưu vào database qua UserDBContext
        userDB.insert(newUser);

        // Redirect sang trang login sau khi đăng ký thành công
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Chuyển hướng đến trang đăng ký
        request.getRequestDispatcher("/Register/Register.jsp").forward(request, response);
    }
}
