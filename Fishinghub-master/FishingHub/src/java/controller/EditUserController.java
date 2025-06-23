package controller;

import dal.UserDao;
import model.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Date;

@WebServlet(name = "EditUserController", urlPatterns = {"/EditUserController"})
public class EditUserController extends HttpServlet {

    private UserDao userDao = new UserDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy userId từ URL parameter
        int userId = Integer.parseInt(request.getParameter("id"));
        
        // Lấy thông tin người dùng từ database
        Users user = userDao.getUserById(userId);
        
        if (user == null) {
            request.setAttribute("error", "Không tìm thấy người dùng.");
            request.getRequestDispatcher("/UserManager").forward(request, response);
            return;
        }

        // Lưu user vào request để hiển thị trong form
        request.setAttribute("user", user);

        // Chuyển đến trang chỉnh sửa người dùng
        request.getRequestDispatcher("/EditUser.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int userId = Integer.parseInt(request.getParameter("id"));  // Sử dụng đúng tham số là "id"
        
        // Lấy dữ liệu từ form
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String gender = request.getParameter("gender");
        String dobStr = request.getParameter("dob");
        String location = request.getParameter("location");
        String role = request.getParameter("role");

        int roleId = role.equals("fish_owner") ? 2 : (role.equals("admin") ? 3 : 1);  // Giải quyết các loại vai trò

        // Kiểm tra và chuyển đổi ngày sinh
        Date dob;
        try {
            dob = Date.valueOf(dobStr);  // Convert string to Date
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", "Ngày sinh không hợp lệ.");
            request.getRequestDispatcher("/EditUser.jsp").forward(request, response);
            return;
        }

        // Kiểm tra nếu người dùng tồn tại
        Users existingUser = userDao.getUserById(userId);
        if (existingUser == null) {
            request.setAttribute("error", "Không tìm thấy người dùng.");
            request.getRequestDispatcher("/UserManager").forward(request, response);
            return;
        }

        // Cập nhật thông tin người dùng
        Users updatedUser = new Users(
                userId,
                fullName,
                email,
                phone,
                password,
                existingUser.getGoogleId(),
                roleId,
                gender,
                dob,
                location,
                existingUser.getCreatedAt(),
                existingUser.getAvatar()
        );

        // Cập nhật thông tin vào database
        userDao.update(updatedUser);

        // Redirect về trang quản lý người dùng sau khi cập nhật thành công
        response.sendRedirect(request.getContextPath() + "/UserManager");
    }
}
