package controller;

import dal.UserDao;
import model.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "ChangePasswordController", urlPatterns = { "/ChangePasswordController" })
public class ChangePasswordController extends HttpServlet {
    private UserDao userDao = new UserDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String enteredOtp = request.getParameter("otp");
        HttpSession session = request.getSession();

        // Lấy giá trị OTP từ session
        String sessionOtp = (String) session.getAttribute("otp");

        if (sessionOtp != null && sessionOtp.equals(enteredOtp)) {
            // OTP hợp lệ, cho phép đổi mật khẩu
            String newPassword = request.getParameter("newPassword");

            // Lấy thông tin người dùng từ session
            Users user = (Users) request.getSession().getAttribute("user");

            // Chuyển đổi userId từ int sang String nếu cần thiết
            String userId = String.valueOf(user.getUserId()); // Chuyển đổi int sang String

            // Cập nhật mật khẩu mới trong cơ sở dữ liệu
            userDao.updatePassword(userId, newPassword);

            // Cập nhật lại thông tin người dùng trong session
            request.getSession().setAttribute("user", user);

            response.sendRedirect("Profile.jsp"); // Chuyển hướng đến trang Profile
        } else {
            // OTP không hợp lệ, hiển thị lỗi
            request.setAttribute("error", "Mã OTP không hợp lệ!");
            request.getRequestDispatcher("ChangePassword.jsp").forward(request, response);
        }
    }
}