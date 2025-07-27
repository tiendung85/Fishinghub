<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@page import="java.util.List"%>
<%@page import="model.Post"%>
<%@page import="dal.PostDAO"%>
<%@page import="dal.UserDao"%>
<%@page import="model.Users"%>
<%@page import="model.PostComment"%>
<%@page import="dal.PostCommentDAO"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@page import="java.util.Date"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="dal.PostLikeDAO"%>
<%@page import="dal.CommentLikeDAO"%>
<%@page import="dal.PostNotificationDAO"%>
<%@page import="dal.EventDAO"%>
<%@page import="model.PostNotification"%>
<%@page import="model.EventNotification"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>






<%!
    public String getTimeAgo(Date date) {
        long timeInMillis = new Date().getTime() - date.getTime();
        long minutes = timeInMillis / (60 * 1000);
        long hours = timeInMillis / (60 * 60 * 1000);
        long days = timeInMillis / (24 * 60 * 60 * 1000);

        if (minutes < 1) {
            return "Vừa xong";
        } else if (minutes < 60) {
            return minutes + " phút trước";
        } else if (hours < 24) {
            return hours + " giờ trước";
        } else if (days < 30) {
            return days + " ngày trước";
        } else {
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
            return sdf.format(date);
        }
    }
     
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Bảng Tin</title>
        <script src="https://cdn.tailwindcss.com/3.4.16"></script>
        <script>
            tailwind.config = {
                theme: {
                    extend: {
                        colors: {
                            primary: '#1E88E5',
                            secondary: '#FFA726'
                        },
                        borderRadius: {
                            'none': '0px',
                            'sm': '4px',
                            DEFAULT: '8px',
                            'md': '12px',
                            'lg': '16px',
                            'xl': '20px',
                            '2xl': '24px',
                            '3xl': '32px',
                            'full': '9999px',
                            'button': '8px'
                        }
                    }
                }
            }
        </script>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.6.0/remixicon.min.css">
        <link rel="stylesheet" href="assets/css/style.css">

    </head>
    <body>


        <!-- Header -->
        <header class="bg-white shadow-sm">
            <div class="container mx-auto px-4 py-3 flex items-center justify-between">
                <div class="flex items-center">
                    <a href="Home.jsp" class="text-3xl font-['Pacifico'] text-primary">FishingHub</a>

                   <nav class="hidden md:flex ml-10">
                        <a href="Home" class="px-4 py-2 text-gray-800 font-medium hover:text-primary">Trang Chủ</a>
                        <a href="EventList" class="px-4 py-2 text-gray-800 font-medium hover:text-primary">Sự Kiện</a>
                        <a href="NewFeed" class="px-4 py-2 text-gray-800 font-medium hover:text-primary">Bảng Tin</a>
                        <a href="shop-list" class="px-4 py-2 text-gray-800 font-medium hover:text-primary">Cửa Hàng</a>
                        <a href="KnowledgeFish" class="px-4 py-2 text-gray-800 font-medium hover:text-primary">Kiến Thức</a>
                   
                    </nav>
                </div>

                <div class="flex items-center space-x-4">

                    
                    <div class="relative">
                        <div class="w-10 h-10 flex items-center justify-center rounded-full bg-gray-100 cursor-pointer" id="notificationBell">
                            <i class="ri-notification-3-line text-gray-600"></i>
                        </div>
                        <c:if test="${unreadPostNotificationCount > 0}">
                            <span class="absolute -top-1 -right-1 flex h-5 w-5 items-center justify-center rounded-full bg-primary text-xs text-white">
                                ${unreadPostNotificationCount}
                            </span>
                        </c:if>
                        <!-- Dropdown thông báo -->
                        <div id="notificationDropdown" class="absolute right-0 mt-2 w-80 bg-white shadow-lg rounded-lg overflow-hidden z-50 hidden">
                            <div class="p-4 border-b font-semibold text-gray-700">Thông báo</div>
                            <ul class="max-h-64 overflow-y-auto divide-y divide-gray-200">

                                <c:forEach var="n" items="${notifications}">
                                    <li class="px-4 py-3 hover:bg-gray-100 text-sm">
                                        <a href="EventDetails?action=details&eventId=${n.eventId}" class="block text-gray-800 font-medium">${n.title}</a>
                                        <p class="text-gray-500 text-xs">${n.message}</p>
                                        <p class="text-gray-400 text-xs mt-1">${n.formattedCreatedAt}</p>
                                    </li>
                                </c:forEach>
<c:forEach var="n" items="${postNotifications}">
    <div class="notification-item border-b border-gray-100 py-4 px-4 hover:bg-gray-50 transition-colors duration-200">
        <c:choose>
            <c:when test="${n.status == 'từ chối'}">
                <div class="space-y-2">
                    <a href="NewFeed?tab=rejected#post-${n.postId}" 
                       class="block text-gray-800 font-medium hover:text-red-600 transition-colors duration-150 leading-relaxed">
                        ${n.message}
                    </a>
                    <p class="text-gray-500 text-xs">
                        <fmt:formatDate value="${n.createdAt}" pattern="dd/MM/yyyy HH:mm" />
                    </p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="space-y-2">
                    <a href="NewFeed#post-${n.postId}" 
                       class="block text-gray-800 font-medium hover:text-blue-600 transition-colors duration-150 leading-relaxed">
                        ${n.message}
                    </a>
                    <p class="text-gray-500 text-xs">
                        <fmt:formatDate value="${n.createdAt}" pattern="dd/MM/yyyy HH:mm" />
                    </p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</c:forEach>
                                <c:if test="${empty notifications && empty postNotifications}">
                                    <li class="px-4 py-3 text-gray-500 text-sm text-center">Không có thông báo nào</li>
                                    </c:if>
                            </ul>
                        </div>
                    </div>

                    <% 
                    Users currentUser = (Users) session.getAttribute("user");
                if (currentUser == null) { %>
                    <!-- Chưa đăng nhập -->
                    <a href="Login.jsp" class="bg-primary text-white px-4 py-2 rounded-button whitespace-nowrap">Đăng Nhập</a>
                    <a href="Register.jsp" class="bg-white text-primary border border-primary px-4 py-2 rounded-button whitespace-nowrap">Đăng Ký</a>
                    <% } else { %>
                    <!-- Đã đăng nhập -->
                    <div class="flex items-center space-x-3">
                        <span class="font-semibold text-primary"><i class="ri-user-line mr-1"></i> <%= currentUser.getFullName() %></span>
                        <form action="logout" method="post" style="display:inline;">
                            <button type="submit" class="bg-gray-200 text-gray-800 px-3 py-2 rounded-button hover:bg-gray-300">Đăng Xuất</button>
                        </form>
                    </div>

                    <% } %>
                </div>
        </header>

        <!-- Breadcrumb -->
        <div class="bg-gray-50 border-b border-gray-200">
            <div class="container mx-auto px-4 py-3">
                <div class="flex items-center text-sm">
                    <a href="Home.jsp" data-readdy="true" class="text-gray-600 hover:text-primary">Trang Chủ</a>
                    <div class="w-4 h-4 flex items-center justify-center text-gray-400 mx-1">
                        <i class="ri-arrow-right-s-line"></i>
                    </div>
                    <span class="text-primary font-medium">Bảng Tin</span>
                </div>
            </div>
        </div>

        <!-- Main Content -->
        <main class="py-8">
            <div class="container mx-auto px-4">
                <!-- Title and Search -->
                <div class="flex flex-col md:flex-row justify-between items-start md:items-center mb-8 gap-4">
                    <div>
                        <h1 class="text-3xl font-bold text-gray-900">Bảng Tin Cộng Đồng</h1>
                        <p class="text-gray-600 mt-2">Chia sẻ kinh nghiệm, tin tức và thảo luận về câu cá</p>
                    </div>
                    <div class="flex items-center gap-4">
                        <!-- Search input -->
                        <div class="relative">
                            <input type="text" 
                                   id="searchInput"
                                   placeholder="Tìm kiếm bài viết theo chủ đề..." 
                                   value="<%= request.getParameter("topic") != null ? request.getParameter("topic") : "" %>"
                                   class="w-full md:w-80 pl-10 pr-4 py-2 rounded-button border-none bg-white shadow-sm focus:ring-2 focus:ring-primary focus:outline-none text-sm">
                            <div class="absolute left-3 top-1/2 transform -translate-y-1/2 w-5 h-5 flex items-center justify-center text-gray-400">
                                <i class="ri-search-line"></i>
                            </div>
                        </div>

                        <button class="bg-primary text-white px-6 py-2 rounded-button whitespace-nowrap flex items-center gap-2" onclick="openCreatePostDialog()">
    <i class="ri-add-line"></i>
    <span>
        <% if (currentUser != null) { %>
            Tạo Bài Viết Mới
        <% } else { %>
            Đăng Nhập để Tạo Bài Viết
        <% } %>
    </span>
