<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Thành tựu cá nhân</title>
        <script src="https://cdn.tailwindcss.com/3.4.16"></script>
        <script>tailwind.config = {theme: {extend: {colors: {primary: '#1E88E5', secondary: '#64B5F6'}, borderRadius: {'none': '0px', 'sm': '4px', DEFAULT: '8px', 'md': '12px', 'lg': '16px', 'xl': '20px', '2xl': '24px', '3xl': '32px', 'full': '9999px', 'button': '8px'}}}}</script>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.6.0/remixicon.min.css">
        <link rel="stylesheet" href="assets/css/style.css">
    
        <!-- Header -->
    <header class="bg-white shadow-sm">
        <div class="container mx-auto px-4 py-3 flex items-center justify-between">
            <div class="flex items-center">
                <a href="Home.jsp" class="text-3xl font-['Pacifico'] text-primary">FishingHub</a>
                <!-- Header navigation links -->
                <nav class="hidden md:flex ml-10">
                        <a href="Home.jsp" class="px-4 py-2 text-gray-800 font-medium hover:text-primary">Trang chủ</a>
                        <a href="Event.jsp" class="px-4 py-2 text-gray-800 font-medium hover:text-primary">Sự kiện</a>
                        <a href="NewFeed.jsp" class="px-4 py-2 text-gray-800 font-medium hover:text-primary">Bảng tin</a>
                        <a href="Product.jsp" class="px-4 py-2 text-gray-800 font-medium hover:text-primary">Cửa hàng</a>
                        <a href="KnowledgeFish" class="px-4 py-2 text-gray-800 font-medium hover:text-primary">Kiến thức</a>
                        <a href="Achievement.jsp" class="px-4 py-2 text-gray-800 font-medium hover:text-primary">Xếp hạng</a>
                    </nav>
            </div>

            <div class="flex items-center space-x-4">
                <!-- Cart -->
                <div class="relative w-10 h-10 flex items-center justify-center">
                    <button class="text-gray-700 hover:text-primary">
                        <i class="ri-shopping-cart-2-line text-xl"></i>
                    </button>
                    <span
                        class="absolute -top-1 -right-1 bg-red-500 text-white text-xs w-5 h-5 flex items-center justify-center rounded-full"
                        >3</span
                    >
                </div>
                <div class="relative">
                    <div class="w-10 h-10 flex items-center justify-center rounded-full bg-gray-100 cursor-pointer">
                        <i class="ri-notification-3-line text-gray-600"></i>
                    </div>
                    <span class="absolute -top-1 -right-1 flex h-5 w-5 items-center justify-center rounded-full bg-primary text-xs text-white">3</span>
                </div>

                <button class="bg-primary text-white px-4 py-2 rounded-button whitespace-nowrap">Đăng nhập</button>
                <button class="bg-white text-primary border border-primary px-4 py-2 rounded-button whitespace-nowrap">Đăng ký</button>
            </div>
        </div>
    </header>
    <!-- Breadcrumb -->
    <div class="bg-white border-b">
        <div class="container mx-auto px-4 py-3">
            <div class="flex items-center text-sm">
                <a href="Home.jsp" class="text-gray-500 hover:text-primary">Trang chủ</a>
                <span class="mx-2 text-gray-400">/</span>
                <span class="text-primary font-medium">Thành tích</span>
            </div>
        </div>
    </div>
    <main class="container mx-auto px-4 py-6 min-h-[calc(100vh-160px)]">
   <!-- Wrapper for all tab content -->
   <div class="tab-contents">
      <!-- Add active class to the first tab -->
      <div class="tab-content active" id="my-achievements">
         <div class="max-w-4xl mx-auto">
            <div class="bg-white rounded-lg shadow-sm p-6 mb-6">
                <h2 class="text-2xl font-bold text-gray-800 mb-6">Thành tích của tôi</h2>
                <div class="flex justify-between items-center mb-6">
                    <div class="flex items-center space-x-2">
                        <span class="text-gray-700">Tổng điểm:</span>
                        <span class="font-bold text-primary">325</span>
                    </div>
                    <div class="relative">
                        <select class="appearance-none bg-white border border-gray-300 rounded-button py-2 pl-4 pr-8 focus:outline-none focus:ring-2 focus:ring-primary focus:border-primary cursor-pointer">
                            <option>Mới nhất</option>
                            <option>Cũ nhất</option>
                            <option>Điểm cao nhất</option>
                            <option>Lượt thích nhiều nhất</option>
                        </select>
                        <div class="absolute inset-y-0 right-0 flex items-center px-2 pointer-events-none">
                            <i class="ri-arrow-down-s-line text-gray-500"></i>
                        </div>
                    </div>
                </div>
                <div class="space-y-6">
                    <div class="achievement-card bg-white border border-gray-200 rounded-lg overflow-hidden shadow-sm">
                        <div class="p-4">
                            <div class="flex items-start">
                                <div class="w-24 h-24 rounded-lg overflow-hidden mr-4 flex-shrink-0">
                                    <img src="https://readdy.ai/api/search-image?query=realistic%20koi%20fish%2C%20red%20and%20white%2C%20swimming%20in%20clear%20water%2C%20detailed%20scales%2C%20underwater%20photography%2C%20high%20resolution&width=200&height=200&seq=6&orientation=squarish" alt="Koi Fish" class="w-full h-full object-cover">
                                </div>
                                <div class="flex-1">
                                    <div class="flex justify-between items-start mb-2">
                                        <div>
                                            <h3 class="font-medium text-gray-800">Koi Fish</h3>
                                            <p class="text-primary font-bold">100 points</p>
                                        </div>
                                        <span class="text-sm text-gray-500">05/21/2025</span>
                                    </div>
                                    <p class="text-gray-700 mb-4">Today, I caught a beautiful koi fish at West Lake. This is the first time I caught this species after months of persistence.</p>
                                    <div class="flex items-center justify-between">
                                        <div class="flex items-center space-x-4">
                                            <div class="flex items-center">
                                                <button class="w-8 h-8 flex items-center justify-center text-gray-500 hover:text-primary">
                                                    <i class="ri-heart-line"></i>
                                                </button>
                                                <span class="text-sm text-gray-600">24</span>
                                            </div>
                                            <div class="flex items-center">
                                                <button class="w-8 h-8 flex items-center justify-center text-gray-500 hover:text-primary">
                                                    <i class="ri-chat-1-line"></i>
                                                </button>
                                                <span class="text-sm text-gray-600">8</span>
                                            </div>
                                        </div>
                                        <button class="text-gray-500 hover:text-gray-700 w-8 h-8 flex items-center justify-center">
                                            <i class="ri-more-2-fill"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="achievement-card bg-white border border-gray-200 rounded-lg overflow-hidden shadow-sm">
                        <div class="p-4">
                            <div class="flex items-start">
                                <div class="w-24 h-24 rounded-lg overflow-hidden mr-4 flex-shrink-0">
                                    <img src="https://readdy.ai/api/search-image?query=realistic%20arowana%20fish%2C%20golden%20scales%2C%20swimming%20in%20clear%20water%2C%20detailed%20scales%2C%20underwater%20photography%2C%20high%20resolution&width=200&height=200&seq=7&orientation=squarish" alt="Arowana Fish" class="w-full h-full object-cover">
                                </div>
                                <div class="flex-1">
                                    <div class="flex justify-between items-start mb-2">
                                        <div>
                                            <h3 class="font-medium text-gray-800">Arowana Fish</h3>
                                            <p class="text-primary font-bold">150 points</p>
                                        </div>
                                        <span class="text-sm text-gray-500">05/18/2025</span>
                                    </div>
                                    <p class="text-gray-700 mb-4">After 3 years of nurturing, my arowana fish has reached a size of 75cm with vibrant golden color. This is the greatest pride in my fish collection.</p>
                                    <div class="flex items-center justify-between">
                                        <div class="flex items-center space-x-4">
                                            <div class="flex items-center">
                                                <button class="w-8 h-8 flex items-center justify-center text-primary">
                                                    <i class="ri-heart-fill"></i>
                                                </button>
                                                <span class="text-sm text-gray-600">42</span>
                                            </div>
                                            <div class="flex items-center">
                                                <button class="w-8 h-8 flex items-center justify-center text-gray-500 hover:text-primary">
                                                    <i class="ri-chat-1-line"></i>
                                                </button>
                                                <span class="text-sm text-gray-600">15</span>
                                            </div>
                                        </div>
                                        <button class="text-gray-500 hover:text-gray-700 w-8 h-8 flex items-center justify-center">
                                            <i class="ri-more-2-fill"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="achievement-card bg-white border border-gray-200 rounded-lg overflow-hidden shadow-sm">
                        <div class="p-4">
                            <div class="flex items-start">
                                <div class="w-24 h-24 rounded-lg overflow-hidden mr-4 flex-shrink-0">
                                    <img src="https://readdy.ai/api/search-image?query=realistic%20clownfish%2C%20orange%20and%20white%2C%20swimming%20in%20clear%20water%2C%20detailed%20scales%2C%20underwater%20photography%2C%20high%20resolution&width=200&height=200&seq=8&orientation=squarish" alt="Clownfish" class="w-full h-full object-cover">
                                </div>
                                <div class="flex-1">
                                    <div class="flex justify-between items-start mb-2">
                                        <div>
                                            <h3 class="font-medium text-gray-800">Clownfish</h3>
                                            <p class="text-primary font-bold">75 points</p>
                                        </div>
                                        <span class="text-sm text-gray-500">05/10/2025</span>
                                    </div>
                                    <p class="text-gray-700 mb-4">My first fishing trip in Vung Tau, and I caught 5 clownfish at once. A memorable moment with friends.</p>
                                    <div class="flex items-center justify-between">
                                        <div class="flex items-center space-x-4">
                                            <div class="flex items-center">
                                                <button class="w-8 h-8 flex items-center justify-center text-gray-500 hover:text-primary">
                                                    <i class="ri-heart-line"></i>
                                                </button>
                                                <span class="text-sm text-gray-600">18</span>
                                            </div>
                                            <div class="flex items-center">
                                                <button class="w-8 h-8 flex items-center justify-center text-gray-500 hover:text-primary">
                                                    <i class="ri-chat-1-line"></i>
                                                </button>
                                                <span class="text-sm text-gray-600">5</span>
                                            </div>
                                        </div>
                                        <button class="text-gray-500 hover:text-gray-700 w-8 h-8 flex items-center justify-center">
                                            <i class="ri-more-2-fill"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="mt-8 text-center">
                    <button class="text-primary font-medium hover:text-blue-700 flex items-center justify-center mx-auto">
                        <span>Load More</span>
                        <i class="ri-arrow-down-s-line ml-1"></i>
                    </button>
                </div>
            </div>
      </div>

      <div class="tab-content" id="post-achievement">
         <!-- Content for post achievement tab -->
      </div>

      <div class="tab-content" id="leaderboard">
         <!-- Content for leaderboard tab -->  
      </div>
   </div>
