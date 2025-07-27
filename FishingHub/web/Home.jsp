<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.Users" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
Users currentUser = (Users) session.getAttribute("user");
%>


<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Trang chủ</title>
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
                    <a href="Home" class="text-3xl font-['Pacifico'] text-primary">FishingHub</a>
                    <!-- Header navigation links -->
                    <nav class="hidden md:flex ml-10">
                        <a href="Home" class="px-4 py-2 text-gray-800 font-medium hover:text-primary">Trang Chủ</a>
                        <a href="EventList" class="px-4 py-2 text-gray-800 font-medium hover:text-primary">Sự Kiện</a>
                        <a href="NewFeed" class="px-4 py-2 text-gray-800 font-medium hover:text-primary">Bảng Tin</a>
                        <a href="shop-list" class="px-4 py-2 text-gray-800 font-medium hover:text-primary">Cửa Hàng</a>
                        <a href="KnowledgeFish" class="px-4 py-2 text-gray-800 font-medium hover:text-primary">Kiến Thức</a>
                   
                    </nav>
                </div>

                <div class="flex items-center space-x-4">
                    


                    <% if (currentUser == null) { %>
                    <!-- Khi chưa đăng nhập -->
                    <a href="Login.jsp" class="bg-primary text-white px-4 py-2 rounded-button whitespace-nowrap">Đăng Nhập</a>
                    <a href="Register.jsp" class="bg-white text-primary border border-primary px-4 py-2 rounded-button whitespace-nowrap">Đăng Ký</a>
                    <% } else { %>
                    <!-- Khi đã đăng nhập -->
                    <div class="flex items-center space-x-3">
                        <a href="Profile" class="flex items-center gap-2 font-semibold text-primary hover:text-blue-700 transition-colors">


                            <i class="ri-user-line mr-1"></i>
                            <span><%= currentUser.getFullName() %></span>
                        </a>

                        <%-- Dashboard Links --%>
                        <% if (currentUser.getRoleId() == 2) { %>
                        <a href="OwnerDashboard" class="bg-secondary text-white px-4 py-2 rounded-button whitespace-nowrap hover:bg-secondary/90">Dashboard</a>
                        <a href="LakeServlet" class="bg-secondary text-white px-4 py-2 rounded-button whitespace-nowrap hover:bg-secondary/90">Hồ câu</a>

                        <% } %>


                        <form action="logout" method="post" style="display:inline;">
                            <button type="submit" class="bg-gray-200 text-gray-800 px-3 py-2 rounded-button hover:bg-gray-300">Đăng Xuất</button>
                        </form>
                    </div>
                    <% } %>
                </div>
                </div>
        </header>
        <!-- Hero Section -->
        <!-- Hero Section -->
        <section class="hero-section relative">
            <div class="swiper heroSwiper">
                <div class="swiper-wrapper">
                    <!-- Slide 1: Banner chào mừng -->
                    <div class="swiper-slide">
                        <div class="py-16 relative bg-cover bg-center bg-no-repeat" style="background-image: url('assets/img/hero-bg.jpg'); min-height: 440px;">
                            <div class="absolute inset-0 bg-black/40"></div>
                            <div class="container mx-auto px-4 w-full relative z-10">
                                <div class="max-w-2xl">
                                    <h1 class="text-4xl md:text-5xl font-bold text-white mb-4">Cộng Đồng Câu Cá Hàng Đầu Việt Nam</h1>
                                    <p class="text-lg text-white mb-8">Tham gia cùng hơn 10,000+ người đam mê câu cá, chia sẻ kinh nghiệm và tham gia các sự kiện câu cá hấp dẫn trên khắp cả nước.</p>
                                    <div class="flex flex-col sm:flex-row gap-4">
                                        <a href="Login.jsp" class="bg-primary text-white px-6 py-3 rounded-button font-medium whitespace-nowrap hover:bg-primary/90" >Tham Gia Ngay</a>
                                        <a href="EventList"  class="bg-white text-primary border border-primary px-6 py-3 rounded-button font-medium whitespace-nowrap hover:bg-gray-50">Xem Sự Kiện</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                   
                </div>



                <div class="swiper-pagination"></div>



            </div>
        </section>
        <!-- SwiperJS Script -->
        <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
        <script>
                                            document.addEventListener("DOMContentLoaded", function () {
                                                new Swiper('.heroSwiper', {
                                                    loop: true,
                                                    autoplay: false,
                                                    pagination: {
                                                        el: '.swiper-pagination',
                                                        clickable: true,
                                                    }
                                                });
                                            });
        </script>
        <!-- Featured Events -->
        <section class="py-16 bg-white">
            <div class="container mx-auto px-4">
                <div class="flex justify-between items-center mb-8">
                    <h2 class="text-3xl font-bold text-gray-900">Sự Kiện Nổi Bật</h2>
                    <a href="EventList" class="text-primary font-medium flex items-center">
                        Xem Tất Cả
                        <i class="ri-arrow-right-line ml-1"></i>
                    </a>
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
                        </div>
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
                                                        ${o.currentParticipants}/${o.maxParticipants} người
                                                    </span>
                                                </div>
                                            </div>
                                            <div class="flex gap-4 mt-4">

                                                <c:if test="${user.getRoleId() != 2}">
                                                    <c:choose>
                                                        <c:when test="${isRegisteredList[index] && o.eventStatus == 'Sắp diễn ra'}">

                                                            <button class="w-full bg-red-600 text-white py-2 rounded-button whitespace-nowrap text-center hover:bg-red-700 cancel-btn"
                                                                    data-event-id="${o.eventId}"
                                                                    onclick="showCancelModal('RegisterEvent?action=cancel&eventId=${o.eventId}&redirectTo=home', '${o.title}')">
                                                                Hủy đăng ký
                                                            </button>
                                                        </c:when>
                                                        <c:when test="${isRegisteredList[index] || o.currentParticipants >= o.maxParticipants || o.eventStatus == 'Đã kết thúc' || o.eventStatus == 'Đang diễn ra'}">

                                                            <span class="w-full bg-gray-400 text-white py-2 rounded-button whitespace-nowrap text-center cursor-not-allowed">
                                                                <c:choose>
                                                                    <c:when test="${o.eventStatus == 'Đã kết thúc'}">Sự kiện kết thúc</c:when>
                                                                    <c:when test="${o.eventStatus == 'Đang diễn ra'}">Sự kiện đang diễn ra</c:when>
                                                                    <c:when test="${o.currentParticipants >= o.maxParticipants}">Tất cả sự kiện</c:when>
                                                                    <c:otherwise>Already Registered</c:otherwise>
                                                                </c:choose>
                                                            </span>
                                                        </c:when>
                                                        <c:otherwise>

                                                            <button class="w-full bg-blue-600 text-white py-2 rounded-button whitespace-nowrap text-center hover:bg-blue-700 register-btn"
                                                                    data-event-id="${o.eventId}"
                                                                    onclick="showRegisterModal('RegisterEvent?action=register&eventId=${o.eventId}&redirectTo=home', '${o.title}')">
                                                                Đăng ký sự kiện
                                                            </button>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:if>
                                                <a href="EventDetails?action=details&eventId=${o.eventId}&redirectTo=home" 
                                                   class="w-full bg-gray-200 text-gray-700 py-2 rounded-button whitespace-nowrap text-center hover:bg-gray-300">
                                                    Xem chi tiết
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

                <!-- Registration Modal with Form -->
                <div id="registerModal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center hidden">
                    <div class="bg-white rounded-lg p-6 w-full max-w-md">
                        <h2 class="text-xl font-bold mb-4">Đăng ký tham gia sự kiện<span id="eventTitle" class="font-semibold"></span></h2>
                        <form id="registerForm" action="" method="POST">
                            <input type="hidden" name="action" value="register">
                            <input type="hidden" id="redirectToInput" name="redirectTo" value="home">
                            <div class="mb-4">
                                <label for="fullName" class="block text-sm font-medium text-gray-700">Tên đầy đủ</label>
                                <input type="fullname" id="fullname" name="fullname" required
                                       class="mt-1 w-full pl-3 pr-10 py-2 border-none bg-white shadow-sm focus:ring-2 focus:ring-primary focus:outline-none text-sm"
                                       placeholder="Nhập tên đầy đủ" value="${user.getFullName()}">
                            </div>
                            <div class="mb-4">
                                <label for="cccd" class="block text-sm font-medium text-gray-700">CCCD</label>
                                <input type="cccd" id="cccd" name="cccd" required
                                       class="mt-1 w-full pl-3 pr-10 py-2 border-none bg-white shadow-sm focus:ring-2 focus:ring-primary focus:outline-none text-sm"
                                       placeholder="Enter CCCD" >
                            </div>
                            <div class="mb-4">
                                <label for="phoneNumber" class="block text-sm font-medium text-gray-700">Số điện thoại</label>
                                <input type="tel" id="phoneNumber" name="phoneNumber" required
                                       class="mt-1 w-full pl-3 pr-10 py-2 border-none bg-white shadow-sm focus:ring-2 focus:ring-primary focus:outline-none text-sm"
                                       placeholder="Nhập số điện thoại">
                            </div>
                            <div class="mb-6">
                                <label for="email" class="block text-sm font-medium text-gray-700">Email</label>
                                <input type="email" id="email" name="email" required
                                       class="mt-1 w-full pl-3 pr-10 py-2 border-none bg-white shadow-sm focus:ring-2 focus:ring-primary focus:outline-none text-sm"
                                       placeholder="Nhập email của bạn">
                            </div>
                            <div class="flex justify-end gap-4">
                                <button type="button" id="cancelButton" class="bg-gray-200 text-gray-700 px-4 py-2 rounded-button hover:bg-gray-300">Cancel</button>
                                <button type="submit" class="bg-blue-600 text-white px-4 py-2 rounded-button hover:bg-blue-700">Xác nhận</button>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Cancel Registration Modal -->
                <div id="cancelModal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center hidden">
                    <div class="bg-white rounded-lg p-6 w-full max-w-md">
                        <h2 class="text-xl font-bold mb-4">Xác nhận hủy đăng ký</h2>
                        <p class="text-gray-600 mb-6">Bạn có chắc chắn muốn hủy đăng ký tham gia sự kiện<span id="cancelEventTitle" class="font-semibold"></span>?</p>
                        <div class="flex justify-end gap-4">
                            <button id="cancelCancelButton" class="bg-gray-200 text-gray-700 px-4 py-2 rounded-button hover:bg-gray-300">Quay lại</button>
                            <button id="confirmCancelButton" class="bg-red-600 text-white px-4 py-2 rounded-button hover:bg-red-700">Xác nhận</button>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Community News -->
