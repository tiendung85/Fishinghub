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
                            <a href="#" class="sidebar-item active flex items-center px-2 py-2 text-sm font-medium text-gray-700 rounded-md hover:bg-gray-50 hover:text-primary">
                                <div class="w-6 h-6 mr-3 flex items-center justify-center text-gray-500">
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
                    <div class="flex flex-1 items-center justify-center min-h-screen py-8 bg-gray-50">

                        <form action="EventUpdate" method="post" id="updateEventForm" enctype="multipart/form-data"
                              class="w-full max-w-5xl bg-white p-10 rounded-lg shadow-md space-y-2">
                            <input type="hidden" name="eventId" value="${event.eventId}">

                            <% if (request.getAttribute("success") !=null) { %>
                            <div class="success bg-green-100 text-green-700 p-4 rounded mb-4"
                                 style="color: green;">
                                <%= request.getAttribute("success") %>
                            </div>
                            <% } %>

                            <% if (request.getAttribute("error") !=null) { %>
                            <div class="error bg-red-100 text-red-700 p-4 rounded mb-4"
                                 style="color: red;">
                                <%= request.getAttribute("error") %>
                            </div>
                            <% } %>
                            <input type="hidden" name="action" value="update">
                            <h1 class="text-3xl font-bold text-center text-primary mb-6">Chỉnh sửa sự kiện
                            </h1>

                            <div class="flex flex-col lg:flex-row gap-8">
                                <!-- Ảnh poster bên trái -->
                                <div class="flex-shrink-0 w-full lg:w-1/4">
                                    <label for="posterFile"
                                           class="block text-sm font-medium text-gray-700 mb-2">Ảnh
                                        Poster:</label>
                                    <!-- Ảnh xem trước -->
                                    <img id="posterPreview"
                                         src="assets/img/eventPoster/${event.posterUrl}"
                                         alt="Xem trước ảnh"
                                         class="mb-3 w-full rounded shadow object-cover ${event.posterUrl == null ? 'hidden' : ''}" />
                                    <c:if test="${event.status == 'pending'}">
                                        <input type="file" id="posterFile" name="posterFile"

                                               accept="image/*"
                                               class="block w-full h-12 text-sm text-gray-500 file:mr-4 file:py-2 file:px-4 file:rounded-md file:border file:border-black file:text-sm file:font-medium file:bg-gray-50 file:text-primary hover:file:bg-gray-100">
                                    </c:if>
                                </div>
                                <!-- Thông tin sự kiện bên phải -->
                                <div class="flex-1 lg:w-3/4 space-y-4">
                                    <div>
                                        <label for="title"
                                               class="block text-sm font-medium text-gray-700">Tiêu
                                            đề sự kiện:</label>
                                        <input type="text" id="title" name="title"
                                               value="${event.title}"
                                               ${event.status == 'pending' ? '' : 'disabled'}
                                               placeholder="Nhập tiêu đề sự kiện" required
                                               class="mt-1 block w-full h-12 rounded-md border-2 shadow-sm focus:border-primary focus:ring-primary">
                                    </div>
                                    <div>
                                        <label for="description"
                                               class="block text-sm font-medium text-gray-700">Mô
                                            tả:</label>
                                        <textarea id="description" name="description"
                                                  ${event.status == 'pending' ? '' : 'disabled'}
                                                  placeholder="Nhập mô tả sự kiện" required rows="5"
                                                  class="mt-1 block w-full rounded-md border-2 shadow-sm focus:border-primary focus:ring-primary">${event.description}</textarea>
                                    </div>
                                    <div>
                                        <label for="lakeName"
                                               class="block text-sm font-medium text-gray-700">Tên
                                            hồ
                                            câu:</label>
                                        <input type="text" id="lakeName" name="lakeName"
                                               value="${event.lakeName}"
                                               ${event.status == 'pending' ? '' : 'disabled'}
                                               placeholder="Nhập tên hồ câu" required
                                               class="mt-1 block w-full h-12 rounded-md border-2 shadow-sm focus:border-primary focus:ring-primary">
                                    </div>
                                    <div>
                                        <label for="location"
                                               class="block text-sm font-medium text-gray-700">Địa
                                            điểm:</label>
                                        <input type="text" id="location" name="location"
                                               value="${event.location}"
                                               ${event.status == 'pending' ? '' : 'disabled'}
                                               placeholder="Nhập địa điểm tổ chức" required
                                               class="mt-1 block w-full h-12 rounded-md border-2 shadow-sm focus:border-primary focus:ring-primary">
                                    </div>
                                    <div class="flex flex-col md:flex-row gap-4">
                                        <div class="flex-1">
                                            <label for="startTime"
                                                   class="block text-sm font-medium text-gray-700">Thời
                                                gian bắt đầu:</label>
                                            <input type="datetime-local" id="startTime"
                                                   value="${event.startTime}"
                                                   ${event.status == 'pending' ? '' : 'disabled'}
                                                   name="startTime" required
                                                   class="mt-1 block w-full h-12 rounded-md border-2 shadow-sm focus:border-primary focus:ring-primary">
                                        </div>
                                        <div class="flex-1">
                                            <label for="endTime"
                                                   class="block text-sm font-medium text-gray-700">Thời
                                                gian kết thúc:</label>
                                            <input type="datetime-local" id="endTime"
                                                   value="${event.endTime}"
                                                   ${event.status == 'pending' ? '' : 'disabled'}
                                                   name="endTime" required
                                                   class="mt-1 block w-full h-12 rounded-md border-2 shadow-sm focus:border-primary focus:ring-primary">
                                        </div>
                                    </div>
                                    <div>
                                        <label for="maxParticipants"
                                               class="block text-sm font-medium text-gray-700">Số
                                            người
                                            tham gia tối đa:</label>
                                        <input type="number" id="maxParticipants"
                                               name="maxParticipants" min="1"
                                               value="${event.maxParticipants}"
                                               ${event.status == 'pending' ? '' : 'disabled'}
                                               placeholder="Nhập số người tối đa" required
                                               class="mt-1 block w-full h-12 rounded-md border-2 shadow-sm focus:border-primary focus:ring-primary">
                                    </div>



                                    <div class="flex justify-end gap-4">
                                        <a href="EventManager" 
                                           class="bg-gray-300 text-gray-800 px-6 py-3 rounded-button hover:bg-gray-400 transition">
                                            Cancel
                                        </a>
                                        <c:if test="${event.status == 'pending'}">
                                            <button type="submit"
                                                    class="bg-primary text-white px-6 py-3 rounded-button hover:bg-blue-600">
                                                Update
                                            </button>
                                        </c:if>
                                    </div>


                                </div>
                            </div>
                        </form>
                    </div>
                </main>

            </div>
        </div>
    </body>
</html>


