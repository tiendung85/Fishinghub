package controller;

import dal.PostCommentDAO;
import model.Post;
import dal.PostDAO;
import dal.PostNotificationDAO;
import dal.SavedPostDAO;
import jakarta.servlet.RequestDispatcher;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.Users;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import model.PostNotification;

@WebServlet("/NewFeed")
public class NewFeedServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Users currentUser = (Users) session.getAttribute("user");

        String searchTopic = request.getParameter("topic");
        String tab = request.getParameter("tab");

        PostDAO postDAO = new PostDAO();
        PostNotificationDAO postNotificationDAO = new PostNotificationDAO();

        List<Post> posts;
        List<PostNotification> postNotifications = new ArrayList<>();

        if ("saved".equals(tab) && currentUser != null) {
            SavedPostDAO savedPostDAO = new SavedPostDAO();
            posts = savedPostDAO.getSavedPostsByUser(currentUser.getUserId());
        } else if ("my".equals(tab) && currentUser != null) {
            posts = postDAO.getPostsByUser(currentUser.getUserId());
        } else if ("rejected".equals(tab) && currentUser != null) {
            posts = postDAO.getPostsByStatusAndUser("từ chối", currentUser.getUserId());
        } else if (searchTopic != null && !searchTopic.trim().isEmpty()) {
            posts = postDAO.searchPostsByTopic(searchTopic);
        } else {
            posts = postDAO.getAllPosts();
        }

        if (currentUser != null) {
            postNotifications = postNotificationDAO.getNotificationsByUser(currentUser.getUserId());
        }

        // Count unread notifications
        long unreadPostNotificationCount = postNotifications.stream().filter(n -> !n.getIsRead()).count();
        request.setAttribute("unreadPostNotificationCount", unreadPostNotificationCount);

        request.setAttribute("posts", posts);
        request.setAttribute("postNotifications", postNotifications);

        RequestDispatcher dispatcher = request.getRequestDispatcher("NewFeed.jsp");
        dispatcher.forward(request, response);
    }
}
