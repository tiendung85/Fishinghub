<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>${fish.commonName} Details</title>
        <script src="https://cdn.tailwindcss.com/3.4.16"></script>
        <script>tailwind.config = {theme: {extend: {colors: {primary: '#1E88E5', secondary: '#FFA726'}, borderRadius: {'none': '0px', 'sm': '4px', DEFAULT: '8px', 'md': '12px', 'lg': '16px', 'xl': '20px', '2xl': '24px', '3xl': '32px', 'full': '9999px', 'button': '8px'}}}}</script>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.6.0/remixicon.min.css">
        <link rel="stylesheet" href="assets/css/style.css">
        <style>
            .main-img { width: 350px; height: 300px; object-fit: cover; border-radius: 12px; }
            .thumbs { display: flex; gap: 8px; margin-top: 12px; }
            .thumbs img { width: 60px; height: 60px; object-fit: cover; border-radius: 8px; border: 2px solid transparent; cursor: pointer; }
            .thumbs img.selected { border-color: #3b82f6; }
        </style>
        <script>
            function selectImage(src, thumb) {
                document.getElementById('mainFishImg').src = src;
                document.querySelectorAll('.thumbs img').forEach(img => img.classList.remove('selected'));
                thumb.classList.add('selected');
            }
        </script>
    </head>

    <body class="font-roboto bg-gray-100">
        <!-- Header -->
        <jsp:include page="Header.jsp" />

        <!-- Breadcrumb with icons -->
        <div class="bg-white border-b">
            <div class="container mx-auto px-4 py-3">
                <span class="text-sm text-gray-600 flex items-center space-x-1">
                    <a href="Home.jsp" class="hover:text-blue-800">Trang Chủ</a>
                    <span>/</span>
                    <a href="FishKnowledge" class="hover:text-blue-800">Kiến Thức</a>
                    <span>/</span>
                    <span class=" text-blue-800">Thông Tin</span>
                </span>
            </div>
        </div>


        <!-- Main Content -->
        <main class="container mx-auto px-4 py-6">
            <div class="bg-white rounded-lg shadow p-6">
                <h1 class="text-3xl font-bold text-gray-800 mb-6">${fish.commonName}</h1>
                <div class="flex flex-col md:flex-row gap-6">
                    <!-- Hình ảnh -->
                     
                    <div class="md:w-1/2">
                        <c:choose>
                            <c:when test="${not empty fish.images and not empty fish.images[0]}">
                                <img id="mainFishImg" src="${fish.images[0]}" alt="${fish.commonName}"
                                     class="main-img rounded-xl w-full h-auto max-h-[500px] object-cover shadow" />
                            </c:when>
                            <c:otherwise>
                                <div class="main-img flex items-center justify-center bg-gray-200 text-gray-400">
                                    No image available
                                </div>
                            </c:otherwise>
                        </c:choose>
                        <div class="thumbs">
                            <c:forEach var="img" items="${fish.images}" varStatus="loop">
                                <img src="${img}" alt="thumb" class="${loop.index == 0 ? 'selected' : ''}"
                                     onclick="selectImage('${img}', this)">
                            </c:forEach>
                        </div>
                    </div>

                    <!-- Phần bên phải -->
                    <div class="md:w-1/2 space-y-5">
                        <!-- Box: Description -->
                        <div class="bg-gray-50 p-5 rounded-lg shadow-sm border border-gray-200">
                            <h2 class="text-2xl font-semibold text-gray-800 mb-2">Mô Tả</h2>
                            <p class="text-gray-800 text-base leading-relaxed">${fish.description}</p>
                        </div>

                        <!-- Box: Fishing Tips -->
                        <div class="bg-gray-50 p-5 rounded-lg shadow-sm border border-gray-200">
                            <h2 class="text-2xl font-semibold text-gray-800 mb-2">Mẹo Câu Cá</h2>
                            <p class="text-gray-800 text-base leading-relaxed">${fish.tips}</p>
                        </div>

                        <!-- Box: Details -->
                        <div class="bg-gray-50 p-5 rounded-lg shadow-sm border border-gray-200">
                            <h2 class="text-2xl font-semibold text-gray-800 mb-2">Chi Tiết</h2>
                            <ul class="list-disc list-inside text-gray-800 text-base space-y-1">
                                <li><strong>Tên Khoa Học:</strong> ${fish.scientificName}</li>
                                <li><strong>Độ Khó Câu:</strong> ${fish.difficultyLevel}/4</li>
                                <li><strong>Mồi Câu:</strong> ${fish.bait}</li>
                                <li><strong>Mùa Tốt Nhất Để Câu:</strong> ${fish.bestSeason}</li>
                                <li><strong>Thời Điểm Tốt Nhất:</strong> ${fish.bestTimeOfDay}</li>
                                <li><strong>Địa Điểm Câu:</strong> ${fish.fishingSpots}</li>
                                <li><strong>Kỹ Thuật Câu:</strong> ${fish.fishingTechniques}</li>
                                <li><strong>Trọng Lượng Trung Bình (kg):</strong> ${fish.averageWeightKg}</li>
                                <li><strong>Chiều Dài (m):</strong> ${fish.length}</li>
                                <li><strong>Môi Trường Sống:</strong> ${fish.habitat}</li>
                                <li><strong>Tập Tính:</strong> ${fish.behavior}</li>
                            </ul>
                        </div>
                    </div>


                </div>
                <div class="mt-6">
                    <a href="KnowledgeFish" class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700">Quay Lại Danh Sách</a>
                </div>
            </div>
        </main>
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
    </body>

</html>