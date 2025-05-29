/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.Part;
import model.Post;
import dal.PostDAO;
import java.io.File;
import java.sql.Timestamp;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.Collection;
import java.util.stream.Collectors;

/**
 *
 * @author pc
 */
@WebServlet(name = "PostServlet", urlPatterns = { "/PostServlet" })
@MultipartConfig(fileSizeThreshold = 1024 * 1024, // 1 MB
        maxFileSize = 1024 * 1024 * 10, // 10 MB
        maxRequestSize = 1024 * 1024 * 15 // 15 MB
)

public class PostServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet PostServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PostServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String topic = request.getParameter("topic");
            String title = request.getParameter("title");
            String content = request.getParameter("content");

            Post post = new Post();
            post.setUserId(1);
            post.setTopic(topic);
            post.setTitle(title);
            post.setContent(content);
            post.setCreatedAt(new Timestamp(System.currentTimeMillis()));

            // Handle multiple file uploads
            for (Part part : request.getParts()) {
                if (part.getName().equals("images") && part.getSize() > 0) {
                    String fileName = part.getSubmittedFileName();
                    String uploadPath = getServletContext().getRealPath("")
                            + File.separator + "assets"
                            + File.separator + "img"
                            + File.separator + "post";

                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdirs();
                    }

                    // Save file to disk
                    part.write(uploadPath + File.separator + fileName);

                    // Add image name to post
                    post.addImage(fileName);
                }
            }

            PostDAO postDAO = new PostDAO();
            boolean success = postDAO.createPost(post);

            if (success) {
                response.sendRedirect("NewFeed.jsp");
            } else {
                request.setAttribute("error", "Failed to create post");
                request.getRequestDispatcher("NewFeed.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

    public boolean uploadFile(InputStream is, String path) {
        boolean test = false;
        try (FileOutputStream fops = new FileOutputStream(path)) {
            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = is.read(buffer)) != -1) {
                fops.write(buffer, 0, bytesRead);
            }
            test = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return test;
    }

}