<section class="py-16 bg-gray-50">
    <div class="container mx-auto px-4">
        <div class="flex justify-between items-center mb-8">
            <h2 class="text-3xl font-bold text-gray-900">Tin Tức Cộng Đồng</h2>
            <a href="NewFeed" data-readdy="true" class="text-primary font-medium flex items-center">
                Xem Tất Cả
                <i class="ri-arrow-right-line ml-1"></i>
            </a>
        </div>
        <c:choose>
            <c:when test="${empty recentPosts}">
                <div class="bg-white rounded shadow-sm p-6 text-center">
                    <p class="text-gray-600 text-lg">Không có bài viết nào.</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <c:forEach items="${recentPosts}" var="post">
                        <% 
                            dal.UserDao userDao = new dal.UserDao();
                            model.Users postUser = userDao.getUserById(((model.Post)pageContext.getAttribute("post")).getUserId());
                            String userName = (postUser != null) ? postUser.getFullName() : "Unknown User";
                            String firstLetter = (userName != null && !userName.isEmpty()) ? userName.substring(0, 1).toUpperCase() : "U";
                            pageContext.setAttribute("userName", userName);
                            pageContext.setAttribute("firstLetter", firstLetter);
                        %>
                        <div class="bg-white rounded shadow-md p-6">
                            <div class="flex items-start mb-4">
                                <div class="w-12 h-12 rounded-full overflow-hidden mr-4">
                                    <div class="w-full h-full flex items-center justify-center bg-primary text-white font-bold">
                                        ${firstLetter}
                                    </div>
                                </div>
                                <div class="flex-1">
                                    <div class="flex items-center mb-2">
                                        <h3 class="font-bold text-lg">${userName}</h3>
                                        <span class="ml-2 text-gray-500 text-sm">
                                            <fmt:formatDate value="${post.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                                        </span>
                                    </div>
                                    <p class="text-gray-600 text-sm">Chủ đề: ${post.topic}</p>
                                </div>
                            </div>
                            <h4 class="text-xl font-semibold mb-2">${post.title}</h4>
                           
