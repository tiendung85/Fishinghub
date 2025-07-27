
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="dal.PostDAO"%>
<%@page import="model.Post"%>
<%@page import="dal.UserDao"%>
<%@page import="model.Users"%>
<%@page import="java.text.SimpleDateFormat"%>

<%
    List<Post> posts = (List<Post>) request.getAttribute("posts");
    int totalPages = (int) request.getAttribute("totalPages");
    int currentPage = (int) request.getAttribute("currentPage");
    String keyword = (String) request.getAttribute("keyword");
    String status = (String) request.getAttribute("status");
    Map<Integer, Users> userMap = (Map<Integer, Users>) request.getAttribute("userMap");
    Integer totalPostsObj = (Integer) request.getAttribute("totalPosts");
    int totalPosts = (totalPostsObj != null) ? totalPostsObj : 0;
    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Quản lý bài viết</title>
    <script src="https://cdn.tailwindcss.com/3.4.16"></script>
    <script>
      tailwind.config = {
        theme: {
          extend: {
            colors: { primary: "#4f46e5", secondary: "#10b981" },
            borderRadius: {
              none: "0px",
              sm: "4px",
              DEFAULT: "8px",
              md: "12px",
              lg: "16px",
              xl: "20px",
              "2xl": "24px",
              "3xl": "32px",
              full: "9999px",
              button: "8px",
            },
          },
        },
      };
    </script>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.6.0/remixicon.min.css" />
    <style>
        body {
            font-family: "Inter", sans-serif;
            background-color: #f9fafb;
        }
        .sidebar-item.active {
            background-color: rgba(79, 70, 229, 0.1);
            color: #4f46e5;
            border-left: 3px solid #4f46e5;
        }
        .custom-scrollbar::-webkit-scrollbar {
            width: 5px;
        }
        .custom-scrollbar::-webkit-scrollbar-track {
            background: #f1f1f1;
        }
        .custom-scrollbar::-webkit-scrollbar-thumb {
            background: #d1d5db;
            border-radius: 8px;
        }
        .custom-scrollbar::-webkit-scrollbar-thumb:hover {
            background: #9ca3af;
        }
        .table-hover tbody tr:hover {
            background-color: #f1f5f9;
        }
        .modal {
            display: none;
            position: fixed;
            z-index: 50;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.4);
        }
        .modal.show {
            display: block;
        }
        .modal-content {
            background-color: #fefefe;
            margin: 15% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 90%;
            max-width: 500px;
            border-radius: 8px;
        }
    </style>
