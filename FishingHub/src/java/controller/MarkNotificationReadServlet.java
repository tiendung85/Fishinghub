package controller;

import dal.PostNotificationDAO;
import model.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/mark-notifications-read")
public class MarkNotificationReadServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Users currentUser = (Users) session.getAttribute("user");
        if (currentUser != null) {
            new PostNotificationDAO().markAllAsRead(currentUser.getUserId());
            response.getWriter().write("success");
        } else {
            response.getWriter().write("not_logged_in");
        }
    }
} 