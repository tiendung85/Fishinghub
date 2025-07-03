package controller;

import dal.UserDao;
import model.Users;
import reset.MailUtils;
import reset.TokenUtil;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "SendOtpController", urlPatterns = { "/SendOtpController" })
public class SendOtpController extends HttpServlet {
    private UserDao userDao = new UserDao();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String currentPassword = request.getParameter("currentPassword");

        Users user = userDao.getByEmail(email);
        if (user == null || !user.getPassword().equals(currentPassword)) {
            request.setAttribute("error", "Email hoặc mật khẩu hiện tại không đúng!");
            request.getRequestDispatcher("ChangePassword.jsp").forward(request, response);
            return;
        }

        String otp = TokenUtil.generateToken(6);
        try {
            MailUtils.sendEmail(email, "Mã OTP đổi mật khẩu", "Mã OTP của bạn là: " + otp);
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi gửi email: " + e.getMessage());
            request.getRequestDispatcher("ChangePassword.jsp").forward(request, response);
            return;
        }

        HttpSession session = request.getSession();
        session.setAttribute("otp", otp);
        session.setAttribute("email", email);

        response.sendRedirect("VerifyOtp.jsp");
    }
}