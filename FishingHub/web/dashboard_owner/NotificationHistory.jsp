<%-- 
    Document   : NotificationHistory
    Created on : Jul 25, 2025, 10:33:07 AM
    Author     : [Your Name]
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="model.Users" %>


<%
    Users currentUser = (Users) session.getAttribute("user");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Notification History - Fishing Community</title>
        <script src="https://cdn.tailwindcss.com/3.4.16"></script>
        <script>tailwind.config = {theme: {extend: {colors: {primary: '#1E88E5', secondary: '#FFA726'}, borderRadius: {'none': '0px', 'sm': '4px', DEFAULT: '8px', 'md': '12px', 'lg': '16px', 'xl': '20px', '2xl': '24px', '3xl': '32px', 'full': '9999px', 'button': '8px'}}}}</script>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.6.0/remixicon.min.css">
        <link rel="stylesheet" href="<c:url value='/css/style.css'/>">
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
                            <a href="OwnerDashboard" class="sidebar-item flex items-center px-2 py-2 text-sm font-medium text-gray-700 rounded-md hover:bg-gray-50 hover:text-primary">
                                <div class="w-6 h-6 mr-3 flex items-center justify-center text-gray-500">
                                    <i class="ri-dashboard-line"></i>
                                </div>
                                Dashboard
                            </a>
                            <div class="px-2 pt-4 pb-2 text-xs font-semibold text-gray-500 uppercase">Quản lý sự kiện</div>
                            <a href="EventManager" class="sidebar-item flex items-center px-2 py-2 text-sm font-medium text-gray-700 rounded-md hover:bg-gray-50 hover:text-primary">
                                <div class="w-6 h-6 mr-3 flex items-center justify-center text-gray-500">
                                    <i class="ri-calendar-event-line"></i>
                                </div>
                                Sự kiện
                            </a>
                            <div class="mt-1 mb-2 flex flex-col gap-2">
                                <button onclick="location.href = 'EventManager'" class="py-1 text-gray-500 hover:text-primary hover:bg-gray-100 rounded transition text-sm">
                                    <i class="ri-list-unordered mr-2"></i>Danh sách sự kiện
                                </button>
                                <button onclick="location.href = 'NotificationHistory'" class="py-1 text-gray-500 hover:text-primary hover:bg-gray-100 rounded transition text-sm">
                                    <i class="ri-notification-line mr-2"></i>Lịch sử thông báo
                                </button>
                            </div>
                            <div class="px-2 pt-4 pb-2 text-xs font-semibold text-gray-500 uppercase">Quản lý sản phẩm</div>
                            <a href="${pageContext.request.contextPath}/ProductManage" class="sidebar-item flex items-center px-2 py-2 text-sm font-medium text-gray-700 rounded-md hover:bg-gray-50 hover:text-primary">
                                <div class="w-6 h-6 mr-3 flex items-center justify-center text-gray-500">
                                    <i class="ri-shopping-bag-line"></i>
                                </div>
                                Danh sách sản phẩm
                            </a>
                            <a href="<c:url value='/Order'/>" class="sidebar-item flex items-center px-2 py-2 text-sm font-medium text-gray-700 rounded-md hover:bg-gray-50 hover:text-primary">
                                <div class="w-6 h-6 mr-3 flex items-center justify-center text-gray-500">
                                    <i class="ri-shopping-cart-line"></i>
                                </div>
                                Đơn hàng
                            </a>
                            <div class="px-2 pt-4 pb-2 text-xs font-semibold text-gray-500 uppercase">Quản lý danh mục</div>
                            <a href="CategoryManage" class="sidebar-item flex items-center px-2 py-2 text-sm font-medium text-gray-700 rounded-md hover:bg-gray-50 hover:text-primary">
                                <div class="w-6 h-6 mr-3 flex items-center justify-center text-gray-500">
                                    <i class="ri-list-unordered"></i>
                                </div>
                                Danh sách danh mục
                            </a>
                        </div>
                    </div>
                    <div class="flex items-center p-4 border-t border-gray-200">
                        <div class="flex-shrink-0">
                            <img class="w-10 h-10 rounded-full" src="https://readdy.ai/api/search-image?query=professional%20headshot%20of%20a%20Vietnamese%20male%20administrator%20with%20short%20black%20hair%2C%20wearing%20a%20business%20casual%20outfit%2C%20looking%20confident%20and%20friendly%2C%20high%20quality%2C%20realistic%2C%20studio%20lighting&width=100&height=100&seq=admin123&orientation=squarish" alt="Admin"/>
                        </div>
                        <div class="ml-3">
                            <p class="text-sm font-medium text-gray-700">
                                <%= currentUser != null ? currentUser.getFullName() : "Khách" %>
                            </p>
                            <p class="text-xs font-medium text-gray-500">
                                <% if (currentUser != null && currentUser.getRoleId() == 2) { %>
                                Chủ Hồ Câu <% } else { %> Quản trị viên <% } %>
                            </p>
                        </div>
                    </div>
                    <div class="p-4">
                        <a href="Home" class="flex items-center justify-center w-full bg-primary text-white py-2 rounded-button font-medium hover:bg-primary/90 transition">
                            <i class="ri-arrow-left-line mr-2"></i> Quay lại Trang Chủ
                        </a>
                    </div>
                </div>
            </div>
            <!-- Main content -->
            <div class="flex flex-col flex-1 w-0 overflow-hidden">
                <!-- Top navigation -->
                <div class="relative z-10 flex-shrink-0 flex h-16 bg-white border-b border-gray-200">
                    <button class="px-4 border-r border-gray-200 text-gray-500 md:hidden">
                        <div class="w-6 h-6 flex items-center justify-center">
                            <i class="ri-menu-line"></i>
                        </div>
                    </button>
                </div>
                <!-- Main content area -->
                <main class="w-full max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-6 overflow-x-auto">
                    <!-- Title -->
                    <div class="mb-8 flex items-center justify-between">
                        <div>
                            <h1 class="text-2xl font-bold text-gray-900">Lịch Sử Thông Báo</h1>
                            <p class="mt-2 text-sm text-gray-600">
                                Xem tất cả các thông báo bạn đã gửi
                            </p>
                        </div>
                    </div>
                    <!-- Search Form -->
                    <div class="flex flex-col md:flex-row gap-4 mb-6">
                        <form method="get" action="NotificationHistory" class="flex-1 flex flex-col sm:flex-row items-stretch sm:items-center bg-white rounded-lg shadow-sm border border-gray-200 p-4 gap-2">
                            <input type="hidden" name="action" value="search">
                            <div class="relative flex-1">
                                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                    <i class="ri-search-line text-gray-400"></i>
                                </div>
                                <input type="text" name="search" value="${search}" class="block w-full pl-10 pr-3 py-2 border border-gray-300 rounded-button text-sm placeholder-gray-400 focus:ring-2 focus:ring-primary focus:ring-opacity-20 focus:border-primary" placeholder="Tìm kiếm thông báo hoặc sự kiện..." />
                            </div>
                            <button type="submit" class="flex-shrink-0 inline-flex items-center justify-center px-4 py-2 bg-primary text-white text-sm font-medium rounded-button hover:bg-primary/90 transition">
                                <i class="ri-search-line mr-2"></i> Tìm kiếm
                            </button>
                        </form>
                    </div>
                    <!-- Notifications Table -->
                    <div class="bg-white rounded-lg shadow-sm border border-gray-200 overflow-hidden">
                        <div class="overflow-x-auto">
                            <table class="min-w-full divide-y divide-gray-200">
                                <thead class="bg-gray-50">
                                    <tr>
                                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                            Tên sự kiện
                                        </th>
                                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                            Tiêu đề thông báo
                                        </th>
                                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                            Lời nhắn
                                        </th>
                                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                            Thời gian gửi
                                        </th>
                                    </tr>
                                </thead>
                                <tbody class="bg-white divide-y divide-gray-200">
                                    <c:forEach var="notification" items="${notifications}">
                                        <tr class="hover:bg-gray-50">
                                            <td class="px-6 py-4 whitespace-nowrap">
                                                <div class="text-sm font-medium text-gray-900">${notification.eventTitle}</div>
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap">
                                                <div class="text-sm text-gray-900">${notification.title}</div>
                                            </td>
                                            <td class="px-6 py-4">
                                                <div class="text-sm text-gray-900">${notification.message}</div>
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap">
                                                <div class="text-sm text-gray-900">
                                                    ${notification.formattedCreatedAt}
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </main>
            </div>
        </div>
    </body>
</html>