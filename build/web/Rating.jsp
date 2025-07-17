<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thành Tích Cá Nhân</title>
    <script src="https://cdn.tailwindcss.com/3.4.16"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: '#1E88E5',
                        secondary: '#64B5F6'
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
    <link href="https://fonts.googleapis.com/css2?family=Pacifico&family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
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
                <a href="Event.jsp" class="px-4 py-2 text-gray-800 font-medium hover:text-primary">Sự Kiện</a>
                <a href="NewFeed.jsp" class="px-4 py-2 text-gray-800 font-medium hover:text-primary">Bảng Tin</a>
                <a href="Product.jsp" class="px-4 py-2 text-gray-800 font-medium hover:text-primary">Cửa Hàng</a>
                <a href="KnowledgeFish" class="px-4 py-2 text-gray-800 font-medium hover:text-primary">Kiến Thức</a>
                <a href="Achievement.jsp" class="px-4 py-2 text-gray-800 font-medium hover:text-primary">Xếp Hạng</a>
            </nav>
            </div>
            <div class="flex items-center space-x-4">
                <div class="relative w-10 h-10 flex items-center justify-center">
                    <button class="text-gray-700 hover:text-primary" aria-label="Cart">
                        <i class="ri-shopping-cart-2-line text-xl"></i>
                    </button>
                    <span class="absolute -top-1 -right-1 bg-red-500 text-white text-xs w-5 h-5 flex items-center justify-center rounded-full">3</span>
                </div>
                <div class="relative">
                    <div class="w-10 h-10 flex items-center justify-center rounded-full bg-gray-100 cursor-pointer" aria-label="Notifications">
                        <i class="ri-notification-3-line text-gray-600"></i>
                    </div>
                    <span class="absolute -top-1 -right-1 flex h-5 w-5 items-center justify-center rounded-full bg-primary text-xs text-white">3</span>
                </div>
                 <button class="bg-primary text-white px-4 py-2 rounded-button whitespace-nowrap">Đăng Nhập</button>
            <button class="bg-white text-primary border border-primary px-4 py-2 rounded-button whitespace-nowrap">Đăng Ký</button>
            </div>
        </div>
    </header>

    <!-- Breadcrumb -->
    <nav class="bg-white border-b" aria-label="Điều hướng">
        <div class="container mx-auto px-4 py-3">
            <div class="flex items-center text-sm">
                <a href="Home.jsp" class="text-gray-500 hover:text-primary">Trang Chủ</a>
                <span class="mx-2 text-gray-400">/</span>
                <span class="text-primary font-medium" aria-current="page">Thành Tích</span>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <main class="container mx-auto px-4 py-6 min-h-[calc(100vh-160px)]">
        <section class="tab-content active" id="leaderboard" aria-labelledby="leaderboard-title">
            <div class="max-w-4xl mx-auto">
                <div class="bg-white rounded-lg shadow-sm p-6">
                    <h2 id="leaderboard-title" class="text-2xl font-bold text-gray-800 mb-8 text-center">Bảng Xếp Hạng</h2>
                    <div class="flex flex-col md:flex-row justify-center items-center gap-6 mb-10">
                        <!-- Rank 2 -->
                        <div class="top-user text-center order-2 md:order-1">
                            <div class="relative">
                                <div class="w-20 h-20 md:w-24 md:h-24 rounded-full overflow-hidden mx-auto border-4 border-gray-200">
                                    <img
                                        src="https://readdy.ai/api/search-image?query=professional%20profile%20picture%20of%20a%20young%20vietnamese%20man%2C%20minimalist%20style%2C%20neutral%20expression%2C%20high%20quality%20portrait&width=200&height=200&seq=9&orientation=squarish"
                                        alt="Profile picture of Tran Van Hung, rank 2"
                                        class="w-full h-full object-cover"
                                    />
                                </div>
                                <div class="absolute -bottom-2 left-1/2 transform -translate-x-1/2 bg-gray-200 text-gray-700 rounded-full w-8 h-8 flex items-center justify-center font-bold text-lg">2</div>
                            </div>
                            <h3 class="font-medium mt-4">Tran Van Hung</h3>
                            <p class="text-primary font-bold">780 points</p>
                        </div>
                        <!-- Rank 1 -->
                        <div class="top-user text-center order-1 md:order-2 md:scale-110">
                            <div class="relative">
                                <div class="w-24 h-24 md:w-32 md:h-32 rounded-full overflow-hidden mx-auto border-4 border-yellow-400">
                                    <img
                                        src="https://readdy.ai/api/search-image?query=professional%20profile%20picture%20of%20a%20young%20vietnamese%20woman%2C%20minimalist%20style%2C%20neutral%20expression%2C%20high%20quality%20portrait&width=200&height=200&seq=10&orientation=squarish"
                                        alt="Profile picture of Pham Thi Huong, rank 1"
                                        class="w-full h-full object-cover"
                                    />
                                </div>
                                <div class="absolute -bottom-2 left-1/2 transform -translate-x-1/2 bg-yellow-400 text-white rounded-full w-8 h-8 flex items-center justify-center font-bold text-lg">1</div>
                            </div>
                            <h3 class="font-medium mt-4">Pham Thi Huong</h3>
                            <p class="text-primary font-bold">925 points</p>
                        </div>
                        <!-- Rank 3 -->
                        <div class="top-user text-center order-3">
                            <div class="relative">
                                <div class="w-20 h-20 md:w-24 md:h-24 rounded-full overflow-hidden mx-auto border-4 border-orange-300">
                                    <img
                                        src="https://readdy.ai/api/search-image?query=professional%20profile%20picture%20of%20a%20young%20vietnamese%20man%2C%20minimalist%20style%2C%20neutral%20expression%2C%20high%20quality%20portrait&width=200&height=200&seq=11&orientation=squarish"
                                        alt="Profile picture of Le Minh Duc, rank 3"
                                        class="w-full h-full object-cover"
                                    />
                                </div>
                                <div class="absolute -bottom-2 left-1/2 transform -translate-x-1/2 bg-orange-300 text-white rounded-full w-8 h-8 flex items-center justify-center font-bold text-lg">3</div>
                            </div>
                            <h3 class="font-medium mt-4">Le Minh Duc</h3>
                            <p class="text-primary font-bold">710 points</p>
                        </div>
                    </div>
                    <div class="overflow-x-auto">
                        <table class="w-full bg-gray-50 rounded-t-lg">
                            <thead>
                                <tr class="text-gray-600 font-medium">
                                    <th class="w-12 text-center py-3 px-4">Hạng</th>
                                    <th class="w-12"></th>
                                    <th class="flex-1 text-left py-3 px-4">Người Dùng</th>
                                    <th class="w-24 text-center py-3 px-4">Điểm</th>
                                    <th class="w-24 text-center py-3 px-4 hidden md:table-cell">Thành Tích</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-gray-200">
                                <tr class="hover:bg-gray-50">
                                    <td class="w-12 text-center font-medium py-3 px-4">4</td>
                                    <td class="w-12 py-3 px-4">
                                        <div class="w-8 h-8 rounded-full overflow-hidden">
                                            <img
                                                src="https://readdy.ai/api/search-image?query=professional%20profile%20picture%20of%20a%20young%20vietnamese%20woman%2C%20minimalist%20style%2C%20neutral%20expression%2C%20high%20quality%20portrait&width=100&height=100&seq=12&orientation=squarish"
                                                alt="Profile picture of Vo Thi Lan Anh"
                                                class="w-full h-full object-cover"
                                            />
                                        </div>
                                    </td>
                                    <td class="flex-1 font-medium py-3 px-4">Vo Thi Lan Anh</td>
                                    <td class="w-24 text-center font-medium text-primary py-3 px-4">650</td>
                                    <td class="w-24 text-center hidden md:table-cell py-3 px-4">15</td>
                                </tr>
                                <tr class="hover:bg-gray-50">
                                    <td class="w-12 text-center font-medium py-3 px-4">5</td>
                                    <td class="w-12 py-3 px-4">
                                        <div class="w-8 h-8 rounded-full overflow-hidden">
                                            <img
                                                src="https://readdy.ai/api/search-image?query=professional%20profile%20picture%20of%20a%20young%20vietnamese%20man%2C%20minimalist%20style%2C%20neutral%20expression%2C%20high%20quality%20portrait&width=100&height=100&seq=13&orientation=squarish"
                                                alt="Profile picture of Nguyen Dinh Thang"
                                                class="w-full h-full object-cover"
                                            />
                                        </div>
                                    </td>
                                    <td class="flex-1 font-medium py-3 px-4">Nguyen Dinh Thang</td>
                                    <td class="w-24 text-center font-medium text-primary py-3 px-4">590</td>
                                    <td class="w-24 text-center hidden md:table-cell py-3 px-4">12</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    
                    <div class="mt-8 text-center">
                        <button class="text-primary font-medium hover:text-primary-dark flex items-center justify-center mx-auto gap-1" aria-label="Xem thêm người dùng trong bảng xếp hạng">
                            <span>Xem Thêm</span>
                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
                            </svg>
                        </button>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <!-- Footer -->
    <footer class="bg-white border-t border-gray-200 py-4">
        <div class="container mx-auto px-4">
            <div class="flex flex-col md:flex-row justify-between items-center gap-4">
                <div class="text-sm text-gray-500">© 2025 Thành Tích Cá Nhân</div>
                <nav class="flex bg-gray-100 rounded-full p-1 w-full md:w-auto">
                    <button class="tab-button flex-1 py-2 px-4 rounded-full text-sm font-medium transition-colors active bg-white text-primary" data-tab="post-achievement">
                        <div class="flex items-center justify-center">
                            <i class="ri-add-circle-line mr-1"></i>
                            <span>Đăng Bài</span>
                        </div>
                    </button>
                    <button class="tab-button flex-1 py-2 px-4 rounded-full text-sm font-medium transition-colors" data-tab="my-achievements">
                        <div class="flex items-center justify-center">
                            <i class="ri-trophy-line mr-1"></i>
                            <span>Thành Tích</span>
                        </div>
                    </button>
                    <button class="tab-button flex-1 py-2 px-4 rounded-full text-sm font-medium transition-colors active bg-white text-primary" data-tab="leaderboard">
                        <div class="flex items-center justify-center">
                            <i class="ri-bar-chart-line mr-1"></i>
                            <span>Xếp Hạng</span>
                        </div>
                    </button>
                </nav>
                <button class="text-gray-500 hover:text-gray-700 w-8 h-8 flex items-center justify-center" aria-label="Cài Đặt">
                    <i class="ri-settings-3-line"></i>
                </button>
            </div>
        </div>
    </footer>

    <script src="assets/js/tabNavigation.js"></script>
</body>
</html>