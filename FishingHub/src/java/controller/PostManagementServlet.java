package controller;

import dal.PostDAO;
import dal.PostNotificationDAO;
import dal.PostRejectionDAO;
import dal.UserDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Post;
import model.PostNotification;
import model.PostRejection;
import model.Users;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/PostManagement")
public class PostManagementServlet extends HttpServlet {
    private PostDAO postDAO;
    private UserDao userDao;
    private PostNotificationDAO postNotificationDAO;
    private PostRejectionDAO postRejectionDAO;

    @Override
    public void init() throws ServletException {
        postDAO = new PostDAO();
        userDao = new UserDao();
        postNotificationDAO = new PostNotificationDAO();
        postRejectionDAO = new PostRejectionDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String keyword = request.getParameter("keyword");
        String status = request.getParameter("status");
        String pageStr = request.getParameter("page");
        String postIdStr = request.getParameter("postId");
        String search = request.getParameter("search");
        String date = request.getParameter("date");

        int page = 1;
        int pageSize = 5;

        if (pageStr != null && !pageStr.isEmpty()) {
            try {
                page = Integer.parseInt(pageStr);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        if ("getAllNotifications".equals(action)) {
            List<PostNotification> notifications = postNotificationDAO.getAllNotifications(search, date);
            List<PostRejection> rejections = postRejectionDAO.getAllRejections(search, date);
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
            StringBuilder html = new StringBuilder();
            html.append(
                    "<table class='table table-striped table-hover'><thead><tr><th style='width: 25%;'>Loại</th><th style='width: 25%;'>Thông điệp</th><th style='width: 25%;'>Thời gian</th><th style='width: 25%;'>Bài viết</th></tr></thead><tbody>");

            if (notifications.isEmpty() && rejections.isEmpty()) {
                html.append("<tr><td colspan='4' class='text-center'>Không có thông báo nào.</td></tr>");
            } else {
                for (PostNotification notification : notifications) {
                    Post post = postDAO.getPostById(notification.getPostId());
                    String postTitle = post != null ? post.getTitle() : "Unknown Post";
                    html.append("<tr><td>Thông báo</td><td>")
                            .append(notification.getMessage() != null ? notification.getMessage() : "No message")
                            .append("</td><td>").append(sdf.format(notification.getCreatedAt()))
                            .append("</td><td>").append(postTitle).append("</td></tr>");
                }
                for (PostRejection rejection : rejections) {
                    Post post = postDAO.getPostById(rejection.getPostId());
                    String postTitle = post != null ? post.getTitle() : "Unknown Post";
                    html.append("<tr><td>Từ chối</td><td>")
                            .append(rejection.getReason() != null ? rejection.getReason() : "No reason")
                            .append("</td><td>").append(sdf.format(rejection.getRejectedAt()))
                            .append("</td><td>").append(postTitle).append("</td></tr>");
                }
            }
            html.append("</tbody></table>");
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().write(html.toString());
            return;
        }

        // Handle approve/reject actions
        if (action != null && postIdStr != null && !postIdStr.isEmpty()) {
            try {
                int postId = Integer.parseInt(postIdStr);
                boolean success = false;

                switch (action) {
                    case "approve":
                        success = postDAO.updatePostStatus(postId, "đã duyệt");
                        if (success) {
                            Post post = postDAO.getPostById(postId);
                            if (post != null) {
                                PostNotification notification = new PostNotification();
                                notification.setPostId(postId);
                                notification.setReceiverId(post.getUserId());
                                notification.setMessage("Bài viết '" + post.getTitle() + "' của bạn đã được duyệt.");
                                notification.setIsRead(false);
                                postNotificationDAO.saveNotification(notification);
                            }
                        }
                        break;
                    case "reject":
                        success = postDAO.updatePostStatus(postId, "từ chối");
                        break;
                    default:
                        break;
                }

                // Load data for JSP rendering after action
                List<Post> posts = postDAO.searchPosts(keyword, status, page, pageSize);
                int totalPosts = postDAO.countPosts(keyword, status);
                int totalPages = (int) Math.ceil((double) totalPosts / pageSize);

                Map<Integer, Users> userMap = new HashMap<>();
                for (Post post : posts) {
                    int userId = post.getUserId();
                    if (!userMap.containsKey(userId)) {
                        Users user = userDao.getUserById(userId);
                        userMap.put(userId, user);
                    }
                }

                request.setAttribute("posts", posts);
                request.setAttribute("userMap", userMap);
                request.setAttribute("currentPage", page);
                request.setAttribute("totalPages", totalPages);
                request.setAttribute("totalPosts", totalPosts);
                request.setAttribute("keyword", keyword);
                request.setAttribute("status", status);

                request.getRequestDispatcher("dashboard_admin/PostManagement.jsp").forward(request, response);
                return;
            } catch (NumberFormatException e) {
                e.printStackTrace();
                request.setAttribute("error", "Invalid post ID");
            }
        }

        // Default case: Load posts and forward to JSP
        List<Post> posts = postDAO.searchPosts(keyword, status, page, pageSize);
        int totalPosts = postDAO.countPosts(keyword, status);
        int totalPages = (int) Math.ceil((double) totalPosts / pageSize);

        Map<Integer, Users> userMap = new HashMap<>();
        for (Post post : posts) {
            int userId = post.getUserId();
            if (!userMap.containsKey(userId)) {
                Users user = userDao.getUserById(userId);
                userMap.put(userId, user);
            }
        }

        request.setAttribute("posts", posts);
        request.setAttribute("userMap", userMap);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalPosts", totalPosts);
        request.setAttribute("keyword", keyword);
        request.setAttribute("status", status);

        request.getRequestDispatcher("dashboard_admin/PostManagement.jsp").forward(request, response);
    }
}