package controller;

import dal.PostDAO;
import dal.UserDao;
import model.Post;
import model.Users;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/post-detail")
public class PostDetailServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idStr = request.getParameter("id");
        if (idStr != null) {
            try {
                int postId = Integer.parseInt(idStr);
                PostDAO postDAO = new PostDAO();
                Post post = postDAO.getPostById(postId);
                if (post != null) {
                    UserDao userDao = new UserDao();
                    Users user = userDao.getUserById(post.getUserId());
                    request.setAttribute("post", post);
                    request.setAttribute("user", user);
                    RequestDispatcher dispatcher = request.getRequestDispatcher("dashboard_admin/PostDetail.jsp");
                    dispatcher.forward(request, response);
                } else {
                    request.setAttribute("error", "Không tìm thấy bài viết");
                    RequestDispatcher dispatcher = request.getRequestDispatcher("dashboard_admin/PostManagement.jsp");
                    dispatcher.forward(request, response);
                }
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/PostManagement");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/PostManagement");
        }
    }
}