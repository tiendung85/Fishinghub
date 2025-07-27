package controller;

import dal.EventDAO;
import dal.PostNotificationDAO;
import model.EventNotification;
import model.NotificationDTO;
import model.PostNotification;
import model.Users;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/notifications")
public class NotificationServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("Login.jsp");
            return;
        }
        int userId = user.getUserId();

        EventDAO eventDAO = new EventDAO();
        PostNotificationDAO postNotificationDAO = new PostNotificationDAO();

        List<EventNotification> eventNotifications = eventDAO.getNotificationsByUserId(userId);
        List<PostNotification> postNotifications = postNotificationDAO.getNotificationsByUser(userId);

        List<NotificationDTO> combinedNotifications = new ArrayList<>();
        for (EventNotification en : eventNotifications) {
            NotificationDTO dto = new NotificationDTO(en.getNotificationId(), "event", en.getMessage(), false, en.getCreatedAt());
            combinedNotifications.add(dto);
        }
        for (PostNotification pn : postNotifications) {
            NotificationDTO dto = new NotificationDTO(pn.getNotificationId(), "post", pn.getMessage(), pn.getIsRead(), (Timestamp) pn.getCreatedAt());
                
            combinedNotifications.add(dto);
        }

        combinedNotifications.sort((n1, n2) -> n2.getCreatedAt().compareTo(n1.getCreatedAt()));

        request.setAttribute("notifications", combinedNotifications);
        request.getRequestDispatcher("notifications.jsp").forward(request, response);
    }
}