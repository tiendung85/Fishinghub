package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import reset.MailUtils; // dùng lại MailUtils của bạn

import java.io.IOException;

@WebServlet(name = "FeedbackController", urlPatterns = { "/FeedbackController" })
public class FeedbackController extends HttpServlet {

    private final String adminEmail = "nguyendhlam11@gmail.com"; // Thay bằng mail admin thực tế

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String content = request.getParameter("content");

        String subject = "Góp ý mới từ người dùng: " + fullname;
        String messageText = "Người dùng: " + fullname + "\nEmail: " + email + "\nNội dung góp ý:\n" + content;

        try {
            MailUtils.sendEmail(adminEmail, subject, messageText);
            request.setAttribute("success", "Gửi góp ý thành công!");
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi khi gửi email: " + e.getMessage());
        }

        request.getRequestDispatcher("Feedback.jsp").forward(request, response);
    }
}