<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Fishing Community</title>
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
        <!-- Hero Section -->
       <!-- Hero Section -->
<section class="hero-section py-16 relative bg-cover bg-center bg-no-repeat" style="background-image: url('assets/img/hero-bg.jpg');">
    <!-- Add overlay -->
    <div class="absolute inset-0 bg-black/40"></div>
    <div class="container mx-auto px-4 w-full relative">
        <div class="max-w-2xl">
            <h1 class="text-4xl md:text-5xl font-bold text-white mb-4">Vietnam's Leading Fishing Community</h1>
            <p class="text-lg text-white mb-8">Join over 10,000+ fishing enthusiasts, share experiences, and participate in exciting fishing events across the country.</p>
            <div class="flex flex-col sm:flex-row gap-4">
                <button class="bg-primary text-white px-6 py-3 rounded-button font-medium whitespace-nowrap hover:bg-primary/90">Join Now</button>
                <button class="bg-white text-primary border border-primary px-6 py-3 rounded-button font-medium whitespace-nowrap hover:bg-gray-50">View Events</button>
            </div>
        </div>
    </div>
</section>
        <!-- Featured Events -->
        <section class="py-16 bg-white">
            <div class="container mx-auto px-4">
                <div class="flex justify-between items-center mb-8">
                    <h2 class="text-3xl font-bold text-gray-900">Featured Events</h2>
                    <a href="Event.jsp" class="text-primary font-medium flex items-center">
                        View All
                        <i class="ri-arrow-right-line ml-1"></i>
                    </a>
                </div>
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                    <!-- Event 1 -->
                    <div class="bg-white rounded shadow-md overflow-hidden border border-gray-100">
                        <div class="h-48 overflow-hidden">
                            <img src="https://readdy.ai/api/search-image?query=fishing%20tournament%20event%20at%20a%20beautiful%20lake%2C%20many%20participants%20with%20fishing%20rods%2C%20tents%20and%20banners%20set%20up%2C%20sunny%20day%2C%20vibrant%20atmosphere%2C%20high%20quality%20photography&width=400&height=240&seq=event1&orientation=landscape" alt="Fishing event" class="w-full h-full object-cover object-top">
                        </div>
                        <div class="p-5">
                            <div class="flex justify-between items-center mb-3">
                                <span class="bg-blue-100 text-primary text-xs px-3 py-1 rounded-full">Upcoming</span>
                                <span class="text-sm text-gray-500">05/17/2025</span>
                            </div>
                            <h3 class="text-xl font-bold mb-2">West Lake Fishing Tournament 2025</h3>
                            <p class="text-gray-600 mb-4 line-clamp-2">Join the largest fishing tournament in Northern Vietnam with a total prize pool of up to 50 million VND and many exciting rewards.</p>
                            <div class="flex justify-between items-center">
                                <div class="flex items-center">
                                    <div class="w-5 h-5 flex items-center justify-center text-gray-500">
                                        <i class="ri-map-pin-line"></i>
                                    </div>
                                    <span class="ml-1 text-sm text-gray-500">West Lake, Hanoi</span>
                                </div>
                                <div class="flex items-center">
                                    <div class="w-5 h-5 flex items-center justify-center text-gray-500">
                                        <i class="ri-user-line"></i>
                                    </div>
                                    <span class="ml-1 text-sm text-gray-500">120/150 participants</span>
                                </div>
                            </div>
                            <button class="mt-4 w-full bg-primary text-white py-2 rounded-button whitespace-nowrap">Register to Join</button>
                        </div>
                    </div>
                    <!-- Event 2 -->
                    <div class="bg-white rounded shadow-md overflow-hidden border border-gray-100">
                        <div class="h-48 overflow-hidden">
                            <img src="https://readdy.ai/api/search-image?query=fishing%20workshop%20event%20at%20a%20riverside%2C%20instructor%20demonstrating%20fishing%20techniques%2C%20small%20group%20of%20learners%2C%20fishing%20equipment%20displayed%2C%20educational%20setting%2C%20sunny%20day%2C%20high%20quality%20photography&width=400&height=240&seq=event2&orientation=landscape" alt="Fishing event" class="w-full h-full object-cover object-top">
                        </div>
                        <div class="p-5">
                            <div class="flex justify-between items-center mb-3">
                                <span class="bg-green-100 text-green-600 text-xs px-3 py-1 rounded-full">Ongoing</span>
                                <span class="text-sm text-gray-500">05/15 - 05/20/2025</span>
                            </div>
                            <h3 class="text-xl font-bold mb-2">Advanced Fishing Techniques Workshop</h3>
                            <p class="text-gray-600 mb-4 line-clamp-2">A 5-day course with leading experts, learning modern and traditional fishing techniques.</p>
                            <div class="flex justify-between items-center">
                                <div class="flex items-center">
                                    <div class="w-5 h-5 flex items-center justify-center text-gray-500">
                                        <i class="ri-map-pin-line"></i>
                                    </div>
                                    <span class="ml-1 text-sm text-gray-500">Xuan Huong Lake, Da Lat</span>
                                </div>
                                <div class="flex items-center">
                                    <div class="w-5 h-5 flex items-center justify-center text-gray-500">
                                        <i class="ri-user-line"></i>
                                    </div>
                                    <span class="ml-1 text-sm text-gray-500">25/30 participants</span>
                                </div>
                            </div>
                            <button class="mt-4 w-full bg-primary text-white py-2 rounded-button whitespace-nowrap">Register to Join</button>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Community News -->
        <section class="py-16 bg-gray-50">
            <div class="container mx-auto px-4">
                <div class="flex justify-between items-center mb-8">
                    <h2 class="text-3xl font-bold text-gray-900">Community News</h2>
                    <a href="NewFeed.jsp" data-readdy="true" class="text-primary font-medium flex items-center">
                        View All
                        <i class="ri-arrow-right-line ml-1"></i>
                    </a>
                </div>
                <!-- Pinned Post -->
                <div class="bg-white rounded shadow-md p-6 mb-8 border-l-4 border-primary">
                    <div class="flex items-start">
                        <div class="w-12 h-12 rounded-full overflow-hidden mr-4">
                            <img src="https://readdy.ai/api/search-image?query=profile%20picture%20of%20a%20professional%20looking%20male%20in%20his%2040s%2C%20outdoor%20clothing%2C%20fishing%20hat%2C%20confident%20expression%2C%20natural%20lighting&width=100&height=100&seq=admin1&orientation=squarish" alt="Admin" class="w-full h-full object-cover">
                        </div>
                        <div class="flex-1">
                            <div class="flex items-center mb-2">
                                <h3 class="font-bold text-lg">Tran Quoc Bao</h3>
                                <span class="ml-2 bg-blue-100 text-primary text-xs px-2 py-0.5 rounded">Admin</span>
                                <div class="w-5 h-5 flex items-center justify-center ml-2 text-yellow-500">
                                    <i class="ri-pushpin-fill"></i>
                                </div>
                            </div>
                            <p class="text-gray-600 mb-4">Important announcement: Updates on the new regulations for the 2025 National Fishing Tournament. All members are kindly requested to read the guidelines carefully before registering for upcoming tournaments.</p>
                            <div class="flex justify-between items-center">
                                <div class="flex items-center">
                                    <button class="flex items-center text-gray-500 hover:text-primary">
                                        <div class="w-5 h-5 flex items-center justify-center">
                                            <i class="ri-heart-line"></i>
                                        </div>
                                        <span class="ml-1">128</span>
                                    </button>
                                    <button class="flex items-center text-gray-500 hover:text-primary ml-4">
                                        <div class="w-5 h-5 flex items-center justify-center">
                                            <i class="ri-chat-1-line"></i>
                                        </div>
                                        <span class="ml-1">43</span>
                                    </button>
                                </div>
                                <span class="text-sm text-gray-500">05/17/2025, 08:30</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Featured Products -->
        <section class="py-16 bg-white">
            <div class="container mx-auto px-4">
                <div class="flex justify-between items-center mb-8">
                    <h2 class="text-3xl font-bold text-gray-900">Featured Products</h2>
                    <a href="Product.jsp" data-readdy="true" class="text-primary font-medium flex items-center">
                        View All
                        <i class="ri-arrow-right-line ml-1"></i>
                    </a>
                </div>
                <div class="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
                    <!-- Product 1 -->
                    <div class="bg-white rounded shadow-sm overflow-hidden border border-gray-100 group">
                        <div class="h-48 overflow-hidden relative">
                            <img src="https://readdy.ai/api/search-image?query=high-quality%20fishing%20rod%20with%20reel%2C%20professional%20equipment%2C%20detailed%20product%20photography%20on%20clean%20white%20background%2C%20no%20people&width=300&height=300&seq=product1&orientation=squarish" alt="Fishing rod" class="w-full h-full object-cover object-top transition-transform duration-300 group-hover:scale-105">
                            <div class="absolute top-2 right-2 bg-red-500 text-white text-xs px-2 py-1 rounded">-15%</div>
                        </div>
                        <div class="p-4">
                            <h3 class="text-lg font-medium mb-1 line-clamp-1">Shimazu Pro X5 Carbon Fishing Rod</h3>
                            <p class="text-gray-500 text-sm mb-2 line-clamp-1">Professional, lightweight, and durable fishing rod</p>
                            <div class="flex items-center mb-3">
                                <div class="flex text-yellow-400">
                                    <i class="ri-star-fill"></i>
                                    <i class="ri-star-fill"></i>
                                    <i class="ri-star-fill"></i>
                                    <i class="ri-star-fill"></i>
                                    <i class="ri-star-half-fill"></i>
                                </div>
                                <span class="text-xs text-gray-500 ml-1">(48)</span>
                            </div>
                            <div class="flex items-center justify-between">
                                <div>
                                    <span class="text-gray-400 line-through text-sm">1,850,000₫</span>
                                    <p class="text-lg font-bold text-primary">1,570,000₫</p>
                                </div>
                                <button class="w-10 h-10 flex items-center justify-center bg-primary text-white rounded-full">
                                    <i class="ri-shopping-cart-line"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                    <!-- Product 2 -->
                    <div class="bg-white rounded shadow-sm overflow-hidden border border-gray-100 group">
                        <div class="h-48 overflow-hidden">
                            <img src="https://readdy.ai/api/search-image?query=fishing%20tackle%20box%20with%20various%20lures%20and%20hooks%2C%20organized%20fishing%20equipment%2C%20detailed%20product%20photography%20on%20clean%20white%20background%2C%20no%20people&width=300&height=300&seq=product2&orientation=squarish" alt="Tackle box" class="w-full h-full object-cover object-top transition-transform duration-300 group-hover:scale-105">
                        </div>
                        <div class="p-4">
                            <h3 class="text-lg font-medium mb-1 line-clamp-1">5-Tier Multifunctional Tackle Box</h3>
                            <p class="text-gray-500 text-sm mb-2 line-clamp-1">High-quality waterproof plastic box with multiple compartments</p>
                            <div class="flex items-center mb-3">
                                <div class="flex text-yellow-400">
                                    <i class="ri-star-fill"></i>
                                    <i class="ri-star-fill"></i>
                                    <i class="ri-star-fill"></i>
                                    <i class="ri-star-fill"></i>
                                    <i class="ri-star-line"></i>
                                </div>
                                <span class="text-xs text-gray-500 ml-1">(36)</span>
                            </div>
                            <div class="flex items-center justify-between">
                                <div>
                                    <p class="text-lg font-bold text-primary">450,000₫</p>
                                </div>
                                <button class="w-10 h-10 flex items-center justify-center bg-primary text-white rounded-full">
                                    <i class="ri-shopping-cart-line"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Fish Knowledge -->
        <section class="py-16 bg-gray-50">
            <div class="container mx-auto px-4">
                <div class="flex justify-between items-center mb-8">
                    <h2 class="text-3xl font-bold text-gray-900">Fish Knowledge</h2>
                    <a href="FishKnowledge.jsp" data-readdy="true" class="text-primary font-medium flex items-center">
                        View All
                        <i class="ri-arrow-right-line ml-1"></i>
                    </a>
                </div>
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                    <!-- Fish Species 1 -->
                    <div class="bg-white rounded shadow-md overflow-hidden">
                        <div class="h-48 overflow-hidden">
                            <img src="https://readdy.ai/api/search-image?query=large%20carp%20fish%20in%20water%2C%20detailed%20view%20of%20scales%20and%20fins%2C%20freshwater%20fish%2C%20natural%20habitat%2C%20high%20quality%20photography&width=400&height=240&seq=fish_species1&orientation=landscape" alt="Carp" class="w-full h-full object-cover object-top">
                        </div>
                        <div class="p-5">
                            <h3 class="text-xl font-bold mb-2">Carp (Cyprinus carpio)</h3>
                            <p class="text-gray-600 mb-4">Carp is one of the most common freshwater fish in Vietnam, highly sought after by recreational and sport anglers.</p>
                            <div class="grid grid-cols-2 gap-2 mb-4">
                                <div class="flex items-center">
                                    <div class="w-5 h-5 flex items-center justify-center text-primary">
                                        <i class="ri-scales-line"></i>
                                    </div>
                                    <span class="ml-2 text-sm">Weight: 1-10kg</span>
                                </div>
                                <div class="flex items-center">
                                    <div class="w-5 h-5 flex items-center justify-center text-primary">
                                        <i class="ri-ruler-line"></i>
                                    </div>
                                    <span class="ml-2 text-sm">Length: 30-80cm</span>
                                </div>
                                <div class="flex items-center">
                                    <div class="w-5 h-5 flex items-center justify-center text-primary">
                                        <i class="ri-water-flash-line"></i>
                                    </div>
                                    <span class="ml-2 text-sm">Environment: Freshwater</span>
                                </div>
                                <div class="flex items-center">
                                    <div class="w-5 h-5 flex items-center justify-center text-primary">
                                        <i class="ri-map-pin-line"></i>
                                    </div>
                                    <span class="ml-2 text-sm">Distribution: Nationwide</span>
                                </div>
                            </div>
                            <button class="w-full bg-primary text-white py-2 rounded-button whitespace-nowrap">View Details</button>
                        </div>
                    </div>
                    <!-- Fish Species 2 -->
                    <div class="bg-white rounded shadow-md overflow-hidden">
                        <div class="h-48 overflow-hidden">
                            <img src="https://readdy.ai/api/search-image?query=snakehead%20fish%20in%20water%2C%20detailed%20view%20of%20head%20and%20body%2C%20freshwater%20predator%20fish%2C%20natural%20habitat%2C%20high%20quality%20photography&width=400&height=240&seq=fish_species2&orientation=landscape" alt="Snakehead" class="w-full h-full object-cover object-top">
                        </div>
                        <div class="p-5">
                            <h3 class="text-xl font-bold mb-2">Snakehead (Channa striata)</h3>
                            <p class="text-gray-600 mb-4">Snakehead is a predatory fish, favored by many anglers for its strength and challenging catch.</p>
                            <div class="grid grid-cols-2 gap-2 mb-4">
                                <div class="flex items-center">
                                    <div class="w-5 h-5 flex items-center justify-center text-primary">
                                        <i class="ri-scales-line"></i>
                                    </div>
                                    <span class="ml-2 text-sm">Weight: 0.5-5kg</span>
                                </div>
                                <div class="flex items-center">
                                    <div class="w-5 h-5 flex items-center justify-center text-primary">
                                        <i class="ri-ruler-line"></i>
                                    </div>
                                    <span class="ml-2 text-sm">Length: 30-90cm</span>
                                </div>
                                <div class="flex items-center">
                                    <div class="w-5 h-5 flex items-center justify-center text-primary">
                                        <i class="ri-water-flash-line"></i>
                                    </div>
                                    <span class="ml-2 text-sm">Environment: Freshwater</span>
                                </div>
                                <div class="flex items-center">
                                    <div class="w-5 h-5 flex items-center justify-center text-primary">
                                        <i class="ri-map-pin-line"></i>
                                    </div>
                                    <span class="ml-2 text-sm">Distribution: Southern Vietnam</span>
                                </div>
                            </div>
                            <button class="w-full bg-primary text-white py-2 rounded-button whitespace-nowrap">View Details</button>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Rankings -->
        <section class="py-16 bg-white">
            <div class="container mx-auto px-4">
                <div class="flex justify-between items-center mb-8">
                    <h2 class="text-3xl font-bold text-gray-900">Rankings</h2>
                    <div class="flex items-center bg-gray-100 rounded-full p-1">
                        <button class="px-4 py-2 rounded-full bg-primary text-white text-sm whitespace-nowrap">This Month</button>
                        <button class="px-4 py-2 rounded-full text-gray-700 text-sm whitespace-nowrap">This Year</button>
                        <button class="px-4 py-2 rounded-full text-gray-700 text-sm whitespace-nowrap">All Time</button>
                    </div>
                </div>
                <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
                    <!-- Top Achievements -->
                    <div class="bg-white rounded shadow-md overflow-hidden border border-gray-100">
                        <div class="bg-primary text-white py-3 px-4">
                            <h3 class="text-lg font-bold">Top Achievements</h3>
                        </div>
                        <div class="p-4">
                            <div class="space-y-4">
                                <!-- Top 1 -->
                                <div class="flex items-center">
                                    <div class="w-8 h-8 flex items-center justify-center bg-yellow-400 text-white rounded-full font-bold mr-3">1</div>
                                    <div class="w-10 h-10 rounded-full overflow-hidden mr-3">
                                        <img src="https://readdy.ai/api/search-image?query=profile%20picture%20of%20a%20vietnamese%20male%20in%20his%2040s%2C%20outdoor%20enthusiast%2C%20wearing%20fishing%20hat%2C%20natural%20lighting&width=100&height=100&seq=top1&orientation=squarish" alt="Top 1" class="w-full h-full object-cover">
                                    </div>
                                    <div class="flex-1">
                                        <h4 class="font-medium">Nguyen Van Hung</h4>
                                        <p class="text-sm text-gray-500">Catfish 8.5kg at Tri An Lake</p>
                                    </div>
                                    <div class="flex items-center">
                                        <div class="w-5 h-5 flex items-center justify-center text-yellow-500">
                                            <i class="ri-trophy-fill"></i>
                                        </div>
                                        <span class="ml-1 font-medium">156</span>
                                    </div>
                                </div>
                                <!-- Top 2 -->
                                <div class="flex items-center">
                                    <div class="w-8 h-8 flex items-center justify-center bg-gray-300 text-white rounded-full font-bold mr-3">2</div>
                                    <div class="w-10 h-10 rounded-full overflow-hidden mr-3">
                                        <img src="https://readdy.ai/api/search-image?query=profile%20picture%20of%20a%20vietnamese%20female%20in%20her%2030s%2C%20outdoor%20enthusiast%2C%20casual%20attire%2C%20natural%20lighting&width=100&height=100&seq=top2&orientation=squarish" alt="Top 2" class="w-full h-full object-cover">
                                    </div>
                                    <div class="flex-1">
                                        <h4 class="font-medium">Tran Thi Hoa</h4>
                                        <p class="text-sm text-gray-500">Carp 6.2kg at West Lake</p>
                                    </div>
                                    <div class="flex items-center">
                                        <div class="w-5 h-5 flex items-center justify-center text-yellow-500">
                                            <i class="ri-trophy-fill"></i>
                                        </div>
                                        <span class="ml-1 font-medium">132</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
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
                        <h3 class="text-lg font-bold mb-4">Quick Links</h3>
                        <ul class="space-y-2">
                            <li><a href="Home.jsp" class="text-gray-400 hover:text-white">Home</a></li>
                            <li><a href="Event.jsp" class="text-gray-400 hover:text-white">Events</a></li>
                            <li><a href="NewFeed.jsp" class="text-gray-400 hover:text-white">Feed</a></li>
                            <li><a href="Product.jsp" class="text-gray-400 hover:text-white">Shop</a></li> 
                            <li><a href="FishKnowledge.jsp" class="text-gray-400 hover:text-white">Knowledge</a></li>
                            <li><a href="Achievement.jsp" class="text-gray-400 hover:text-white">Rankings</a></li>
                        </ul>
                    </div>
                    <!-- Support -->
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
                    <!-- Payment Methods -->
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
        <script src="https://cdnjs.cloudflare.com/ajax/libs/echarts/5.5.0/echarts.min.js"></script>
    </body>
</html>