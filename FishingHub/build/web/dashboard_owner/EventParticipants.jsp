<%-- 
    Document   : EventManager
    Created on : Jun 20, 2025, 8:44:07 AM
    Author     : LENOVO
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="model.Users" %>

<%
    Users currentUser = (Users) session.getAttribute("user");
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Event List - Fishing Community</title>
        <script src="https://cdn.tailwindcss.com/3.4.16"></script>
        <script>tailwind.config = {theme: {extend: {colors: {primary: '#1E88E5', secondary: '#FFA726'}, borderRadius: {'none': '0px', 'sm': '4px', DEFAULT: '8px', 'md': '12px', 'lg': '16px', 'xl': '20px', '2xl': '24px', '3xl': '32px', 'full': '9999px', 'button': '8px'}}}}</script>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.6.0/remixicon.min.css">
        <link rel="stylesheet" href="assets/css/style.css">
        <link rel="stylesheet" href="<c:url value='/css/style.css'/>">
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
                                href="#"
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
                                Quản lý sự kiện
                            </div>
                            <a href="#"
                               class="sidebar-item flex items-center px-2 py-2 text-sm font-medium text-gray-700 rounded-md ">
                                <div class="w-6 h-6 mr-3 flex items-center justify-center text-gray-500">
                                    <i class="ri-calendar-event-line"></i>
                                </div>
                                Sự kiện
                            </a>
                            <div class="ml-10 mt-1 mb-2 flex flex-col gap-2">
                                <a href="EventManager"
                                   class=" py-1 text-gray-500 hover:text-primary hover:bg-gray-100 rounded transition text-sm">
                                    <i class="ri-list-unordered mr-2"></i>Danh sách sự kiện
                                </a>

                            </div>


                            <div
                                class="px-2 pt-4 pb-2 text-xs font-semibold text-gray-500 uppercase"
                                >
                                Quản lý sản phẩm
                            </div>
                            <a
                                href="#"
                                class="sidebar-item flex items-center px-2 py-2 text-sm font-medium text-gray-700 rounded-md hover:bg-gray-50 hover:text-primary"
                                >
                                <div
                                    class="w-6 h-6 mr-3 flex items-center justify-center text-gray-500"
                                    >
                                    <i class="ri-shopping-bag-line"></i>
                                </div>
                                Danh sách sản phẩm
                            </a>
                            <a
                                href="<c:url value='/Order'/>"
                                class="sidebar-item flex items-center px-2 py-2 text-sm font-medium text-gray-700 rounded-md hover:bg-gray-50 hover:text-primary"
                                >
                                <div
                                    class="w-6 h-6 mr-3 flex items-center justify-center text-gray-500"
                                    >
                                    <i class="ri-shopping-cart-line"></i>
                                </div>
                                Đơn hàng
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
                            <p class="text-sm font-medium text-gray-700">
                                <%= currentUser != null ? currentUser.getFullName() : "Khách" %>
                            </p>
                            <p class="text-xs font-medium text-gray-500">
                                <% if(currentUser != null && currentUser.getRoleId() == 2) { %>
                                Chủ Hồ Câu
                                <% } else { %>
                                Quản trị viên
                                <% } %>
                            </p>
                        </div>
                    </div>

                    <div class="p-4">
                        <a href="./Home.jsp" class="flex items-center justify-center w-full bg-primary text-white py-2 rounded-button font-medium hover:bg-primary/90 transition">
                            <i class="ri-arrow-left-line mr-2"></i> Quay lại Trang Chủ
                        </a>
                    </div>
                </div>
            </div>
            <!-- Main content -->
            <div class="flex flex-col flex-1 w-0 overflow-hidden">
                <!-- Top navigation -->
                <div
                    class="relative z-10 flex-shrink-0 flex h-16 bg-white border-b border-gray-200"
                    >
                    <button
                        type="button"
                        class="px-4 border-r border-gray-200 text-gray-500 md:hidden"
                        >
                        <div class="w-6 h-6 flex items-center justify-center">
                            <i class="ri-menu-line"></i>
                        </div>
                    </button>
                    <div class="flex-1 px-4 flex justify-between">
                        <div class="flex-1 flex items-center">
                            <div class="w-full max-w-2xl">
                                <div class="relative w-full">
                                    <div
                                        class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none"
                                        >
                                        <div
                                            class="w-5 h-5 flex items-center justify-center text-gray-400"
                                            >
                                            <i class="ri-search-line"></i>
                                        </div>
                                    </div>
                                    <input
                                        type="text"
                                        class="block w-full pl-10 pr-3 py-2 border border-gray-200 rounded-md text-sm placeholder-gray-500 focus:outline-none focus:ring-1 focus:ring-primary focus:border-primary"
                                        placeholder="Tìm kiếm..."
                                        />
                                </div>
                            </div>
                        </div>
                        <div class="ml-4 flex items-center md:ml-6">
                            <button
                                class="p-1 rounded-full text-gray-400 hover:text-gray-500 focus:outline-none"
                                >
                                <div class="w-6 h-6 flex items-center justify-center">
                                    <i class="ri-notification-3-line"></i>
                                </div>
                            </button>
                            <div class="relative ml-3">
                                <div class="flex items-center">
                                    <span
                                        class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800"
                                        >
                                        Online
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Main content area -->
                <main class="w-full max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-6 overflow-x-auto">
                    <!-- Title -->
                    <div class="mb-8">
                        <h1 class="text-2xl font-bold text-gray-900">Danh sách người tham gia</h1>
                        <p class="mt-2 text-sm text-gray-600">
                            Theo dõi và quản lý người tham gia sự kiện của bạn
                        </p>
                    </div>
                    
                    <form action="EventNotification" method="get" >
                        <input type="hidden" name="action" value="sendinfo">
                        <input type="hidden" name="eventId" value="${eventId}">
                        <div class="grid grid-cols-12 gap-4 my-6">
                            <button 
                                class="col-span-12 sm:col-span-4 bg-white rounded-lg shadow-sm p-4 flex items-center hover:shadow-md transition-shadow whitespace-nowrap">
                                <div class="w-10 h-10 bg-blue-100 rounded-full flex items-center justify-center mr-3">
                                    <i class="ri-notification-3-line ri-lg text-primary"></i>
                                </div>
                                <span class="font-medium">Gửi thông báo</span>
                            </button>
                        </div>
                    </form>
                    
                    <div class="flex flex-col md:flex-row gap-4 mb-6">

                        <form method="get" action="EventParticipants"
                              class="flex-1 flex flex-col sm:flex-row items-stretch sm:items-center bg-white rounded-lg shadow-sm border border-gray-200 p-4 gap-2">
                            <input type="hidden" name="action" value="search">
                            <input type="hidden" name="eventId" value="${eventId}">
                            <div class="relative flex-1">
                                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                    <i class="ri-search-line text-gray-400"></i>
                                </div>
                                <input type="text" name="keyword"
                                       value="${search}"
                                       class="block w-full pl-10 pr-3 py-2 border border-gray-300 rounded-button text-sm placeholder-gray-400 focus:ring-2 focus:ring-primary focus:ring-opacity-20 focus:border-primary"
                                       placeholder="Tìm theo tên, email, SĐT..." />
                            </div>
                            <button type="submit"
                                    class="flex-shrink-0 inline-flex items-center justify-center px-4 py-2 bg-primary text-white text-sm font-medium rounded-button hover:bg-primary/90 transition">
                                <i class="ri-search-line mr-2"></i> Tìm kiếm
                            </button>
                        </form>


                        <form method="get" action="EventParticipants"
                              class="flex flex-col sm:flex-row items-stretch sm:items-center bg-white rounded-lg shadow-sm border border-gray-200 p-4 gap-2 sm:w-auto w-full">
                            <input type="hidden" name="action" value="filter">
                            <input type="hidden" name="eventId" value="${eventId}">
                            <div class="relative w-full sm:w-48">
                                <select name="status"
                                        class="block w-full pl-3 pr-10 py-2 text-base border border-gray-300 rounded-button appearance-none focus:outline-none focus:ring-2 focus:ring-primary focus:ring-opacity-20 focus:border-primary bg-white text-sm">
                                    <option value="" <c:if test="${empty status}">selected</c:if>>Tất cả trạng thái</option>
                                    <option value="1" <c:if test="${status == '1'}">selected</c:if>>Đã check-in</option>
                                    <option value="0" <c:if test="${status == '0'}">selected</c:if>>Chưa check-in</option>
                                    </select>
                                    <div class="absolute inset-y-0 right-0 flex items-center pr-2 pointer-events-none">
                                        <i class="ri-arrow-down-s-line text-gray-400"></i>
                                    </div>
                                </div>
                                <button type="submit"
                                        class="inline-flex items-center justify-center px-4 py-2 bg-secondary text-white text-sm font-medium rounded-button hover:bg-secondary/90 transition">
                                    <i class="ri-filter-line mr-2"></i> Lọc
                                </button>
                            </form>
                        </div>

                        <div class="bg-white rounded-lg shadow-sm border border-gray-200 overflow-hidden">
                            <div class="overflow-x-auto">
                                <table class="min-w-full divide-y divide-gray-200">
                                    <thead class="bg-gray-50">
                                        <tr>
                                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                Họ và tên
                                            </th>
                                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                CCCD
                                            </th>
                                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                Email
                                            </th>
                                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                Số điện thoại
                                            </th>
                                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                Trạng thái
                                            </th>
                                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                Thời gian check-in
                                            </th>
                                            <th class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                Thao tác
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody class="bg-white divide-y divide-gray-200">
                                    <c:forEach var="o" items="${listEP}">
                                        <tr class="hover:bg-gray-50">
                                            <td class="px-6 py-4 whitespace-nowrap">
                                                <div class="flex items-center">
                                                    <div class="w-8 h-8 bg-primary/10 rounded-full flex items-center justify-center text-primary">
                                                        <i class="ri-user-line w-4 h-4"></i>
                                                    </div>
                                                    <div class="ml-3">
                                                        <div class="text-sm font-medium text-gray-900">${o.fullName}</div>
                                                    </div>
                                                </div>
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${o.cccd}</td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${o.email}</td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${o.numberPhone}</td>

                                            <td class="px-6 py-4 whitespace-nowrap">
                                                <c:if test="${o.checkin}">
                                                    <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-green-100 text-green-800">Đã check in</span>
                                                </c:if>
                                                <c:if test="${!o.checkin}">
                                                    <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-gray-100 text-gray-800">Chưa check in</span>
                                                </c:if>
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${o.checkinTime}</td>
                                            <td class="px-6 py-4 whitespace-nowrap text-right text-sm">

                                                <c:if test="${!o.checkin}">
                                                    <form method="get" action="EventParticipants">
                                                        <input type="hidden" name="action" value="checkin"/>
                                                        <input type="hidden" name="eventId" value="${eventId}"/>
                                                        <input type="hidden" name="userId" value="${o.userId}"/>
                                                        <button type="submit" class="text-blue-600 hover:text-blue-800 font-semibold text-sm">
                                                            Check-in
                                                        </button>
                                                    </form>
                                                </c:if>

                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>


                        <div class="bg-white px-4 py-3 flex items-center justify-between border-t border-gray-200 sm:px-6">
                            <div class="flex-1 flex justify-between sm:hidden">
                                <a href="#" class="inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-button text-gray-700 bg-white hover:bg-gray-50">Trang trước</a>
                                <a href="#" class="ml-3 inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-button text-gray-700 bg-white hover:bg-gray-50">Trang sau</a>
                            </div>
                            <div class="hidden sm:flex-1 sm:flex sm:items-center sm:justify-between">
                                <div>
                                    <p class="text-sm text-gray-700">
                                        Hiển thị <span class="font-medium">1</span> đến <span class="font-medium">5</span> của <span class="font-medium">15</span> người tham gia
                                    </p>
                                </div>
                                <div>
                                    <nav class="relative z-0 inline-flex rounded-md shadow-sm -space-x-px" aria-label="Pagination">
                                        <a href="#" class="relative inline-flex items-center px-2 py-2 rounded-l-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50">
                                            <span class="sr-only">Trang trước</span>
                                            <i class="ri-arrow-left-s-line"></i>
                                        </a>
                                        <a href="#" class="z-10 bg-primary border-primary text-white relative inline-flex items-center px-4 py-2 border text-sm font-medium">1</a>
                                        <a href="#" class="bg-white border-gray-300 text-gray-500 hover:bg-gray-50 relative inline-flex items-center px-4 py-2 border text-sm font-medium">2</a>
                                        <a href="#" class="bg-white border-gray-300 text-gray-500 hover:bg-gray-50 relative inline-flex items-center px-4 py-2 border text-sm font-medium">3</a>
                                        <a href="#" class="relative inline-flex items-center px-2 py-2 rounded-r-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50">
                                            <span class="sr-only">Trang sau</span>
                                            <i class="ri-arrow-right-s-line"></i>
                                        </a>
                                    </nav>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>

            </div>
        </div>
    </body>
</html>