<p class="text-gray-600 mb-4">${fn:substring(post.content, 0, 100)}...</p>    
  <c:if test="${not empty post.images}">
                                <div class="grid grid-cols-2 gap-2 mb-4">
                                    <c:forEach items="${post.images}" var="image">
                                        <img src="assets/img/post/${image}" alt="Post image" class="w-full h-40 object-cover rounded">
                                    </c:forEach>
                                </div>
                            </c:if>
  <c:if test="${not empty post.videos}">
                                <div class="grid grid-cols-2 gap-2 mb-4">
                                    <c:forEach items="${post.videos}" var="video">
                                        <video controls class="w-full h-40 object-cover rounded">
                                            <source src="${video}" type="video/mp4">
                                            Your browser does not support the video tag.
                                        </video>
                                    </c:forEach>
                                </div>
                            </c:if>

                            <div class="flex justify-between items-center">
                                <div class="flex items-center">
                                    <button class="flex items-center text-gray-500 hover:text-primary">
                                        <div class="w-5 h-5 flex items-center justify-center">
                                            <i class="ri-heart-line"></i>
                                        </div>
                                        <span class="ml-1">${post.likeCount}</span>
                                    </button>
                                    <button class="flex items-center text-gray-500 hover:text-primary ml-4">
                                        <div class="w-5 h-5 flex items-center justify-center">
                                            <i class="ri-chat-1-line"></i>
                                        </div>
                                        <span class="ml-1">${post.commentCount}</span>
                                    </button>
                                </div>
                                <button class="flex items-center text-gray-500 hover:text-primary">
                                    <div class="w-5 h-5 flex items-center justify-center">
                                        <i class="ri-bookmark-line"></i>
                                    </div>
                                </button>
                            </div>
                            <a href="NewFeed#post-${post.postId}" class="text-primary font-medium mt-4 inline-block">Đọc thêm</a>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</section>
    
        <!-- Fish Knowledge -->
       <!-- Fish Knowledge -->
