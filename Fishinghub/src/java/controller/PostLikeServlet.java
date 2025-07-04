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
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("error");
        }
    }
}