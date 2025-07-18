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
<html>
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
                        <h1 class="text-2xl font-bold text-gray-900">Quản Lý Sự Kiện</h1>
                        <p class="mt-2 text-sm text-gray-600">
                            Quản lý và theo dõi tất cả các sự kiện của bạn tại một nơi
                        </p>
                    </div>

                    <!-- Search and Filter -->
                    <div class="flex flex-col md:flex-row gap-4 mb-6">
                        <!-- Search Form -->
                        <form method="get" action="EventManager"
                              class="flex-1 flex flex-col sm:flex-row items-stretch sm:items-center bg-white rounded-lg shadow-sm border border-gray-200 p-4 gap-2">

                            <input type="hidden" name="action" value="search">
                            <div class="relative flex-1">
                                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                    <i class="ri-search-line text-gray-400"></i>
                                </div>
                                <input type="text" name="search"
                                       value="${search}"
                                       class="block w-full pl-10 pr-3 py-2 border border-gray-300 rounded-button text-sm placeholder-gray-400 focus:ring-2 focus:ring-primary focus:ring-opacity-20 focus:border-primary"
                                       placeholder="Tìm kiếm sự kiện..." />
                            </div>
                            <button type="submit"
                                    class="flex-shrink-0 inline-flex items-center justify-center px-4 py-2 bg-primary text-white text-sm font-medium rounded-button hover:bg-primary/90 transition">
                                <i class="ri-search-line mr-2"></i> Tìm kiếm
                            </button>
                        </form>

                        <!-- Filter Form -->
                        <form method="get" action="EventManager"
                              class="flex flex-col sm:flex-row items-stretch sm:items-center bg-white rounded-lg shadow-sm border border-gray-200 p-4 gap-2 sm:w-auto w-full">
                            <input type="hidden" name="action" value="filter">
                            <div class="relative w-full sm:w-48">
                                <select id="event-status-filter" name="status"
                                        class="block w-full pl-3 pr-10 py-2 text-base border border-gray-300 rounded-button appearance-none focus:outline-none focus:ring-2 focus:ring-primary focus:ring-opacity-20 focus:border-primary bg-white text-sm">
                                    <option value="all" <c:if test="${empty filter or filter == 'all'}">selected</c:if>>Tất cả sự kiện</option>
                                    <option value="ongoing" <c:if test="${filter == 'ongoing'}">selected</c:if>>Sự kiện đang diễn ra</option>
                                    <option value="upcoming" <c:if test="${filter == 'upcoming'}">selected</c:if>>Sự kiện sắp diễn ra</option>
                                    <option value="ended" <c:if test="${filter == 'ended'}">selected</c:if>>Sự kiện đã kết thúc</option>                            
                                    <option value="pass" <c:if test="${filter == 'pass'}">selected</c:if>>Sự kiện đã được duyệt</option>
                                    <option value="pending" <c:if test="${filter == 'pending'}">selected</c:if>>Sự kiện chờ duyệt</option>
                                    <option value="reject" <c:if test="${filter == 'reject'}">selected</c:if>>Sự kiện bị từ chối</option>

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
                        <!-- ...existing code... -->

                        <!-- Events Table -->
                        <div class="bg-white rounded-lg shadow-sm border border-gray-200 overflow-hidden">
                            <div class="overflow-x-auto">
                                <table class="event-table min-w-full divide-y divide-gray-200">
                                    <thead class="bg-gray-50">
                                        <tr>
                                            <th scope="col"
                                                class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                Tên sự kiện
                                            </th>
                                            <th scope="col"
                                                class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                Thời gian
                                            </th>
                                            <th scope="col"
                                                class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                Địa điểm
                                            </th>
                                            <th scope="col"
                                                class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                Trạng thái thời gian
                                            </th>
                                            <th scope="col"
                                                class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                Trạng thái duyệt
                                            </th>
                                            <th scope="col"
                                                class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                Người tham gia
                                            </th>
                                            <th scope="col"
                                                class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                Thao tác
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody class="bg-white divide-y divide-gray-200">
                                    <c:forEach var="o" items="${listE}">
                                        <tr class="hover:bg-gray-50">
                                            <td class="px-6 py-4 whitespace-nowrap">
                                                <div class="flex items-center">

                                                    <div >
                                                        <div class="text-sm font-medium text-gray-900">
                                                            ${o.title}
                                                        </div>

                                                    </div>
                                                </div>
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap">
                                                <div class="text-sm text-gray-900">${o.formattedStartTime}</div>
                                                <div class="text-sm text-gray-900">${o.formattedEndTime}</div>
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap">
                                                <div class="text-sm text-gray-900">
                                                    ${o.location}
                                                </div>

                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap">
                                                <c:choose>
                                                    <c:when test="${o.eventStatus == 'Sắp diễn ra' && o.status == 'approved' }">
                                                        <span
                                                            class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-yellow-100 text-yellow-600">Sắp diễn ra
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${o.eventStatus == 'Đã kết thúc' && o.status == 'approved'}">
                                                        <span
                                                            class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-gray-100 text-gray-800">Đã kết thúc
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${o.eventStatus == 'Đang diễn ra' && o.status == 'approved'}">
                                                        <span
                                                            class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-green-100 text-green-800">Đang diễn ra
                                                        </span>
                                                    </c:when>
                                                </c:choose>
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap">
                                                <c:choose>
                                                    <c:when test="${o.status == 'pending'}">
                                                        <span
                                                            class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-red-100 text-red-800">Chờ duyệt
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${o.status == 'approved'}">
                                                        <span
                                                            class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-green-100 text-green-800">Đã duyệt 
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${o.status == 'rejected'}">
                                                        <span
                                                            class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-gray-100 text-gray-800">Từ chối
                                                        </span>
                                                    </c:when>
                                                </c:choose>
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                                <button class="inline-flex items-center text-primary hover:text-primary/80"
                                                        data-event-id="1">
                                                    <a href="EventParticipants?action=list&eventId=${o.eventId}"><span>${o.currentParticipants}/${o.maxParticipants}</span><i class="ri-eye-line ml-1"></i></a>

                                                </button>
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                                                <div class="flex justify-end space-x-2">
                                                    <button onclick="location.href = 'EventUpdate?action=event&eventId=${o.eventId}'"
                                                            class="w-8 h-8 flex items-center justify-center rounded-full hover:bg-gray-100">
                                                        <i class="ri-edit-line text-blue-600"></i>
                                                    </button>
                                                    <c:if test="${o.status == 'pending'}">
                                                        <button onclick="confirmDelete(${o.eventId})"
                                                                class="w-8 h-8 flex items-center justify-center rounded-full hover:bg-gray-100">
                                                            <i class="ri-delete-bin-line text-red-600"></i>
                                                        </button>
                                                    </c:if>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>

                                </tbody>
                            </table>
                        </div>
                        <script>
                            function confirmDelete(eventId) {
                                if (confirm("Bạn có chắc chắn muốn xóa sự kiện này không?")) {
                                    window.location.href = 'EventManager?action=delete&eventId=' + eventId;
                                }
                            }
                        </script>
                        <!-- Pagination -->
                        <div class="bg-white px-4 py-3 flex items-center justify-between border-t border-gray-200 sm:px-6">
                            <div class="flex-1 flex justify-between sm:hidden">
                                <a href="#"
                                   class="relative inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-button text-gray-700 bg-white hover:bg-gray-50 whitespace-nowrap !rounded-button">
                                    Trang trước
                                </a>
                                <a href="#"
                                   class="ml-3 relative inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-button text-gray-700 bg-white hover:bg-gray-50 whitespace-nowrap !rounded-button">
                                    Trang sau
                                </a>
                            </div>
                            <div class="hidden sm:flex-1 sm:flex sm:items-center sm:justify-between">
                                <div>
                                    <p class="text-sm text-gray-700">
                                        Hiển thị <span class="font-medium">1</span> đến
                                        <span class="font-medium">5</span> của
                                        <span class="font-medium">12</span> sự kiện
                                    </p>
                                </div>
                                <div>
                                    <nav class="relative z-0 inline-flex rounded-md shadow-sm -space-x-px"
                                         aria-label="Pagination">
                                        <a href="#"
                                           class="relative inline-flex items-center px-2 py-2 rounded-l-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50">
                                            <span class="sr-only">Trang trước</span>
                                            <i class="ri-arrow-left-s-line"></i>
                                        </a>
                                        <a href="#" aria-current="page"
                                           class="z-10 bg-primary border-primary text-white relative inline-flex items-center px-4 py-2 border text-sm font-medium">
                                            1
                                        </a>
                                        <a href="#"
                                           class="bg-white border-gray-300 text-gray-500 hover:bg-gray-50 relative inline-flex items-center px-4 py-2 border text-sm font-medium">
                                            2
                                        </a>
                                        <a href="#"
                                           class="bg-white border-gray-300 text-gray-500 hover:bg-gray-50 relative inline-flex items-center px-4 py-2 border text-sm font-medium">
                                            3
                                        </a>
                                        <span
                                            class="relative inline-flex items-center px-4 py-2 border border-gray-300 bg-white text-sm font-medium text-gray-700">
                                            ...
                                        </span>
                                        <a href="#"
                                           class="relative inline-flex items-center px-2 py-2 rounded-r-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50">
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