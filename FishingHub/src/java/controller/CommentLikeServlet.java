package controller;

import dal.CommentLikeDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/comment-like")
public class CommentLikeServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String type = request.getParameter("type");
        int id = Integer.parseInt(request.getParameter("id"));
        int userId = Integer.parseInt(request.getParameter("userId"));
        CommentLikeDAO dao = new CommentLikeDAO();
        boolean hasLiked = dao.hasLiked(id, userId);
        if (hasLiked) {
            dao.removeLike(id, userId);
            response.getWriter().write("unliked");
        } else {
            dao.addLike(id, userId);
            response.getWriter().write("liked");
        }
    }
}