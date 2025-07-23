package controller;

import dal.PostDAO;
import dal.PostNotificationDAO;
import dal.UserDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Post;
import model.PostNotification;
import model.Users;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/PostManagement")
public class PostManagementServlet extends HttpServlet {
    private PostDAO postDAO;
    private UserDao userDao;

    @Override
    public void init() throws ServletException {
        postDAO = new PostDAO();
        userDao = new UserDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String keyword = request.getParameter("keyword");
        String status = request.getParameter("status");
        String pageStr = request.getParameter("page");
        String postIdStr = request.getParameter("postId");

        int page = 1;
        int pageSize = 5;

        if (pageStr != null && !pageStr.isEmpty()) {
            try {
                page = Integer.parseInt(pageStr);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        if (action != null && postIdStr != null && !postIdStr.isEmpty()) {
            try {
                int postId = Integer.parseInt(postIdStr);
                boolean success = false;

                switch (action) {
                    case "approve":
                        success = postDAO.updatePostStatus(postId, "đã duyệt");
                        if (success) {
                            // Lấy thông tin bài viết để lấy UserId và tiêu đề
                            Post post = postDAO.getPostById(postId);
                            if (post != null) {
                                PostNotificationDAO notificationDAO = new PostNotificationDAO();
                                PostNotification notification = new PostNotification();
                                notification.setPostId(postId);
                                notification.setReceiverId(post.getUserId());
                                notification.setMessage("Bài viết '" + post.getTitle() + "' của bạn đã được duyệt.");
                                notification.setIsRead(false); // Đặt trạng thái chưa đọc
                                notificationDAO.saveNotification(notification);
                            }
                        }
                        break;
                    case "reject":
                        success = postDAO.updatePostStatus(postId, "từ chối");
                        break;
                    default:
                        break;
                }

                String redirectUrl = "PostManagement?page=" + page +
                        (keyword != null && !keyword.isEmpty() ? "&keyword=" + keyword : "") +
                        (status != null && !status.isEmpty() ? "&status=" + status : "") +
                        (success ? "&action=approve&success=true" : "");
                response.sendRedirect(redirectUrl);
                return;
            } catch (NumberFormatException e) {
                e.printStackTrace();
                request.setAttribute("error", "Invalid post ID");
            }
        }

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
        request.setAttribute("keyword", keyword);
        request.setAttribute("status", status);

        request.getRequestDispatcher("dashboard_admin/PostManagement.jsp").forward(request, response);
    }
}