package controller;

import dal.UserDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet(name = "VerifyCodeController", urlPatterns = {"/verify-code"})
public class VerifyCodeController extends HttpServlet {
    UserDao userDao = new UserDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String code = request.getParameter("code");

        boolean isValid = userDao.checkResetToken(email, code);

        if (isValid) {
            // Mã đúng, chuyển sang form đặt lại mật khẩu mới
            request.setAttribute("email", email);
            request.setAttribute("code", code);
            request.getRequestDispatcher("ResetPassword.jsp").forward(request, response);
        } else {
            // Mã sai hoặc hết hạn
            request.setAttribute("error", "Mã xác nhận không đúng hoặc đã hết hạn!");
            request.setAttribute("email", email);
            request.getRequestDispatcher("VerifyCode.jsp").forward(request, response);
        }
    }
}