</button>
                    </div>
                </div>



                <div class="bg-white rounded shadow-sm mb-8">
                    <div class="flex border-b border-gray-200">
                        <button id="allPostsBtn" class="tab-button active px-6 py-4 text-primary font-medium">Tất Cả Bài Viết</button>
                        <button id="savedPostsBtn" class="tab-button active px-6 py-4 text-gray-600 font-medium hover:text-primary">Đã Lưu</button>
                        <button id="myPostsBtn" class="tab-button active px-6 py-4 text-gray-600 font-medium hover:text-primary">Bài Viết Của Tôi</button>   
                        <button id="rejectedPostsBtn" class="tab-button active px-6 py-4 text-gray-600 font-medium hover:text-primary">Bài Viết Bị Từ Chối</button>

                    </div>

                </div>

                <!-- Posts List -->
                <div class="space-y-6 max-w-4xl mx-auto" id="postsContainer"> 

                    <%
                        PostDAO postDAO = new PostDAO();
                        UserDao userDao = new UserDao();
                        PostCommentDAO commentDAO = new PostCommentDAO();
                        String searchTopic = request.getParameter("topic");
                        String tab = request.getParameter("tab");
                        List<Post> posts;

                        if ("saved".equals(tab) && currentUser != null) {
                            dal.SavedPostDAO savedDao = new dal.SavedPostDAO();
                            posts = savedDao.getSavedPostsByUser(currentUser.getUserId());
                        } else if ("my".equals(tab) && currentUser != null) {
                            posts = postDAO.getPostsByUser(currentUser.getUserId());
                        } else if ("rejected".equals(tab) && currentUser != null) {
                                posts = postDAO.getPostsByStatusAndUser("từ chối", currentUser.getUserId());
                            } 
                        else if (searchTopic != null && !searchTopic.trim().isEmpty()) {
                            posts = postDAO.searchPostsByTopic(searchTopic);
                        } else {
                            posts = postDAO.getAllPosts();
                        }

                        SimpleDateFormat sdf = new SimpleDateFormat("MMM dd, yyyy HH:mm");

                        for(Post post : posts) {
        

                    %>
                    <div class="bg-white rounded-lg shadow-sm" id="post-<%= post.getPostId() %>"> 

                        <div class="p-6"> 

                            <!-- Post Header -->
                            <div class="flex items-start justify-between mb-4">
                                <div class="flex items-center gap-3">
                                    <% 
                                        Users postUser = userDao.getUserById(post.getUserId());
                                        String userName = (postUser != null) ? postUser.getFullName() : "Unknown User";
                                        String firstLetter = userName.substring(0, 1).toUpperCase();
                                    %>


                                    <div class="w-10 h-10 rounded-full bg-gradient-to-r from-blue-500 to-primary flex items-center justify-center text-white text-lg font-bold">
                                        <%= firstLetter %>
                                    </div>


                                    <div>
                                        <p class="font-medium text-gray-900"><%= userName %></p>
                                        <p class="text-sm text-gray-500"><%= sdf.format(post.getCreatedAt()) %></p>
                                    </div>



                                </div>

                                <div class="flex gap-2 items-center">

                                    <% boolean isPostOwner = currentUser != null && post.getUserId() == currentUser.getUserId(); %>
                                    <% if (isPostOwner) { %>
                                    <button class="text-xs text-blue-500 hover:underline" onclick="editPost(<%= post.getPostId() %>, this)">Sửa</button>
                                    <button class="text-xs text-red-500 hover:underline" onclick="deletePost(<%= post.getPostId() %>, this)">Xóa</button>
                                    <% } %>
                                </div>



                            </div>


                            <!-- Post Topic -->
                            <div class="mb-3">

                                <span class="topic inline-block px-0 py-1 bg-gray-100 text-gray-700 rounded-full text-sm">
                                    <%= post.getTopic() %>
                                </span>
                            </div>

                            <!-- Post Content Container -->
                     <div class="mb-4">
    <p class="text-gray-800 font-bold mb-0"><%= post.getTitle() %></p>
    <div class="content-wrapper">
     <div class="content-text" data-expanded="false">
    <%= post.getContent().replaceAll("^[\\s\\n\\r]+", "").trim() %>
</div>
        <div class="read-more-fade"></div>
        <button type="button" class="read-more-btn" onclick="toggleContent(this)">Xem thêm</button>
    </div>
</div>
                            <!-- Post Media Container -->

                            <div class="mb-4"> 
                                <div class="grid grid-cols-1 gap-4"> 

                                    <!-- Images -->
                                    <% if(post.getImages() != null && !post.getImages().isEmpty()) { %>
                                    <div class="flex gap-4 overflow-x-auto pb-2 scrollbar-thin">
                                        <% for(String image : post.getImages()) { %>

                                        <div class="flex-shrink-0 w-[300px] h-[225px]"> 

                                            <img src="assets/img/post/<%= image %>" 
                                                 alt="Post image" 
                                                 class="w-full h-full object-cover rounded-lg cursor-pointer hover:opacity-90 transition-opacity"
                                                 onclick="openImageModal(this.src)">
                                        </div>
                                        <% } %>
                                    </div>
                                    <% } %>

                                    <!-- Videos -->
                                    <% if(post.getVideos() != null && !post.getVideos().isEmpty()) { %>
                                    <div class="flex gap-4 overflow-x-auto pb-2 scrollbar-thin">
                                        <% for(String video : post.getVideos()) { %>
                                        <div class="flex-shrink-0 w-[400px]">
                                            <div class="aspect-video rounded-lg bg-black overflow-hidden">
                                                <video controls class="w-full h-full object-contain">
                                                    <source src="assets/video/post/<%= video %>" type="video/mp4">
                                                </video>
                                            </div>
                                        </div>
                                        <% } %>
                                    </div>
                                    <% } %>
                                </div>
                            </div>
                        </div>


                        <!-- Post Interactions  -->

                        <div class="px-6 py-3 border-t border-gray-100">
                            <div class="flex items-center justify-between">

                                <div class="flex items-center gap-4">
                                    <button onclick="toggleLike(<%= post.getPostId() %>, this)" 
                                            class="flex items-center gap-2 text-gray-600 hover:text-primary transition-colors">
                                        <% 
                                            boolean hasLiked = new dal.PostLikeDAO().hasLiked(post.getPostId(), 
                                                             currentUser != null ? currentUser.getUserId() : 0);
                                            int likeCount = new dal.PostLikeDAO().countLikesByPostId(post.getPostId());
                                        %>
                                        <i class="ri-heart-<%= hasLiked ? "fill text-primary" : "line" %> text-xl"></i>
                                        <span class="text-sm like-count" data-post-id="<%= post.getPostId() %>"><%= likeCount %> Thích</span>
                                    </button>

                                    <button class="flex items-center gap-2 text-gray-600 hover:text-primary transition-colors">
                                        <i class="ri-chat-1-line text-xl"></i>
                                        <span class="text-sm comment-count" data-post-id="<%= post.getPostId() %>">
                                            <%= commentDAO.countCommentsByPostId(post.getPostId()) %> Bình Luận
                                        </span>
                                    </button>
                                </div>

                                <% 
                      dal.SavedPostDAO savedDao = new dal.SavedPostDAO();
                      boolean isSaved = currentUser != null && savedDao.isSaved(currentUser.getUserId(), post.getPostId());
                                %>
                                <button class="flex items-center gap-2 text-gray-600 hover:text-primary transition-colors" 
                                        title="Lưu bài viết"
                                        onclick="toggleSavePost(<%= post.getPostId() %>, this)"
                                        <%= currentUser == null ? "disabled" : "" %>>
                                    <i class="ri-bookmark-<%= isSaved ? "fill text-primary" : "line" %> text-xl"></i>
                                    <span><%= isSaved ? "Đã lưu" : "Lưu" %></span>
                                </button>
                            </div>
                        </div>



                        <div class="px-6 py-4 border-t border-gray-100 bg-gray-50">
                            <!-- Comment Form -->

                            <form onsubmit="submitComment(event, <%= post.getPostId() %>, this)" class="mb-4">
                                <input type="hidden" name="postId" value="<%= post.getPostId() %>">
                                <input type="hidden" name="userId" value="<%= currentUser != null ? currentUser.getUserId() : "" %>">
                                <div class="flex gap-2">
                                    <div class="w-8 h-8 rounded-full bg-gradient-to-r from-blue-500 to-primary flex items-center justify-center text-white font-bold text-sm">
                                        <%= currentUser != null ? currentUser.getFullName().substring(0, 1).toUpperCase() : "?" %>
                                    </div>
                                    <div class="flex-1">
                                        <div class="relative">
                                            <input type="text" 
                                                   name="content" 
                                                   class="w-full px-4 py-2 rounded-full bg-gray-100 focus:outline-none focus:ring-2 focus:ring-primary focus:bg-white text-sm"
                                                   placeholder="<%= currentUser != null ? "Viết bình luận của bạn..." : "Đăng nhập để bình luận" %>"
                                                   required
                                                   <%= currentUser == null ? "disabled" : "" %>>
                                            <% if (currentUser != null) { %>
                                            <button type="submit" 
                                                    class="absolute right-2 top-1/2 transform -translate-y-1/2 px-3 py-1 bg-primary text-white rounded-full text-sm hover:bg-primary/90 transition-colors">
                                                Gửi
                                            </button>
                                            <% } %>
                                        </div>
                                    </div>
                                </div>
                            </form>


                            <!-- Comments List -->
                            <div class="space-y-4 comments-container" data-post-id="<%= post.getPostId() %>">
                                <% 
        
                                    List<PostComment> comments = commentDAO.getCommentsByPostId(post.getPostId());
                                    int commentCount = comments.size();
                                    for (int i = 0; i < comments.size(); i++) {
                                        PostComment comment = comments.get(i);
                                        Users commentUser = userDao.getUserById(comment.getUserId());
                                        boolean isHidden = i >= 2; // Ẩn các bình luận từ thứ 3 trở đi
                                %>
                                <div class="flex gap-2 comment-item <%= isHidden ? "hidden" : "" %>">
                                    <div class="w-8 h-8 rounded-full bg-gradient-to-r from-blue-500 to-primary flex items-center justify-center text-white font-bold text-sm">
                                        <%= commentUser.getFullName().substring(0, 1).toUpperCase() %>
                                    </div>
                                    <div class="flex-1">
                                        <div class="bg-gray-100 rounded-2xl px-4 py-3">
                                            <div class="flex items-center gap-2 mb-2">
                                                <p class="font-medium text-sm text-gray-900"><%= commentUser.getFullName() %></p>
                                                <span class="text-xs text-gray-500">• <%= getTimeAgo(comment.getCreatedAt()) %></span>
                                            </div>

                                            <p class="text-sm text-gray-800 pt-1 comment-content"><%= comment.getContent() %></p>
                                        </div>
                                        <div class="flex items-center gap-4 mt-2 ml-2">
                                            <button type="button"
                                                    class="text-xs text-gray-500 hover:text-primary transition-colors comment-like-btn"
                                                    onclick="toggleCommentLike(<%= comment.getCommentId() %>, 'comment', this)"
                                                    <%= currentUser == null ? "disabled" : "" %>>
                                                <i class="ri-heart-<%= new dal.CommentLikeDAO().hasLiked(comment.getCommentId(), currentUser != null ? currentUser.getUserId() : 0) ? "fill text-primary" : "line" %>"></i>
                                                <span>
                                                    <span class="comment-like-count" data-comment-id="<%= comment.getCommentId() %>">
                                                        <%= new dal.CommentLikeDAO().getLikeCount(comment.getCommentId()) %>
                                                    </span> Thích
                                                </span>
                                            </button>

                                            <button type="button"
                                                    class="text-xs text-gray-500 hover:text-primary transition-colors"
                                                    onclick="toggleReplyForm(<%= comment.getCommentId() %>)">
                                                <i class="ri-reply-line"></i>
                                                <span>Phản hồi</span>
                                            </button>
                                            <form action="comment-reply" method="post"
                                                  class="reply-form mt-2 ml-12 flex gap-2 items-center hidden"
                                                  id="reply-form-<%= comment.getCommentId() %>">
                                                <input type="hidden" name="commentId" value="<%= comment.getCommentId() %>">
                                                <input type="hidden" name="userId" value="<%= currentUser != null ? currentUser.getUserId() : "" %>">
                                                <input type="text" name="content" class="flex-1 px-3 py-1 rounded-full bg-gray-100 text-xs"
                                                       placeholder="Phản hồi bình luận..." <%= currentUser == null ? "disabled" : "" %> required>
                                                <button type="submit"
                                                        class="text-primary text-xs font-medium px-3 py-1 rounded-full bg-white border border-primary hover:bg-primary hover:text-white transition-colors"
                                                        <%= currentUser == null ? "disabled" : "" %>>Gửi</button>
                                            </form>

                                        </div>
                                    </div>
                                    <%

                                  // Hiển thị danh sách phản hồi cho từng bình luận
                                  dal.CommentReplyDAO replyDAO = new dal.CommentReplyDAO();
                                  List<model.CommentReply> replies = replyDAO.getRepliesByCommentId(comment.getCommentId());
                                  if (!replies.isEmpty()) {
                                    %>
                                    <div class="ml-12 mt-2 flex flex-col gap-2">
                                        <% for (model.CommentReply reply : replies) {
                                            Users replyUser = userDao.getUserById(reply.getUserId());
                                        %>
                                        <div class="flex gap-2 items-start">
                                            <div class="w-7 h-7 rounded-full bg-gradient-to-r from-blue-500 to-primary flex items-center justify-center text-white font-bold text-xs">
                                                <%= replyUser.getFullName().substring(0, 1).toUpperCase() %>
                                            </div>
                                            <div class="bg-gray-50 rounded-2xl px-3 py-2 flex-1">
                                                <span class="font-medium text-xs text-gray-900"><%= replyUser.getFullName() %></span>
                                                <span class="text-xs text-gray-500">• <%= getTimeAgo(reply.getCreatedAt()) %></span>
                                                <div class="text-xs text-gray-800 pt-1"><%= reply.getContent() %></div>
                                                <div class="flex items-center gap-4 mt-2">
                                                    <!-- Nút thích phản hồi -->
                                                    <button type="button"
                                                            class="text-xs text-gray-500 hover:text-primary transition-colors reply-like-btn"
                                                            onclick="toggleReplyLike(<%= reply.getReplyId() %>, this)"
                                                            <%= currentUser == null ? "disabled" : "" %>>
                                                        <i class="ri-heart-<%= new dal.ReplyLikeDAO().hasLiked(reply.getReplyId(), currentUser != null ? currentUser.getUserId() : 0) ? "fill text-primary" : "line" %>"></i>
                                                        <span>
                                                            <span class="reply-like-count" data-reply-id="<%= reply.getReplyId() %>">
                                                                <%= new dal.ReplyLikeDAO().getLikeCount(reply.getReplyId()) %>
                                                            </span> Thích
                                                        </span>
                                                    </button>
                                                    <!-- Nút phản hồi lại phản hồi -->
                                                    <button type="button"
                                                            class="text-xs text-gray-500 hover:text-primary transition-colors"
                                                            onclick="toggleReplyForm('reply-<%= reply.getReplyId() %>')">
                                                        <i class="ri-reply-line"></i>
                                                        <span>Phản hồi</span>
                                                    </button>
                                                </div>
                                                <!-- Form phản hồi cho từng reply -->
                                                <form action="comment-reply" method="post"
                                                      class="reply-form mt-2 ml-8 flex gap-2 items-center hidden"
                                                      id="reply-form-reply-<%= reply.getReplyId() %>">
                                                    <input type="hidden" name="commentId" value="<%= comment.getCommentId() %>">
                                                    <!-- <input type="hidden" name="parentReplyId" value="<%= reply.getReplyId() %>"> -->
                                                    <input type="hidden" name="userId" value="<%= currentUser != null ? currentUser.getUserId() : "" %>">
                                                    <input type="text" name="content" class="flex-1 px-3 py-1 rounded-full bg-gray-100 text-xs"
                                                           placeholder="Phản hồi bình luận..." <%= currentUser == null ? "disabled" : "" %> required>
                                                    <button type="submit"
                                                            class="text-primary text-xs font-medium px-3 py-1 rounded-full bg-white border border-primary hover:bg-primary hover:text-white transition-colors"
                                                            <%= currentUser == null ? "disabled" : "" %>>Gửi</button>
                                                </form>
                                            </div>
                                        </div>
                                        <% } %>
                                    </div>
                                    <% } %>
                                    <% 
                                            boolean isCommentOwner = currentUser != null && comment.getUserId() == currentUser.getUserId();
                                            if (isCommentOwner || isPostOwner) {
                                    %>
                                    <button class="text-xs text-red-500 hover:underline" onclick="deleteComment(<%= comment.getCommentId() %>,<%= post.getUserId() %>, <%= comment.getUserId() %>, this)">Xóa</button>
                                    <% } %>
                                    <% if (isCommentOwner) { %>
                                    <button class="text-xs text-blue-500 hover:underline" onclick="editComment(<%= comment.getCommentId() %>, <%= post.getUserId() %>,<%= comment.getUserId() %>, this)">Sửa</button>
                                    <% } %>
                                </div>
                                <%  } %>

                                <% if (commentCount > 2) { %>
                                <div class="text-center">
                                    <button class="load-more-comments text-primary text-sm font-medium hover:underline"
                                            data-post-id="<%= post.getPostId() %>"
                                            onclick="loadMoreComments(this)">
                                        Xem thêm bình luận
                                    </button>
                                </div>
                                <% } %>
                            </div>
                        </div>

                        <% } %>
                    </div>
                    </main>

                    <!-- Create Post Dialog -->
                    <div id="createPostDialog" class="fixed inset-0 bg-black bg-opacity-50 hidden items-center justify-center p-4">
                        <div class="bg-white rounded-xl w-full max-w-2xl mx-auto flex flex-col max-h-[90vh] shadow-2xl"> 


                            <div class="flex items-center justify-between p-6 border-b border-gray-100 bg-white rounded-t-xl sticky top-0 z-10">
                                <h3 class="text-2xl font-semibold text-gray-800">Tạo Bài Viết Mới</h3>
                                <button onclick="closeCreatePostDialog()" class="w-10 h-10 flex items-center justify-center text-gray-500 hover:text-gray-700 rounded-full hover:bg-gray-100 transition-all">
                                    <i class="ri-close-line text-2xl"></i>
                                </button>
                            </div>

                            <!-- Dialog Content -->
                            <div class="overflow-y-auto flex-1 px-6">
                                <form id="postForm" action="PostServlet" method="POST" enctype="multipart/form-data" class="py-4" accept-charset="UTF-8">
                                    <input type="hidden" name="action" id="formAction" value="create">
                                    <input type="hidden" name="postId" id="postId">
                                    <input type="hidden" name="existingImages" id="existingImages">
                                    <input type="hidden" name="existingVideos" id="existingVideos">
                                    <input type="hidden" name="removedImages" id="removedImages">
                                    <input type="hidden" name="removedVideos" id="removedVideos">
                                    <% if (currentUser != null) { %>
                                    <div class="flex items-center gap-4 mb-6">
                                        <div class="w-12 h-12 rounded-full bg-gradient-to-r from-blue-500 to-primary flex items-center justify-center text-white text-xl font-bold">
                                            <%= currentUser.getFullName().substring(0, 1).toUpperCase() %>
                                        </div>
                                        <div class="flex-1">
                                            <p class="font-medium text-gray-900 mb-2"><%= currentUser.getFullName() %></p>
                                            <input type="text" name="topic" placeholder="Thêm chủ đề..."
                                                   class="w-full p-4 border border-gray-200 rounded-xl focus:ring-2 focus:ring-primary focus:border-transparent focus:outline-none text-sm bg-gray-50 placeholder-gray-500"
                                                   maxlength="50" required>
                                        </div>
                                    </div>
                                    <% } %>
                                    <div class="space-y-4 mb-6">
                                        <textarea name="title" placeholder="Tiêu đề bài viết là gì?"
                                                  class="w-full p-4 border border-gray-200 rounded-xl focus:ring-2 focus:ring-primary focus:border-transparent focus:outline-none text-sm bg-gray-50 placeholder-gray-500"
                                                  rows="1" maxlength="200" required></textarea>
                                        <textarea name="content" placeholder="Bạn muốn chia sẻ điều gì?"
                                                  class="w-full p-4 border border-gray-200 rounded-xl focus:ring-2 focus:ring-primary focus:border-transparent focus:outline-none text-sm bg-gray-50 placeholder-gray-500 whitespace-pre-wrap"
                                                  style="min-height: 150px; resize: vertical;" rows="4" required></textarea>
                                    </div>
                                    <div class="space-y-4 mb-6">
                                        <input type="file" id="imageInput" name="images" accept="image/*" multiple class="hidden">
                                        <input type="file" id="videoInput" name="videos" accept="video/*" multiple class="hidden">
                                        <div id="imagePreviewContainer" class="hidden">
                                            <h4 class="font-medium text-gray-700 mb-2">Hình ảnh đã chọn</h4>
                                            <div class="flex gap-4 overflow-x-auto pb-4 scrollbar-thin scrollbar-thumb-gray-300 scrollbar-track-gray-100"></div>
                                        </div>
                                        <div id="videoPreviewContainer" class="hidden">
                                            <h4 class="font-medium text-gray-700 mb-2">Video đã chọn</h4>
                                            <div class="flex gap-4 overflow-x-auto pb-4 scrollbar-thin scrollbar-thumb-gray-300 scrollbar-track-gray-100"></div>
                                        </div>
                                    </div>
                                    <div class="border-t border-gray-100 bg-white sticky bottom-0 -mx-6 px-6">
                                        <div class="flex items-center gap-4 py-4">
                                            <button type="button" onclick="document.getElementById('imageInput').click()"
                                                    class="flex items-center gap-2 px-4 py-2 rounded-xl hover:bg-gray-100 transition-colors">
                                                <i class="ri-image-line text-xl text-primary"></i>
                                                <span class="text-sm font-medium text-gray-700">Thêm ảnh</span>
                                            </button>
                                            <button type="button" onclick="document.getElementById('videoInput').click()"
                                                    class="flex items-center gap-2 px-4 py-2 rounded-xl hover:bg-gray-100 transition-colors">
                                                <i class="ri-video-line text-xl text-primary"></i>
                                                <span class="text-sm font-medium text-gray-700">Thêm video</span>
                                            </button>
                                        </div>
                                        <div class="py-4">
                                            <button type="submit" id="submitButton"
                                                    class="w-full bg-primary text-white px-6 py-3 rounded-xl font-medium hover:bg-primary/90 transition-colors shadow-lg shadow-primary/25">
                                                Đăng Bài
                                            </button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                    
                       <!-- Modal thông báo bài viết đang chờ duyệt -->
        <div id="pendingPostModal" class="fixed inset-0 bg-black bg-opacity-50 hidden items-center justify-center p-4 z-50">
            <div class="bg-white rounded-xl w-full max-w-md mx-auto shadow-2xl">
                <div class="p-6 text-center">
                    <div class="w-16 h-16 mx-auto mb-4 bg-yellow-100 rounded-full flex items-center justify-center">
                        <i class="ri-time-line text-3xl text-yellow-600"></i>
                    </div>
                    <h3 class="text-xl font-semibold text-gray-800 mb-2">Bài viết đang chờ duyệt</h3>
                    <p class="text-gray-600 mb-6">Bài viết của bạn đã được gửi thành công và đang chờ quản trị viên phê duyệt. Chúng tôi sẽ thông báo cho bạn khi bài viết được duyệt.</p>
                    <button onclick="closePendingPostModal()" 
                            class="w-full bg-primary text-white px-6 py-3 rounded-xl font-medium hover:bg-primary/90 transition-colors">
                        Đã hiểu
                    </button>
                </div>
            </div>
        </div>

                    <!-- Thêm modal xem ảnh toàn màn hình -->
                    <div id="imageModal" class="fixed inset-0 bg-black bg-opacity-90 hidden items-center justify-center z-50">
                        <button onclick="closeImageModal()" class="absolute top-4 right-4 text-white hover:text-gray-300">
                            <i class="ri-close-line text-3xl"></i>
                        </button>
                        <img id="modalImage" src="" alt="Full screen image" class="max-h-[90vh] max-w-[90vw] object-contain">
                    </div>

                    <!-- Footer -->
                    <footer class="bg-gray-800 text-white pt-12 pb-6">
                        <div class="container mx-auto px-4">
                            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8 mb-8">
                                <div>
                                    <a href="#" class="text-3xl font-['Pacifico'] text-white mb-4 inline-block">FishingHub</a>
                                    <p class="text-gray-400 mb-4">Vietnam's leading fishing community, connecting passion and sharing experiences.</p>
                                    <div class="flex space-x-4">
                                        <a href="#" class="w-10 h-10 flex items-center justify-center rounded-full bg-gray-700 hover:bg-primary transition-colors">
                                            <i class="ri-facebook-fill"></i>
                                        </a>
                                        <a href="#" class="w-10 h-10 flex items-center justify-center rounded-full bg-gray-700 hover:bg-primary transition-colors">
                                            <i class="ri-youtube-fill"></i>
                                        </a>
                                        <a href="#" class="w-10 h-10 flex items-center justify-center rounded-full bg-gray-700 hover:bg-primary transition-colors">
                                            <i class="ri-instagram-fill"></i>
                                        </a>
                                        <a href="#" class="w-10 h-10 flex items-center justify-center rounded-full bg-gray-700 hover:bg-primary transition-colors">
                                            <i class="ri-tiktok-fill"></i>
                                        </a>
                                    </div>
                                </div>
                                <div>
                                    <h3 class="text-lg font-bold mb-4">Quick Links</h3>
                                    <ul class="space-y-2">
                                        <li><a href="Home.jsp" class="text-gray-400 hover:text-white">Home</a></li>
                                        <li><a href="Event.jsp" class="text-gray-400 hover:text-white">Events</a></li>
                                        <li><a href="NewFeed" class="text-gray-400 hover:text-white">News Feed</a></li>
                                        <li><a href="Product.jsp" class="text-gray-400 hover:text-white">Shop</a></li> 
                                        <li><a href="FishKnowledge.jsp" class="text-gray-400 hover:text-white">Knowledge</a></li>
                                        <li><a href="Achievement.jsp" class="text-gray-400 hover:text-white">Rankings</a></li>
                                    </ul>
                                </div>
                                <div>
                                    <h3 class="text-lg font-bold mb-4">Support</h3>
                                    <ul class="space-y-2">
                                        <li><a href="#" class="text-gray-400 hover:text-white">Help Center</a></li>
                                        <li><a href="#" class="text-gray-400 hover:text-white">Privacy Policy</a></li>
                                        <li><a href="#" class="text-gray-400 hover:text-white">Terms of Use</a></li>
                                        <li><a href="#" class="text-gray-400 hover:text-white">Return Policy</a></li>
                                        <li><a href="#" class="text-gray-400 hover:text-white">FAQ</a></li>
                                    </ul>
                                </div>
                                <div>
                                    <div class="mt-4">
                                        <h4 class="text-sm font-medium mb-2">Payment Methods</h4>
                                        <div class="flex space-x-3">
                                            <div class="w-10 h-6 flex items-center justify-center bg-white rounded">
                                                <i class="ri-visa-fill text-blue-800 text-lg"></i>
                                            </div>
                                            <div class="w-10 h-6 flex items-center justify-center bg-white rounded">
                                                <i class="ri-mastercard-fill text-red-500 text-lg"></i>
                                            </div>
                                            <div class="w-10 h-6 flex items-center justify-center bg-white rounded">
                                                <i class="ri-paypal-fill text-blue-600 text-lg"></i>
                                            </div>
                                            <div class="w-10 h-6 flex items-center justify-center bg-white rounded">
                                                <i class="ri-bank-card-fill text-gray-700 text-lg"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="border-t border-gray-700 pt-6">
                                <p class="text-center text-gray-500 text-sm">© 2025 Vietnam Fishing Community. All rights reserved.</p>
                            </div>
                        </div>
                    </footer>

                    <!-- Scripts -->
                    <script>
                        
                        function openCreatePostDialog() {
    <% if (currentUser == null) { %>
        window.location.href = 'Login.jsp';
        return;
    <% } %>
    
    const dialog = document.getElementById('createPostDialog');
    dialog.classList.remove('hidden');
    dialog.classList.add('flex');
    document.body.style.overflow = 'hidden';
}
                        // Dialog control
                        const createPostBtn = document.querySelector('button:has(.ri-add-line)');
                        const createPostDialog = document.getElementById('createPostDialog');

                        createPostBtn.addEventListener('click', () => {
                            createPostDialog.classList.remove('hidden');
                            createPostDialog.classList.add('flex');
                            document.body.style.overflow = 'hidden';
                        });

                        function closeCreatePostDialog() {
                            const dialog = document.getElementById('createPostDialog');
                            dialog.classList.remove('flex');
                            dialog.classList.add('hidden');
                            document.body.style.overflow = 'auto';

                            // Reset form và các mảng file
                            const form = document.getElementById('postForm');
                            form.reset();
                            removeAllImages();
                            removeAllVideos();
                            selectedImageFiles = [];
                            selectedVideoFiles = [];

                            // Đặt lại các input ẩn
                            document.getElementById('existingImages').value = '';
                            document.getElementById('existingVideos').value = '';
                            document.getElementById('removedImages').value = '';
                            document.getElementById('removedVideos').value = '';
                            document.getElementById('formAction').value = 'create';
                            document.getElementById('postId').value = '';
                            document.getElementById('submitButton').textContent = 'Đăng Bài';
                        }
                        
                          // Modal thông báo bài viết đang chờ duyệt
            function showPendingPostModal() {
                const modal = document.getElementById('pendingPostModal');
                modal.classList.remove('hidden');
                modal.classList.add('flex');
                document.body.style.overflow = 'hidden';
            }

            function closePendingPostModal() {
                const modal = document.getElementById('pendingPostModal');
                modal.classList.remove('flex');
                modal.classList.add('hidden');
                document.body.style.overflow = 'auto';
            }

                        createPostDialog.addEventListener('click', (e) => {
                            if (e.target === createPostDialog) {
                                closeCreatePostDialog();
                            }
                        });

                        // Biến để lưu trữ files đã chọn
                        let selectedImageFiles = [];
                        let selectedVideoFiles = [];

                        // Image preview function
                        function previewImages(event) {
                            const container = document.getElementById('imagePreviewContainer');
                            const gridContainer = container.querySelector('div');
                            const files = event.target.files;
                            gridContainer.innerHTML = '';
                            selectedImageFiles = Array.from(files);
                            if (files.length > 0) {
                                container.classList.remove('hidden');
                                selectedImageFiles.forEach((file, index) => {
                                    const previewDiv = document.createElement('div');
                                    previewDiv.className = 'relative flex-shrink-0 w-[200px] aspect-square';
                                    const img = document.createElement('img');
                                    img.className = 'w-full h-full object-cover rounded-lg';
                                    const reader = new FileReader();
                                    reader.onload = function (e) {
                                        img.src = e.target.result;
                                    };
                                    reader.readAsDataURL(file);
                                    const removeButton = document.createElement('button');
                                    removeButton.type = 'button';
                                    removeButton.className = 'absolute top-2 right-2 w-8 h-8 bg-gray-800 bg-opacity-50 text-white rounded-full flex items-center justify-center hover:bg-opacity-70';
                                    removeButton.innerHTML = '<i class="ri-close-line"></i>';
                                    removeButton.onclick = function () {
                                        selectedImageFiles = selectedImageFiles.filter((_, i) => i !== index);
                                        previewDiv.remove();
                                        if (gridContainer.children.length === 0) {
                                            container.classList.add('hidden');
                                        }
                                        updateFileInput();
                                    };
                                    previewDiv.appendChild(img);
                                    previewDiv.appendChild(removeButton);
                                    gridContainer.appendChild(previewDiv);
                                });
                            } else {
                                container.classList.add('hidden');
                            }
                            updateFileInput();
                        }


                        function updateFileInput() {
                            const imageInput = document.getElementById('imageInput');
                            const dataTransfer = new DataTransfer();
                            selectedImageFiles.forEach(file => dataTransfer.items.add(file));
                            imageInput.files = dataTransfer.files;
                        }

                        // Video preview function
                        function previewVideos(event) {
                            const container = document.getElementById('videoPreviewContainer');
                            const gridContainer = container.querySelector('div');
                            const files = event.target.files;
                            gridContainer.innerHTML = '';
                            selectedVideoFiles = Array.from(files);
                            if (files.length > 0) {
                                container.classList.remove('hidden');
                                selectedVideoFiles.forEach((file, index) => {
                                    const videoURL = URL.createObjectURL(file);
                                    const previewDiv = document.createElement('div');
                                    previewDiv.className = 'relative flex-shrink-0 w-[400px]';
                                    const videoWrapper = document.createElement('div');
                                    videoWrapper.className = 'aspect-video rounded-lg bg-black overflow-hidden';
                                    const video = document.createElement('video');
                                    video.className = 'w-full h-full object-contain';
                                    video.controls = true;
                                    video.src = videoURL;
                                    const removeButton = document.createElement('button');
                                    removeButton.type = 'button';
                                    removeButton.className = 'absolute top-2 right-2 w-8 h-8 bg-gray-800 bg-opacity-50 text-white rounded-full flex items-center justify-center hover:bg-opacity-70';
                                    removeButton.innerHTML = '<i class="ri-close-line"></i>';
                                    removeButton.onclick = function () {
                                        selectedVideoFiles.splice(index, 1);
                                        URL.revokeObjectURL(videoURL);
                                        previewDiv.remove();
                                        if (gridContainer.children.length === 0) {
                                            container.classList.add('hidden');
                                        }
                                        updateVideoInput();
                                    };
                                    videoWrapper.appendChild(video);
                                    previewDiv.appendChild(videoWrapper);
                                    previewDiv.appendChild(removeButton);
                                    gridContainer.appendChild(previewDiv);
                                });
                            } else {
                                container.classList.add('hidden');
                            }
                            updateVideoInput();
                        }


                        function updateVideoInput() {
                            const videoInput = document.getElementById('videoInput');
                            const dataTransfer = new DataTransfer();
                            selectedVideoFiles.forEach(file => dataTransfer.items.add(file));
                            videoInput.files = dataTransfer.files;
                        }


                        // Function to remove all images

                        function removeAllImages() {
                            selectedImageFiles = [];
                            const container = document.getElementById('imagePreviewContainer');
                            const gridContainer = container.querySelector('div');
                            gridContainer.innerHTML = '';
                            container.classList.add('hidden');
                            document.getElementById('imageInput').value = '';
                        }


                        // Function to remove all videos

                        function removeAllVideos() {
                            const container = document.getElementById('videoPreviewContainer');
                            const gridContainer = container.querySelector('div');
                            const videos = gridContainer.querySelectorAll('video');
                            videos.forEach(video => {
                                URL.revokeObjectURL(video.src);
                            });
                            selectedVideoFiles = [];
                            gridContainer.innerHTML = '';
                            container.classList.add('hidden');
                            document.getElementById('videoInput').value = '';
                        }

                        // Add event listeners
                        document.getElementById('imageInput').addEventListener('change', previewImages);
                        document.getElementById('videoInput').addEventListener('change', previewVideos);

                        // Validate form before submission
                        function validatePostForm(form) {
                            const topicInput = form.querySelector('input[name="topic"]');
                            const titleInput = form.querySelector('textarea[name="title"]');
                            const contentInput = form.querySelector('textarea[name="content"]');
                            let isValid = true;
                            let errorMessage = '';


                            [topicInput, titleInput, contentInput].forEach(input => {
                                input.classList.remove('border-red-500');
                                const errorDiv = input.nextElementSibling;
                                if (errorDiv && errorDiv.classList.contains('error-message')) {
                                    errorDiv.remove();
                                }
                            });


                            if (!topicInput.value.trim()) {
                                isValid = false;
                                errorMessage += 'Vui lòng nhập chủ đề.\n';
                                topicInput.classList.add('border-red-500');
                                topicInput.insertAdjacentHTML('afterend', '<div class="error-message text-red-500 text-xs mt-1">Vui lòng nhập chủ đề</div>');
                            }


                            if (!titleInput.value.trim()) {
                                isValid = false;
                                errorMessage += 'Vui lòng nhập tiêu đề.\n';
                                titleInput.classList.add('border-red-500');
                                titleInput.insertAdjacentHTML('afterend', '<div class="error-message text-red-500 text-xs mt-1">Vui lòng nhập tiêu đề</div>');
                            }


                            if (!contentInput.value.trim()) {
                                isValid = false;
                                errorMessage += 'Vui lòng nhập nội dung.\n';
                                contentInput.classList.add('border-red-500');
                                contentInput.insertAdjacentHTML('afterend', '<div class="error-message text-red-500 text-xs mt-1">Vui lòng nhập nội dung</div>');
                            }




                            if (!isValid) {
                                alert(errorMessage);
                            }

                            return isValid;
                        }


                        document.querySelector('#postForm').addEventListener('submit', function (event) {
                            event.preventDefault();

                           if (validatePostForm(this)) {
                    const formData = new FormData(this);
                    
                    // Disable submit button to prevent double submission
                    const submitButton = document.getElementById('submitButton');
                    const originalText = submitButton.textContent;
                    submitButton.disabled = true;
                    submitButton.textContent = 'Đang đăng...';

                    fetch('PostServlet', {
                        method: 'POST',
                        body: formData
                    })
                    .then(response => response.text())
                    .then(result => {
                        // Re-enable submit button
                        submitButton.disabled = false;
                        submitButton.textContent = originalText;

                        if (result.trim() === 'success' || result.includes('success')) {
                            // Đóng dialog tạo bài viết
                            closeCreatePostDialog();
                            
                            // Kiểm tra action để xử lý khác nhau
                            const action = formData.get('action');
                            const postId = formData.get('postId');
                            
                            if (action === 'edit' || action === 'repost') {
                                // Nếu là edit/repost, chỉ reload nhanh và scroll đến bài viết
                                window.location.href = 'NewFeed#post-' + postId;
                                setTimeout(() => {
                                    window.location.reload();
                                }, 500);
                            } else {
                                // Nếu là tạo mới, hiển thị modal thông báo và reload sau 2 giây
                                showPendingPostModal();
                                setTimeout(() => {
                                    window.location.reload();
                                }, 2000);
                            }
                        } else {
                            alert('Có lỗi xảy ra khi đăng bài. Vui lòng thử lại.');
                        }
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        submitButton.disabled = false;
                        submitButton.textContent = originalText;
                        alert('Có lỗi xảy ra khi đăng bài. Vui lòng thử lại.');
                    });
                }
                        });

                        // Image modal functions
                        const imageModal = document.getElementById('imageModal');
                        const modalImage = document.getElementById('modalImage');

                        function openImageModal(src) {
                            modalImage.src = src;
                            imageModal.classList.remove('hidden');
                            imageModal.classList.add('flex');
                            document.body.style.overflow = 'hidden';
                        }

                        function closeImageModal() {
                            imageModal.classList.remove('flex');
                            imageModal.classList.add('hidden');
                            document.body.style.overflow = 'auto';
                        }

                        // Add click event to images for modal preview
                        document.querySelectorAll('img[alt="Post image"]').forEach(img => {
                            img.addEventListener('click', function () {
                                openImageModal(this.src);
                            });
                        });

                        // Search functionality
                        const searchInput = document.getElementById('searchInput');

                        searchInput.addEventListener('keyup', function (e) {
                            if (e.key === 'Enter') {
                                const searchTerm = this.value.trim();
                                if (searchTerm) {
                                    window.location.assign('NewFeed?topic=' + encodeURIComponent(searchTerm));
                                } else {
                                    window.location.assign('NewFeed');
                                }
                            }
                        });

                        // Tab functionality
                        const allPostsBtn = document.getElementById('allPostsBtn');
                        allPostsBtn.addEventListener('click', function () {
                            window.location.href = 'NewFeed';
                        });

                        // Initialize "Read More" buttons
                        function initReadMore() {
                            document.querySelectorAll('.content-wrapper').forEach(wrapper => {
                                const content = wrapper.querySelector('.content-text');
                                const button = wrapper.querySelector('.read-more-btn');
                                const fade = wrapper.querySelector('.read-more-fade');



                                content.style.removeProperty('max-height');



                                const needsReadMore = content.scrollHeight > 150;

                                button.style.display = needsReadMore ? 'inline-block' : 'none';
                                fade.style.display = needsReadMore ? 'block' : 'none';

                                if (!needsReadMore) {
                                    content.setAttribute('data-expanded', 'true');
                                }
                            });
                        }

                        function toggleContent(button) {
                            const wrapper = button.closest('.content-wrapper');
                            const content = wrapper.querySelector('.content-text');
                            const fade = wrapper.querySelector('.read-more-fade');
                            const isExpanded = content.getAttribute('data-expanded') === 'true';

                            if (!isExpanded) {
                                content.setAttribute('data-expanded', 'true');
                                button.textContent = 'Thu gọn';
                                fade.style.display = 'none';
                            } else {
                                content.setAttribute('data-expanded', 'false');
                                button.textContent = 'Xem thêm';
                                fade.style.display = 'block';
                            }
                        }

                        // Load more comments function
                        function loadMoreComments(button) {
                            const postId = button.getAttribute('data-post-id');
                            const commentsContainer = button.closest('.comments-container');
                            const hiddenComments = commentsContainer.querySelectorAll('.comment-item.hidden');
                            const commentCount = commentsContainer.querySelectorAll('.comment-item').length;

                            // Hiển thị tất cả bình luận ẩn
                            hiddenComments.forEach(comment => {
                                comment.classList.remove('hidden');
                            });

                            // Thay thế nút "Xem thêm" bằng nút "Thu gọn"
                            const collapseButton = document.createElement('button');
                            collapseButton.className = 'collapse-comments text-primary text-sm font-medium hover:underline';
                            collapseButton.textContent = 'Thu gọn';
                            collapseButton.onclick = function () {
                                collapseComments(this, postId, commentCount);
                            };

                            const buttonContainer = button.parentElement;
                            buttonContainer.innerHTML = '';
                            buttonContainer.appendChild(collapseButton);
                        }

                        function collapseComments(button, postId, commentCount) {
                            const commentsContainer = button.closest('.comments-container');
                            const allComments = Array.from(commentsContainer.querySelectorAll('.comment-item'));

                            // Hiển thị 2 bình luận mới nhất, ẩn các bình luận còn lại
                            allComments.forEach((comment, index) => {
                                if (index < 2) {
                                    comment.classList.remove('hidden');
                                } else {
                                    comment.classList.add('hidden');
                                }
                            });

                            // Thay thế nút "Thu gọn" bằng nút "Xem thêm"
                            const loadMoreButton = document.createElement('button');
                            loadMoreButton.className = 'load-more-comments text-primary text-sm font-medium hover:underline';
                            loadMoreButton.setAttribute('data-post-id', postId);
                            loadMoreButton.textContent = `Xem thêm bình luận`;
                            loadMoreButton.onclick = function () {
                                loadMoreComments(this);
                            };

                            const buttonContainer = button.parentElement;
                            buttonContainer.innerHTML = '';
                            buttonContainer.appendChild(loadMoreButton);
                        }

                        // Toggle Like
                        function toggleLike(postId, button) {
                        <% if (currentUser == null) { %>
                            window.location.href = 'Login.jsp';
                            return;
                        <% } %>

                            const userId = <%= currentUser != null ? currentUser.getUserId() : 0 %>;
                            const xhr = new XMLHttpRequest();
                            xhr.open('POST', 'like', true);
                            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');

                            xhr.onreadystatechange = function () {
                                if (xhr.readyState === 4 && xhr.status === 200) {
                                    const response = xhr.responseText.trim();
                                    if (response === 'liked' || response === 'unliked') {
                                        const heartIcon = button.querySelector('i');
                                        const likeCountSpan = button.querySelector('.like-count');
                                        let likeCount = parseInt(likeCountSpan.textContent);

                                        if (response === 'liked') {
                                            heartIcon.classList.remove('ri-heart-line');
                                            heartIcon.classList.add('ri-heart-fill', 'text-primary');
                                            likeCountSpan.textContent = (likeCount + 1) + ' Thích';
                                        } else {
                                            heartIcon.classList.remove('ri-heart-fill', 'text-primary');
                                            heartIcon.classList.add('ri-heart-line');
                                            likeCountSpan.textContent = (likeCount - 1) + ' Thích';
                                        }
                                    } else if (response === 'login_required') {
                                        window.location.href = 'Login.jsp';
                                    }
                                }
                            };

                            xhr.send('postId=' + postId + '&userId=' + userId);
                        }

                        // Submit Comment
                        function submitComment(event, postId, form) {
                            event.preventDefault();

                        <% if (currentUser == null) { %>
                            window.location.href = 'Login.jsp';
                            return;
                        <% } %>

                            const userId = <%= currentUser != null ? currentUser.getUserId() : 0 %>;
                            const content = form.querySelector('input[name="content"]').value.trim();

                            if (!content) {
                                return;
                            }

                            const xhr = new XMLHttpRequest();
                            xhr.open('POST', 'comment', true);
                            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');

                            xhr.onreadystatechange = function () {
                                if (xhr.readyState === 4 && xhr.status === 200) {
                                    const response = xhr.responseText.trim();
                                    if (response === 'success') {

                                        // Reload page with post ID as hash

                                        window.location.href = `NewFeed#post-${postId}`;
                                        window.location.reload();
                                    } else if (response === 'login_required') {
                                        window.location.href = 'Login.jsp';
                                    } else {
                                        alert('Không thể đăng bình luận. Vui lòng thử lại.');
                                    }
                                }
                            };

                            xhr.send('postId=' + postId + '&userId=' + userId + '&content=' + encodeURIComponent(content));
                        }



                        document.addEventListener('DOMContentLoaded', initReadMore);



                        window.addEventListener('load', () => {
                            setTimeout(initReadMore, 500);
                        });


                        window.addEventListener('resize', () => {
                            setTimeout(initReadMore, 100);
                        });


                        // Add this to your existing DOMContentLoaded event listener
                        document.addEventListener('DOMContentLoaded', function () {

                            if (window.location.hash) {
                                const postId = window.location.hash;
                                const post = document.querySelector(postId);
                                if (post) {


                                    post.scrollIntoView({behavior: 'smooth', block: 'center'});


                                    post.classList.add('bg-blue-50');
                                    setTimeout(() => {
                                        post.classList.remove('bg-blue-50');
                                    }, 2000);
                                }
                            }
                        });

                        // reload lại phần thích
                        function toggleCommentLike(id, type, button) {
                        <% if (currentUser == null) { %>
                            window.location.href = 'Login.jsp';
                            return;
                        <% } %>
                            const userId = <%= currentUser != null ? currentUser.getUserId() : 0 %>;
                            const xhr = new XMLHttpRequest();
                            xhr.open('POST', 'comment-like', true);
                            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                            xhr.onreadystatechange = function () {
                                if (xhr.readyState === 4 && xhr.status === 200) {
                                    const response = xhr.responseText.trim();
                                    const icon = button.querySelector('i');
                                    const countSpan = button.querySelector('.comment-like-count');
                                    let count = parseInt(countSpan.textContent);
                                    if (response === 'liked') {
                                        icon.classList.remove('ri-heart-line');
                                        icon.classList.add('ri-heart-fill', 'text-primary');
                                        countSpan.textContent = count + 1;
                                    } else if (response === 'unliked') {
                                        icon.classList.remove('ri-heart-fill', 'text-primary');
                                        icon.classList.add('ri-heart-line');
                                        countSpan.textContent = count - 1;
                                    }
                                }
                            };
                            xhr.send('id=' + id + '&type=' + type + '&userId=' + userId);
                        }

                        //  reload lại phần thích
                        function toggleReplyLike(replyId, button) {
                        <% if (currentUser == null) { %>
                            window.location.href = 'Login.jsp';
                            return;
                        <% } %>
                            const userId = <%= currentUser != null ? currentUser.getUserId() : 0 %>;
                            const xhr = new XMLHttpRequest();
                            xhr.open('POST', 'reply-like', true);
                            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                            xhr.onreadystatechange = function () {
                                if (xhr.readyState === 4 && xhr.status === 200) {
                                    const response = xhr.responseText.trim();
                                    const icon = button.querySelector('i');
                                    const countSpan = button.querySelector('.reply-like-count');
                                    let count = parseInt(countSpan.textContent);
                                    if (response === 'liked') {
                                        icon.classList.remove('ri-heart-line');
                                        icon.classList.add('ri-heart-fill', 'text-primary');
                                        countSpan.textContent = count + 1;
                                    } else if (response === 'unliked') {
                                        icon.classList.remove('ri-heart-fill', 'text-primary');
                                        icon.classList.add('ri-heart-line');
                                        countSpan.textContent = count - 1;
                                    }
                                }
                            };
                            xhr.send('replyId=' + replyId + '&userId=' + userId);
                        }
                        // hiển thị form phản hồi 
                        function toggleReplyForm(commentId) {
                            var form = document.getElementById('reply-form-' + commentId);
                            if (form) {
                                form.classList.toggle('hidden');
                                if (!form.classList.contains('hidden')) {
                                    form.querySelector('input[name="content"]').focus();
                                }
                            }
                        }
                        //
                        function deleteComment(commentId, postOwnerId, commentOwnerId, btn) {
                            if (!confirm('Bạn có chắc muốn xóa bình luận này?'))
                                return;
                            const commentItem = btn.closest('.comment-item');
                            const commentsContainer = commentItem.closest('.comments-container');
                            const postId = commentsContainer.getAttribute('data-post-id');

                            const xhr = new XMLHttpRequest();
                            xhr.open('POST', 'delete-comment', true);
                            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                            xhr.onreadystatechange = function () {
                                if (xhr.readyState === 4 && xhr.status === 200) {
                                    if (xhr.responseText.trim() === 'success') {
                                        commentItem.remove();
                                        window.location.href = `NewFeed#post-${postId}`;
                                        window.location.reload();



                                    } else {
                                        alert('Không thể xóa bình luận!');
                                    }
                                }
                            };
                            xhr.send('commentId=' + commentId + '&postOwnerId=' + postOwnerId + '&commentOwnerId=' + commentOwnerId);
                        }



                        function editComment(commentId, postOwnerId, commentOwnerId, btn) {
                            const commentItem = btn.closest('.comment-item');
                            const contentSpan = commentItem.querySelector('.comment-content');
                            const oldContent = contentSpan.textContent;
                            const input = document.createElement('input');
                            input.type = 'text';
                            input.value = oldContent;
                            input.className = 'border px-2 py-1 rounded text-sm';
                            contentSpan.replaceWith(input);
                            btn.textContent = 'Lưu';
                            btn.onclick = function () {
                                const newContent = input.value.trim();
                                if (!newContent)
                                    return alert('Nội dung không được để trống!');

                                const xhr = new XMLHttpRequest();
                                xhr.open('POST', 'edit-comment', true);
                                xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                                xhr.onreadystatechange = function () {
                                    if (xhr.readyState === 4 && xhr.status === 200) {
                                        if (xhr.responseText.trim() === 'success') {
                                            const span = document.createElement('span');
                                            span.className = 'comment-content';
                                            span.textContent = newContent;
                                            input.replaceWith(span);
                                            btn.textContent = 'Sửa';
                                            btn.onclick = function () {
                                                editComment(commentId, btn);
                                            };
                                        } else {
                                            alert('Không thể cập nhật bình luận!');
                                        }
                                    }
                                };
                                xhr.send('commentId=' + commentId + '&content=' + encodeURIComponent(newContent) + '&commentOwnerId=' + commentOwnerId);
                            };
                        }

                        function deletePost(postId, btn) {
                            if (!confirm('Bạn có chắc muốn xóa bài viết này?'))
                                return;
                            const xhr = new XMLHttpRequest();
                            xhr.open('POST', 'delete-post', true);
                            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                            xhr.onreadystatechange = function () {
                                if (xhr.readyState === 4 && xhr.status === 200) {
                                    if (xhr.responseText.trim() === 'success') {
                                        const postDiv = document.getElementById('post-' + postId);
                                        if (postDiv)
                                            postDiv.remove();

                                        window.location.reload();
                                    } else {
                                        alert('Không thể xóa bài viết!');
                                    }
                                }
                            };
                            xhr.send('postId=' + postId);
                        }

                        function editPost(postId, btn, isRejected = false) {
                            const postDiv = document.getElementById('post-' + postId);
                            const topic = postDiv.querySelector('.topic').textContent.trim();
                            const title = postDiv.querySelector('p.font-bold').textContent.trim();
                            const content = postDiv.querySelector('.content-text').textContent.trim();
                           const mediaContainer = postDiv.querySelector('.mb-4 .grid'); // hoặc class/selector đúng với container media
                          let images = [];
                           let videos = [];
                        if (mediaContainer) {
               images = Array.from(mediaContainer.querySelectorAll('img[alt="Post image"]')).map(img => img.src.split('/').pop());
                 videos = Array.from(mediaContainer.querySelectorAll('video source')).map(source => source.src.split('/').pop());
}

                            // Reset form and clear previous data
                            const form = document.getElementById('postForm');
                            form.reset(); // Reset toàn bộ form để xóa dữ liệu cũ
                            form.querySelector('input[name="action"]').value = isRejected ? 'repost' : 'edit';
                            form.querySelector('input[name="postId"]').value = postId;
                            form.querySelector('input[name="topic"]').value = topic;
                            form.querySelector('textarea[name="title"]').value = title;
                            form.querySelector('textarea[name="content"]').value = content;

                            // Update button text
                            const submitButton = form.querySelector('button[type="submit"]');
                            submitButton.textContent = isRejected ? 'Đăng Lại' : 'Cập Nhật';

                            // Clear existing previews and reset file arrays
                            removeAllImages();
                            removeAllVideos();
                            selectedImageFiles = []; // Reset mảng chứa file ảnh
                            selectedVideoFiles = []; // Reset mảng chứa file video

                            // Populate image previews
                            const imageContainer = document.getElementById('imagePreviewContainer');
                            const imageGrid = imageContainer.querySelector('div');
                            imageGrid.innerHTML = ''; // Clear previous previews

                            if (images.length > 0) {
                                imageContainer.classList.remove('hidden');
                                images.forEach((image, index) => {
                                    const previewDiv = document.createElement('div');
                                    previewDiv.className = 'relative flex-shrink-0 w-[200px] aspect-square';
                                    const img = document.createElement('img');
                                    img.className = 'w-full h-full object-cover rounded-lg';
                                    img.src = 'assets/img/post/' + image;

                                    const removeButton = document.createElement('button');
                                    removeButton.type = 'button';
                                    removeButton.className = 'absolute top-2 right-2 w-8 h-8 bg-gray-800 bg-opacity-50 text-white rounded-full flex items-center justify-center hover:bg-opacity-70';
                                    removeButton.innerHTML = '<i class="ri-close-line"></i>';
                                    removeButton.onclick = function () {
                                        previewDiv.remove();
                                        if (imageGrid.children.length === 0) {
                                            imageContainer.classList.add('hidden');
                                        }
                                        updateRemovedImagesInput(image);
                                        // Cập nhật lại existingImages sau khi xóa
                                        const remainingImages = images.filter((_, i) => i !== index);
                                        document.getElementById('existingImages').value = remainingImages.join(',');
                                    };

                                    previewDiv.appendChild(img);
                                    previewDiv.appendChild(removeButton);
                                    imageGrid.appendChild(previewDiv);
                                });
                            }

                            // Populate video previews
                            const videoContainer = document.getElementById('videoPreviewContainer');
                            const videoGrid = videoContainer.querySelector('div');
                            videoGrid.innerHTML = ''; // Clear previous previews

                            if (videos.length > 0) {
                                videoContainer.classList.remove('hidden');
                                videos.forEach((video, index) => {
                                    const previewDiv = document.createElement('div');
                                    previewDiv.className = 'relative flex-shrink-0 w-[400px]';
                                    const videoWrapper = document.createElement('div');
                                    videoWrapper.className = 'aspect-video rounded-lg bg-black overflow-hidden';
                                    const vid = document.createElement('video');
                                    vid.className = 'w-full h-full object-contain';
                                    vid.controls = true;
                                    const source = document.createElement('source');
                                    source.src = 'assets/video/post/' + video;
                                    source.type = 'video/mp4';
                                    vid.appendChild(source);

                                    const removeButton = document.createElement('button');
                                    removeButton.type = 'button';
                                    removeButton.className = 'absolute top-2 right-2 w-8 h-8 bg-gray-800 bg-opacity-50 text-white rounded-full flex items-center justify-center hover:bg-opacity-70';
                                    removeButton.innerHTML = '<i class="ri-close-line"></i>';
                                    removeButton.onclick = function () {
                                        previewDiv.remove();
                                        if (videoGrid.children.length === 0) {
                                            videoContainer.classList.add('hidden');
                                        }
                                        updateRemovedVideosInput(video);
                                        // Cập nhật lại existingVideos sau khi xóa
                                        const remainingVideos = videos.filter((_, i) => i !== index);
                                        document.getElementById('existingVideos').value = remainingVideos.join(',');
                                    };

                                    videoWrapper.appendChild(vid);
                                    previewDiv.appendChild(videoWrapper);
                                    previewDiv.appendChild(removeButton);
                                    videoGrid.appendChild(previewDiv);
                                });
                            }

                            // Initialize hidden inputs with current post data
                            document.getElementById('existingImages').value = images.join(',');
                            document.getElementById('existingVideos').value = videos.join(',');
                            document.getElementById('removedImages').value = '';
                            document.getElementById('removedVideos').value = '';

                            // Show dialog
                            const dialog = document.getElementById('createPostDialog');
                            dialog.classList.remove('hidden');
                            dialog.classList.add('flex');
                            document.body.style.overflow = 'hidden';
                        }


                        // Helper function to update removed images input
                        function updateRemovedImagesInput(image) {
                            const form = document.getElementById('postForm');
                            const removedImagesInput = form.querySelector('input[name="removedImages"]');
                            const removedImages = removedImagesInput.value ? removedImagesInput.value.split(',') : [];
                            removedImages.push(image);
                            removedImagesInput.value = removedImages.join(',');
                        }

                        // Helper function to update removed videos input
                        function updateRemovedVideosInput(video) {
                            const form = document.getElementById('postForm');
                            const removedVideosInput = form.querySelector('input[name="removedVideos"]');
                            const removedVideos = removedVideosInput.value ? removedVideosInput.value.split(',') : [];
                            removedVideos.push(video);
                            removedVideosInput.value = removedVideos.join(',');
                        }

                        function toggleSavePost(postId, btn) {
                        <% if (currentUser == null) { %>
                            window.location.href = 'Login.jsp';
                            return;
                        <% } %>
                            const userId = <%= currentUser != null ? currentUser.getUserId() : 0 %>;
                            const icon = btn.querySelector('i');
                            const span = btn.querySelector('span');
                            const isSaved = icon.classList.contains('ri-bookmark-fill');
                            const action = isSaved ? 'unsave' : 'save';

                            const xhr = new XMLHttpRequest();
                            xhr.open('POST', 'save-post', true);
                            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                            xhr.onreadystatechange = function () {
                                if (xhr.readyState === 4 && xhr.status === 200) {
                                    if (xhr.responseText.trim() === 'success') {
                                        if (action === 'save') {
                                            icon.classList.remove('ri-bookmark-line');
                                            icon.classList.add('ri-bookmark-fill', 'text-primary');
                                            span.textContent = 'Đã lưu';
                                        } else {
                                            icon.classList.remove('ri-bookmark-fill', 'text-primary');
                                            icon.classList.add('ri-bookmark-line');
                                            span.textContent = 'Lưu';
                                            window.location.reload();
                                        }
                                    } else {
                                        alert('Không thể lưu bài viết!');
                                    }
                                }
                            };
                            xhr.send('userId=' + userId + '&postId=' + postId + '&action=' + action);
                        }

                        document.getElementById('savedPostsBtn').addEventListener('click', function () {
                            window.location.href = 'NewFeed?tab=saved';
                        });

                        document.getElementById('myPostsBtn').addEventListener('click', function () {
                            window.location.href = 'NewFeed?tab=my';
                        });
                        document.getElementById('rejectedPostsBtn').addEventListener('click', function () {
                            window.location.href = 'NewFeed?tab=rejected';
                        });


                        const bell = document.getElementById("notificationBell");
                        const dropdown = document.getElementById("notificationDropdown");

                        bell.addEventListener("click", function (event) {
                            event.stopPropagation();
                            dropdown.classList.toggle("hidden");
                            if (!dropdown.classList.contains("hidden")) {
                                // Mark notifications as read
                                fetch('mark-notifications-read', { method: 'POST' })
                                    .then(res => res.text())
                                    .then(result => {
                                        if (result === 'success') {
                                            // Hide or update the notification badge
                                            const badge = bell.parentElement.querySelector('span');
                                            if (badge) badge.style.display = 'none';
                                        }
                                    });
                            }
                        });

                        document.addEventListener("click", function (event) {
                            const isClickInside = bell.contains(event.target) || dropdown.contains(event.target);
                            if (!isClickInside) {
                                dropdown.classList.add("hidden");
                            }
                        });







                    </script>

                    </body>
                    </html>

                    // doneeee


