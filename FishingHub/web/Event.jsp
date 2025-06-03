<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
    </head>
    <body>
        <!-- Header -->
        <header class="bg-white shadow-sm">
            <div class="container mx-auto px-4 py-3 flex items-center justify-between">
                <div class="flex items-center">
                    <a href="Home.jsp" class="text-3xl font-['Pacifico'] text-primary">FishingHub</a>
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
                    <div class="relative w-10 h-10 flex items-center justify-center">
                        <button class="text-gray-700 hover:text-primary">
                            <i class="ri-shopping-cart-2-line text-xl"></i>
                        </button>
                        <span class="absolute -top-1 -right-1 bg-red-500 text-white text-xs w-5 h-5 flex items-center justify-center rounded-full">3</span>
                    </div>
                    <div class="relative">
                        <div class="w-10 h-10 flex items-center justify-center rounded-full bg-gray-100 cursor-pointer">
                            <i class="ri-notification-3-line text-gray-600"></i>
                        </div>
                        <span class="absolute -top-1 -right-1 flex h-5 w-5 items-center justify-center rounded-full bg-primary text-xs text-white">3</span>
                    </div>
                    
                    
                  <% if (currentUser == null) { %>
                        <a href="Login.jsp" class="bg-primary text-white px-4 py-2 rounded-button whitespace-nowrap">Đăng Nhập</a>
                        <a href="Register.jsp" class="bg-white text-primary border border-primary px-4 py-2 rounded-button whitespace-nowrap">Đăng Ký</a>
                    <% } else { %>
                        <div class="flex items-center space-x-3">
                            <span class="font-semibold text-primary"><i class="ri-user-line mr-1"></i> <%= currentUser.getFullName() %></span>
                            <% if(currentUser.getRoleId() == 2) { %>
                                <a href="dashboard_owner/Dashboard.jsp" class="bg-secondary text-white px-4 py-2 rounded-button whitespace-nowrap hover:bg-secondary/90">Dashboard</a>
                            <% } %>
                            <form action="logout" method="post" style="display:inline;">
                                <button type="submit" class="bg-gray-200 text-gray-800 px-3 py-2 rounded-button hover:bg-gray-300">Đăng Xuất</button>
                            </form>
                        </div>
                    <% } %>
                </div>
            </div>
        </header>

        <!-- Breadcrumb -->
        <div class="bg-gray-50 border-b border-gray-200">
            <div class="container mx-auto px-4 py-3">
                <div class="flex items-center text-sm">
                    <a href="Home.jsp" data-readdy="true" class="text-gray-600 hover:text-primary">Home</a>
                    <div class="w-4 h-4 flex items-center justify-center text-gray-400 mx-1">
                        <i class="ri-arrow-right-s-line"></i>
                    </div>
                    <span class="text-primary font-medium">Sự kiện</span>
                </div>
            </div>
        </div>

        <!-- Main Content -->
        <main class="py-8">
            <div class="container mx-auto px-4">
                <div class="flex flex-col md:flex-row justify-between items-start md:items-center mb-8 gap-4">
                    <div>
                        <h1 class="text-3xl font-bold text-gray-900">Featured Events</h1>
                        <p class="text-gray-600 mt-2">All ongoing and upcoming fishing events</p>
                    </div>
                    <div class="flex items-center justify-between gap-4">
                        <form action="SearchEvent" method="GET" class="flex items-center w-full max-w-lg">
                            <input type="text" name="query" placeholder="Search for events..."
                                   class="w-full pl-4 pr-20 py-2 border-none bg-white shadow-sm focus:ring-2 focus:ring-primary focus:outline-none text-sm">
                            <button type="submit" class="bg-primary text-white px-4 py-2 hover:bg-blue-700 flex items-center justify-center">
                                <i class="ri-search-line"></i>
                            </button>
                        </form>
                        <c:if test="${user.getRoleId() == 2}">
                            <a href="Event?action=create_event" class="bg-primary text-white px-6 py-2 rounded-button whitespace-nowrap flex items-center gap-2">
                                <i class="ri-add-line"></i>
                                <span>Create Event</span>
                            </a>
                        </c:if>
                    </div>
                </div>

                <div class="bg-white rounded shadow-sm mb-8">
                    <div class="flex border-b border-gray-200">
                        <button class="tab-button px-6 py-4 text-gray-600 font-medium hover:text-primary" onclick="location.href = 'EventList'"> All Events </button>
                        <button class="tab-button px-6 py-4 text-gray-600 font-medium hover:text-primary cursor-pointer" onclick="location.href = 'EventList?action=upcoming'">Up Coming Events</button>
                        <button class="tab-button px-6 py-4 text-gray-600 font-medium hover:text-primary" onclick="location.href = 'EventList?action=ongoing'">Ongoing Events</button>
                        <button class="tab-button px-6 py-4 text-gray-600 font-medium hover:text-primary">My Events</button>
                    </div>
                </div>

                <!-- Events List -->
                <div id="all-events" class="event-list">
                    <c:if test="${not empty success}">
                        <div class="bg-green-100 text-green-700 p-4 rounded mb-4">
                            ${success}
                        </div>
                    </c:if>
                    <c:if test="${not empty error}">
                        <div class="bg-red-100 text-red-700 p-4 rounded mb-4">
                            ${error}
                        </c:if>
                        <c:choose>
                            <c:when test="${empty listE}">
                                <div class="bg-white rounded shadow-sm p-6 text-center">
                                    <p class="text-gray-600 text-lg">Không có sự kiện nào.</p>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 mb-8">
                                    <c:set var="index" value="0" />
                                    <c:forEach items="${listE}" var="o">
                                        <div class="bg-white rounded shadow-md overflow-hidden border border-gray-100">
                                            <div class="h-48 overflow-hidden">
                                                <img src="assets/img/eventPoster/${o.posterUrl}" alt="${o.title}" class="w-full h-full object-cover object-top">
                                            </div>
                                            <div class="p-5">
                                                <div class="flex justify-between items-center mb-3">
                                                    <c:choose>
                                                        <c:when test="${o.eventStatus == 'Sắp diễn ra'}">
                                                            <span class="bg-blue-100 text-blue-600 text-xs px-3 py-1 rounded-full">${o.eventStatus}</span>
                                                        </c:when>
                                                        <c:when test="${o.eventStatus == 'Đang diễn ra'}">
                                                            <span class="bg-green-100 text-green-600 text-xs px-3 py-1 rounded-full">${o.eventStatus}</span>
                                                        </c:when>
                                                        <c:when test="${o.eventStatus == 'Đã kết thúc'}">
                                                            <span class="bg-gray-200 text-gray-600 text-xs px-3 py-1 rounded-full">${o.eventStatus}</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="bg-yellow-100 text-yellow-600 text-xs px-3 py-1 rounded-full">${o.eventStatus}</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <span class="text-sm text-gray-500">
                                                        <c:choose>
                                                            <c:when test="${o.eventStatus == 'Sắp diễn ra'}">${o.formattedStartDate} - ${o.formattedEndDate}</c:when>
                                                            <c:when test="${o.eventStatus == 'Đang diễn ra'}">${o.formattedEndDate}</c:when>
                                                            <c:when test="${o.eventStatus == 'Đã kết thúc'}">${o.formattedStartDate}</c:when>
                                                            <c:otherwise>${o.formattedStartDate}</c:otherwise>
                                                        </c:choose>
                                                    </span>
                                                </div>
                                                <h3 class="text-xl font-bold mb-2">${o.title}</h3>
                                                <p class="text-gray-600 mb-4 line-clamp-2">${o.description}</p>
                                                <div class="flex justify-between items-center">
                                                    <div class="flex items-center">
                                                        <div class="w-5 h-5 flex items-center justify-center text-gray-500">
                                                            <i class="ri-map-pin-line"></i>
                                                        </div>
                                                        <span class="ml-1 text-sm text-gray-500">${o.location}</span>
                                                    </div>
                                                    <div class="flex items-center">
                                                        <div class="w-5 h-5 flex items-center justify-center text-gray-500">
                                                            <i class="ri-user-line"></i>
                                                        </div>
                                                        <span class="ml-1 text-sm text-gray-500 participant-count" data-event-id="${o.eventId}">
                                                            ${o.currentParticipants}/${o.maxParticipants} people
                                                        </span>
                                                    </div>
                                                </div>
                                                <div class="flex gap-4 mt-4">
                                                    <c:choose>
                                                        <c:when test="${isRegisteredList[index] && o.eventStatus == 'Sắp diễn ra'}">
                                                            <!-- User is registered and event is upcoming -->
                                                            <button class="w-full bg-red-600 text-white py-2 rounded-button whitespace-nowrap text-center hover:bg-red-700 cancel-btn"
                                                                    data-event-id="${o.eventId}"
                                                                    onclick="showCancelModal('RegisterEvent?action=cancel&eventId=${o.eventId}', '${o.title}')">
                                                                Cancel Registration
                                                            </button>
                                                        </c:when>
                                                        <c:when test="${isRegisteredList[index] || o.currentParticipants >= o.maxParticipants || o.eventStatus == 'Đã kết thúc' || o.eventStatus == 'Đang diễn ra'}">
                                                            <!-- User is registered, event is full, event has ended, or event is ongoing -->
                                                            <span class="w-full bg-gray-400 text-white py-2 rounded-button whitespace-nowrap text-center cursor-not-allowed">
                                                                <c:choose>
                                                                    <c:when test="${o.eventStatus == 'Đã kết thúc'}">Event Ended</c:when>
                                                                    <c:when test="${o.eventStatus == 'Đang diễn ra'}">Event Ongoing</c:when>
                                                                    <c:when test="${o.currentParticipants >= o.maxParticipants}">Event Full</c:when>
                                                                    <c:otherwise>Already Registered</c:otherwise>
                                                                </c:choose>
                                                            </span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <!-- User is not registered, event is not full, and event is upcoming -->
                                                            <button class="w-full bg-blue-600 text-white py-2 rounded-button whitespace-nowrap text-center hover:bg-blue-700 register-btn"
                                                                    data-event-id="${o.eventId}"
                                                                    onclick="showRegisterModal('RegisterEvent?action=register&eventId=${o.eventId}', '${o.title}')">
                                                                Register to Join
                                                            </button>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <a href="EventDetails?eventId=${o.eventId}" 
                                                       class="w-full bg-gray-200 text-gray-700 py-2 rounded-button whitespace-nowrap text-center hover:bg-gray-300">
                                                        View
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                        <c:set var="index" value="${index + 1}" />
                                    </c:forEach>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <!-- Registration Modal -->
                    <div id="registerModal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center hidden">
                        <div class="bg-white rounded-lg p-6 w-full max-w-md">
                            <h2 class="text-xl font-bold mb-4">Confirm Registration</h2>
                            <p class="text-gray-600 mb-6">Are you sure you want to register for <span id="eventTitle" class="font-semibold"></span>?</p>
                            <div class="flex justify-end gap-4">
                                <button id="cancelButton" class="bg-gray-200 text-gray-700 px-4 py-2 rounded-button hover:bg-gray-300">Cancel</button>
                                <button id="confirmButton" class="bg-blue-600 text-white px-4 py-2 rounded-button hover:bg-blue-700">Confirm</button>
                            </div>
                        </div>
                    </div>

                    <!-- Cancel Registration Modal -->
                    <div id="cancelModal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center hidden">
                        <div class="bg-white rounded-lg p-6 w-full max-w-md">
                            <h2 class="text-xl font-bold mb-4">Confirm Cancellation</h2>
                            <p class="text-gray-600 mb-6">Are you sure you want to cancel your registration for <span id="cancelEventTitle" class="font-semibold"></span>?</p>
                            <div class="flex justify-end gap-4">
                                <button id="cancelCancelButton" class="bg-gray-200 text-gray-700 px-4 py-2 rounded-button hover:bg-gray-300">Cancel</button>
                                <button id="confirmCancelButton" class="bg-red-600 text-white px-4 py-2 rounded-button hover:bg-red-700">Confirm</button>
                            </div>
                        </div>
                    </div>

                    <!-- Pagination -->
                    <div class="flex justify-between items-center">
                        <div class="text-sm text-gray-600">Showing 1-9 of 42 events</div>
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
                        <div class="flex items-center gap-2">
                            <span class="text-sm text-gray-600">Show:</span>
                            <div class="relative">
                                <select class="pl-3 pr-8 py-1 rounded appearance-none bg-white border-none shadow-sm focus:ring-2 focus:ring-primary focus:outline-none text-sm">
                                    <option value="9">9</option>
                                    <option value="18">18</option>
                                    <option value="27">27</option>
                                    <option value="36">36</option>
                                </select>
                                <div class="absolute right-2 top-1/2 transform -translate-y-1/2 w-4 h-4 flex items-center justify-center text-gray-400 pointer-events-none">
                                    <i class="ri-arrow-down-s-line"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
        </main>

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
                        <h3 class="text-lg font-bold mb-4">Liên Kết Nhanh</h3>
                        <ul class="space-y-2">
                            <li><a href="Home.jsp" class="text-gray-400 hover:text-white">Trang Chủ</a></li>
                            <li><a href="Event.jsp" class="text-gray-400 hover:text-white">Sự Kiện</a></li>
                            <li><a href="NewFeed.jsp" class="text-gray-400 hover:text-white">Bảng Tin</a></li>
                            <li><a href="Product.jsp" class="text-gray-400 hover:text-white">Cửa Hàng</a></li>
                            <li><a href="KnowledgeFish" class="text-gray-400 hover:text-white">Kiến Thức</a></li>
                            <li><a href="Achievement.jsp" class="text-gray-400 hover:text-white">Xếp Hạng</a></li>
                        </ul>
                    </div>
                    <div>
                        <h3 class="text-lg font-bold mb-4">Hỗ Trợ</h3>
                        <ul class="space-y-2">
                            <li><a href="#" class="text-gray-400 hover:text-white">Trung Tâm Trợ Giúp</a></li>
                            <li><a href="#" class="text-gray-400 hover:text-white">Chính Sách Bảo Mật</a></li>
                            <li><a href="#" class="text-gray-400 hover:text-white">Điều Khoản Sử Dụng</a></li>
                            <li><a href="#" class="text-gray-400 hover:text-white">Chính Sách Đổi Trả</a></li>
                            <li><a href="#" class="text-gray-400 hover:text-white">Câu Hỏi Thường Gặp</a></li>
                        </ul>
                    </div>
                    <div>
                        <div class="mt-4">
                            <h4 class="text-sm font-medium mb-2">Phương Thức Thanh Toán</h4>
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
                    <p class="text-center text-gray-500 text-sm">© 2025 Cộng Đồng Câu Cá Việt Nam. Đã đăng ký bản quyền.</p>
                </div>
            </div>
        </footer>

        <script>
            let registrationUrl = '';
            let cancelUrl = '';

            function showRegisterModal(url, eventTitle) {
                registrationUrl = url;
                document.getElementById('eventTitle').textContent = eventTitle;
                document.getElementById('registerModal').classList.remove('hidden');
            }

            function showCancelModal(url, eventTitle) {
                cancelUrl = url;
                document.getElementById('cancelEventTitle').textContent = eventTitle;
                document.getElementById('cancelModal').classList.remove('hidden');
            }

            document.getElementById('cancelButton').addEventListener('click', () => {
                document.getElementById('registerModal').classList.add('hidden');
            });

            document.getElementById('confirmButton').addEventListener('click', () => {
                window.location.href = registrationUrl;
                document.getElementById('registerModal').classList.add('hidden');
            });

            document.getElementById('cancelCancelButton').addEventListener('click', () => {
                document.getElementById('cancelModal').classList.add('hidden');
            });

            document.getElementById('confirmCancelButton').addEventListener('click', () => {
                window.location.href = cancelUrl;
                document.getElementById('cancelModal').classList.add('hidden');
            });
        </script>
    </body>
</html>