<section class="py-16 bg-gray-50">
    <div class="container mx-auto px-4">
        <div class="flex justify-between items-center mb-8">
            <h2 class="text-3xl font-bold text-gray-900">Kiến Thức Về Cá</h2>
            <a href="KnowledgeFish" data-readdy="true" class="text-primary font-medium flex items-center">
                Xem Tất Cả
                <i class="ri-arrow-right-line ml-1"></i>
            </a>
        </div>
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            <c:forEach items="${representativeFish}" var="fish">
                <div class="bg-white rounded shadow-md overflow-hidden">
                    <div class="w-[500px] h-[300px] overflow-hidden"> <!-- Kích thước cố định: 400px x 300px -->
                        <img src="${fish.imageUrl}" alt="${fish.commonName}" class="w-full h-full object-cover object-center">
                    </div>
                    <div class="p-5">
                        <h3 class="text-xl font-bold mb-2">${fish.commonName}</h3>
                        <p class="text-gray-600 mb-4">${fn:substring(fish.description, 0, 100)}...</p>
                        <div class="grid grid-cols-2 gap-2 mb-4">
                            <div class="flex items-center">
                                <div class="w-5 h-5 flex items-center justify-center text-primary">
                                    <i class="ri-scales-line"></i>
                                </div>
                                <span class="ml-2 text-sm">Cân Nặng: ${fish.averageWeightKg}kg</span>
                            </div>
                            <div class="flex items-center">
                                <div class="w-5 h-5 flex items-center justify-center text-primary">
                                    <i class="ri-ruler-line"></i>
                                </div>
                                <span class="ml-2 text-sm">Chiều Dài: ${fish.length}cm</span>
                            </div>
                            <div class="flex items-center">
                                <div class="w-5 h-5 flex items-center justify-center text-primary">
                                    <i class="ri-water-flash-line"></i>
                                </div>
                                <span class="ml-2 text-sm">Môi Trường: ${fish.habitat}</span>
                            </div>
                            <div class="flex items-center">
                                <div class="w-5 h-5 flex items-center justify-center text-primary">
                                    <i class="ri-map-pin-line"></i>
                                </div>
                                <span class="ml-2 text-sm">Phân Bố: ${fish.fishingSpots}</span>
                            </div>
                        </div>
                        <div class="flex justify-between items-center">
                            <span class="text-sm text-gray-500">Độ Khó: 
                                <c:choose>
                                    <c:when test="${fish.difficultyLevel == 1}">Dễ</c:when>
                                    <c:when test="${fish.difficultyLevel == 2}">Trung bình</c:when>
                                    <c:when test="${fish.difficultyLevel == 3}">Khó</c:when>
                                </c:choose>
                            </span>
                            <a href="FishDetails?id=${fish.id}" class="text-primary font-medium">Xem Chi Tiết</a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</section>
        
        
        <!-- Footer -->
        <footer class="bg-gray-800 text-white pt-12 pb-6">
            <div class="container mx-auto px-4">
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8 mb-8">
                    <!-- About section -->
                    <div>
                        <a href="#" class="text-3xl font-['Pacifico'] text-white mb-4 inline-block">FishingHub</a>
                        <p class="text-gray-400 mb-4">Cộng đồng câu cá hàng đầu Việt Nam, kết nối đam mê và chia sẻ kinh nghiệm.</p>
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
                            <li><a href="Home" class="text-gray-400 hover:text-white">Trang Chủ</a></li>
                            <li><a href="EventList" class="text-gray-400 hover:text-white">Sự Kiện</a></li>
                            <li><a href="NewFeed" class="text-gray-400 hover:text-white">Bảng Tin</a></li>
                            <li><a href="shop-list" class="text-gray-400 hover:text-white">Cửa Hàng</a></li>
                            <li><a href="KnowledgeFish" class="text-gray-400 hover:text-white">Kiến Thức</a></li>
                           
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
                                                                        let cancelUrl = '';

                                                                        function showRegisterModal(url, eventTitle) {
                                                                            document.getElementById('eventTitle').textContent = eventTitle;
                                                                            document.getElementById('registerForm').action = url;
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