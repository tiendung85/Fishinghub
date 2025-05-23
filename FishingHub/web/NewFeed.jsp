<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>News Feed - Fishing Community</title>
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
                    <!-- Header navigation links -->
                    <nav class="hidden md:flex ml-10">
                        <a href="Home.jsp" class="px-4 py-2 text-gray-800 font-medium hover:text-primary">Home</a>
                        <a href="Event.jsp" class="px-4 py-2 text-gray-800 font-medium hover:text-primary">Events</a>
                        <a href="NewFeed.jsp" class="px-4 py-2 text-gray-800 font-medium hover:text-primary">News Feed</a>
                        <a href="Product.jsp" class="px-4 py-2 text-gray-800 font-medium hover:text-primary">Shop</a>
                        <a href="FishKnowledge.jsp" class="px-4 py-2 text-gray-800 font-medium hover:text-primary">Knowledge</a>
                        <a href="Achievement.jsp" class="px-4 py-2 text-gray-800 font-medium hover:text-primary">Rankings</a>
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

                    <button class="bg-primary text-white px-4 py-2 rounded-button whitespace-nowrap">Sign In</button>
                    <button class="bg-white text-primary border border-primary px-4 py-2 rounded-button whitespace-nowrap">Sign Up</button>
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
                    <span class="text-primary font-medium">News Feed</span>
                </div>
            </div>
        </div>

        <!-- Main Content -->
        <main class="py-8">
            <div class="container mx-auto px-4">
                <!-- Title and Search -->
                <div class="flex flex-col md:flex-row justify-between items-start md:items-center mb-8 gap-4">
                    <div>
                        <h1 class="text-3xl font-bold text-gray-900">Community News Feed</h1>
                        <p class="text-gray-600 mt-2">Share experiences, news, and discussions about fishing</p>
                    </div>
                    <div class="flex items-center gap-4">
                        <div class="relative">
                            <input type="text" placeholder="Search posts..." class="w-full md:w-80 pl-10 pr-4 py-2 rounded-button border-none bg-white shadow-sm focus:ring-2 focus:ring-primary focus:outline-none text-sm">
                            <div class="absolute left-3 top-1/2 transform -translate-y-1/2 w-5 h-5 flex items-center justify-center text-gray-400">
                                <i class="ri-search-line"></i>
                            </div>
                        </div>
                        <button class="bg-primary text-white px-6 py-2 rounded-button whitespace-nowrap flex items-center gap-2">
                            <i class="ri-add-line"></i>
                            <span>Create New Post</span>
                        </button>
                    </div>
                </div>

                <!-- Filters and Tabs -->
                <div class="bg-white rounded shadow-sm mb-8">
                    <!-- Tabs -->
                    <div class="flex border-b border-gray-200">
                        <button class="tab-button active px-6 py-4 text-primary font-medium">All Posts</button>
                        <button class="tab-button px-6 py-4 text-gray-600 font-medium hover:text-primary">Saved</button>
                        <button class="tab-button px-6 py-4 text-gray-600 font-medium hover:text-primary">My Posts</button>
                    </div>
                </div>

                <!-- Posts List -->
                <div class="space-y-4 mb-8">
                    <!-- Post 1 -->
                    <div class="bg-white rounded shadow-sm overflow-hidden border border-gray-100">
                        <div class="p-4">
                            <!-- Author info -->
                            <div class="flex items-center mb-3">
                                <div class="w-10 h-10 rounded-full overflow-hidden mr-3">
                                    <img src="https://readdy.ai/api/search-image?query=profile%2520picture%2520of%2520a%2520vietnamese%2520man%2520in%2520his%252040s&width=100&height=100&seq=user1&orientation=squarish" 
                                         alt="Author" 
                                         class="w-full h-full object-cover">
                                </div>
                                <div>
                                    <h4 class="font-medium text-gray-900">Tran Quoc Bao</h4>
                                    <div class="flex items-center text-xs text-gray-500">
                                        <span>05/17/2025</span>
                                        <span class="mx-2">•</span>
                                        <span>Experience Sharing</span>
                                    </div>
                                </div>
                            </div>

                            <!-- Post title -->
                            <h3 class="text-lg font-bold mb-3">5 Effective Snakehead Fishing Techniques During Flood Season</h3>

                            <!-- Post image -->
                            <div class="mb-3 h-[250px] overflow-hidden rounded">
                                <img src="https://readdy.ai/api/search-image?query=snakehead%2520fishing%2520in%2520flooded%2520fields&width=600&height=360&seq=post1&orientation=landscape" 
                                     alt="Snakehead fishing" 
                                     class="w-full h-full object-cover">
                            </div>

                            <!-- Post excerpt -->
                            <div class="prose max-w-none mb-3">
                                <p class="text-sm text-gray-600 line-clamp-2">The flood season is the ideal time for snakehead fishing. This post shares the 5 most effective snakehead fishing techniques based on 15 years of experience, helping you achieve bountiful catches.</p>
                            </div>

                            <!-- Interaction buttons -->
                            <div class="flex justify-between items-center text-sm">
                                <div class="flex items-center gap-4">
                                    <button class="flex items-center gap-1 text-gray-500 hover:text-primary">
                                        <i class="ri-heart-line"></i>
                                        <span>124</span>
                                    </button>
                                    <button class="flex items-center gap-1 text-gray-500 hover:text-primary">
                                        <i class="ri-chat-1-line"></i>
                                        <span>32</span>
                                    </button>
                                </div>
                                <button class="flex items-center gap-1 text-gray-500 hover:text-primary">
                                    <i class="ri-bookmark-line"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                    <!-- Post 2 (Duplicate removed for brevity, translation would be identical) -->
                    <div class="bg-white rounded shadow-sm overflow-hidden border border-gray-100">
                        <div class="p-4">
                            <!-- Author info -->
                            <div class="flex items-center mb-3">
                                <div class="w-10 h-10 rounded-full overflow-hidden mr-3">
                                    <img src="https://readdy.ai/api/search-image?query=profile%2520picture%2520of%2520a%2520vietnamese%2520man%2520in%2520his%252040s&width=100&height=100&seq=user1&orientation=squarish" 
                                         alt="Author" 
                                         class="w-full h-full object-cover">
                                </div>
                                <div>
                                    <h4 class="font-medium text-gray-900">Tran Quoc Bao</h4>
                                    <div class="flex items-center text-xs text-gray-500">
                                        <span>05/17/2025</span>
                                        <span class="mx-2">•</span>
                                        <span>Experience Sharing</span>
                                    </div>
                                </div>
                            </div>

                            <!-- Post title -->
                            <h3 class="text-lg font-bold mb-3">5 Effective Snakehead Fishing Techniques During Flood Season</h3>

                            <!-- Post image -->
                            <div class="mb-3 h-[250px] overflow-hidden rounded">
                                <img src="https://readdy.ai/api/search-image?query=snakehead%2520fishing%2520in%2520flooded%2520fields&width=600&height=360&seq=post1&orientation=landscape" 
                                     alt="Snakehead fishing" 
                                     class="w-full h-full object-cover">
                            </div>

                            <!-- Post excerpt -->
                            <div class="prose max-w-none mb-3">
                                <p class="text-sm text-gray-600 line-clamp-2">The flood season is the ideal time for snakehead fishing. This post shares the 5 most effective snakehead fishing techniques based on 15 years of experience, helping you achieve bountiful catches.</p>
                            </div>

                            <!-- Interaction buttons -->
                            <div class="flex justify-between items-center text-sm">
                                <div class="flex items-center gap-4">
                                    <button class="flex items-center gap-1 text-gray-500 hover:text-primary">
                                        <i class="ri-heart-line"></i>
                                        <span>124</span>
                                    </button>
                                    <button class="flex items-center gap-1 text-gray-500 hover:text-primary">
                                        <i class="ri-chat-1-line"></i>
                                        <span>32</span>
                                    </button>
                                </div>
                                <button class="flex items-center gap-1 text-gray-500 hover:text-primary">
                                    <i class="ri-bookmark-line"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Load More & Pagination -->
                <div class="flex flex-col md:flex-row justify-between items-center mb-8">
                    <button class="bg-white text-primary border border-primary px-6 py-2 rounded-button whitespace-nowrap mb-4 md:mb-0 w-full md:w-auto">Load More Posts</button>

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
                </div>

                <!-- Featured Members -->
                <div class="bg-white rounded shadow-sm p-6 mb-8">
                    <h2 class="text-xl font-bold mb-4">Active Members</h2>
                    <div class="grid grid-cols-2 md:grid-cols-4 lg:grid-cols-6 gap-4">
                        <!-- Member 1 -->
                        <div class="flex flex-col items-center">
                            <div class="w-16 h-16 rounded-full overflow-hidden mb-2">
                                <img src="https://readdy.ai/api/search-image?query=profile%2520picture%2520of%2520a%2520vietnamese%2520man%2520in%2520his%252040s%2520with%2520short%2520hair%2520and%2520glasses%252C%2520casual%2520outfit%252C%2520natural%2520lighting%252C%2520realistic%2520portrait&width=100&height=100&seq=member1&orientation=squarish" alt="Member" class="w-full h-full object-cover">
                            </div>
                            <h4 class="font-medium text-sm">Tran Quoc Bao</h4>
                            <p class="text-xs text-gray-500">124 posts</p>
                        </div>
                        <!-- Member 2 -->
                        <div class="flex flex-col items-center">
                            <div class="w-16 h-16 rounded-full overflow-hidden mb-2">
                                <img src="https://readdy.ai/api/search-image?query=profile%2520picture%2520of%2520a%2520vietnamese%2520woman%2520in%2520her%252030s%2520with%2520long%2520hair%252C%2520casual%2520outdoor%2520clothing%252C%2520natural%2520lighting%252C%2520realistic%2520portrait&width=100&height=100&seq=member2&orientation=squarish" alt="Member" class="w-full h-full object-cover">
                            </div>
                            <h4 class="font-medium text-sm">Nguyen Thi Huong</h4>
                            <p class="text-xs text-gray-500">98 posts</p>
                        </div>
                        <!-- Member 3 -->
                        <div class="flex flex-col items-center">
                            <div class="w-16 h-16 rounded-full overflow-hidden mb-2">
                                <img src="https://readdy.ai/api/search-image?query=profile%2520picture%2520of%2520a%2520vietnamese%2520man%2520in%2520his%252050s%2520with%2520gray%2520hair%252C%2520experienced%2520fisherman%2520look%252C%2520outdoor%2520setting%252C%2520natural%2520lighting%252C%2520realistic%2520portrait&width=100&height=100&seq=member3&orientation=squarish" alt="Member" class="w-full h-full object-cover">
                            </div>
                            <h4 class="font-medium text-sm">Le Van Tam</h4>
                            <p class="text-xs text-gray-500">156 posts</p>
                        </div>
                        <!-- Member 4 -->
                        <div class="flex flex-col items-center">
                            <div class="w-16 h-16 rounded-full overflow-hidden mb-2">
                                <img src="https://readdy.ai/api/search-image?query=profile%2520picture%2520of%2520a%2520young%2520vietnamese%2520man%2520in%2520his%252020s%252C%2520modern%2520style%252C%2520casual%2520outfit%252C%2520natural%2520lighting%252C%2520realistic%2520portrait&width=100&height=100&seq=member4&orientation=squarish" alt="Member" class="w-full h-full object-cover">
                            </div>
                            <h4 class="font-medium text-sm">Pham Minh Tuan</h4>
                            <p class="text-xs text-gray-500">203 posts</p>
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
                        <h3 class="text-lg font-bold mb-4">Quick Links</h3>
                        <ul class="space-y-2">
                            <li><a href="Home.jsp" class="text-gray-400 hover:text-white">Home</a></li>
                            <li><a href="Event.jsp" class="text-gray-400 hover:text-white">Events</a></li>
                            <li><a href="NewFeed.jsp" class="text-gray-400 hover:text-white">News Feed</a></li>
                            <li><a href="Product.jsp" class="text-gray-400 hover:text-white">Shop</a></li> 
                            <li><a href="FishKnowledge.jsp" class="text-gray-400 hover:text-white">Knowledge</a></li>
                            <li><a href="Achievement.jsp" class="text-gray-400 hover:text-white">Rankings</a></li>
                        </ul>
                    </div>
                    <div>
                        <h3 class="text-lg font-bold mb-4">Support</h3>
                        <ul class="space-y-2">
                            <li><a href="#" class="text-gray-400 hover:text-white">Help Center</a></li>
                            <li><a href="#" class="text-gray-400 hover:text-white">Privacy Policy</a></li>
                            <li><a href="#" class="text-gray-400 hover:text-white">Terms of Use</a></li>
                            <li><a href="#" class="text-gray-400 hover:text-white">Return Policy</a></li>
                            <li><a href="#" class="text-gray-400 hover:text-white">FAQ</a></li>
                        </ul>
                    </div>
                    <div>
                        <div class="mt-4">
                            <h4 class="text-sm font-medium mb-2">Payment Methods</h4>
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
                    <p class="text-center text-gray-500 text-sm">© 2025 Vietnam Fishing Community. All rights reserved.</p>
                </div>
            </div>
        </footer>
    </body>
</html>