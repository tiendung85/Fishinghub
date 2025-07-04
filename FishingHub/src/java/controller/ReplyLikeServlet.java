package controller;

import dal.ReplyLikeDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/reply-like")
public class ReplyLikeServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int replyId = Integer.parseInt(request.getParameter("replyId"));
        int userId = Integer.parseInt(request.getParameter("userId"));
        ReplyLikeDAO dao = new ReplyLikeDAO();
        boolean hasLiked = dao.hasLiked(replyId, userId);
        if (hasLiked) {
            dao.unlike(replyId, userId);
            response.getWriter().write("unliked");
        } else {
            dao.like(replyId, userId);
            response.getWriter().write("liked");
        }
    }
}
