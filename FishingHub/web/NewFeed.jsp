<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Post"%>
<%@page import="dal.PostDAO"%>
<<<<<<< HEAD
<%@page import="dal.UserDao"%>
<%@page import="model.Users"%>
<%@page import="model.PostComment"%>
<%@page import="dal.PostCommentDAO"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@page import="java.util.Date"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="dal.PostLikeDAO"%>
<%@page import="dal.CommentLikeDAO"%>



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
=======
<%@ page import="java.text.SimpleDateFormat" %>



>>>>>>> origin/NgocDung
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bảng Tin</title>
    <script src="https://cdn.tailwindcss.com/3.4.16"></script>
<<<<<<< HEAD
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
=======
    <script>tailwind.config = {theme: {extend: {colors: {primary: '#1E88E5', secondary: '#FFA726'}, borderRadius: {'none': '0px', 'sm': '4px', DEFAULT: '8px', 'md': '12px', 'lg': '16px', 'xl': '20px', '2xl': '24px', '3xl': '32px', 'full': '9999px', 'button': '8px'}}}}</script>
>>>>>>> origin/NgocDung
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.6.0/remixicon.min.css">
<<<<<<< HEAD
    <link rel="stylesheet" href="assets/css/style.css">
 
</head>
<body>
   

=======
      <link rel="stylesheet" href="assets/css/style.css">
</head>
<body>
>>>>>>> origin/NgocDung
    <!-- Header -->
    <header class="bg-white shadow-sm">
        <div class="container mx-auto px-4 py-3 flex items-center justify-between">
            <div class="flex items-center">
                <a href="Home.jsp" class="text-3xl font-['Pacifico'] text-primary">FishingHub</a>
<<<<<<< HEAD

=======
                <!-- Header navigation links -->
>>>>>>> origin/NgocDung
                 <nav class="hidden md:flex ml-10">
            <a href="Home.jsp" class="px-4 py-2 text-gray-800 font-medium hover:text-primary">Trang Chủ</a>
            <a href="Event.jsp" class="px-4 py-2 text-gray-800 font-medium hover:text-primary">Sự Kiện</a>
            <a href="NewFeed.jsp" class="px-4 py-2 text-gray-800 font-medium hover:text-primary">Bảng Tin</a>
            <a href="Product.jsp" class="px-4 py-2 text-gray-800 font-medium hover:text-primary">Cửa Hàng</a>
            <a href="KnowledgeFish" class="px-4 py-2 text-gray-800 font-medium hover:text-primary">Kiến Thức</a>
            <a href="Achievement.jsp" class="px-4 py-2 text-gray-800 font-medium hover:text-primary">Xếp Hạng</a>
        </nav>
            </div>

            <div class="flex items-center space-x-4">
<<<<<<< HEAD

=======
                <!-- Cart -->
>>>>>>> origin/NgocDung
                <div class="relative w-10 h-10 flex items-center justify-center">
                    <button class="text-gray-700 hover:text-primary">
                        <i class="ri-shopping-cart-2-line text-xl"></i>
                    </button>
                    <span
                        class="absolute -top-1 -right-1 bg-red-500 text-white text-xs w-5 h-5 flex items-center justify-center rounded-full"
                        >3</span
                    >
                </div>
                <div class="relative">
                    <div class="w-10 h-10 flex items-center justify-center rounded-full bg-gray-100 cursor-pointer">
                        <i class="ri-notification-3-line text-gray-600"></i>
                    </div>
                    <span class="absolute -top-1 -right-1 flex h-5 w-5 items-center justify-center rounded-full bg-primary text-xs text-white">3</span>
                </div>

<<<<<<< HEAD
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
=======
                <button class="bg-primary text-white px-4 py-2 rounded-button whitespace-nowrap">Đăng Nhập</button>
        <button class="bg-white text-primary border border-primary px-4 py-2 rounded-button whitespace-nowrap">Đăng Ký</button>
            </div>
>>>>>>> origin/NgocDung
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
<<<<<<< HEAD
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