</main>
<footer class="bg-white border-t border-gray-200 py-4">
    <div class="container mx-auto px-4">
        <div class="flex justify-between items-center">
            <div class="w-1/3">
                <p class="text-sm text-gray-500">© 2025 Thành tích cá nhân</p>
            </div>
            <div class="w-1/3 flex justify-center">
                <nav class="flex bg-gray-100 rounded-full p-1">
                    <button class="tab-button flex-1 py-2 px-4 rounded-full text-sm font-medium whitespace-nowrap transition-colors active bg-white text-primary" data-tab="post-achievement">
                        <div class="flex items-center justify-center">
                            <i class="ri-add-circle-line mr-1"></i>
                            <span>Đăng bài</span>
                        </div>
                    </button>
                    <button class="tab-button flex-1 py-2 px-4 rounded-full text-sm font-medium whitespace-nowrap transition-colors" data-tab="my-achievements">
                        <div class="flex items-center justify-center">
                            <i class="ri-trophy-line mr-1"></i>
                            <span>Thành tích</span>
                        </div>
                    </button>
                    <button class="tab-button flex-1 py-2 px-4 rounded-full text-sm font-medium whitespace-nowrap transition-colors" data-tab="leaderboard">
                        <div class="flex items-center justify-center">
                            <i class="ri-bar-chart-line mr-1"></i>
                            <span>Bảng xếp hạng</span>
                        </div>
                    </button>
                </nav>
            </div>
            <div class="w-1/3 flex justify-end">
                <button class="text-gray-500 hover:text-gray-700 w-8 h-8 flex items-center justify-center">
                    <i class="ri-settings-3-line"></i>
                </button>
            </div>
        </div>
    </div>
</footer>
<script src="assets/js/tabNavigation.js"></script>
</body>
</html>