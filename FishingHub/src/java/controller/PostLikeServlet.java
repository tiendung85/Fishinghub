package controller;

import dal.PostLikeDAO;
import model.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import dal.PostDAO;
import model.Post;
import dal.UserDao;
import dal.PostNotificationDAO;
import model.PostNotification;
import java.sql.Timestamp;

@WebServlet("/like")
public class PostLikeServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Users currentUser = (Users) session.getAttribute("user");

        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");

        if (currentUser == null) {
            response.getWriter().write("login_required");
            return;
        }

        try {
            int postId = Integer.parseInt(request.getParameter("postId"));
            int userId = currentUser.getUserId();

            PostLikeDAO likeDAO = new PostLikeDAO();
            boolean hasLiked = likeDAO.hasLiked(postId, userId);

            if (hasLiked) {
                likeDAO.removeLike(postId, userId);
                response.getWriter().write("unliked");
            } else {
                likeDAO.addLike(postId, userId);
                response.getWriter().write("liked");

                // Tạo thông báo cho chủ bài viết
                PostDAO postDAO = new PostDAO();
                Post post = postDAO.getPostById(postId);
                if (post != null && post.getUserId() != userId) { // Không thông báo nếu là chủ bài viết
                    UserDao userDao = new UserDao();
                    Users liker = userDao.getUserById(userId);
                    if (liker != null) {
                        String message = liker.getFullName() + " đã thích bài viết của bạn.";
                        PostNotification notification = new PostNotification();
                        notification.setPostId(postId);
                        notification.setReceiverId(post.getUserId());
                        notification.setMessage(message);
                        notification.setIsRead(false);
                        notification.setCreatedAt(new Timestamp(System.currentTimeMillis()));

                        PostNotificationDAO notificationDAO = new PostNotificationDAO();
                        notificationDAO.saveNotification(notification);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("error");
        }
    }
}