</head>
<body>
    <div class="flex h-screen overflow-hidden">
        <!-- Sidebar -->
        <div class="hidden md:flex md:flex-shrink-0">
            <div class="flex flex-col w-64 bg-white border-r border-gray-200">
                <div class="flex items-center justify-center h-16 px-4 border-b border-gray-200">
                    <h1 class="text-2xl font-['Pacifico'] text-primary">FishingHub</h1>
                </div>
                <div class="flex flex-col flex-grow px-2 py-4 overflow-y-auto custom-scrollbar">
                    <div class="space-y-1">
                        <div class="px-2 py-2 text-xs font-semibold text-gray-500 uppercase">Tổng quan</div>
                        <a href="dashboard-stats" class="sidebar-item flex items-center px-2 py-2 text-sm font-medium text-gray-700 rounded-md hover:bg-gray-50 hover:text-primary">
                            <div class="w-6 h-6 mr-3 flex items-center justify-center text-gray-500"><i class="ri-dashboard-line"></i></div>
                            Dashboard
                        </a>
                        <div class="px-2 pt-4 pb-2 text-xs font-semibold text-gray-500 uppercase">Quản lý người dùng</div>
                        <a href="${pageContext.request.contextPath}/UserManager" class="sidebar-item flex items-center px-2 py-2 text-sm font-medium text-gray-700 rounded-md hover:bg-gray-50 hover:text-primary">
                            <div class="w-6 h-6 mr-3 flex items-center justify-center text-gray-500"><i class="ri-user-line"></i></div>
                            Danh sách người dùng
                        </a>
                        <div class="px-2 pt-4 pb-2 text-xs font-semibold text-gray-500 uppercase">Quản lý sự kiện</div>
                        <a href="AdminEventManager" class="sidebar-item flex items-center px-2 py-2 text-sm font-medium text-gray-700 rounded-md hover:bg-gray-50 hover:text-primary">
                            <div class="w-6 h-6 mr-3 flex items-center justify-center text-gray-500"><i class="ri-calendar-event-line"></i></div>
                            Sự kiện
                        </a>
                        <div class="px-2 pt-4 pb-2 text-xs font-semibold text-gray-500 uppercase">Quản lý bài viết</div>
                        <a href="${pageContext.request.contextPath}/PostManagement" class="sidebar-item active flex items-center px-2 py-2 text-sm font-medium text-gray-700 rounded-md hover:bg-gray-50 hover:text-primary">
                            <div class="w-6 h-6 mr-3 flex items-center justify-center text-gray-500"><i class="ri-file-list-line"></i></div>
                            Danh sách bài viết
                        </a>
                        <div class="px-2 pt-4 pb-2 text-xs font-semibold text-gray-500 uppercase">Quản lý kiến thức</div>
                        <a href="${pageContext.request.contextPath}/FishManage" class="sidebar-item flex items-center px-2 py-2 text-sm font-medium text-gray-700 rounded-md hover:bg-gray-50 hover:text-primary">
                            <div class="w-6 h-6 mr-3 flex items-center justify-center text-gray-500"><i class="ri-book-open-line"></i></div>
                            Thông tin loài cá
                        </a>
                    </div>
                </div>
                <div class="flex items-center p-4 border-t border-gray-200">
                    <div class="flex-shrink-0">
                        <img class="w-10 h-10 rounded-full" src="https://readdy.ai/api/search-image?query=professional%20headshot%20of%20a%20Vietnamese%20male%20administrator%20with%20short%20black%20hair%2C%20wearing%20a%20business%20casual%20outfit%2C%20looking%20confident%20and%20friendly%2C%20high%20quality%2C%20realistic%2C%20studio%20lighting&width=100&height=100&seq=admin123&orientation=squarish" alt="Admin" />
                    </div>
                    <div class="ml-3">
                        <p class="text-xs font-medium text-gray-500">Quản trị viên</p>
                    </div>
                </div>
                <div class="p-4 border-t border-gray-200">
                    <form action="logout" method="post" style="display:inline;">
                        <button type="submit" class="bg-gray-200 text-gray-800 px-3 py-2 rounded-button hover:bg-gray-300">Đăng Xuất</button>
                    </form>
                </div>
            </div>
        </div>
        <!-- Main content -->
        <div class="flex flex-col flex-1 w-0 overflow-hidden">
            <div class="container mx-auto py-6 px-4 sm:px-6 md:px-8">
                <div class="flex justify-between items-center mb-6">
                    <h2 class="text-2xl font-bold text-gray-900"><i class="ri-article-line mr-2"></i>Quản lý bài viết</h2>
                    <span class="bg-gray-200 text-gray-700 px-3 py-1 rounded-full text-sm font-medium">Tổng: <%= totalPosts %> bài viết</span>
                </div>
                <div class="flex justify-end mb-4">
                    <a href="${pageContext.request.contextPath}/AdminNotify" class="bg-blue-600 text-white px-4 py-2 rounded-md hover:bg-blue-700 flex items-center"><i class="ri-notification-line mr-2"></i>Xem tất cả thông báo</a>
                </div>
                <form method="get" action="PostManagement" class="grid grid-cols-1 md:grid-cols-4 gap-4 mb-6">
                    <div class="col-span-2">
                        <div class="relative">
                            <span class="absolute inset-y-0 left-0 flex items-center pl-3 text-gray-500"><i class="ri-search-line"></i></span>
                            <input type="text" name="keyword" class="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-primary" placeholder="Tìm kiếm tiêu đề hoặc người đăng..." value="<%= keyword != null ? keyword : "" %>"/>
                        </div>
                    </div>
                    <div>
                        <select name="status" class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-primary">
                            <option value="">Tất cả trạng thái</option>
                            <option value="chờ duyệt" <%= "chờ duyệt".equals(status) ? "selected" : "" %>>Chờ duyệt</option>
                            <option value="đã duyệt" <%= "đã duyệt".equals(status) ? "selected" : "" %>>Đã duyệt</option>
                            <option value="từ chối" <%= "từ chối".equals(status) ? "selected" : "" %>>Từ chối</option>
                        </select>
                    </div>
                    <div class="flex space-x-2">
                        <button type="submit" class="bg-primary text-white px-4 py-2 rounded-md hover:bg-blue-700 flex items-center"><i class="ri-filter-line mr-2"></i>Tìm kiếm</button>
                        <a href="${pageContext.request.contextPath}/PostManagement" class="bg-gray-200 text-gray-700 px-4 py-2 rounded-md hover:bg-gray-300 flex items-center"><i class="ri-refresh-line mr-2"></i>Làm mới</a>
                    </div>
                </form>
                <div class="bg-white shadow rounded-lg overflow-hidden">
                    <table class="min-w-full divide-y divide-gray-200">
                        <thead class="bg-gray-50">
                            <tr>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">ID</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Tiêu đề</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Người đăng</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Ngày đăng</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Trạng thái</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Thao tác</th>
                            </tr>
                        </thead>
                        <tbody class="bg-white divide-y divide-gray-200">
                            <% for(Post post : posts) { 
                                Users user = userMap.get(post.getUserId());
                            %>
                                <tr class="hover:bg-gray-50">
                                    <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">#<%= post.getPostId() %></td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700"><%= post.getTitle() %></td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700"><%= user != null ? user.getFullName() : "Unknown" %></td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700"><%= post.getCreatedAt() != null ? sdf.format(post.getCreatedAt()) : "N/A" %></td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm">
                                        <% if("đã duyệt".equals(post.getStatus())) { %>
                                            <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800"><i class="ri-checkbox-circle-line mr-1"></i>Đã duyệt</span>
                                        <% } else if("chờ duyệt".equals(post.getStatus())) { %>
                                            <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-yellow-100 text-yellow-800"><i class="ri-time-line mr-1"></i>Chờ duyệt</span>
                                        <% } else { %>
                                            <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-red-100 text-red-800"><i class="ri-close-circle-line mr-1"></i>Từ chối</span>
                                        <% } %>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                        <a href="${pageContext.request.contextPath}/post-detail?id=<%= post.getPostId() %>" class="text-blue-600 hover:text-blue-800 mr-3"><i class="ri-eye-line mr-1"></i>Xem</a>
                                        <% if("chờ duyệt".equals(post.getStatus())) { %>
                                            <a href="PostManagement?action=approve&postId=<%= post.getPostId() %>&currentPage=<%= currentPage %><%= keyword != null ? "&keyword=" + keyword : "" %><%= status != null ? "&status=" + status : "" %>" class="text-green-600 hover:text-green-800 mr-3"><i class="ri-check-line mr-1"></i>Duyệt</a>
                                            <button onclick="openRejectModal(<%= post.getPostId() %>)" class="text-red-600 hover:text-red-800"><i class="ri-close-line mr-1"></i>Từ chối</button>
                                        <% } %>
                                    </td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
                <!-- Pagination -->
                <nav class="mt-6 flex justify-center">
                    <ul class="flex space-x-2">
                        <% for(int i=1; i<=totalPages; i++) { %>
                            <li>
                                <a href="PostManagement?page=<%=i%><%= keyword != null ? "&keyword=" + keyword : "" %><%= status != null ? "&status=" + status : "" %>" class="px-4 py-2 text-sm font-medium <%= i==currentPage ? "bg-primary text-white rounded-md" : "text-gray-700 hover:bg-gray-200 rounded-md" %>"><%= i %></a>
                            </li>
                        <% } %>
                    </ul>
                </nav>
            </div>
        </div>
    </div>

    <!-- Modal từ chối -->
    <div id="rejectModal" class="modal">
        <div class="modal-content">
            <form method="post" action="${pageContext.request.contextPath}/RejectPost">
                <div class="flex justify-between items-center mb-4">
                    <h5 class="text-lg font-semibold text-gray-900">Nhập lý do từ chối</h5>
                    <button type="button" onclick="closeRejectModal()" class="text-gray-500 hover:text-gray-700"><i class="ri-close-line text-xl"></i></button>
                </div>
                <input type="hidden" name="postId" id="rejectPostId" />
                <div class="mb-4">
                    <label for="reason" class="block text-sm font-medium text-gray-700">Lý do</label>
                    <textarea name="reason" id="reason" class="mt-1 w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-primary" rows="4" required></textarea>
                </div>
                <div class="flex justify-end">
                    <button type="submit" class="bg-red-600 text-white px-4 py-2 rounded-md hover:bg-red-700">Từ chối bài viết</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        function openRejectModal(postId) {
            document.getElementById('rejectPostId').value = postId;
            document.getElementById('rejectModal').classList.add('show');
        }

        function closeRejectModal() {
            document.getElementById('rejectModal').classList.remove('show');
        }
    </script>
</body>
</html>
