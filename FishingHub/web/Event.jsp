<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <title>Event List - Fishing Community</title>

        <title>Danh sách sự kiện</title>

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
                        <a href="Home.jsp" class="px-4 py-2 text-gray-800 font-medium hover:text-primary">Trang Chủ</a>
                        <a href="Event.jsp" class="px-4 py-2 text-gray-800 font-medium hover:text-primary">Sự Kiện</a>
                        <a href="NewFeed.jsp" class="px-4 py-2 text-gray-800 font-medium hover:text-primary">Bảng Tin</a>
                        <a href="Product.jsp" class="px-4 py-2 text-gray-800 font-medium hover:text-primary">Cửa Hàng</a>
                        <a href="KnowledgeFish" class="px-4 py-2 text-gray-800 font-medium hover:text-primary">Kiến Thức</a>
                        <a href="Achievement.jsp" class="px-4 py-2 text-gray-800 font-medium hover:text-primary">Xếp Hạng</a>
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

                     <button class="bg-primary text-white px-4 py-2 rounded-button whitespace-nowrap">Đăng Nhập</button>
            <button class="bg-white text-primary border border-primary px-4 py-2 rounded-button whitespace-nowrap">Đăng Ký</button>
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
                    <span class="text-primary font-medium">Featured Events</span>
                </div>
            </div>
        </div>
        <!-- Main Content -->
        <main class="py-8">
            <div class="container mx-auto px-4">
                <!-- Title and Search -->
                <div class="flex flex-col md:flex-row justify-between items-start md:items-center mb-8 gap-4">
                    <div>
                        <h1 class="text-3xl font-bold text-gray-900">Featured Events</h1>
                        <p class="text-gray-600 mt-2">All ongoing and upcoming fishing events</p>
                    </div>
                    <div class="flex items-center gap-4">
                        <div class="relative">
                            <input type="text" placeholder="Search for events..."
                                   class="w-full md:w-80 pl-10 pr-4 py-2 rounded-button border-none bg-white shadow-sm focus:ring-2 focus:ring-primary focus:outline-none text-sm">
                            <div
                                class="absolute left-3 top-1/2 transform -translate-y-1/2 w-5 h-5 flex items-center justify-center text-gray-400">
                                <i class="ri-search-line"></i>
                            </div>
                        </div>
                        <!-- Create Event Button -->
                        <a href="EventController?action=create_event"
                           class="bg-primary text-white px-6 py-2 rounded-button whitespace-nowrap flex items-center gap-2">
                            <i class="ri-add-line"></i>
                            <span>Create Event</span>
                        </a>
                    </div>
                </div>
                
                <div class="bg-white rounded shadow-sm mb-8">
                    <!-- Tabs -->
                    <div class="flex border-b border-gray-200">
                        <button class="tab-button active px-6 py-4 text-primary font-medium">All Events</button>
                        <button class="tab-button px-6 py-4 text-gray-600 font-medium hover:text-primary">Saved</button>
                        <button class="tab-button px-6 py-4 text-gray-600 font-medium hover:text-primary">My Events</button>
                    </div>
                </div>
                <!-- Filters -->
                <div class="bg-white rounded shadow-sm p-4 mb-8">
                    <div class="flex flex-col md:flex-row justify-between items-start md:items-center gap-4 mb-4">
                        <h2 class="text-lg font-medium">Filters</h2>
                        <button class="text-primary text-sm flex items-center">
                            <div class="w-5 h-5 flex items-center justify-center">
                                <i class="ri-refresh-line"></i>
                            </div>
                            <span class="ml-1">Reset Filters</span>
                        </button>
                    </div>
                    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
                        <!-- Status -->
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">Status</label>
                            <div class="relative">
                                <select
                                    class="w-full pl-4 pr-10 py-2 rounded-button appearance-none bg-gray-50 border-none focus:ring-2 focus:ring-primary focus:outline-none text-sm">
                                    <option value="">All</option>
                                    <option value="upcoming">Upcoming</option>
                                    <option value="ongoing">Ongoing</option>
                                    <option value="completed">Completed</option>
                                </select>
                                <div
                                    class="absolute right-3 top-1/2 transform -translate-y-1/2 w-5 h-5 flex items-center justify-center text-gray-400 pointer-events-none">
                                    <i class="ri-arrow-down-s-line"></i>
                                </div>
                            </div>
                        </div>
                        <!-- Region -->
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">Region</label>
                            <div class="relative">
                                <select
                                    class="w-full pl-4 pr-10 py-2 rounded-button appearance-none bg-gray-50 border-none focus:ring-2 focus:ring-primary focus:outline-none text-sm">
                                    <option value="">All</option>
                                    <option value="north">North</option>
                                    <option value="central">Central</option>
                                    <option value="south">South</option>
                                </select>
                                <div
                                    class="absolute right-3 top-1/2 transform -translate-y-1/2 w-5 h-5 flex items-center justify-center text-gray-400 pointer-events-none">
                                    <i class="ri-arrow-down-s-line"></i>
                                </div>
                            </div>
                        </div>
                        <!-- From Date -->
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">From Date</label>
                            <div class="relative date-filter">
                                <div class="w-full pl-4 pr-10 py-2 rounded-button bg-gray-50 text-sm flex items-center">
                                    <div class="w-5 h-5 flex items-center justify-center text-gray-400 mr-2">
                                        <i class="ri-calendar-line"></i>
                                    </div>
                                    <span class="text-gray-500">Select Date</span>
                                </div>
                                <input type="date" class="w-full h-full">
                            </div>
                        </div>
                        <!-- To Date -->
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">To Date</label>
                            <div class="relative date-filter">
                                <div class="w-full pl-4 pr-10 py-2 rounded-button bg-gray-50 text-sm flex items-center">
                                    <div class="w-5 h-5 flex items-center justify-center text-gray-400 mr-2">
                                        <i class="ri-calendar-line"></i>
                                    </div>
                                    <span class="text-gray-500">Select Date</span>
                                </div>
                                <input type="date" class="w-full h-full">
                            </div>
                        </div>
                    </div>
                    <div class="mt-4 pt-4 border-t border-gray-100">
                        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
                        </div>
                    </div>
                </div>
                <!-- Sorting and View Options -->
                <div class="flex flex-col md:flex-row justify-between items-start md:items-center mb-6 gap-4">
                    <div class="flex items-center">
                        <span class="text-gray-600 text-sm mr-2">Sort by:</span>
                        <div class="relative">
                            <select
                                class="pl-4 pr-10 py-2 rounded-button appearance-none bg-white border-none shadow-sm focus:ring-2 focus:ring-primary focus:outline-none text-sm">
                                <option value="newest">Newest</option>
                                <option value="popular">Most Popular</option>
                                <option value="upcoming">Upcoming</option>
                            </select>
                            <div
                                class="absolute right-3 top-1/2 transform -translate-y-1/2 w-5 h-5 flex items-center justify-center text-gray-400 pointer-events-none">
                                <i class="ri-arrow-down-s-line"></i>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Events List -->
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 mb-8">
                    <!-- Event 1 -->
                    <div class="bg-white rounded shadow-md overflow-hidden border border-gray-100">
                        <div class="h-48 overflow-hidden">
                            <img src="https://readdy.ai/api/search-image?query=fishing%2520tournament%2520event%2520at%2520a%2520beautiful%2520lake%252C%2520many%2520participants%2520with%2520fishing%2520rods%252C%2520tents%2520and%2520banners%2520set%2520up%252C%2520sunny%2520day%252C%2520vibrant%2520atmosphere%252C%2520high%2520quality%2520photography&width=400&height=240&seq=event1&orientation=landscape"
                                 alt="Fishing Event" class="w-full h-full object-cover object-top">
                        </div>
                        <div class="p-5">
                            <div class="flex justify-between items-center mb-3">
                                <span class="bg-blue-100 text-primary text-xs px-3 py-1 rounded-full">Upcoming</span>
                                <span class="text-sm text-gray-500">05/17/2025</span>
                            </div>
                            <h3 class="text-xl font-bold mb-2">West Lake Fishing Tournament 2025</h3>
                            <p class="text-gray-600 mb-4 line-clamp-2">Join the largest fishing tournament in the North with a total prize pool of 50 million VND and many exciting rewards.</p>
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
                                    <span class="ml-1 text-sm text-gray-500">120/150 people</span>
                                </div>
                            </div>
                            <button class="mt-4 w-full bg-primary text-white py-2 rounded-button whitespace-nowrap">Register to Join</button>
                        </div>
                    </div>
                    <!-- Event 2 -->
                    <div class="bg-white rounded shadow-md overflow-hidden border border-gray-100">
                        <div class="h-48 overflow-hidden">
                            <img src="https://readdy.ai/api/search-image?query=fishing%2520workshop%2520event%2520at%2520a%2520riverside%252C%2520instructor%2520demonstrating%2520fishing%2520techniques%252C%2520small%2520group%2520of%2520learners%252C%2520fishing%2520equipment%2520displayed%252C%2520educational%2520setting%252C%2520sunny%2520day%252C%2520high%2520quality%2520photography&width=400&height=240&seq=event2&orientation=landscape"
                                 alt="Fishing Event" class="w-full h-full object-cover object-top">
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
                                    <span class="ml-1 text-sm text-gray-500">25/30 people</span>
                                </div>
                            </div>
                            <button class="mt-4 w-full bg-primary text-white py-2 rounded-button whitespace-nowrap">Register to Join</button>
                        </div>
                    </div>
                    <!-- Event 3 -->
                    <div class="bg-white rounded shadow-md overflow-hidden border border-gray-100">
                        <div class="h-48 overflow-hidden">
                            <img src="https://readdy.ai/api/search-image?query=community%2520fishing%2520day%2520at%2520a%2520coastal%2520area%252C%2520families%2520and%2520children%2520learning%2520to%2520fish%252C%2520volunteers%2520helping%2520beginners%252C%2520festive%2520atmosphere%252C%2520tents%2520and%2520food%2520stalls%252C%2520sunny%2520beach%2520setting%252C%2520high%2520quality%2520photography&width=400&height=240&seq=event3&orientation=landscape"
                                 alt="Fishing Event" class="w-full h-full object-cover object-top">
                        </div>
                        <div class="p-5">
                            <div class="flex justify-between items-center mb-3">
                                <span class="bg-blue-100 text-primary text-xs px-3 py-1 rounded-full">Upcoming</span>
                                <span class="text-sm text-gray-500">05/30/2025</span>
                            </div>
                            <h3 class="text-xl font-bold mb-2">Family Fishing Day</h3>
                            <p class="text-gray-600 mb-4 line-clamp-2">An event for all ages, especially families with children wanting to experience fishing for the first time.</p>
                            <div class="flex justify-between items-center">
                                <div class="flex items-center">
                                    <div class="w-5 h-5 flex items-center justify-center text-gray-500">
                                        <i class="ri-map-pin-line"></i>
                                    </div>
                                    <span class="ml-1 text-sm text-gray-500">Suoi Tien Theme Park, Ho Chi Minh City</span>
                                </div>
                                <div class="flex items-center">
                                    <div class="w-5 h-5 flex items-center justify-center text-gray-500">
                                        <i class="ri-user-line"></i>
                                    </div>
                                    <span class="ml-1 text-sm text-gray-500">85/200 people</span>
                                </div>
                            </div>
                            <button class="mt-4 w-full bg-primary text-white py-2 rounded-button whitespace-nowrap">Register to Join</button>
                        </div>
                    </div>
                    <!-- Event 4 -->
                    <div class="bg-white rounded shadow-md overflow-hidden border border-gray-100">
                        <div class="h-48 overflow-hidden">
                            <img src="https://readdy.ai/api/search-image?query=professional%2520fishing%2520competition%2520at%2520a%2520large%2520lake%252C%2520competitive%2520atmosphere%252C%2520judges%2520and%2520spectators%252C%2520professional%2520equipment%252C%2520boats%2520on%2520water%252C%2520sunny%2520day%252C%2520high%2520quality%2520photography&width=400&height=240&seq=event4&orientation=landscape"
                                 alt="Fishing Event" class="w-full h-full object-cover object-top">
                        </div>
                        <div class="p-5">
                            <div class="flex justify-between items-center mb-3">
                                <span class="bg-blue-100 text-primary text-xs px-3 py-1 rounded-full">Upcoming</span>
                                <span class="text-sm text-gray-500">06/10/2025</span>
                            </div>
                            <h3 class="text-xl font-bold mb-2">National Fishing Championship 2025</h3>
                            <p class="text-gray-600 mb-4 line-clamp-2">The most prestigious tournament of the year with top anglers from across the country. Total prize pool up to 200 million VND.</p>
                            <div class="flex justify-between items-center">
                                <div class="flex items-center">
                                    <div class="w-5 h-5 flex items-center justify-center text-gray-500">
                                        <i class="ri-map-pin-line"></i>
                                    </div>
                                    <span class="ml-1 text-sm text-gray-500">Thac Ba Lake, Yen Bai</span>
                                </div>
                                <div class="flex items-center">
                                    <div class="w-5 h-5 flex items-center justify-center text-gray-500">
                                        <i class="ri-user-line"></i>
                                    </div>
                                    <span class="ml-1 text-sm text-gray-500">50/100 people</span>
                                </div>
                            </div>
                            <button class="mt-4 w-full bg-primary text-white py-2 rounded-button whitespace-nowrap">Register to Join</button>
                        </div>
                    </div>
                    <!-- Event 5 -->
                    <div class="bg-white rounded shadow-md overflow-hidden border border-gray-100">
                        <div class="h-48 overflow-hidden">
                            <img src="https://readdy.ai/api/search-image?query=night%2520fishing%2520event%2520at%2520a%2520lake%252C%2520lanterns%2520and%2520lights%2520around%2520the%2520shore%252C%2520people%2520with%2520fishing%2520rods%252C%2520peaceful%2520atmosphere%252C%2520beautiful%2520night%2520sky%252C%2520high%2520quality%2520photography&width=400&height=240&seq=event5&orientation=landscape"
                                 alt="Fishing Event" class="w-full h-full object-cover object-top">
                        </div>
                        <div class="p-5">
                            <div class="flex justify-between items-center mb-3">
                                <span class="bg-blue-100 text-primary text-xs px-3 py-1 rounded-full">Upcoming</span>
                                <span class="text-sm text-gray-500">05/25/2025</span>
                            </div>
                            <h3 class="text-xl font-bold mb-2">Moonlit Fishing Night</h3>
                            <p class="text-gray-600 mb-4 line-clamp-2">Experience night fishing in a romantic setting under the moonlight. The event includes a barbecue and acoustic music.</p>
                            <div class="flex justify-between items-center">
                                <div class="flex items-center">
                                    <div class="w-5 h-5 flex items-center justify-center text-gray-500">
                                        <i class="ri-map-pin-line"></i>
                                    </div>
                                    <span class="ml-1 text-sm text-gray-500">Dai Lai Lake, Vinh Phuc</span>
                                </div>
                                <div class="flex items-center">
                                    <div class="w-5 h-5 flex items-center justify-center text-gray-500">
                                        <i class="ri-user-line"></i>
                                    </div>
                                    <span class="ml-1 text-sm text-gray-500">35/60 people</span>
                                </div>
                            </div>
                            <button class="mt-4 w-full bg-primary text-white py-2 rounded-button whitespace-nowrap">Register to Join</button>
                        </div>
                    </div>
                    <!-- Event 6 -->
                    <div class="bg-white rounded shadow-md overflow-hidden border border-gray-100">
                        <div class="h-48 overflow-hidden">
                            <img src="https://readdy.ai/api/search-image?query=fishing%2520workshop%2520for%2520children%252C%2520kids%2520learning%2520to%2520fish%252C%2520instructors%252C%2520educational%2520setting%252C%2520colorful%2520fishing%2520equipment%2520for%2520children%252C%2520sunny%2520day%2520at%2520a%2520safe%2520pond%252C%2520high%2520quality%2520photography&width=400&height=240&seq=event6&orientation=landscape"
                                 alt="Fishing Event" class="w-full h-full object-cover object-top">
                        </div>
                        <div class="p-5">
                            <div class="flex justify-between items-center mb-3">
                                <span class="bg-blue-100 text-primary text-xs px-3 py-1 rounded-full">Upcoming</span>
                                <span class="text-sm text-gray-500">06/05/2025</span>
                            </div>
                            <h3 class="text-xl font-bold mb-2">Children's Fishing Workshop</h3>
                            <p class="text-gray-600 mb-4 line-clamp-2">A course designed for children aged 6-12, helping them get acquainted with fishing and learn about environmental protection.</p>
                            <div class="flex justify-between items-center">
                                <div class="flex items-center">
                                    <div class="w-5 h-5 flex items-center justify-center text-gray-500">
                                        <i class="ri-map-pin-line"></i>
                                    </div>
                                    <span class="ml-1 text-sm text-gray-500">Vam Sat Ecotourism Area, Ho Chi Minh City</span>
                                </div>
                                <div class="flex items-center">
                                    <div class="w-5 h-5 flex items-center justify-center text-gray-500">
                                        <i class="ri-user-line"></i>
                                    </div>
                                    <span class="ml-1 text-sm text-gray-500">15/30 people</span>
                                </div>
                            </div>
                            <button class="mt-4 w-full bg-primary text-white py-2 rounded-button whitespace-nowrap">Register to Join</button>
                        </div>
                    </div>
                    <!-- Event 7 -->
                    <div class="bg-white rounded shadow-md overflow-hidden border border-gray-100">
                        <div class="h-48 overflow-hidden">
                            <img src="https://readdy.ai/api/search-image?query=fly%2520fishing%2520workshop%2520at%2520a%2520mountain%2520stream%252C%2520instructor%2520demonstrating%2520techniques%252C%2520beautiful%2520mountain%2520scenery%252C%2520specialized%2520fly%2520fishing%2520equipment%252C%2520clear%2520water%252C%2520high%2520quality%2520photography&width=400&height=240&seq=event7&orientation=landscape"
                                 alt="Fishing Event" class="w-full h-full object-cover object-top">
                        </div>
                        <div class="p-5">
                            <div class="flex justify-between items-center mb-3">
                                <span class="bg-blue-100 text-primary text-xs px-3 py-1 rounded-full">Upcoming</span>
                                <span class="text-sm text-gray-500">06/12/2025</span>
                            </div>
                            <h3 class="text-xl font-bold mb-2">Fly Fishing Workshop</h3>
                            <p class="text-gray-600 mb-4 line-clamp-2">Learn how to use artificial lures effectively with expert Tran Duc Phuong, who has over 20 years of professional fishing experience.</p>
                            <div class="flex justify-between items-center">
                                <div class="flex items-center">
                                    <div class="w-5 h-5 flex items-center justify-center text-gray-500">
                                        <i class="ri-map-pin-line"></i>
                                    </div>
                                    <span class="ml-1 text-sm text-gray-500">Yen Stream, Ba Vi, Hanoi</span>
                                </div>
                                <div class="flex items-center">
                                    <div class="w-5 h-5 flex items-center justify-center text-gray-500">
                                        <i class="ri-user-line"></i>
                                    </div>
                                    <span class="ml-1 text-sm text-gray-500">18/25 people</span>
                                </div>
                            </div>
                            <button class="mt-4 w-full bg-primary text-white py-2 rounded-button whitespace-nowrap">Register to Join</button>
                        </div>
                    </div>
                    <!-- Event 8 -->
                    <div class="bg-white rounded shadow-md overflow-hidden border border-gray-100">
                        <div class="h-48 overflow-hidden">
                            <img src="https://readdy.ai/api/search-image?query=boat%2520fishing%2520competition%2520on%2520a%2520large%2520lake%252C%2520multiple%2520boats%2520with%2520fishermen%252C%2520competitive%2520atmosphere%252C%2520beautiful%2520scenery%252C%2520sunny%2520day%252C%2520high%2520quality%2520photography&width=400&height=240&seq=event8&orientation=landscape"
                                 alt="Fishing Event" class="w-full h-full object-cover object-top">
                        </div>
                        <div class="p-5">
                            <div class="flex justify-between items-center mb-3">
                                <span class="bg-blue-100 text-primary text-xs px-3 py-1 rounded-full">Upcoming</span>
                                <span class="text-sm text-gray-500">06/20/2025</span>
                            </div>
                            <h3 class="text-xl font-bold mb-2">Boat Fishing Tournament</h3>
                            <p class="text-gray-600 mb-4 line-clamp-2">Experience boat fishing at Dau Tieng Lake, one of the largest freshwater lakes in Vietnam with diverse fish species.</p>
                            <div class="flex justify-between items-center">
                                <div class="flex items-center">
                                    <div class="w-5 h-5 flex items-center justify-center text-gray-500">
                                        <i class="ri-map-pin-line"></i>
                                    </div>
                                    <span class="ml-1 text-sm text-gray-500">Dau Tieng Lake, Tay Ninh</span>
                                </div>
                                <div class="flex items-center">
                                    <div class="w-5 h-5 flex items-center justify-center text-gray-500">
                                        <i class="ri-user-line"></i>
                                    </div>
                                    <span class="ml-1 text-sm text-gray-500">30/40 people</span>
                                </div>
                            </div>
                            <button class="mt-4 w-full bg-primary text-white py-2 rounded-button whitespace-nowrap">Register to Join</button>
                        </div>
                    </div>
                    <!-- Event 9 -->
                    <div class="bg-white rounded shadow-md overflow-hidden border border-gray-100">
                        <div class="h-48 overflow-hidden">
                            <img src="https://readdy.ai/api/search-image?query=fishing%2520equipment%2520exhibition%252C%2520various%2520fishing%2520gear%2520displayed%2520in%2520booths%252C%2520vendors%2520and%2520visitors%252C%2520indoor%2520exhibition%2520hall%252C%2520professional%2520setting%252C%2520high%2520quality%2520photography&width=400&height=240&seq=event9&orientation=landscape"
                                 alt="Fishing Event" class="w-full h-full object-cover object-top">
                        </div>
                        <div class="p-5">
                            <div class="flex justify-between items-center mb-3">
                                <span class="bg-blue-100 text-primary text-xs px-3 py-1 rounded-full">Upcoming</span>
                                <span class="text-sm text-gray-500">07/15/2025</span>
                            </div>
                            <h3 class="text-xl font-bold mb-2">Fishing Equipment Exhibition 2025</h3>
                            <p class="text-gray-600 mb-4 line-clamp-2">An exhibition featuring over 50 top domestic and international fishing equipment brands, showcasing the latest products.</p>
                            <div class="flex justify-between items-center">
                                <div class="flex items-center">
                                    <div class="w-5 h-5 flex items-center justify-center text-gray-500">
                                        <i class="ri-map-pin-line"></i>
                                    </div>
                                    <span class="ml-1 text-sm text-gray-500">Saigon Exhibition and Convention Center (SECC)</span>
                                </div>
                                <div class="flex items-center">
                                    <div class="w-5 h-5 flex items-center justify-center text-gray-500">
                                        <i class="ri-user-line"></i>
                                    </div>
                                    <span class="ml-1 text-sm text-gray-500">Unlimited</span>
                                </div>
                            </div>
                            <button class="mt-4 w-full bg-primary text-white py-2 rounded-button whitespace-nowrap">Register to Join</button>
                        </div>
                    </div>
                    <!-- Duplicate Event 9 (as in original code) -->
                    <div class="bg-white rounded shadow-md overflow-hidden border border-gray-100">
                        <div class="h-48 overflow-hidden">
                            <img src="https://readdy.ai/api/search-image?query=fishing%2520equipment%2520exhibition%252C%2520various%2520fishing%2520gear%2520displayed%2520in%2520booths%252C%2520vendors%2520and%2520visitors%252C%2520indoor%2520exhibition%2520hall%252C%2520professional%2520setting%252C%2520high%2520quality%2520photography&width=400&height=240&seq=event9&orientation=landscape"
                                 alt="Fishing Event" class="w-full h-full object-cover object-top">
                        </div>
                        <div class="p-5">
                            <div class="flex justify-between items-center mb-3">
                                <span class="bg-blue-100 text-primary text-xs px-3 py-1 rounded-full">Upcoming</span>
                                <span class="text-sm text-gray-500">07/15/2025</span>
                            </div>
                            <h3 class="text-xl font-bold mb-2">Fishing Equipment Exhibition 2025</h3>
                            <p class="text-gray-600 mb-4 line-clamp-2">An exhibition featuring over 50 top domestic and international fishing equipment brands, showcasing the latest products.</p>
                            <div class="flex justify-between items-center">
                                <div class="flex items-center">
                                    <div class="w-5 h-5 flex items-center justify-center text-gray-500">
                                        <i class="ri-map-pin-line"></i>
                                    </div>
                                    <span class="ml-1 text-sm text-gray-500">Saigon Exhibition and Convention Center (SECC)</span>
                                </div>
                                <div class="flex items-center">
                                    <div class="w-5 h-5 flex items-center justify-center text-gray-500">
                                        <i class="ri-user-line"></i>
                                    </div>
                                    <span class="ml-1 text-sm text-gray-500">Unlimited</span>
                                </div>
                            </div>
                            <button class="mt-4 w-full bg-primary text-white py-2 rounded-button whitespace-nowrap">Register to Join</button>
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
                        <button
                            class="w-9 h-9 flex items-center justify-center bg-white text-gray-600 rounded shadow-sm">2</button>
                        <button
                            class="w-9 h-9 flex items-center justify-center bg-white text-gray-600 rounded shadow-sm">3</button>
                        <button
                            class="w-9 h-9 flex items-center justify-center bg-white text-gray-600 rounded shadow-sm">4</button>
                        <button
                            class="w-9 h-9 flex items-center justify-center bg-white text-gray-600 rounded shadow-sm">5</button>
                        <button class="w-9 h-9 flex items-center justify-center bg-white text-gray-600 rounded shadow-sm">
                            <i class="ri-arrow-right-s-line"></i>
                        </button>
                    </div>
                    <div class="flex items-center gap-2">
                        <span class="text-sm text-gray-600">Show:</span>
                        <div class="relative">
                            <select
                                class="pl-3 pr-8 py-1 rounded appearance-none bg-white border-none shadow-sm focus:ring-2 focus:ring-primary focus:outline-none text-sm">
                                <option value="9">9</option>
                                <option value="18">18</option>
                                <option value="27">27</option>
                                <option value="36">36</option>
                            </select>
                            <div
                                class="absolute right-2 top-1/2 transform -translate-y-1/2 w-4 h-4 flex items-center justify-center text-gray-400 pointer-events-none">
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

    </body>
</html>