package controller;

import dal.UserDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Users;
import reset.MailUtils; // Class gửi mail
import reset.TokenUtil; // Class tạo mã code random

import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDateTime;

@WebServlet(name = "ForgotPasswordController", urlPatterns = {"/forgot-password"})
public class ForgotPasswordController extends HttpServlet {

    UserDao userDao = new UserDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("ForgotPassword.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        Users user = userDao.getByEmail(email);

        if (user != null) {
            // Tạo mã xác nhận ngẫu nhiên (6 ký tự)
            String code = TokenUtil.generateToken(6);

            // Lưu mã vào DB, gắn với email và thời hạn
            userDao.saveResetToken(email, code, Timestamp.valueOf(LocalDateTime.now().plusMinutes(15)));

            // Gửi email
            String subject = "Mã xác nhận đổi mật khẩu (Fishing Hub)";
            String content = "Chào bạn,\n\nMã xác nhận đổi mật khẩu của bạn là: " + code +
                    "\nMã này có hiệu lực trong 15 phút.\nNếu bạn không yêu cầu, hãy bỏ qua email này.";

            try {
                MailUtils.sendEmail(email, subject, content);

                // Chuyển sang trang VerifyCode.jsp và truyền email
                request.setAttribute("email", email);
                request.setAttribute("msg", "Đã gửi mã xác nhận về email. Vui lòng kiểm tra hộp thư đến!");
                request.getRequestDispatcher("VerifyCode.jsp").forward(request, response);
                return; // Dừng lại, không forward về ForgotPassword.jsp nữa
            } catch (Exception e) {
                request.setAttribute("error", "Gửi email thất bại: " + e.getMessage());
            }
        } else {
            request.setAttribute("error", "Email này không tồn tại trong hệ thống.");
        }
        // Trường hợp lỗi, giữ lại trang ForgotPassword.jsp và hiển thị thông báo
        request.getRequestDispatcher("ForgotPassword.jsp").forward(request, response);
    }
}