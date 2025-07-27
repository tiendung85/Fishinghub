//package controller;
//
//import dal.PostDAO;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.*;
//import java.io.IOException;
//import java.io.PrintWriter;
//
//@WebServlet(name = "EditPostServlet", urlPatterns = { "/edit-post" })
//public class EditPostServlet extends HttpServlet {
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        int postId = Integer.parseInt(request.getParameter("postId"));
//        String topic = request.getParameter("topic");
//        String title = request.getParameter("title");
//        String content = request.getParameter("content");
//
//        PostDAO dao = new PostDAO();
//        boolean success = dao.updatePost(postId, topic, title, content);
//
//        response.setContentType("text/plain");
//        PrintWriter out = response.getWriter();
//        out.print(success ? "success" : "fail");
//    }
//}