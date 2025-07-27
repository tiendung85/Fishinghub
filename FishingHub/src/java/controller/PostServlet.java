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
import model.Users;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.http.HttpSession;
import java.util.UUID;

@WebServlet(name = "PostServlet", urlPatterns = { "/PostServlet" })
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 10, // 10 MB
        maxFileSize = 1024 * 1024 * 100, // 100 MB
        maxRequestSize = 1024 * 1024 * 150 // 150 MB
)
public class PostServlet extends HttpServlet {

    private static final String UPLOAD_DIR = "assets/img/post";
    private static final String VIDEO_UPLOAD_DIR = "assets/video/post";
    private static final String BASE_PATH = "C:\\Users\\pc\\Desktop\\SWP\\Dung\\Fishinghub\\web";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<html><body>");
            out.println("<h1>Servlet PostServlet at " + request.getContextPath() + "</h1>");
            out.println("</body></html>");
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
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        try {
            HttpSession session = request.getSession();
            Users loggedInUser = (Users) session.getAttribute("user");

            if (loggedInUser == null) {
                response.sendRedirect("Login.jsp");
                return;
            }

            String action = request.getParameter("action");
            String topic = request.getParameter("topic");
            String title = request.getParameter("title");
            String content = request.getParameter("content");

            // Input validation
            if (topic == null || topic.trim().isEmpty() || title == null || title.trim().isEmpty() || content == null
                    || content.trim().isEmpty()) {
                response.getWriter().write("Error: Topic, title, and content are required.");
                return;
            }

            PostDAO postDAO = new PostDAO();
            Post post = new Post();
            post.setUserId(loggedInUser.getUserId());
            post.setTopic(topic.trim());
            post.setTitle(title.trim());
            post.setContent(content.trim());

            List<String> newImages = new ArrayList<>();
            List<String> newVideos = new ArrayList<>();
            String uploadPath = BASE_PATH + File.separator + UPLOAD_DIR.replace("/", File.separator);
            String videoUploadPath = BASE_PATH + File.separator + VIDEO_UPLOAD_DIR.replace("/", File.separator);

            File uploadDir = new File(uploadPath);
            File videoUploadDir = new File(videoUploadPath);
            if (!uploadDir.exists())
                uploadDir.mkdirs();
            if (!videoUploadDir.exists())
                videoUploadDir.mkdirs();

            if ("create".equals(action)) {

                for (Part part : request.getParts()) {
                    String fileName = extractFileName(part);
                    if (fileName != null && !fileName.isEmpty()) {
                        if (part.getName().equals("images")) {
                            String filePath = uploadPath + File.separator + fileName;
                            part.write(filePath);
                            newImages.add(fileName);
                        } else if (part.getName().equals("videos")) {
                            String filePath = videoUploadPath + File.separator + fileName;
                            part.write(filePath);
                            newVideos.add(fileName);
                        }
                    }
                }

                post.setImages(newImages);
                post.setVideos(newVideos);
                post.setCreatedAt(new Timestamp(System.currentTimeMillis()));
                post.setStatus("chờ duyệt");
                boolean success = postDAO.createPost(post);

                if (success) {
                    response.getWriter().write("success");
                } else {
                    response.getWriter().write("error");
                }
            } else if ("edit".equals(action) || "repost".equals(action)) {
                int postId;
                try {
                    postId = Integer.parseInt(request.getParameter("postId"));
                } catch (NumberFormatException e) {
                    response.getWriter().write("Error: Invalid post ID.");
                    return;
                }
                post.setPostId(postId);

                Post existingPost = postDAO.getPostById(postId);
                if (existingPost == null || existingPost.getUserId() != loggedInUser.getUserId()) {
                    session.setAttribute("error", "Bạn không có quyền chỉnh sửa bài viết này.");
                    response.sendRedirect("NewFeed.jsp");
                    return;
                }

                String existingImages = request.getParameter("existingImages");
                String existingVideos = request.getParameter("existingVideos");
                String removedImages = request.getParameter("removedImages");
                String removedVideos = request.getParameter("removedVideos");

                List<String> existingImageList = existingImages != null && !existingImages.isEmpty()
                        ? List.of(existingImages.split(","))
                        : new ArrayList<>();
                List<String> existingVideoList = existingVideos != null && !existingVideos.isEmpty()
                        ? List.of(existingVideos.split(","))
                        : new ArrayList<>();
                List<String> removedImageList = removedImages != null && !removedImages.isEmpty()
                        ? List.of(removedImages.split(","))
                        : new ArrayList<>();
                List<String> removedVideoList = removedVideos != null && !removedVideos.isEmpty()
                        ? List.of(removedVideos.split(","))
                        : new ArrayList<>();

                // Handle new file uploads
                for (Part part : request.getParts()) {
                    String fileName = extractFileName(part);
                    if (fileName != null && !fileName.isEmpty()) {

                        String uniqueFileName = System.currentTimeMillis() + "_" + fileName;
                        if (part.getName().equals("images")) {
                            String filePath = uploadPath + File.separator + uniqueFileName;
                            part.write(filePath);
                            newImages.add(uniqueFileName);
                        } else if (part.getName().equals("videos")) {
                            String filePath = videoUploadPath + File.separator + uniqueFileName;
                            part.write(filePath);
                            newVideos.add(uniqueFileName);
                        }
                    }
                }

                List<String> finalImages = new ArrayList<>(existingImageList);
                finalImages.removeAll(removedImageList);
                finalImages.addAll(newImages);
                List<String> finalVideos = new ArrayList<>(existingVideoList);
                finalVideos.removeAll(removedVideoList);
                finalVideos.addAll(newVideos);

                post.setImages(finalImages);
                post.setVideos(finalVideos);
                post.setStatus("chờ duyệt");

                boolean success = postDAO.updatePost(postId, topic, title, content, finalImages, finalVideos);
                if ("repost".equals(action)) {
                    postDAO.insertNotification(loggedInUser.getUserId(), postId,
                            "Bài viết của bạn đã được đăng lại và đang chờ duyệt.");
                }

                if (success) {
                    response.getWriter().write("success");
                } else {
                    response.getWriter().write("error");
                }
            } else {
                response.getWriter().write("Error: Invalid action.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("NewFeed.jsp");
        }
    }

    private String extractFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        if (contentDisposition == null)
            return null;
        String[] items = contentDisposition.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                String fileName = s.substring(s.indexOf("=") + 2, s.length() - 1);
                return fileName.replaceAll("[^a-zA-Z0-9.-]", "_");
            }
        }
        return null;
    }
}