=======
                    <div class="relative">
                        <input type="text" placeholder="Tìm kiếm bài viết..." class="w-full md:w-80 pl-10 pr-4 py-2 rounded-button border-none bg-white shadow-sm focus:ring-2 focus:ring-primary focus:outline-none text-sm">
                        <div class="absolute left-3 top-1/2 transform -translate-y-1/2 w-5 h-5 flex items-center justify-center text-gray-400">
                            <i class="ri-search-line"></i>
                        </div>
                    </div>
>>>>>>> origin/NgocDung
                    <button class="bg-primary text-white px-6 py-2 rounded-button whitespace-nowrap flex items-center gap-2" onclick="openCreatePostDialog()">
                        <i class="ri-add-line"></i>
                        <span>Tạo Bài Viết Mới</span>
                    </button>
                </div>
            </div>

<<<<<<< HEAD

          
            <div class="bg-white rounded shadow-sm mb-8">
    <div class="flex border-b border-gray-200">
        <button id="allPostsBtn" class="tab-button active px-6 py-4 text-primary font-medium">Tất Cả Bài Viết</button>
<button id="savedPostsBtn" class="tab-button active px-6 py-4 text-gray-600 font-medium hover:text-primary">Đã Lưu</button>
<button id="myPostsBtn" class="tab-button active px-6 py-4 text-gray-600 font-medium hover:text-primary">Bài Viết Của Tôi</button>    </div>

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
    } else if (searchTopic != null && !searchTopic.trim().isEmpty()) {
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
    <div class="content-text whitespace-pre-wrap" data-expanded="false">
        <%= post.getContent()%>
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
=======
            <!-- Filters and Tabs -->
            <div class="bg-white rounded shadow-sm mb-8">
                <div class="flex border-b border-gray-200">
                    <button class="tab-button active px-6 py-4 text-primary font-medium">Tất Cả Bài Viết</button>
                    <button class="tab-button px-6 py-4 text-gray-600 font-medium hover:text-primary">Đã Lưu</button>
                    <button class="tab-button px-6 py-4 text-gray-600 font-medium hover:text-primary">Bài Viết Của Tôi</button>
                </div>
            </div>

 <!-- Posts List -->
                <div class="space-y-6">
    <% 
        PostDAO postDAO = new PostDAO();
        List<Post> posts = postDAO.getAllPosts();
        SimpleDateFormat sdf = new SimpleDateFormat("MMM dd, yyyy HH:mm");
        
        for(Post post : posts) {
    %>
    <div class="bg-white rounded-lg shadow-sm p-6">
        <!-- Post Header -->
        <div class="flex items-start justify-between mb-4">
            <div class="flex items-center gap-3">
                <div class="w-10 h-10 rounded-full bg-gray-200"></div>
                <div>
                    <p class="font-medium">User <%= post.getUserId() %></p>
                    <p class="text-sm text-gray-500"><%= sdf.format(post.getCreatedAt()) %></p>
                </div>
            </div>
            <button class="text-gray-400 hover:text-gray-600">
                <i class="ri-more-fill text-xl"></i>
            </button>
        </div>

        <!-- Post Topic -->
        <div class="mb-3">
            <span class="inline-block px-3 py-1 bg-gray-100 text-gray-700 rounded-full text-sm">
                <%= post.getTopic() %>
            </span>
        </div>

        <!-- Post Content -->
                 <p class="text-gray-800 mb-4"><%= post.getTitle() %></p>

        <p class="text-gray-800 mb-4"><%= post.getContent() %></p>

        <!-- Post Image -->

<% if(post.getImages() != null && !post.getImages().isEmpty()) { %>
<div class="mb-4 grid grid-cols-1 md:grid-cols-2 gap-4 max-w-2xl">
    <% for(String image : post.getImages()) { %>
        <div class="overflow-hidden">
            <img src="assets/img/post/<%= image %>" 
                 alt="Post image" 
                 class="w-full h-[300px] object-cover rounded-lg">
>>>>>>> origin/NgocDung
        </div>
    <% } %>
</div>
<% } %>
<<<<<<< HEAD
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
            <form action="PostServlet" method="POST" enctype="multipart/form-data" class="py-4" accept-charset="UTF-8">
                <!-- User Info -->
                <% 
                    
                    if(currentUser != null) {
                %>
                <div class="flex items-center gap-4 mb-6">
                    <div class="w-12 h-12 rounded-full bg-gradient-to-r from-blue-500 to-primary flex items-center justify-center text-white text-xl font-bold">
                        <%= currentUser.getFullName().substring(0, 1).toUpperCase() %>
                    </div>
                    <div class="flex-1">
                        <p class="font-medium text-gray-900 mb-2"><%= currentUser.getFullName() %></p>
                        <input type="text" 
                               name="topic"
                               placeholder="Thêm chủ đề..." 
                               class="w-full p-4 border border-gray-200 rounded-xl focus:ring-2 focus:ring-primary focus:border-transparent focus:outline-none text-sm bg-gray-50 placeholder-gray-500"
                               maxlength="50">
                    </div>
                </div>
                <% 
                    } 
                %>
                
                <!-- Post Content -->
                <div class="space-y-4 mb-6">
                    <textarea name="title" 
                          placeholder="Tiêu đề bài viết là gì?" 
                          class="w-full p-4 border border-gray-200 rounded-xl focus:ring-2 focus:ring-primary focus:border-transparent focus:outline-none text-sm bg-gray-50 placeholder-gray-500"
                          rows="1"
                          maxlength="200"></textarea>
                    <textarea name="content" 
                          placeholder="Bạn muốn chia sẻ điều gì?" 
                          class="w-full p-4 border border-gray-200 rounded-xl focus:ring-2 focus:ring-primary focus:border-transparent focus:outline-none text-sm bg-gray-50 placeholder-gray-500 whitespace-pre-wrap"
                          style="min-height: 150px; resize: vertical;"
                          rows="4"></textarea>
                </div>

               

                <div class="space-y-4 mb-6">
                    <input type="file" id="imageInput" name="images" accept="image/*" multiple class="hidden">
                    <input type="file" id="videoInput" name="videos" accept="video/*" multiple class="hidden">
                    

                    
                    <div id="imagePreviewContainer" class="hidden">
                        <h4 class="font-medium text-gray-700 mb-2">Hình ảnh đã chọn</h4>
                        <div class="flex gap-4 overflow-x-auto pb-4 scrollbar-thin scrollbar-thumb-gray-300 scrollbar-track-gray-100">
                         
                        </div>
                    </div>

               
                    <div id="videoPreviewContainer" class="hidden">
                        <h4 class="font-medium text-gray-700 mb-2">Video đã chọn</h4>
                        <div class="flex gap-4 overflow-x-auto pb-4 scrollbar-thin scrollbar-thumb-gray-300 scrollbar-track-gray-100">
                    

                        </div>
                    </div>
                </div>

                <!-- Dialog Footer -->
                <div class="border-t border-gray-100 bg-white sticky bottom-0 -mx-6 px-6">
                    <!-- Upload Actions -->
                    <div class="flex items-center gap-4 py-4">
                        <button type="button" 
                                onclick="document.getElementById('imageInput').click()" 
                                class="flex items-center gap-2 px-4 py-2 rounded-xl hover:bg-gray-100 transition-colors">
                            <i class="ri-image-line text-xl text-primary"></i>
                            <span class="text-sm font-medium text-gray-700">Thêm ảnh</span>
                        </button>
                        <button type="button" 
                                onclick="document.getElementById('videoInput').click()" 
                                class="flex items-center gap-2 px-4 py-2 rounded-xl hover:bg-gray-100 transition-colors">
                            <i class="ri-video-line text-xl text-primary"></i>
                            <span class="text-sm font-medium text-gray-700">Thêm video</span>
                        </button>
                    </div>

                    <!-- Submit Button -->
                    <div class="py-4">
                        <button type="submit" 
                                class="w-full bg-primary text-white px-6 py-3 rounded-xl font-medium hover:bg-primary/90 transition-colors shadow-lg shadow-primary/25">
                            Đăng Bài
                        </button>
                    </div>
                </div>
            </form>
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
=======



        <!-- Post Actions -->
        <div class="flex items-center justify-between pt-4 border-t">
            <div class="flex items-center gap-4">
                <button class="flex items-center gap-2 text-gray-600 hover:text-primary">
                    <i class="ri-heart-line text-xl"></i>
                    <span>Thích</span>
                </button>
                <button class="flex items-center gap-2 text-gray-600 hover:text-primary">
                    <i class="ri-chat-1-line text-xl"></i>
                    <span>Bình Luận</span>
                </button>
               
            </div>
            <button class="flex items-center gap-2 text-gray-600 hover:text-primary">
                <i class="ri-bookmark-line text-xl"></i>
            </button>
        </div>
    </div>
    <% } %>
</div>

                
                <!-- Load More & Pagination -->
                <div class="flex flex-col md:flex-row justify-between items-center mb-8">
                    <button class="bg-white text-primary border border-primary px-6 py-2 rounded-button whitespace-nowrap mb-4 md:mb-0 w-full md:w-auto">
                        Xem Thêm Bài Viết
                    </button>

                    <div class="flex items-center gap-2">
                        <button class="w-9 h-9 flex items-center justify-center bg-white text-gray-600 rounded shadow-sm">
                            <i class="ri-arrow-left-s-line"></i>
                        </button>
                        <button class="w-9 h-9 flex items-center justify-center bg-primary text-white rounded">1</button>
                        <button class="w-9 h-9 flex items-center justify-center bg-white text-gray-600 rounded shadow-sm">2</button>
                        <button class="w-9 h-9 flex items-center justify-center bg-white text-gray-600 rounded shadow-sm">3</button>
                        <button class="w-9 h-9 flex items-center justify-center bg-white text-gray-600 rounded shadow-sm">4</button>
                        <button class="w-9 h-9 flex items-center justify-center bg-white text-gray-600 rounded shadow-sm">5</button>
                        <button class="w-9 h-9 flex items-center justify-center bg-white text-gray-600 rounded shadow-sm">
                            <i class="ri-arrow-right-s-line"></i>
                        </button>
                    </div>
                </div>

                <!-- Featured Members -->
                <div class="bg-white rounded shadow-sm p-6 mb-8">
                    <h2 class="text-xl font-bold mb-4">Thành Viên Tích Cực</h2>
                    <div class="grid grid-cols-2 md:grid-cols-4 lg:grid-cols-6 gap-4">
                        <!-- Member 1 -->
                        <div class="flex flex-col items-center">
                            <div class="w-16 h-16 rounded-full overflow-hidden mb-2">
                                <img src="https://readdy.ai/api/search-image?query=profile%2520picture%2520of%2520a%2520vietnamese%2520man%2520in%2520his%252040s%2520with%2520short%2520hair%2520and%2520glasses%252C%2520casual%2520outfit%252C%2520natural%2520lighting%252C%2520realistic%2520portrait&width=100&height=100&seq=member1&orientation=squarish" alt="Member" class="w-full h-full object-cover">
                            </div>
                            <h4 class="font-medium text-sm">Tran Quoc Bao</h4>
                            <p class="text-xs text-gray-500">124 posts</p>
                        </div>
                        <!-- Member 2 -->
                        <div class="flex flex-col items-center">
                            <div class="w-16 h-16 rounded-full overflow-hidden mb-2">
                                <img src="https://readdy.ai/api/search-image?query=profile%2520picture%2520of%2520a%2520vietnamese%2520woman%2520in%2520her%252030s%2520with%2520long%2520hair%252C%2520casual%2520outdoor%2520clothing%252C%2520natural%2520lighting%252C%2520realistic%2520portrait&width=100&height=100&seq=member2&orientation=squarish" alt="Member" class="w-full h-full object-cover">
                            </div>
                            <h4 class="font-medium text-sm">Nguyen Thi Huong</h4>
                            <p class="text-xs text-gray-500">98 posts</p>
                        </div>
                        <!-- Member 3 -->
                        <div class="flex flex-col items-center">
                            <div class="w-16 h-16 rounded-full overflow-hidden mb-2">
                                <img src="https://readdy.ai/api/search-image?query=profile%2520picture%2520of%2520a%2520vietnamese%2520man%2520in%2520his%252050s%2520with%2520gray%2520hair%252C%2520experienced%2520fisherman%2520look%252C%2520outdoor%2520setting%252C%2520natural%2520lighting%252C%2520realistic%2520portrait&width=100&height=100&seq=member3&orientation=squarish" alt="Member" class="w-full h-full object-cover">
                            </div>
                            <h4 class="font-medium text-sm">Le Van Tam</h4>
                            <p class="text-xs text-gray-500">156 posts</p>
                        </div>
                        <!-- Member 4 -->
                        <div class="flex flex-col items-center">
                            <div class="w-16 h-16 rounded-full overflow-hidden mb-2">
                                <img src="https://readdy.ai/api/search-image?query=profile%2520picture%2520of%2520a%2520young%2520vietnamese%2520man%2520in%2520his%252020s%252C%2520modern%2520style%252C%2520casual%2520outfit%252C%2520natural%2520lighting%252C%2520realistic%2520portrait&width=100&height=100&seq=member4&orientation=squarish" alt="Member" class="w-full h-full object-cover">
                            </div>
                            <h4 class="font-medium text-sm">Pham Minh Tuan</h4>
                            <p class="text-xs text-gray-500">203 posts</p>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <!-- Create Post Dialog -->
        <div id="createPostDialog" class="fixed inset-0 bg-black bg-opacity-50 hidden items-center justify-center">
            <div class="bg-white rounded-lg w-full max-w-2xl mx-4">
                <!-- Dialog Header -->
                <div class="flex items-center justify-between p-4 border-b">
                    <h3 class="text-xl font-semibold">Tạo Bài Viết Mới</h3>
                    <button onclick="closeCreatePostDialog()" class="text-gray-500 hover:text-gray-700">
                        <i class="ri-close-line text-2xl"></i>
                    </button>
                </div>
                
                <!-- Dialog Content -->
                <form action="PostServlet" method="POST" enctype="multipart/form-data" class="p-4">
                     <!-- User Info -->
     <div class="flex items-center gap-3 mb-4">
        <div class="w-10 h-10 rounded-full bg-gray-200"></div>
        <div>
            <p class="font-medium">Tên của bạn</p>
            <input type="text" 
                   name="topic"
                   placeholder="Thêm chủ đề..." 
                   class="w-full p-3 border border-gray-200 rounded-lg focus:ring-2 focus:ring-primary focus:outline-none text-sm"
                   maxlength="50">
        </div>
    </div>
                    <!-- Post Content -->
                    <div class="mb-4">
                        <textarea name="title" 
                                  placeholder="Tiêu đề bài viết là gì?" 
                                  class="w-full p-3 border border-gray-200 rounded-lg focus:ring-2 focus:ring-primary focus:outline-none text-sm mb-3"
                                  rows="1"></textarea>
                        <textarea name="content" 
                                  placeholder="Bạn muốn chia sẻ điều gì?" 
                                  class="w-full p-3 border border-gray-200 rounded-lg focus:ring-2 focus:ring-primary focus:outline-none text-sm"
                                  rows="4"></textarea>
                    </div>

                   
                   <!-- Hidden file input and preview -->
    <div class="mb-4">
        <input type="file" 
               id="imageInput" 
               name="images" 
               accept="image/*" 
               multiple
               class="hidden"
               onchange="previewImages(event)">

        <div id="imagePreviewContainer" class="grid grid-cols-2 gap-4 mb-4 hidden">
            <!-- Image previews will be added here -->
        </div>
    </div>


                    <!-- Post Actions -->
                    <div class="flex items-center gap-3 border-t border-b py-3">
                        <button type="button" 
                                onclick="document.getElementById('imageInput').click()" 
                                class="flex items-center gap-2 px-3 py-2 hover:bg-gray-100 rounded-lg">
                            <i class="ri-image-line text-xl text-gray-600"></i>
                            <span class="text-sm text-gray-600">Photo</span>
                        </button>
                      
                    </div>

                    <!-- Submit Button -->
                    <div class="flex justify-end mt-4">
                        <button type="submit" class="bg-primary text-white px-6 py-2 rounded-button font-medium hover:bg-primary/90">
                            Đăng Bài
                        </button>
                    </div>
                </form>
            </div>
        </div>
>>>>>>> origin/NgocDung

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
                            <li><a href="NewFeed.jsp" class="text-gray-400 hover:text-white">News Feed</a></li>
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

<<<<<<< HEAD
        <!-- Scripts -->
  <script>
// Dialog control
const createPostBtn = document.querySelector('button:has(.ri-add-line)');
const createPostDialog = document.getElementById('createPostDialog');

createPostBtn.addEventListener('click', () => {
    createPostDialog.classList.remove('hidden');
    createPostDialog.classList.add('flex');
    document.body.style.overflow = 'hidden';
});

function closeCreatePostDialog() {
    createPostDialog.classList.remove('flex');
    createPostDialog.classList.add('hidden');
    document.body.style.overflow = 'auto';


    removeAllImages();
    removeAllVideos();
 

    const form = createPostDialog.querySelector('form');
    form.reset();
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
    selectedImageFiles = [];
    
    if (files.length > 0) {
        container.classList.remove('hidden');

        selectedImageFiles = Array.from(files);
        
        // Create preview for each file
        selectedImageFiles.forEach((file, index) => {
            const previewDiv = document.createElement('div');
            previewDiv.className = 'relative flex-shrink-0 w-[200px] aspect-square';
            

     
            const img = document.createElement('img');
            img.className = 'w-full h-full object-cover rounded-lg';
            
          

            const reader = new FileReader();
            reader.onload = function(e) {
                img.src = e.target.result;
            };
            reader.readAsDataURL(file);
            


            const removeButton = document.createElement('button');
            removeButton.type = 'button';
            removeButton.className = 'absolute top-2 right-2 w-8 h-8 bg-gray-800 bg-opacity-50 text-white rounded-full flex items-center justify-center hover:bg-opacity-70';
            removeButton.innerHTML = '<i class="ri-close-line"></i>';
            

            removeButton.onclick = function() {
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
    

   
    selectedVideoFiles = Array.from(files);
    
  

    gridContainer.innerHTML = '';
    
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
            removeButton.onclick = function() {

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


document.querySelector('#createPostDialog form').addEventListener('submit', function(event) {
    event.preventDefault();
    
    if (validatePostForm(this)) {

     
        console.log('Selected images:', selectedImageFiles);
        console.log('Selected videos:', selectedVideoFiles);
        
     

        this.submit();
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
    img.addEventListener('click', function() {
        openImageModal(this.src);
    });
});

// Search functionality
const searchInput = document.getElementById('searchInput');

searchInput.addEventListener('keyup', function(e) {
    if (e.key === 'Enter') {
        const searchTerm = this.value.trim();
        if (searchTerm) {
            window.location.assign('NewFeed.jsp?topic=' + encodeURIComponent(searchTerm));
        } else {
            window.location.assign('NewFeed.jsp');
        }
    }
});

// Tab functionality
const allPostsBtn = document.getElementById('allPostsBtn');
allPostsBtn.addEventListener('click', function() {
    window.location.href = 'NewFeed.jsp';
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
    collapseButton.onclick = function() {
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
    loadMoreButton.onclick = function() {
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
    
    xhr.onreadystatechange = function() {
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
    
    xhr.onreadystatechange = function() {
        if (xhr.readyState === 4 && xhr.status === 200) {
            const response = xhr.responseText.trim();
            if (response === 'success') {

                // Reload page with post ID as hash

                window.location.href = `NewFeed.jsp#post-${postId}`;
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
document.addEventListener('DOMContentLoaded', function() {

    if (window.location.hash) {
        const postId = window.location.hash;
        const post = document.querySelector(postId);
        if (post) {

         
            post.scrollIntoView({ behavior: 'smooth', block: 'center' });
      

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
    xhr.onreadystatechange = function() {
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
    xhr.onreadystatechange = function() {
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
    if (!confirm('Bạn có chắc muốn xóa bình luận này?')) return;
    const commentItem = btn.closest('.comment-item');
    const commentsContainer = commentItem.closest('.comments-container');
    const postId = commentsContainer.getAttribute('data-post-id');

    const xhr = new XMLHttpRequest();
    xhr.open('POST', 'delete-comment', true);
    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    xhr.onreadystatechange = function() {
        if (xhr.readyState === 4 && xhr.status === 200) {
            if (xhr.responseText.trim() === 'success') {
            commentItem.remove();
            window.location.href = `NewFeed.jsp#post-${postId}`;
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
    btn.onclick = function() {
        const newContent = input.value.trim();
        if (!newContent) return alert('Nội dung không được để trống!');
       
        const xhr = new XMLHttpRequest();
        xhr.open('POST', 'edit-comment', true);
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4 && xhr.status === 200) {
                if (xhr.responseText.trim() === 'success') {
                    const span = document.createElement('span');
                    span.className = 'comment-content';
                    span.textContent = newContent;
                    input.replaceWith(span);
                    btn.textContent = 'Sửa';
                    btn.onclick = function() { editComment(commentId, btn); };
                } else {
                    alert('Không thể cập nhật bình luận!');
                }
            }
        };
        xhr.send('commentId=' + commentId + '&content=' + encodeURIComponent(newContent) + '&commentOwnerId=' + commentOwnerId);
    };
}

function deletePost(postId, btn) {
    if (!confirm('Bạn có chắc muốn xóa bài viết này?')) return;
    const xhr = new XMLHttpRequest();
    xhr.open('POST', 'delete-post', true);
    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    xhr.onreadystatechange = function() {
        if (xhr.readyState === 4 && xhr.status === 200) {
            if (xhr.responseText.trim() === 'success') {
                const postDiv = document.getElementById('post-' + postId);
                if (postDiv) postDiv.remove();
                   
                window.location.reload();
            } else {
                alert('Không thể xóa bài viết!');
            }
        }
    };
    xhr.send('postId=' + postId);
}

function editPost(postId, btn) {
    
    const postDiv = document.getElementById('post-' + postId);
    const topicElem = postDiv.querySelector('.topic');
    const titleElem = postDiv.querySelector('p.font-bold');
    const contentElem = postDiv.querySelector('.content-text');
    const oldTopic = topicElem.textContent;
    const oldTitle = titleElem.textContent;
    const oldContent = contentElem.textContent;

    
    const topicInput = document.createElement('input');
    topicInput.type = 'text';
    topicInput.value = oldTopic;
    topicInput.className = 'border px-2 py-1 rounded text-sm w-full mb-2';

    const titleInput = document.createElement('input');
    titleInput.type = 'text';
    titleInput.value = oldTitle;
    titleInput.className = 'border px-2 py-1 rounded text-sm w-full mb-2';

    const contentInput = document.createElement('textarea');
    contentInput.value = oldContent;
    contentInput.className = 'border px-2 py-1 rounded text-sm w-full mb-2';
    contentInput.rows = 4;

    topicElem.replaceWith(topicInput);
    titleElem.replaceWith(titleInput);
    contentElem.replaceWith(contentInput);

    btn.textContent = 'Lưu';
    btn.onclick = function() {
        const newTopic = topicInput.value.trim();
        const newTitle = titleInput.value.trim();
        const newContent = contentInput.value.trim();
        if (!newTopic || !newTitle || !newContent) {
            alert('Chủ đề, tiêu đề và nội dung không được để trống!');
            return;
        }
        const xhr = new XMLHttpRequest();
        xhr.open('POST', 'edit-post', true);
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4 && xhr.status === 200) {
                if (xhr.responseText.trim() === 'success') {
              
                
                window.location.reload();
                    
                } else {
                    alert('Không thể cập nhật bài viết!');
                }
            }
        };
        xhr.send('postId=' + postId + '&topic=' + encodeURIComponent(newTopic) + '&title=' + encodeURIComponent(newTitle) + '&content=' + encodeURIComponent(newContent));
    };
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
    xhr.onreadystatechange = function() {
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

document.getElementById('savedPostsBtn').addEventListener('click', function() {
    window.location.href = 'NewFeed.jsp?tab=saved';
});

document.getElementById('myPostsBtn').addEventListener('click', function() {
    window.location.href = 'NewFeed.jsp?tab=my';
});
</script>
  
</body>
</html>

// done


=======
        <script>
          
            const createPostBtn = document.querySelector('button:has(.ri-add-line)');
            const createPostDialog = document.getElementById('createPostDialog');

          
            createPostBtn.addEventListener('click', () => {
                createPostDialog.classList.remove('hidden');
                createPostDialog.classList.add('flex');
                document.body.style.overflow = 'hidden';
            });

            function closeCreatePostDialog() {
                createPostDialog.classList.remove('flex');
                createPostDialog.classList.add('hidden');
                document.body.style.overflow = 'auto';
            }

        
            createPostDialog.addEventListener('click', (e) => {
                if (e.target === createPostDialog) {
                    closeCreatePostDialog();
                }
            });

    
        </script>
        <script>
            function previewImage(event) {
    const file = event.target.files[0];
    if (file) {
        const reader = new FileReader();
        reader.onload = function(e) {
            const preview = document.getElementById('imagePreview');
            const img = preview.querySelector('img');
            img.src = e.target.result;
            preview.classList.remove('hidden');
            preview.classList.add('flex');
        }
        reader.readAsDataURL(file);
    }
}

function removeImage() {
    const preview = document.getElementById('imagePreview');
    const input = document.getElementById('imageInput');
    preview.classList.add('hidden');
    preview.classList.remove('flex');
    preview.querySelector('img').src = '';
    input.value = '';
}


document.getElementById('imageInput').addEventListener('change', previewImage);

</script>
        <script>
    function previewImages(event) {
        const container = document.getElementById('imagePreviewContainer');
        container.innerHTML = ''; // Clear existing previews
        container.classList.remove('hidden');

        const files = event.target.files;
        
        for (let i = 0; i < files.length; i++) {
            const file = files[i];
            const reader = new FileReader();
            
            reader.onload = function(e) {
                const previewDiv = document.createElement('div');
                previewDiv.className = 'relative';
                
                const img = document.createElement('img');
                img.src = e.target.result;
                img.className = 'w-full h-48 object-cover rounded-lg';
                
                const removeButton = document.createElement('button');
                removeButton.type = 'button';
                removeButton.className = 'absolute top-2 right-2 w-8 h-8 bg-gray-800 bg-opacity-50 text-white rounded-full flex items-center justify-center hover:bg-opacity-70';
                removeButton.innerHTML = '<i class="ri-close-line"></i>';
                removeButton.onclick = function() {
                    previewDiv.remove();
                    if (container.children.length === 0) {
                        container.classList.add('hidden');
                    }
                };
                
                previewDiv.appendChild(img);
                previewDiv.appendChild(removeButton);
                container.appendChild(previewDiv);
            }
            
            reader.readAsDataURL(file);
        }
    }

    function removeAllImages() {
        const container = document.getElementById('imagePreviewContainer');
        container.innerHTML = '';
        container.classList.add('hidden');
        document.getElementById('imageInput').value = '';
    }
</script>
</body>
</html>
>>>>>>> origin/NgocDung
