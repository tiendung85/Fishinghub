<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="dal.PostDAO"%>
<%@page import="model.Post"%>
<%@page import="dal.UserDao"%>
<%@page import="model.Users"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
    String keyword = request.getParameter("keyword");
    String status = request.getParameter("status");
    String action = request.getParameter("action");
    String postIdStr = request.getParameter("postId");
    int currentPage = 1;
    int pageSize = 3;
    if(request.getParameter("currentPage") != null) currentPage = Integer.parseInt(request.getParameter("currentPage"));

    PostDAO postDAO = new PostDAO();

    // Xử lý duyệt, từ chối, xóa
    if(action != null && postIdStr != null) {
        int postId = Integer.parseInt(postIdStr);
        if("approve".equals(action)) {
            postDAO.updatePostStatus(postId, "đã duyệt");
        } else if("reject".equals(action)) {
            postDAO.updatePostStatus(postId, "từ chối");
        } else if("delete".equals(action)) {
            postDAO.deletePost(postId);
        }
        
        response.sendRedirect("PostManagement.jsp?currentPage=" + currentPage + 
            (keyword != null ? "&keyword=" + keyword : "") +
            (status != null ? "&status=" + status : ""));
        return;
    }

    int totalPosts = postDAO.countPosts(keyword, status);
    int totalPages = (int)Math.ceil((double)totalPosts / pageSize);

    List<Post> posts = postDAO.searchPosts(keyword, status, currentPage, pageSize);
    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
    UserDao userDao = new UserDao();
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý bài viết</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.6.0/remixicon.min.css" rel="stylesheet">
    <style>
        .status-approved { color: #22c55e; font-weight: bold; }
        .status-pending { color: #eab308; font-weight: bold; }
        .status-rejected { color: #ef4444; font-weight: bold; }
        .action-btn { margin-right: 8px; }
        .table-hover tbody tr:hover { background-color: #f1f5f9; }
    </style>
</head>
<body class="bg-light">
    <div class="container py-5">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="fw-bold text-primary"><i class="ri-article-line me-2"></i>Quản lý bài viết</h2>
            <span class="badge bg-secondary fs-6">Tổng: <%= totalPosts %> bài viết</span>
        </div>
        <form method="get" class="row g-2 align-items-center mb-4">
            <div class="col-md-5">
                <div class="input-group">
                    <span class="input-group-text"><i class="ri-search-line"></i></span>
                    <input type="text" name="keyword" class="form-control" placeholder="Tìm kiếm tiêu đề hoặc người đăng..." value="<%= keyword != null ? keyword : "" %>"/>
                </div>
            </div>
            <div class="col-md-3">
                <select name="status" class="form-select">
                    <option value="">Tất cả trạng thái</option>
                    <option value="chờ duyệt" <%= "chờ duyệt".equals(status) ? "selected" : "" %>>Chờ duyệt</option>
                    <option value="đã duyệt" <%= "đã duyệt".equals(status) ? "selected" : "" %>>Đã duyệt</option>
                    <option value="từ chối" <%= "từ chối".equals(status) ? "selected" : "" %>>Từ chối</option>
                </select>
            </div>
            <div class="col-md-2">
                <button type="submit" class="btn btn-primary w-100"><i class="ri-filter-line me-1"></i>Tìm kiếm</button>
            </div>
            <div class="col-md-2">
                <a href="PostManagement.jsp" class="btn btn-outline-secondary w-100"><i class="ri-refresh-line me-1"></i>Làm mới</a>
            </div>
        </form>
        <div class="table-responsive shadow rounded">
            <table class="table table-hover align-middle mb-0">
                <thead class="table-light">
                    <tr>
                        <th>ID</th>
                        <th>Tiêu đề</th>
                        <th>Người đăng</th>
                        <th>Ngày đăng</th>
                        <th>Trạng thái</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                <% for(Post post : posts) { 
                    Users user = userDao.getUserById(post.getUserId());
                %>
                    <tr>
                        <td class="fw-semibold">#<%= post.getPostId() %></td>
                        <td><%= post.getTitle() %></td>
                        <td><%= user != null ? user.getFullName() : "Unknown" %></td>
                        <td><%= sdf.format(post.getCreatedAt()) %></td>
                        <td>
                            <% if("đã duyệt".equals(post.getStatus())) { %>
                                <span class="badge bg-success-subtle text-success-emphasis px-3 py-2"><i class="ri-checkbox-circle-line me-1"></i>Đã duyệt</span>
                            <% } else if("chờ duyệt".equals(post.getStatus())) { %>
                                <span class="badge bg-warning-subtle text-warning-emphasis px-3 py-2"><i class="ri-time-line me-1"></i>Chờ duyệt</span>
                            <% } else { %>
                                <span class="badge bg-danger-subtle text-danger-emphasis px-3 py-2"><i class="ri-close-circle-line me-1"></i>Từ chối</span>
                            <% } %>
                        </td>
                        <td>
                            <a class="btn btn-sm btn-outline-info action-btn" href="PostDetail.jsp?id=<%= post.getPostId() %>"><i class="ri-eye-line"></i> Xem</a>
                            <% if("chờ duyệt".equals(post.getStatus())) { %>
                                <a class="btn btn-sm btn-success action-btn" href="PostManagement.jsp?action=approve&postId=<%= post.getPostId() %>&currentPage=<%= currentPage %><%= keyword != null ? "&keyword=" + keyword : "" %><%= status != null ? "&status=" + status : "" %>"><i class="ri-check-line"></i> Duyệt</a>
                                <a class="btn btn-sm btn-warning action-btn" href="PostManagement.jsp?action=reject&postId=<%= post.getPostId() %>&currentPage=<%= currentPage %><%= keyword != null ? "&keyword=" + keyword : "" %><%= status != null ? "&status=" + status : "" %>"><i class="ri-close-line"></i> Từ chối</a>
                            <% } %>
                            <a class="btn btn-sm btn-outline-danger action-btn" href="PostManagement.jsp?action=delete&postId=<%= post.getPostId() %>&currentPage=<%= currentPage %><%= keyword != null ? "&keyword=" + keyword : "" %><%= status != null ? "&status=" + status : "" %>" onclick="return confirm('Xóa bài viết này?');"><i class="ri-delete-bin-line"></i> Xóa</a>
                        </td>
                    </tr>
                <% } %>
                </tbody>
            </table>
        </div>
        <!-- Pagination -->
        <nav class="mt-4 d-flex justify-content-center">
            <ul class="pagination">
                
                <% for(int i=1; i<=totalPages; i++) { %>
                    <li class="page-item <%= i==currentPage ? "active" : "" %>">
                        <a class="page-link" href="PostManagement.jsp?currentPage=<%=i%><%= keyword != null ? "&keyword=" + keyword : "" %><%= status != null ? "&status=" + status : "" %>"><%= i %></a>
                    </li>
                <% } %>
                
            </ul>
        </nav>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>