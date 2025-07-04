package controller;

import dal.UserDao;
import model.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
<<<<<<< HEAD
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
=======
import jakarta.servlet.http.*;
>>>>>>> lam

import java.io.IOException;
import java.sql.Date;

<<<<<<< HEAD

=======
@WebServlet(name = "RegisterController", urlPatterns = {"/Register"})
>>>>>>> lam
public class RegisterController extends HttpServlet {

    private UserDao userDB = new UserDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
<<<<<<< HEAD
        // Lấy tham số từ form
=======
>>>>>>> lam
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String gender = request.getParameter("gender");
        String dobStr = request.getParameter("dob");
        String location = request.getParameter("location");
<<<<<<< HEAD
        String role = request.getParameter("role"); // lấy từ select
        String terms = request.getParameter("terms"); // checkbox
=======
        String role = request.getParameter("role");
        String terms = request.getParameter("terms");
>>>>>>> lam

        // Validate cơ bản
        if (fullName == null || fullName.isEmpty() ||
            email == null || email.isEmpty() ||
            phone == null || phone.isEmpty() ||
            password == null || password.isEmpty() ||
            confirmPassword == null || !password.equals(confirmPassword) ||
            gender == null || gender.isEmpty() ||
            dobStr == null || dobStr.isEmpty() ||
            location == null || location.isEmpty() ||
            role == null || role.isEmpty() ||
            terms == null || !terms.equals("on")) {
            request.setAttribute("error", "Vui lòng điền đầy đủ thông tin và đồng ý điều khoản.");
            request.getRequestDispatcher("/Register.jsp").forward(request, response);
            return;
        }

        // Validate SĐT
        if (!phone.matches("\\d{10}")) {
            request.setAttribute("error", "Số điện thoại phải gồm đúng 10 chữ số.");
            request.getRequestDispatcher("/Register.jsp").forward(request, response);
            return;
        }

        // Validate ngày sinh (>= 18 tuổi)
        Date dob;
        try {
            dob = Date.valueOf(dobStr);
            java.util.Calendar cal = java.util.Calendar.getInstance();
            cal.add(java.util.Calendar.YEAR, -18);
            java.util.Date minBirthDate = cal.getTime();
            if (dob.toLocalDate().isAfter(new java.sql.Date(minBirthDate.getTime()).toLocalDate())) {
                request.setAttribute("error", "Bạn phải đủ 18 tuổi trở lên.");
                request.getRequestDispatcher("/Register.jsp").forward(request, response);
                return;
            }
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", "Ngày sinh không hợp lệ.");
            request.getRequestDispatcher("/Register.jsp").forward(request, response);
            return;
        }

<<<<<<< HEAD
        // Mapping role string sang roleId
        int roleId = 1; // mặc định user
        if ("fish_owner".equals(role)) roleId = 2;

        Users newUser = new Users(fullName, email, phone, password, roleId, gender, dob, location);

        // Lưu vào database qua UserDBContext
        userDB.insert(newUser);

        // Redirect sang trang login sau khi đăng ký thành công
=======
        if (userDB.checkEmailExists(email)) {
            request.setAttribute("error", "Email đã tồn tại. Vui lòng nhập email khác.");
            request.getRequestDispatcher("/Register.jsp").forward(request, response);
            return;
        }

        int roleId = 1; // mặc định user
        if ("fish_owner".equals(role)) roleId = 2;

        // Tạo người dùng mới không có avatar
        Users newUser = new Users(fullName, email, phone, password, roleId, gender, dob, location); 
        userDB.insert(newUser);

>>>>>>> lam
        response.sendRedirect(request.getContextPath() + "/Login.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
<<<<<<< HEAD
        // Chuyển hướng đến trang đăng ký
        request.getRequestDispatcher("/Register.jsp").forward(request, response);
    }
}
=======
        request.getRequestDispatcher("/Register.jsp").forward(request, response);
    }
}
>>>>>>> lam
