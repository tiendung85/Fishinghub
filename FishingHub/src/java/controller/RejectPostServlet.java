package controller;

import dal.PostDAO;
import dal.PostNotificationDAO;
import dal.PostRejectionDAO;
import model.Post;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import model.PostNotification;
import model.PostRejection;

@WebServlet("/RejectPost")
public class RejectPostServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String postIdStr = request.getParameter("postId");
        String reason = request.getParameter("reason");

        if (postIdStr == null || reason == null || reason.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing parameters");
            return;
        }

        int postId;
        try {
            postId = Integer.parseInt(postIdStr);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid post ID");
            return;
        }

        PostDAO postDAO = new PostDAO();
        Post post = postDAO.getPostById(postId);
        if (post == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Post not found");
            return;
        }

        // Update trạng thái bài viết
        post.setStatus("từ chối");
        boolean statusUpdated = postDAO.updatePostStatus(postId, "từ chối");
        if (!statusUpdated) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to update post status");
            return;
        }

        // Lưu lý do từ chối
        PostRejection rejection = new PostRejection();
        rejection.setPostId(postId);
        rejection.setReason(reason);
        PostRejectionDAO postRejectionDAO = new PostRejectionDAO();
        postRejectionDAO.saveRejection(rejection);

        // Gửi thông báo
        String message = "Bài viết '" + post.getTitle() + "' của bạn đã bị từ chối " + "lý do: '" + rejection.getReason() + "'";
        PostNotification notification = new PostNotification();
        notification.setPostId(postId);
        notification.setReceiverId(post.getUserId());
        notification.setMessage(message);

        System.out.println("Sending notification to userId=" + post.getUserId() + " for postId=" + postId);

        PostNotificationDAO postNotificationDAO = new PostNotificationDAO();
        postNotificationDAO.saveNotification(notification);

        response.sendRedirect("NewFeed");
    }
}
