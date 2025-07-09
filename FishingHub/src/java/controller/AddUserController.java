package controller;

import dal.UserDao;
import model.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Date;

@WebServlet(name = "AddUserController", urlPatterns = {"/AddUser"})
public class AddUserController extends HttpServlet {

    private UserDao userDB = new UserDao();  // Khởi tạo đối tượng UserDao

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String gender = request.getParameter("gender");
        String dobStr = request.getParameter("dob");
        String location = request.getParameter("location");
        String role = request.getParameter("role");
        String terms = request.getParameter("terms");

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
            request.getRequestDispatcher("/AddUser.jsp").forward(request, response);
            return;
        }

        // Validate SĐT
        if (!phone.matches("\\d{10}")) {
            request.setAttribute("error", "Số điện thoại phải gồm đúng 10 chữ số.");
            request.getRequestDispatcher("/AddUser.jsp").forward(request, response);
            return;
        }

        // Validate ngày sinh (>= 18 tuổi)
        Date dob;
        try {
            dob = Date.valueOf(dobStr);  // Chuyển đổi chuỗi ngày sinh sang đối tượng Date
            java.util.Calendar cal = java.util.Calendar.getInstance();
            cal.add(java.util.Calendar.YEAR, -18);
            java.util.Date minBirthDate = cal.getTime();
            if (dob.toLocalDate().isAfter(new java.sql.Date(minBirthDate.getTime()).toLocalDate())) {
                request.setAttribute("error", "Bạn phải đủ 18 tuổi trở lên.");
                request.getRequestDispatcher("/AddUser.jsp").forward(request, response);
                return;
            }
        } catch (IllegalArgumentException e) {
request.setAttribute("error", "Ngày sinh không hợp lệ.");
            request.getRequestDispatcher("/AddUser.jsp").forward(request, response);
            return;
        }

        // Kiểm tra trùng email
        if (userDB.checkEmailExists(email)) {
            request.setAttribute("error", "Email đã tồn tại. Vui lòng nhập email khác.");
            request.getRequestDispatcher("/AddUser.jsp").forward(request, response);
            return;
        }

        // Mặc định role là user
        int roleId = 1;
        if ("fish_owner".equals(role)) roleId = 2;

        // Tạo người dùng mới không có avatar
        Users newUser = new Users(fullName, email, phone, password, roleId, gender, dob, location); // không có avatar
        userDB.insert(newUser);  // Thêm người dùng vào database

        // Chuyển hướng về trang UserManager sau khi thêm thành công
        request.getSession().setAttribute("successMessage", "Thêm người dùng thành công!");
        response.sendRedirect("UserManager");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/AddUser.jsp").forward(request, response);  // Hiển thị trang AddUser.jsp
    }
}