<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dal.PostDAO"%>
<%@page import="dal.UserDao"%>
<%@page import="model.Post"%>
<%@page import="model.Users"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
    String idStr = request.getParameter("id");
    Post post = null;
    Users user = null;
    if(idStr != null) {
        try {
            int postId = Integer.parseInt(idStr);
            PostDAO postDAO = new PostDAO();
            post = postDAO.getPostById(postId);
            if(post != null) {
                user = new UserDao().getUserById(post.getUserId());
            }
        } catch(Exception e) {
            post = null;
        }
    }
    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết bài viết</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.6.0/remixicon.min.css" rel="stylesheet">
    <style>
        .media-thumb { max-width: 220px; margin: 8px 8px 8px 0; border-radius: 12px; box-shadow: 0 2px 8px #0001; }
        .badge-status { font-size: 1rem; padding: 0.5em 1em; }
    </style>
</head>
<body class="bg-light">
    <div class="container py-5">
        <div class="card shadow-lg mx-auto" style="max-width: 700px;">
            <div class="card-header bg-primary text-white d-flex align-items-center">
                <i class="ri-article-line me-2 fs-4"></i>
                <h3 class="mb-0">Chi tiết bài viết</h3>
            </div>
            <div class="card-body">
                <% if(post == null) { %>
                    <div class="alert alert-danger">Không tìm thấy bài viết!</div>
                <% } else { %>
                    <div class="row mb-3">
                        <div class="col-4 text-secondary">ID:</div>
                        <div class="col-8 fw-semibold">#<%= post.getPostId() %></div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-4 text-secondary">Tiêu đề:</div>
                        <div class="col-8"><%= post.getTitle() %></div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-4 text-secondary">Chủ đề:</div>
                        <div class="col-8"><%= post.getTopic() %></div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-4 text-secondary">Người đăng:</div>
                        <div class="col-8"><%= user != null ? user.getFullName() : "Unknown" %></div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-4 text-secondary">Ngày đăng:</div>
                        <div class="col-8"><%= sdf.format(post.getCreatedAt()) %></div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-4 text-secondary">Trạng thái:</div>
                        <div class="col-8">
                            <% if("đã duyệt".equals(post.getStatus())) { %>
                                <span class="badge bg-success-subtle text-success-emphasis badge-status"><i class="ri-checkbox-circle-line me-1"></i>Đã duyệt</span>
                            <% } else if("chờ duyệt".equals(post.getStatus())) { %>
                                <span class="badge bg-warning-subtle text-warning-emphasis badge-status"><i class="ri-time-line me-1"></i>Chờ duyệt</span>
                            <% } else { %>
                                <span class="badge bg-danger-subtle text-danger-emphasis badge-status"><i class="ri-close-circle-line me-1"></i>Từ chối</span>
                            <% } %>
                        </div>
                    </div>
                    <div class="mb-4">
                        <div class="text-secondary mb-1">Nội dung:</div>
                        <div class="border rounded p-3 bg-light"><%= post.getContent() %></div>
                    </div>
                    <%-- ảnh --%>
                    <% if(post.getImages() != null && !post.getImages().isEmpty()) { %>
                        <div class="mb-3">
                            <div class="text-secondary mb-1">Ảnh:</div>
                            <div>
                                <% for(String img : post.getImages()) { %>
                                    <img class="media-thumb" src="<%= request.getContextPath() + "/assets/img/post/" + img %>" alt="Ảnh bài viết"/>
                                <% } %>
                            </div>
                        </div>
                    <% } %>
                    <%-- video --%>
                    <% if(post.getVideos() != null && !post.getVideos().isEmpty()) { %>
                        <div class="mb-3">
                            <div class="text-secondary mb-1">Video:</div>
                            <div>
                                <% for(String vid : post.getVideos()) { %>
                                    <video class="media-thumb" controls>
                                        <source src="<%= request.getContextPath() + "/assets/video/post/" + vid %>" type="video/mp4">
                                    </video>
                                <% } %>
                            </div>
                        </div>
                    <% } %>
                    <div class="mt-4">
                        <a href="PostManagement.jsp" class="btn btn-outline-primary"><i class="ri-arrow-left-line me-1"></i>Quay lại danh sách</a>
                    </div>
                <% } %>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>