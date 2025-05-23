<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Personal Achievements</title>
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

                <button class="bg-primary text-white px-4 py-2 rounded-button whitespace-nowrap">Log In</button>
                <button class="bg-white text-primary border border-primary px-4 py-2 rounded-button whitespace-nowrap">Sign Up</button>
            </div>
        </div>
    </header>
    <!-- Breadcrumb -->
    <div class="bg-white border-b">
        <div class="container mx-auto px-4 py-3">
            <div class="flex items-center text-sm">
                <a href="Home.jsp" class="text-gray-500 hover:text-primary">Home</a>
                <span class="mx-2 text-gray-400">/</span>
                <span class="text-primary font-medium">Achievements</span>
            </div>
        </div>
    </div>
    <main class="container mx-auto px-4 py-6 min-h-[calc(100vh-160px)]">
        <div class="tab-content active" id="post-achievement">
            <div class="max-w-3xl mx-auto bg-white rounded-lg shadow-sm p-6 mb-6">
                <h2 class="text-2xl font-bold text-gray-800 mb-6 text-center">Post Achievement</h2>
                <div class="mb-8">
                    <h3 class="text-lg font-medium text-gray-700 mb-4">Upload your achievement photo</h3>
                    <div class="flex flex-col items-center justify-center w-full">
                        <label for="fish-image" class="w-full h-64 border-2 border-gray-300 border-dashed rounded-lg cursor-pointer bg-gray-50 hover:bg-gray-100 transition-colors flex flex-col items-center justify-center">
                            <div class="flex flex-col items-center justify-center pt-5 pb-6" id="upload-placeholder">
                                <i class="ri-upload-cloud-2-line text-4xl text-gray-500 mb-2"></i>
                                <p class="mb-2 text-sm text-gray-500"><span class="font-medium">Click to upload</span> or drag and drop</p>
                                <p class="text-xs text-gray-500">PNG, JPG (Max 5MB)</p>
                            </div>
                            <div id="image-preview" class="hidden w-full h-full relative">
                                <img src="" alt="Preview" class="w-full h-full object-contain">
                                <button type="button" class="absolute top-2 right-2 bg-white rounded-full p-1 shadow-sm hover:bg-gray-100" id="remove-image">
                                    <i class="ri-close-line text-gray-500"></i>
                                </button>
                            </div>
                        </label>
                        <input id="fish-image" type="file" class="hidden" accept="image/*">
                    </div>
                </div>
            </div>
        </div>
        <div class="mb-6">
            <div class="flex justify-between items-center mb-2">
                <label for="description" class="block text-lg font-medium text-gray-700">Achievement Description</label>
                <span class="text-sm text-gray-500" id="char-count">0/200</span>
            </div>
            <textarea id="description" rows="4" class="w-full px-4 py-3 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-primary focus:border-primary resize-none" placeholder="Share your achievement..."></textarea>
        </div>
        <div class="flex justify-between items-center">
            <div class="flex items-center">
                <div class="w-8 h-8 bg-gray-100 rounded-full flex items-center justify-center mr-2">
                    <i class="ri-trophy-line text-primary"></i>
                </div>
                <span class="font-medium" id="selected-points">0 points</span>
            </div>
            <button id="post-button" class="bg-primary text-white px-6 py-3 rounded-button font-medium hover:bg-blue-600 transition-colors whitespace-nowrap disabled:opacity-50 disabled:cursor-not-allowed" disabled>Post Achievement</button>
        </div>
    </main>
    <footer class="bg-white border-t border-gray-200 py-4">
        <div class="container mx-auto px-4">
            <div class="flex justify-between items-center">
                <div class="w-1/3">
                    <p class="text-sm text-gray-500">© 2025 Personal Achievements</p>
                </div>
                <div class="w-1/3 flex justify-center">
                    <nav class="flex bg-gray-100 rounded-full p-1">
                        <button class="tab-button flex-1 py-2 px-4 rounded-full text-sm font-medium whitespace-nowrap transition-colors active bg-white text-primary" data-tab="post-achievement">
                            <div class="flex items-center justify-center">
                                <i class="ri-add-circle-line mr-1"></i>
                                <span>Post</span>
                            </div>
                        </button>
                        <button class="tab-button flex-1 py-2 px-4 rounded-full text-sm font-medium whitespace-nowrap transition-colors" data-tab="my-achievements">
                            <div class="flex items-center justify-center">
                                <i class="ri-trophy-line mr-1"></i>
                                <span>Achievements</span>
                            </div>
                        </button>
                        <button class="tab-button flex-1 py-2 px-4 rounded-full text-sm font-medium whitespace-nowrap transition-colors" data-tab="leaderboard">
                            <div class="flex items-center justify-center">
                                <i class="ri-bar-chart-line mr-1"></i>
                                <span>Rankings</span>
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