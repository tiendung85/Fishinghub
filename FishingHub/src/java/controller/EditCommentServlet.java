package controller;

import dal.PostCommentDAO;
import model.Users;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/edit-comment")
public class EditCommentServlet extends HttpServlet {
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
        String content = request.getParameter("content");
        int commentOwnerId = Integer.parseInt(request.getParameter("commentOwnerId"));
        if (currentUser.getUserId() == commentOwnerId) {
            boolean success = new PostCommentDAO().editComment(commentId, content);
            response.getWriter().write(success ? "success" : "error");
        } else {
            response.getWriter().write("unauthorized");
        }
    }
}