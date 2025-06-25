package controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "VerifyOtpController", urlPatterns = {"/VerifyOtpController"})
public class VerifyOtpController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String enteredOtp = request.getParameter("otp");
        HttpSession session = request.getSession();
        String otp = (String) session.getAttribute("otp");

        if (otp != null && otp.equals(enteredOtp)) {
            session.setAttribute("otpVerified", true);
            response.sendRedirect("NewPassword.jsp");
        } else {
            request.setAttribute("error", "Mã OTP không hợp lệ!");
            request.getRequestDispatcher("VerifyOtp.jsp").forward(request, response);
        }
    }
}
