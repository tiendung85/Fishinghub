package controller;

import dal.CommentReplyDAO;
import model.CommentReply;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/comment-reply")
public class CommentReplyServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int commentId = Integer.parseInt(request.getParameter("commentId"));
            int userId = Integer.parseInt(request.getParameter("userId"));
            String content = request.getParameter("content");
            if (content != null && !content.trim().isEmpty()) {
                CommentReply reply = new CommentReply();
                reply.setCommentId(commentId);
                reply.setUserId(userId);
                reply.setContent(content.trim());
                // reply.setParentReplyId(0);

                new CommentReplyDAO().addReply(reply);
            }
            // Quay lại trang trước
            String referer = request.getHeader("referer");
            if (referer != null) {
                response.sendRedirect(referer + "#comment-" + commentId);
            } else {
                response.sendRedirect("NewFeed.jsp");
            }
        } catch (Exception e) {
            response.sendRedirect("NewFeed.jsp");
        }
    }
}