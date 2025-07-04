package controller;

import dal.PostCommentDAO;
import model.Users;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/delete-comment")
public class DeleteCommentServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        HttpSession session = request.getSession();
        Users currentUser = (Users) session.getAttribute("user");
        response.setContentType("text/plain");
        if (currentUser == null) {
            response.getWriter().write("login_required");
            return;
        }
        int commentId = Integer.parseInt(request.getParameter("commentId"));
        int postOwnerId = Integer.parseInt(request.getParameter("postOwnerId"));
        int commentOwnerId = Integer.parseInt(request.getParameter("commentOwnerId"));
        int userId = currentUser.getUserId();
        if (userId == postOwnerId || userId == commentOwnerId) {
            boolean success = new PostCommentDAO().deleteComment(commentId);
            response.getWriter().write(success ? "success" : "error");
        } else {
            response.getWriter().write("unauthorized");
        }
    }
}