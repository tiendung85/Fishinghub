package controller;

import dal.PostNotificationDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.PostNotification;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.List;

@WebServlet("/AdminNotify")
public class AdminNotifyServlet extends HttpServlet {
    private PostNotificationDAO postNotificationDAO;

    @Override
    public void init() throws ServletException {
        postNotificationDAO = new PostNotificationDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String search = request.getParameter("search");
        String date = request.getParameter("date");

        if ("getAllNotifications".equals(action)) {
            List<PostNotification> notifications = postNotificationDAO.getAllNotifications(search, date);
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
            StringBuilder html = new StringBuilder();
            html.append(
                    "<table class='table table-striped table-hover'><thead><tr><th style='width: 25%;'>Loại</th><th style='width: 25%;'>Thông điệp</th><th style='width: 25%;'>Thời gian</th><th style='width: 25%;'>Bài viết</th></tr></thead><tbody>");

            if (notifications.isEmpty()) {
                html.append("<tr><td colspan='4' class='text-center'>Không có thông báo nào.</td></tr>");
            } else {
                for (PostNotification notification : notifications) {
                    String postTitle = getPostTitle(notification.getPostId());
                    html.append("<tr><td>Thông báo</td><td>")
                            .append(notification.getMessage() != null ? notification.getMessage() : "No message")
                            .append("</td><td>").append(sdf.format(notification.getCreatedAt()))
                            .append("</td><td>").append(postTitle != null ? postTitle : "Unknown Post")
                            .append("</td></tr>");
                }
            }
            html.append("</tbody></table>");
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().write(html.toString());
            return;
        }

        // Default: Forward to AdminNotify.jsp
        request.getRequestDispatcher("dashboard_admin/AdminNotify.jsp").forward(request, response);
    }

    private String getPostTitle(int postId) {
        dal.PostDAO postDAO = new dal.PostDAO();
        model.Post post = postDAO.getPostById(postId);
        return post != null ? post.getTitle() : null;
    }
}