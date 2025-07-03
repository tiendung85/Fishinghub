package controller;

import dal.UserDao;
import model.Users;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "NewPasswordController", urlPatterns = {"/NewPasswordController"})
public class NewPasswordController extends HttpServlet {
    private UserDao userDao = new UserDao();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Boolean otpVerified = (Boolean) session.getAttribute("otpVerified");
        String email = (String) session.getAttribute("email");

        if (otpVerified == null || !otpVerified || email == null) {
            response.sendRedirect("ChangePassword.jsp");
            return;
        }

        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            request.getRequestDispatcher("NewPassword.jsp").forward(request, response);
            return;
        }

        // Cập nhật mật khẩu
        userDao.updatePasswordByEmail(email, newPassword);

        // Cập nhật lại thông tin user trong session (nếu cần)
        Users user = userDao.getUserByEmail(email);
        session.setAttribute("user", user);

        // Xoá dữ liệu phiên tạm OTP
        session.removeAttribute("otp");
        session.removeAttribute("otpVerified");
        session.removeAttribute("email");

        // Thêm thông báo thành công (sẽ hiển thị ở Profile.jsp)
        request.setAttribute("successMessage", "Đổi mật khẩu thành công!");

        // Chuyển tiếp đến Profile.jsp
        request.getRequestDispatcher("Profile.jsp").forward(request, response);
    }
}