package controller;

import dal.UserDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet(name = "ResetPasswordController", urlPatterns = {"/reset-password"})
public class ResetPasswordController extends HttpServlet {
    UserDao userDao = new UserDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String code = request.getParameter("code");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Kiểm tra xác nhận mật khẩu
        if (newPassword == null || !newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            request.setAttribute("email", email);
            request.setAttribute("code", code);
            request.getRequestDispatcher("ResetPassword.jsp").forward(request, response);
            return;
        }

        // Kiểm tra mã xác nhận còn hiệu lực, đúng user
        boolean valid = userDao.checkResetToken(email, code);
        if (valid) {
            // Đổi mật khẩu mới cho user
            userDao.updatePassword(email, newPassword);
            // Đánh dấu mã đã sử dụng
            userDao.markResetTokenUsed(email, code);

            // Gửi alert và chuyển về login.jsp
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().println(
                "<script>alert('Đổi mật khẩu thành công! Vui lòng đăng nhập lại.'); window.location='login';</script>"
            );
        } else {
            request.setAttribute("error", "Mã xác nhận không đúng hoặc đã hết hạn!");
            request.setAttribute("email", email);
            request.setAttribute("code", code);
            request.getRequestDispatcher("ResetPassword.jsp").forward(request, response);
        }
    }
}