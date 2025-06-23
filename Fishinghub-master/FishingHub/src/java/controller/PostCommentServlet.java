package controller;

import dal.PostCommentDAO;
import model.PostComment;
import model.Users;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Timestamp;

@WebServlet("/comment")
public class PostCommentServlet extends HttpServlet {

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
            int userId = Integer.parseInt(request.getParameter("userId"));
            String content = request.getParameter("content");

            PostComment comment = new PostComment();
            comment.setPostId(postId);
            comment.setUserId(userId);
            comment.setContent(content);
            comment.setCreatedAt(new Timestamp(System.currentTimeMillis()));

            PostCommentDAO dao = new PostCommentDAO();
            boolean success = dao.addComment(comment);

            if (success) {
                response.getWriter().write("success");
            } else {
                response.getWriter().write("error");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("error");
        }
    }
}