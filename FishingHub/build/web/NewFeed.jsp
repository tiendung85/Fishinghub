<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                    <!-- Header navigation links -->
                    <nav class="hidden md:flex ml-10">
                        <a href="Home.jsp" class="px-4 py-2 text-gray-800 font-medium hover:text-primary">Trang Chủ</a>
                        <a href="Event" class="px-4 py-2 text-gray-800 font-medium hover:text-primary">Sự Kiện</a>
                        <a href="NewFeed.jsp" class="px-4 py-2 text-gray-800 font-medium hover:text-primary">Bảng Tin</a>
                        <a href="Product.jsp" class="px-4 py-2 text-gray-800 font-medium hover:text-primary">Cửa Hàng</a>
                        <a href="KnowledgeFish" class="px-4 py-2 text-gray-800 font-medium hover:text-primary">Kiến Thức</a>
                        <a href="Achievement.jsp" class="px-4 py-2 text-gray-800 font-medium hover:text-primary">Xếp Hạng</a>
                    </nav>
                </div>

                <div class="flex items-center space-x-4">
                    <!-- Cart -->
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
                            <span>Tạo Bài Viết Mới</span>
                        </button>
                    </div>
                </div>

                <!-- Filters and Tabs -->
                <div class="bg-white rounded shadow-sm mb-8">
                    <div class="flex border-b border-gray-200">
                        <button id="allPostsBtn" class="tab-button active px-6 py-4 text-primary font-medium">Tất Cả Bài Viết</button>
                        <button class="tab-button px-6 py-4 text-gray-600 font-medium hover:text-primary">Đã Lưu</button>
                        <button class="tab-button px-6 py-4 text-gray-600 font-medium hover:text-primary">Bài Viết Của Tôi</button>
                    </div>
                </div>

                <!-- Posts List -->
                <div class="space-y-6 max-w-4xl mx-auto" id="postsContainer"> 
                    <% 
                        PostDAO postDAO = new PostDAO();
                        UserDao userDao = new UserDao();
                        PostCommentDAO commentDAO = new PostCommentDAO();
                        String searchTopic = request.getParameter("topic");
                        List<Post> posts;
        
                        if (searchTopic != null && !searchTopic.trim().isEmpty()) {
                            posts = postDAO.searchPostsByTopic(searchTopic);
                        } else {
                            posts = postDAO.getAllPosts();
                        }
        
                        SimpleDateFormat sdf = new SimpleDateFormat("MMM dd, yyyy HH:mm");
        
                        for(Post post : posts) {
                    %>
                    <div class="bg-white rounded-lg shadow-sm" id="post-<%= post.getPostId() %>"> <!-- Bỏ padding p-8 ở đây -->
                        <!-- Post Wrapper để control padding -->
                        <div class="p-6"> <!-- Thêm wrapper với padding nhỏ hơn -->
                            <!-- Post Header -->
                            <div class="flex items-start justify-between mb-4">
                                <div class="flex items-center gap-3">
                                    <% 
                                        Users postUser = userDao.getUserById(post.getUserId());
                                        String userName = (postUser != null) ? postUser.getFullName() : "Unknown User";
                                        String firstLetter = userName.substring(0, 1).toUpperCase();
                                    %>
                                    <!-- Avatar chữ cái đầu -->
                                    <div class="w-10 h-10 rounded-full bg-gradient-to-r from-blue-500 to-primary flex items-center justify-center text-white text-lg font-bold">
                                        <%= firstLetter %>
                                    </div>


                                    <div>
                                        <p class="font-medium text-gray-900"><%= userName %></p>
                                        <p class="text-sm text-gray-500"><%= sdf.format(post.getCreatedAt()) %></p>
                                    </div>
                                </div>


                                <button class="text-gray-400 hover:text-gray-600">
                                    <i class="ri-more-fill text-xl"></i>
                                </button>
                            </div>


                            <!-- Post Topic -->
                            <div class="mb-3">
                                <span class="inline-block px-0 py-1 bg-gray-100 text-gray-700 rounded-full text-sm">
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

                        <!-- Post Interactions - Separate section with different background -->
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
                                <button class="flex items-center gap-2 text-gray-600 hover:text-primary transition-colors" 
                                        title="Lưu bài viết">
                                    <i class="ri-bookmark-line text-xl"></i>
                                </button>
                            </div>
                        </div>

                        <!-- Comments Section -->
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
                                            <p class="text-sm text-gray-800 pt-1"><%= comment.getContent() %></p>
                                        </div>
                                        <div class="flex items-center gap-4 mt-2 ml-2">
                                            <button class="text-xs text-gray-500 hover:text-primary transition-colors">
                                                <i class="ri-heart-line"></i>
                                                <span>Thích</span>
                                            </button>
                                            <button class="text-xs text-gray-500 hover:text-primary transition-colors">
                                                <i class="ri-reply-line"></i>
                                                <span>Phản hồi</span>
                                            </button>
                                            <span class="text-xs text-gray-500">
                                                <span class="font-medium">0</span> lượt thích
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <% } %>
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
                            <!-- Dialog Header -->
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

                                    <!-- File Upload Section -->
                                    <div class="space-y-4 mb-6">
                                        <input type="file" id="imageInput" name="images" accept="image/*" multiple class="hidden">
                                        <input type="file" id="videoInput" name="videos" accept="video/*" multiple class="hidden">

                                        <!-- Image Preview Container -->
                                        <div id="imagePreviewContainer" class="hidden">
                                            <h4 class="font-medium text-gray-700 mb-2">Hình ảnh đã chọn</h4>
                                            <div class="flex gap-4 overflow-x-auto pb-4 scrollbar-thin scrollbar-thumb-gray-300 scrollbar-track-gray-100">
                                                <!-- Image previews will be inserted here -->
                                            </div>
                                        </div>

                                        <!-- Video Preview Container -->
                                        <div id="videoPreviewContainer" class="hidden">
                                            <h4 class="font-medium text-gray-700 mb-2">Video đã chọn</h4>
                                            <div class="flex gap-4 overflow-x-auto pb-4 scrollbar-thin scrollbar-thumb-gray-300 scrollbar-track-gray-100">
                                                <!-- Video previews will be inserted here -->
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
                            // Reset file inputs and previews when closing the dialog
                            removeAllImages();
                            removeAllVideos();
                            // Reset form fields
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

                            // Reset everything
                            gridContainer.innerHTML = '';
                            selectedImageFiles = [];

                            if (files.length > 0) {
                                container.classList.remove('hidden');

                                // Convert FileList to Array and store it
                                selectedImageFiles = Array.from(files);

                                // Create preview for each file
                                selectedImageFiles.forEach((file, index) => {
                                    const previewDiv = document.createElement('div');
                                    previewDiv.className = 'relative flex-shrink-0 w-[200px] aspect-square';

                                    // Create image preview
                                    const img = document.createElement('img');
                                    img.className = 'w-full h-full object-cover rounded-lg';

                                    // Read file and set image source
                                    const reader = new FileReader();
                                    reader.onload = function (e) {
                                        img.src = e.target.result;
                                    };
                                    reader.readAsDataURL(file);

                                    // Create remove button
                                    const removeButton = document.createElement('button');
                                    removeButton.type = 'button';
                                    removeButton.className = 'absolute top-2 right-2 w-8 h-8 bg-gray-800 bg-opacity-50 text-white rounded-full flex items-center justify-center hover:bg-opacity-70';
                                    removeButton.innerHTML = '<i class="ri-close-line"></i>';

                                    // Remove button click handler
                                    removeButton.onclick = function () {
                                        selectedImageFiles = selectedImageFiles.filter((_, i) => i !== index);
                                        previewDiv.remove();

                                        if (gridContainer.children.length === 0) {
                                            container.classList.add('hidden');
                                        }

                                        updateFileInput();
                                    };

                                    // Append elements
                                    previewDiv.appendChild(img);
                                    previewDiv.appendChild(removeButton);
                                    gridContainer.appendChild(previewDiv);
                                });
                            } else {
                                container.classList.add('hidden');
                            }

                            // Update file input immediately
                            updateFileInput();
                        }

                  // Function to update file input with current selectedImageFiles
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

                            // Reset selectedVideoFiles to avoid duplication
                            selectedVideoFiles = Array.from(files);

                            // Clear existing previews
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
                                    removeButton.onclick = function () {
                                        // Remove the specific file from selectedVideoFiles
                                        selectedVideoFiles.splice(index, 1);
                                        URL.revokeObjectURL(videoURL);
                                        previewDiv.remove();

                                        // Hide container if no videos remain
                                        if (gridContainer.children.length === 0) {
                                            container.classList.add('hidden');
                                        }

                                        // Update video input to reflect current selection
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


                        function removeAllImages() {
                            selectedImageFiles = [];
                            const container = document.getElementById('imagePreviewContainer');
                            const gridContainer = container.querySelector('div');
                            gridContainer.innerHTML = '';
                            container.classList.add('hidden');
                            document.getElementById('imageInput').value = '';
                        }


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

                            // Check if topic is empty
                            if (!topicInput.value.trim()) {
                                isValid = false;
                                errorMessage += 'Vui lòng nhập chủ đề.\n';
                                topicInput.classList.add('border-red-500');
                                topicInput.insertAdjacentHTML('afterend', '<div class="error-message text-red-500 text-xs mt-1">Vui lòng nhập chủ đề</div>');
                            }

                            // Check if title is empty
                            if (!titleInput.value.trim()) {
                                isValid = false;
                                errorMessage += 'Vui lòng nhập tiêu đề.\n';
                                titleInput.classList.add('border-red-500');
                                titleInput.insertAdjacentHTML('afterend', '<div class="error-message text-red-500 text-xs mt-1">Vui lòng nhập tiêu đề</div>');
                            }

                            // Check if content is empty
                            if (!contentInput.value.trim()) {
                                isValid = false;
                                errorMessage += 'Vui lòng nhập nội dung.\n';
                                contentInput.classList.add('border-red-500');
                                contentInput.insertAdjacentHTML('afterend', '<div class="error-message text-red-500 text-xs mt-1">Vui lòng nhập nội dung</div>');
                            }

                            // Optionally, check for images or videos if required
                            // if (selectedImageFiles.length === 0 && selectedVideoFiles.length === 0) {
                            //     isValid = false;
                            //     errorMessage += 'Vui lòng chọn ít nhất một hình ảnh hoặc video.\n';
                            // }

                            if (!isValid) {
                                alert(errorMessage);
                            }

                            return isValid;
                        }

                  // Handle form submission
                        document.querySelector('#createPostDialog form').addEventListener('submit', function (event) {
                            event.preventDefault();

                            if (validatePostForm(this)) {
                                // Log selected files for debugging
                                console.log('Selected images:', selectedImageFiles);
                                console.log('Selected videos:', selectedVideoFiles);

                                // Submit the form if validation passes
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
                                    window.location.assign('NewFeed.jsp?topic=' + encodeURIComponent(searchTerm));
                                } else {
                                    window.location.assign('NewFeed.jsp');
                                }
                            }
                        });

                  // Tab functionality
                        const allPostsBtn = document.getElementById('allPostsBtn');
                        allPostsBtn.addEventListener('click', function () {
                            window.location.href = 'NewFeed.jsp';
                        });

                  // Initialize "Read More" buttons
                        function initReadMore() {
                            document.querySelectorAll('.content-wrapper').forEach(wrapper => {
                                const content = wrapper.querySelector('.content-text');
                                const button = wrapper.querySelector('.read-more-btn');
                                const fade = wrapper.querySelector('.read-more-fade');

                                // Reset styles
                                content.style.removeProperty('max-height');

                                // Check if content needs "read more" button
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

                  // Initialize on page load
                        document.addEventListener('DOMContentLoaded', initReadMore);

                  // Re-initialize on window load
                        window.addEventListener('load', () => {
                            setTimeout(initReadMore, 500);
                        });

                  // Re-initialize on window resize
                        window.addEventListener('resize', () => {
                            setTimeout(initReadMore, 100);
                        });


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
                    </script>

                    </body>
                    </html>