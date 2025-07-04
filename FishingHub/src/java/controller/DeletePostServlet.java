package controller;

import dal.PostDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "DeletePostServlet", urlPatterns = {"/delete-post"})
public class DeletePostServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        int postId = Integer.parseInt(request.getParameter("postId"));

        PostDAO dao = new PostDAO();
        boolean success = dao.deletePost(postId);

        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();
        out.print(success ? "success" : "fail");
    }
}