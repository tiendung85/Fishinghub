<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <title>Fish Species List</title>
        <script src="https://cdn.tailwindcss.com/3.4.16"></script>
        <script>tailwind.config = {theme: {extend: {colors: {primary: '#3b82f6', secondary: '#10b981'}, borderRadius: {'none': '0px', 'sm': '4px', DEFAULT: '8px', 'md': '12px', 'lg': '16px', 'xl': '20px', '2xl': '24px', '3xl': '32px', 'full': '9999px', 'button': '8px'}}}}</script>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.6.0/remixicon.min.css" rel="stylesheet">
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
                        <a href="Event.jsp" class="px-4 py-2 text-gray-800 font-medium hover:text-primary">Sự Kiện</a>
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
        <div class="bg-white border-b">
            <div class="container mx-auto px-4 py-3">
                <div class="flex items-center text-sm">
                    <a href="Home.jsp" class="text-gray-500 hover:text-primary">Trang Chủ</a>
                    <span class="mx-2 text-gray-400">/</span>
                    <span class="text-primary font-medium">Kiến Thức</span>
                </div>
            </div>
        </div>

        <main class="container mx-auto px-4 py-8">
            <div class="grid grid-cols-1 md:grid-cols-12 gap-6">
                <!-- Sidebar trái: Độ khó -->
                <aside class="hidden md:block md:col-span-2 bg-white rounded-lg shadow p-4 mb-6">
                    <h3 class="font-bold text-gray-800 mb-3 text-base">Phân loại cá</h3>
                    <ul class="space-y-2">
                        <%-- Cá khó bắt --%>
                        <li class="flex items-center text-sm text-gray-700 cursor-pointer group px-3 py-2 rounded-md hover:bg-gray-200 transition-colors
                            ${param.difficulty == 'hard' ? 'bg-blue-100 text-blue-700' : ''}"
                            onclick="window.location.href='KnowledgeFish?difficulty=hard'">
                            <span class="mr-2">Cá khó bắt</span> <span class="ml-auto">😈</span>
                        </li>
                        <%-- Cá dễ bắt --%>
                        <li class="flex items-center text-sm text-gray-700 cursor-pointer group px-3 py-2 rounded-md hover:bg-gray-200 transition-colors
                            ${param.difficulty == 'easy' ? 'bg-blue-100 text-blue-700' : ''}"
                            onclick="window.location.href='KnowledgeFish?difficulty=easy'">
                            <span class="mr-2">Cá dễ bắt</span> <span class="ml-auto">🎣</span>
                        </li>
                        <%-- Hiện tất cả --%>
                        <li class="flex items-center text-xs text-gray-400 cursor-pointer group px-3 py-2 rounded-md hover:bg-gray-200 transition-colors
                            ${param.difficulty == null ? 'bg-blue-100 text-blue-700' : ''}"
                            onclick="window.location.href='KnowledgeFish'">
                            <span class="mr-2">Hiện tất cả</span>
                        </li>
                    </ul>
                </aside>
                <!-- Nội dung chính: Danh sách cá -->
                <section class="col-span-1 md:col-span-8">
                    <div class="mb-6">
                        <h2 class="text-center text-xl font-bold bg-blue-600 text-white py-3 rounded mb-6">Danh sách và thông tin các loài cá</h2>
                    </div>
                    <div id="fishList" class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
                        <c:choose>
                            <c:when test="${not empty fishList}">
                                <c:forEach var="fish" items="${fishList}">
                                    <div class="card-fish bg-white rounded-lg shadow overflow-hidden">
                                        <div class="relative aspect-square w-full">
                                            <img src="${fish.images[0]}" alt="${fish.commonName}" class="w-full h-full object-cover object-center">

                                        </div>
                                        <div class="p-4">
                                            <h3 class="font-bold text-gray-800 text-lg mb-1">${fish.commonName}</h3>
                                            <p class="text-sm text-gray-600 mb-2"><i class="ri-map-pin-line mr-1"></i> ${fish.fishingSpots}</p>
                                            <div class="flex items-center space-x-2 mb-4">
                                                <span class="text-xs text-gray-500">Độ Khó:</span>
                                                <span class="text-xs font-semibold text-primary">${fish.difficultyLevel}</span>
                                            </div>
                                            <div class="flex justify-end">
                                                <a href="FishDetails?id=${fish.id}"
                                                   class="inline-block px-4 py-1 border border-primary text-primary rounded-button text-sm hover:bg-primary hover:text-white transition-colors">
                                                    Chi Tiết
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="col-span-4 text-center text-gray-500">Không tìm thấy loài cá nào</div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <!-- Phân trang: chỉ hiển thị khi không filter -->
                    <c:if test="${param.difficulty == null}">
                    <div class="mt-10 flex justify-center">
                        <nav id="paginationNav" class="flex items-center space-x-1">
                            <button class="pagination-btn w-8 h-8 flex items-center justify-center rounded text-gray-600 text-sm" ${currentPage == 1 ? 'disabled' : ''} onclick="window.location.href = 'KnowledgeFish?page=${currentPage - 1}'">
                                <i class="ri-arrow-left-s-line"></i>
                            </button>
                            <c:forEach var="i" begin="1" end="${totalPages}">
                                <button class="pagination-btn w-8 h-8 flex items-center justify-center rounded text-gray-600 text-sm ${currentPage == i ? 'active bg-primary text-white' : ''}"
                                        onclick="window.location.href = 'KnowledgeFish?page=${i}'">${i}</button>
                            </c:forEach>
                            <button class="pagination-btn w-8 h-8 flex items-center justify-center rounded text-gray-600 text-sm" ${currentPage == totalPages ? 'disabled' : ''} onclick="window.location.href = 'KnowledgeFish?page=${currentPage + 1}'">
                                <i class="ri-arrow-right-s-line"></i>
                            </button>
                        </nav>
                    </div>
                    </c:if>
                </section>
                <!-- Sidebar phải: Tips/Cần câu -->
                <aside class="hidden md:block md:col-span-2 bg-white rounded-lg shadow p-4 mb-6 hover:bg-gray-100 transition-colors">
                    <div class="bg-white rounded-lg shadow p-4 mb-6">
                        <h3 class="font-bold text-gray-800 mb-3 text-base">Tips &amp; Cần câu</h3>
                        <ul class="space-y-2">
                            <li class="text-sm text-gray-700">
                                <a href="TipsToCatch.html" class="hover:text-primary transition-colors">Cách Câu được nhiều cá hơn</a>
                            </li>
                            <li class="text-sm text-gray-700">
                                <a href="RoodsForBeginners.html" class="hover:text-primary transition-colors">Cần câu tốt nhất cho người mới</a>
                            </li>
                        </ul>
                    </div>
                </aside>
            </div>
        </main>
        <button id="backToTop" class="back-to-top fixed bottom-6 right-6 w-12 h-12 bg-primary text-white rounded-full shadow-lg flex items-center justify-center">
            <i class="ri-arrow-up-line text-xl"></i>
        </button>
        <!-- Footer -->
        <footer class="bg-gray-800 text-white pt-12 pb-6">
            <div class="container mx-auto px-4">
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8 mb-8">
                    <!-- About section -->
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
                    <!-- Quick Links -->
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
                    <!-- Support -->
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
                    <!-- Payment Methods -->
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
        <script src="https://cdnjs.cloudflare.com/ajax/libs/echarts/5.5.0/echarts.min.js"></script>
        <script>
            // Đã chuyển filter sang server, không cần JS filter nữa
        </script>
    </body>
</html>