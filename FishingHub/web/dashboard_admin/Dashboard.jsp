<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
    Integer newUsers = (Integer) request.getAttribute("newUsers");
    if (newUsers == null) {
        response.sendRedirect(request.getContextPath() + "/dashboard-stats");
        return;
    }
%>
<!DOCTYPE html>
<html lang="vi">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Admin Dashboard</title>
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
    <link
      href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap"
      rel="stylesheet"
    />
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.6.0/remixicon.min.css"
    />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/echarts/5.5.0/echarts.min.js"></script>
    <style>
      :where([class^="ri-"])::before {
        content: "\f3c2";
      }
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
      input[type="checkbox"].custom-checkbox {
        display: none;
      }
      input[type="checkbox"].custom-checkbox + label {
        display: inline-block;
        width: 18px;
        height: 18px;
        border: 2px solid #d1d5db;
        border-radius: 4px;
        cursor: pointer;
        position: relative;
      }
      input[type="checkbox"].custom-checkbox:checked + label {
        background-color: #4f46e5;
        border-color: #4f46e5;
      }
      input[type="checkbox"].custom-checkbox:checked + label:after {
        content: "";
        position: absolute;
        left: 5px;
        top: 2px;
        width: 5px;
        height: 10px;
        border: solid white;
        border-width: 0 2px 2px 0;
        transform: rotate(45deg);
      }
      .switch {
        position: relative;
        display: inline-block;
        width: 40px;
        height: 20px;
      }
      .switch input {
        opacity: 0;
        width: 0;
        height: 0;
      }
      .slider {
        position: absolute;
        cursor: pointer;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background-color: #e5e7eb;
        transition: 0.4s;
        border-radius: 20px;
      }
      .slider:before {
        position: absolute;
        content: "";
        height: 16px;
        width: 16px;
        left: 2px;
        bottom: 2px;
        background-color: white;
        transition: 0.4s;
        border-radius: 50%;
      }
      input:checked + .slider {
        background-color: #4f46e5;
      }
      input:checked + .slider:before {
        transform: translateX(20px);
      }
      input[type="number"]::-webkit-inner-spin-button,
      input[type="number"]::-webkit-outer-spin-button {
        -webkit-appearance: none;
        margin: 0;
      }
    </style>
  </head>
  <body>
    <div class="flex h-screen overflow-hidden">
      <!-- Sidebar -->
      <div class="hidden md:flex md:flex-shrink-0">
        <div class="flex flex-col w-64 bg-white border-r border-gray-200">
          <div
            class="flex items-center justify-center h-16 px-4 border-b border-gray-200"
          >
            <h1 class="text-2xl font-['Pacifico'] text-primary">FishingHub</h1>
          </div>
          <div
            class="flex flex-col flex-grow px-2 py-4 overflow-y-auto custom-scrollbar"
          >
            <div class="space-y-1">
              <div
                class="px-2 py-2 text-xs font-semibold text-gray-500 uppercase"
              >
                Tổng quan
              </div>
              <a
                href="dashboard-stats"
                class="sidebar-item active flex items-center px-2 py-2 text-sm font-medium text-gray-700 rounded-md hover:bg-gray-50 hover:text-primary"
              >
                <div
                  class="w-6 h-6 mr-3 flex items-center justify-center text-gray-500"
                >
                  <i class="ri-dashboard-line"></i>
                </div>
                Dashboard
              </a>
              <div
                class="px-2 pt-4 pb-2 text-xs font-semibold text-gray-500 uppercase"
              >
                Quản lý người dùng
              </div>
              <a
                href="${pageContext.request.contextPath}/UserManager"
                class="sidebar-item flex items-center px-2 py-2 text-sm font-medium text-gray-700 rounded-md hover:bg-gray-50 hover:text-primary"
              >
                <div
                  class="w-6 h-6 mr-3 flex items-center justify-center text-gray-500"
                >
                  <i class="ri-user-line"></i>
                </div>
                Danh sách người dùng
              </a>
           
              <div
                class="px-2 pt-4 pb-2 text-xs font-semibold text-gray-500 uppercase"
              >
                Quản lý sự kiện
              </div>
              <a
                href="AdminEventManager"
                class="sidebar-item flex items-center px-2 py-2 text-sm font-medium text-gray-700 rounded-md hover:bg-gray-50 hover:text-primary"
              >
                <div
                  class="w-6 h-6 mr-3 flex items-center justify-center text-gray-500"
                >
                  <i class="ri-calendar-event-line"></i>
                </div>
                Sự kiện
              </a>
            
              <div
                class="px-2 pt-4 pb-2 text-xs font-semibold text-gray-500 uppercase"
              >
                Quản lý bài viết
              </div>
              <a
                href="${pageContext.request.contextPath}/PostManagement"
                class="sidebar-item flex items-center px-2 py-2 text-sm font-medium text-gray-700 rounded-md hover:bg-gray-50 hover:text-primary"
              >
                <div
                  class="w-6 h-6 mr-3 flex items-center justify-center text-gray-500"
                >
                  <i class="ri-file-list-line"></i>
                </div>
                Danh sách bài viết
              </a>
           
            
              
             
              <div
                class="px-2 pt-4 pb-2 text-xs font-semibold text-gray-500 uppercase"
              >
                Quản lý kiến thức
              </div>
              <a
                href="${pageContext.request.contextPath}/FishManage"
                class="sidebar-item flex items-center px-2 py-2 text-sm font-medium text-gray-700 rounded-md hover:bg-gray-50 hover:text-primary"
              >
                <div
                  class="w-6 h-6 mr-3 flex items-center justify-center text-gray-500"
                >
                  <i class="ri-book-open-line"></i>
                </div>
                Thông tin loài cá
              </a>
            
             
             
             
            
            </div>
          </div>
          <div class="flex items-center p-4 border-t border-gray-200">
                        <div class="flex-shrink-0">
                            <img class="w-10 h-10 rounded-full"
                                 src="https://readdy.ai/api/search-image?query=professional%20headshot%20of%20a%20Vietnamese%20male%20administrator%20with%20short%20black%20hair%2C%20wearing%20a%20business%20casual%20outfit%2C%20looking%20confident%20and%20friendly%2C%20high%20quality%2C%20realistic%2C%20studio%20lighting&width=100&height=100&seq=admin123&orientation=squarish"
                                 alt="Admin" />
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
                <!-- Top navigation -->
                <div class="relative z-10 flex-shrink-0 flex h-16 bg-white border-b border-gray-200">
                    <button type="button" class="px-4 border-r border-gray-200 text-gray-500 md:hidden">
                        <div class="w-6 h-6 flex items-center justify-center">
                            <i class="ri-menu-line"></i>
                        </div>
                    </button>
                    <div class="flex-1 px-4 flex justify-between">
                        <div class="flex-1 flex items-center">
                            <div class="flex justify-end items-center h-16 px-4 space-x-4">
                                <span class="text-base font-medium text-gray-700">
                                    Xin chào, <span class="font-semibold text-primary">ADMIN</span>🐳
                                </span>
                                
                            </div>
                        </div>
                        <div class="ml-4 flex items-center md:ml-6">
                            <button class="p-1 rounded-full text-gray-400 hover:text-gray-500 focus:outline-none">
                                <div class="w-6 h-6 flex items-center justify-center">
                                    <i class="ri-notification-3-line"></i>
                                </div>
                            </button>
                            <div class="relative ml-3">
                                <div class="flex items-center">
                                    <span
                                        class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800">
                                        Online
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Main content area -->
                <main class="flex-1 relative overflow-y-auto focus:outline-none custom-scrollbar">
                    <div class="py-6">
                        <div class="max-w-7xl mx-auto px-4 sm:px-6 md:px-8">
                            <div class="flex items-center justify-between mb-6">
                                <h1 class="text-2xl font-semibold text-gray-900">Dashboard</h1>
                                
                            </div>
                        </div>
                        <div class="max-w-7xl mx-auto px-4 sm:px-6 md:px-8">
                            <!-- Stats cards -->
                            <div class="grid grid-cols-1 sm:grid-cols-2 gap-5 mb-6">
                                <!-- Card Người dùng mới -->
                                <div class="bg-white overflow-hidden shadow rounded-lg">
                                    <div class="p-5">
                                        <div class="flex items-center">
                                            <div class="flex-shrink-0 bg-yellow-50 rounded-md p-3">
                                                <div class="w-6 h-6 flex items-center justify-center text-yellow-600">
                                                    <i class="ri-user-line"></i>
                                                </div>
                                            </div>
                                            <div class="ml-5 w-0 flex-1">
                                                <% Double percentChange = (Double) request.getAttribute("percentChange"); %>
                                                <dl>
                                                    <dt class="text-sm font-medium text-gray-500 truncate">Người dùng mới</dt>
                                                    <dd class="flex items-baseline">
                                                        <div class="text-2xl font-semibold text-gray-900">
                                                            <%= newUsers != null ? newUsers : 0 %>
                                                        </div>
                                                        <% String percentClass = (percentChange != null && percentChange >= 0) ? "text-green-600" : "text-red-600"; %>
                                                        <div class="ml-2 flex items-baseline text-sm font-semibold <%= percentClass %>">
                                                            <div class="w-3 h-3 flex items-center justify-center">
                                                                <% if (percentChange != null && percentChange > 0) { %>
                                                                <i class="ri-arrow-up-s-line"></i>
                                                                <% } else if (percentChange != null && percentChange < 0) { %>
                                                                <i class="ri-arrow-down-s-line"></i>
                                                                <% } else { %>
                                                                <i class="ri-subtract-line"></i>
                                                                <% } %>
                                                            </div>
                                                            <span>
                                                                <%= String.format("%.1f", percentChange) %>% so với tuần trước
                                                            </span>
                                                        </div>
                                                    </dd>
                                                </dl>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- Card Bài viết chờ duyệt -->
                                <div class="bg-white overflow-hidden shadow rounded-lg">
                                    <div class="p-5">
                                        <div class="flex items-center">
                                            <div class="flex-shrink-0 bg-red-50 rounded-md p-3">
                                                <div class="w-6 h-6 flex items-center justify-center text-red-600">
                                                    <i class="ri-file-list-2-line"></i>
                                                </div>
                                            </div>
                                            <div class="ml-5 w-0 flex-1">
                                                <dl>
                                                    <dt class="text-sm font-medium text-gray-500 truncate">Bài viết chờ duyệt</dt>
                                                    <dd class="flex items-baseline">
                                                        <div class="text-2xl font-semibold text-gray-900">
                                                            <%= request.getAttribute("pendingPosts") != null ? request.getAttribute("pendingPosts") : 0 %>
                                                        </div>
                                                        <% 
                                                        Double pendingPostsChange = (Double) request.getAttribute("pendingPostsChange");
                                                        String percentClassPost = (pendingPostsChange != null && pendingPostsChange >= 0) ? "text-green-600" : "text-red-600"; 
                                                        %>
                                                        <div class="ml-2 flex items-baseline text-sm font-semibold <%= percentClassPost %>">
                                                            <div class="w-3 h-3 flex items-center justify-center">
                                                                <% if (pendingPostsChange != null && pendingPostsChange > 0) { %>
                                                                <i class="ri-arrow-up-s-line"></i>
                                                                <% } else if (pendingPostsChange != null && pendingPostsChange < 0) { %>
                                                                <i class="ri-arrow-down-s-line"></i>
                                                                <% } else { %>
                                                                <i class="ri-subtract-line"></i>
                                                                <% } %>
                                                            </div>
                                                            <span>
                                                                <%= pendingPostsChange != null ? String.format("%.1f", pendingPostsChange) : "0.0" %>% so với tuần trước
                                                            </span>
                                                        </div>
                                                    </dd>
                                                </dl>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Charts -->
                            <!-- Charts + Bài viết chờ duyệt nằm cạnh nhau -->
                            <div class="mt-8 grid grid-cols-1 gap-5 lg:grid-cols-3">
                                <!-- Biểu đồ cột (chiếm 2/3 hàng) -->
                                <div class="col-span-2 bg-white p-6 rounded-lg shadow flex flex-col">
                                    <h3 class="text-lg font-bold mb-3">Phân bố người dùng theo vai trò</h3>
                                    <p class="text-sm text-gray-500 mb-2">
                                        Tổng số user: <span class="font-semibold text-gray-800"><%= request.getAttribute("totalUsers") %></span>
                                    </p>
                                    <canvas id="userRoleChart" width="400" height="200"></canvas>
                                    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
                                    <script>
            const userRoleLabels = ['User', 'FishingOwner', 'Admin'];
            const userRoleCounts = [
                                        <%= request.getAttribute("countUser") != null ? request.getAttribute("countUser") : 0 %>,
                                        <%= request.getAttribute("countFishingOwner") != null ? request.getAttribute("countFishingOwner") : 0 %>,
                                        <%= request.getAttribute("countAdmin") != null ? request.getAttribute("countAdmin") : 0 %>
            ];
            const ctx = document.getElementById('userRoleChart').getContext('2d');
            new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: userRoleLabels,
                    datasets: [{
                            label: 'User count by role',
                            data: userRoleCounts,
                            borderWidth: 1,
                            backgroundColor: ['#fbbf24', '#38bdf8', '#f87171'],
                        }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: {display: false}
                    },
                    scales: {
                        y: {beginAtZero: true}
                    }
                }
            });
                                    </script>
                                </div>

                                <!-- Card bài viết chờ duyệt (chiếm 1/3 hàng) -->
                                <div class="col-span-1 bg-white rounded-lg shadow p-6 flex flex-col">
                                    <div class="flex justify-between items-center mb-3">
                                        <h3 class="font-semibold text-base">Bài viết chờ duyệt</h3>
                                        <a href="${pageContext.request.contextPath}/admin/post-approval" class="text-blue-600 text-sm hover:underline">Xem tất cả</a>
                                    </div>
                                    <div class="space-y-3 max-h-96 overflow-y-auto pr-1">
                                        <c:choose>
                                            <c:when test="${empty topPendingPosts}">
                                                <div class="text-gray-400 text-sm italic text-center">Không có bài viết chờ duyệt</div>
                                            </c:when>
                                            <c:otherwise>
                                                <c:forEach var="post" items="${topPendingPosts}">
                                                    <div class="bg-gray-50 rounded-lg p-3 flex justify-between items-center">
                                                        <div>
                                                            <div class="font-medium text-gray-900">${post.title}</div>
                                                            <div class="text-xs text-gray-500 flex items-center mt-1">
                                                                <i class="ri-user-line mr-1"></i> ${post.authorName}
                                                                <i class="ri-time-line ml-4 mr-1"></i>
                                                                <fmt:formatDate value="${post.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                                                            </div>
                                                        </div>
                                                        <div class="flex gap-1">
                                                            <button class="rounded bg-blue-600 hover:bg-blue-700 text-white p-2"><i class="ri-check-line"></i></button>
                                                            <button class="rounded bg-red-500 hover:bg-red-600 text-white p-2"><i class="ri-close-line"></i></button>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>


                        </div>
                    </div>
                </main>
            </div>
        </div>
        <script>
            document.addEventListener("DOMContentLoaded", function () {



                categoryChart.setOption(categoryOption);
                // Resize charts when window size changes
                window.addEventListener("resize", function () {
                    productsChart.resize();
                    categoryChart.resize();
                });
            });
        </script>
    </body>

</html>