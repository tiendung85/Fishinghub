package controller;

import dal.SavedPostDAO;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "SavePostServlet", urlPatterns = {"/save-post"})
public class SavePostServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        int postId = Integer.parseInt(request.getParameter("postId"));
        String action = request.getParameter("action"); // "save" or "unsave"

        SavedPostDAO dao = new SavedPostDAO();
        boolean result = false;
        if ("save".equals(action)) {
            result = dao.savePost(userId, postId);
        } else if ("unsave".equals(action)) {
            result = dao.unsavePost(userId, postId);
        }

        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();
        out.print(result ? "success" : "fail");
    }
}