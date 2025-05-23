<%@page contentType="text/html" pageEncoding="UTF-8"%>

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
                    <!-- Header navigation links -->
                    <nav class="hidden md:flex ml-10">
                        <a href="Home.jsp" class="px-4 py-2 text-gray-800 font-medium hover:text-primary">Home</a>
                        <a href="Event.jsp" class="px-4 py-2 text-gray-800 font-medium hover:text-primary">Events</a>
                        <a href="NewFeed.jsp" class="px-4 py-2 text-gray-800 font-medium hover:text-primary">News Feed</a>
                        <a href="Product.jsp" class="px-4 py-2 text-gray-800 font-medium hover:text-primary">Store</a>
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
                    <span class="text-primary font-medium">Knowledge</span>
                </div>
            </div>
        </div>

        <main class="container mx-auto px-4 py-8">
            <div id="fishList" class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
                <!-- Common Carp -->
                <div class="card-fish bg-white rounded-lg shadow overflow-hidden">
                    <div class="relative h-48">
                        <img src="https://readdy.ai/api/search-image?query=A%20detailed%20photograph%20of%20a%20common%20carp%20%28Cyprinus%20carpio%29%20swimming%20in%20clear%20water%2C%20showing%20its%20distinctive%20reddish-orange%20scales%20and%20barbels%2C%20against%20a%20simple%20underwater%20background&width=400&height=300&seq=1&orientation=landscape" alt="Common Carp" class="w-full h-full object-cover object-top">
                        <button class="bookmark-btn absolute top-2 right-2 w-8 h-8 flex items-center justify-center bg-white bg-opacity-70 rounded-full">
                            <i class="ri-bookmark-line text-gray-600"></i>
                        </button>
                    </div>
                    <div class="p-4">
                        <div class="flex justify-between items-start">
                            <div>
                                <h3 class="font-bold text-gray-800">Common Carp</h3>
                                <p class="text-sm text-gray-600 italic">Cyprinus carpio</p>
                            </div>
                            <div class="w-6 h-6 flex items-center justify-center bg-blue-100 rounded-full">
                                <i class="ri-water-flash-line text-blue-600 text-sm"></i>
                            </div>
                        </div>
                        <div class="mt-3 flex justify-between items-center">
                            <span class="text-xs text-gray-500">Warm Water • Asia</span>
                            <button class="view-details px-3 py-1 text-xs text-primary border border-primary rounded-button hover:bg-primary hover:text-white whitespace-nowrap" data-id="1">Details</button>
                        </div>
                    </div>
                </div>
                <!-- Nile Tilapia -->
                <div class="card-fish bg-white rounded-lg shadow overflow-hidden">
                    <div class="relative h-48">
                        <img src="https://readdy.ai/api/search-image?query=A%20clear%20photograph%20of%20a%20Nile%20tilapia%20%28Oreochromis%20niloticus%29%20with%20its%20distinctive%20body%20shape%20and%20vertical%20stripes%2C%20swimming%20in%20freshwater%20with%20a%20clean%20background&width=400&height=300&seq=2&orientation=landscape" alt="Nile Tilapia" class="w-full h-full object-cover object-top">
                        <button class="bookmark-btn absolute top-2 right-2 w-8 h-8 flex items-center justify-center bg-white bg-opacity-70 rounded-full">
                            <i class="ri-bookmark-line text-gray-600"></i>
                        </button>
                    </div>
                    <div class="p-4">
                        <div class="flex justify-between items-start">
                            <div>
                                <h3 class="font-bold text-gray-800">Nile Tilapia</h3>
                                <p class="text-sm text-gray-600 italic">Oreochromis niloticus</p>
                            </div>
                            <div class="w-6 h-6 flex items-center justify-center bg-blue-100 rounded-full">
                                <i class="ri-water-flash-line text-blue-600 text-sm"></i>
                            </div>
                        </div>
                        <div class="mt-3 flex justify-between items-center">
                            <span class="text-xs text-gray-500">Warm Water • Africa</span>
                            <button class="view-details px-3 py-1 text-xs text-primary border border-primary rounded-button hover:bg-primary hover:text-white whitespace-nowrap" data-id="2">Details</button>
                        </div>
                    </div>
                </div>
                <!-- Pangasius -->
                <div class="card-fish bg-white rounded-lg shadow overflow-hidden">
                    <div class="relative h-48">
                        <img src="https://readdy.ai/api/search-image?query=A%20detailed%20photograph%20of%20a%20Pangasius%20%28Pangasius%20hypophthalmus%29%20with%20its%20silvery-gray%20body%20and%20flat%20head%2C%20swimming%20in%20freshwater%20with%20a%20simple%20natural%20background&width=400&height=300&seq=5&orientation=landscape" alt="Pangasius" class="w-full h-full object-cover object-top">
                        <button class="bookmark-btn absolute top-2 right-2 w-8 h-8 flex items-center justify-center bg-white bg-opacity-70 rounded-full">
                            <i class="ri-bookmark-line text-gray-600"></i>
                        </button>
                    </div>
                    <div class="p-4">
                        <div class="flex justify-between items-start">
                            <div>
                                <h3 class="font-bold text-gray-800">Pangasius</h3>
                                <p class="text-sm text-gray-600 italic">Pangasius hypophthalmus</p>
                            </div>
                            <div class="w-6 h-6 flex items-center justify-center bg-blue-100 rounded-full">
                                <i class="ri-water-flash-line text-blue-600 text-sm"></i>
                            </div>
                        </div>
                        <div class="mt-3 flex justify-between items-center">
                            <span class="text-xs text-gray-500">Warm Water • Southeast Asia</span>
                            <button class="view-details px-3 py-1 text-xs text-primary border border-primary rounded-button hover:bg-primary hover:text-white whitespace-nowrap" data-id="5">Details</button>
                        </div>
                    </div>
                </div>
                <!-- Neon Tetra -->
                <div class="card-fish bg-white rounded-lg shadow overflow-hidden">
                    <div class="relative h-48">
                        <img src="https://readdy.ai/api/search-image?query=A%20detailed%20photograph%20of%20a%20small%20neon%20tetra%20%28Paracheirodon%20innesi%29%20with%20its%20vibrant%20blue%20and%20red%20horizontal%20stripes%2C%20swimming%20in%20a%20planted%20aquarium%20with%20a%20clean%20background&width=400&height=300&seq=6&orientation=landscape" alt="Neon Tetra" class="w-full h-full object-cover object-top">
                        <button class="bookmark-btn absolute top-2 right-2 w-8 h-8 flex items-center justify-center bg-white bg-opacity-70 rounded-full">
                            <i class="ri-bookmark-line text-gray-600"></i>
                        </button>
                    </div>
                    <div class="p-4">
                        <div class="flex justify-between items-start">
                            <div>
                                <h3 class="font-bold text-gray-800">Neon Tetra</h3>
                                <p class="text-sm text-gray-600 italic">Paracheirodon innesi</p>
                            </div>
                            <div class="w-6 h-6 flex items-center justify-center bg-blue-100 rounded-full">
                                <i class="ri-water-flash-line text-blue-600 text-sm"></i>
                            </div>
                        </div>
                        <div class="mt-3 flex justify-between items-center">
                            <span class="text-xs text-gray-500">Warm Water • South America</span>
                            <button class="view-details px-3 py-1 text-xs text-primary border border-primary rounded-button hover:bg-primary hover:text-white whitespace-nowrap" data-id="6">Details</button>
                        </div>
                    </div>
                </div>
                <!-- Goldfish -->
                <div class="card-fish bg-white rounded-lg shadow overflow-hidden">
                    <div class="relative h-48">
                        <img src="https://readdy.ai/api/search-image?query=A%20detailed%20photograph%20of%20a%20fancy%20goldfish%20%28Carassius%20auratus%29%20with%20its%20bright%20orange-gold%20coloration%20and%20flowing%20fins%2C%20swimming%20in%20clear%20water%20with%20a%20simple%20clean%20background&width=400&height=300&seq=8&orientation=landscape" alt="Goldfish" class="w-full h-full object-cover object-top">
                        <button class="bookmark-btn absolute top-2 right-2 w-8 h-8 flex items-center justify-center bg-white bg-opacity-70 rounded-full">
                            <i class="ri-bookmark-line text-gray-600"></i>
                        </button>
                    </div>
                    <div class="p-4">
                        <div class="flex justify-between items-start">
                            <div>
                                <h3 class="font-bold text-gray-800">Goldfish</h3>
                                <p class="text-sm text-gray-600 italic">Carassius auratus</p>
                            </div>
                            <div class="w-6 h-6 flex items-center justify-center bg-blue-100 rounded-full">
                                <i class="ri-water-flash-line text-blue-600 text-sm"></i>
                            </div>
                        </div>
                        <div class="mt-3 flex justify-between items-center">
                            <span class="text-xs text-gray-500">Cold Water • Asia</span>
                            <button class="view-details px-3 py-1 text-xs text-primary border border-primary rounded-button hover:bg-primary hover:text-white whitespace-nowrap" data-id="8">Details</button>
                        </div>
                    </div>
                </div>
                <!-- Koi Carp -->
                <div class="card-fish bg-white rounded-lg shadow overflow-hidden">
                    <div class="relative h-48">
                        <img src="https://readdy.ai/api/search-image?query=A%20detailed%20photograph%20of%20a%20beautiful%20koi%20carp%20with%20vibrant%20red%2C%20white%20and%20black%20patterns%2C%20swimming%20in%20crystal%20clear%20pond%20water%20with%20a%20clean%20natural%20background&width=400&height=300&seq=9&orientation=landscape" alt="Koi Carp" class="w-full h-full object-cover object-top">
                        <button class="bookmark-btn absolute top-2 right-2 w-8 h-8 flex items-center justify-center bg-white bg-opacity-70 rounded-full">
                            <i class="ri-bookmark-line text-gray-600"></i>
                        </button>
                    </div>
                    <div class="p-4">
                        <div class="flex justify-between items-start">
                            <div>
                                <h3 class="font-bold text-gray-800">Koi Carp</h3>
                                <p class="text-sm text-gray-600 italic">Cyprinus rubrofuscus</p>
                            </div>
                            <div class="w-6 h-6 flex items-center justify-center bg-blue-100 rounded-full">
                                <i class="ri-water-flash-line text-blue-600 text-sm"></i>
                            </div>
                        </div>
                        <div class="mt-3 flex justify-between items-center">
                            <span class="text-xs text-gray-500">Cold Water • Japan</span>
                            <button class="view-details px-3 py-1 text-xs text-primary border border-primary rounded-button hover:bg-primary hover:text-white whitespace-nowrap" data-id="9">Details</button>
                        </div>
                    </div>
                </div>
                <!-- Discus Fish -->
                <div class="card-fish bg-white rounded-lg shadow overflow-hidden">
                    <div class="relative h-48">
                        <img src="https://readdy.ai/api/search-image?query=A%20detailed%20photograph%20of%20a%20discus%20fish%20with%20vibrant%20colors%20and%20distinctive%20round%20shape%2C%20swimming%20in%20a%20planted%20aquarium%20with%20a%20clean%20natural%20background&width=400&height=300&seq=10&orientation=landscape" alt="Discus Fish" class="w-full h-full object-cover object-top">
                        <button class="bookmark-btn absolute top-2 right-2 w-8 h-8 flex items-center justify-center bg-white bg-opacity-70 rounded-full">
                            <i class="ri-bookmark-line text-gray-600"></i>
                        </button>
                    </div>
                    <div class="p-4">
                        <div class="flex justify-between items-start">
                            <div>
                                <h3 class="font-bold text-gray-800">Discus Fish</h3>
                                <p class="text-sm text-gray-600 italic">Symphysodon discus</p>
                            </div>
                            <div class="w-6 h-6 flex items-center justify-center bg-blue-100 rounded-full">
                                <i class="ri-water-flash-line text-blue-600 text-sm"></i>
                            </div>
                        </div>
                        <div class="mt-3 flex justify-between items-center">
                            <span class="text-xs text-gray-500">Warm Water • South America</span>
                            <button class="view-details px-3 py-1 text-xs text-primary border border-primary rounded-button hover:bg-primary hover:text-white whitespace-nowrap" data-id="10">Details</button>
                        </div>
                    </div>
                </div>
                <!-- Betta Fish -->
                <div class="card-fish bg-white rounded-lg shadow overflow-hidden">
                    <div class="relative h-48">
                        <img src="https://readdy.ai/api/search-image?query=A%20detailed%20photograph%20of%20a%20male%20betta%20fish%20with%20flowing%20fins%20and%20vibrant%20colors%2C%20swimming%20gracefully%20in%20clear%20water%20with%20a%20clean%20natural%20background&width=400&height=300&seq=11&orientation=landscape" alt="Betta Fish" class="w-full h-full object-cover object-top">
                        <button class="bookmark-btn absolute top-2 right-2 w-8 h-8 flex items-center justify-center bg-white bg-opacity-70 rounded-full">
                            <i class="ri-bookmark-line text-gray-600"></i>
                        </button>
                    </div>
                    <div class="p-4">
                        <div class="flex justify-between items-start">
                            <div>
                                <h3 class="font-bold text-gray-800">Betta Fish</h3>
                                <p class="text-sm text-gray-600 italic">Betta splendens</p>
                            </div>
                            <div class="w-6 h-6 flex items-center justify-center bg-blue-100 rounded-full">
                                <i class="ri-water-flash-line text-blue-600 text-sm"></i>
                            </div>
                        </div>
                        <div class="mt-3 flex justify-between items-center">
                            <span class="text-xs text-gray-500">Warm Water • Southeast Asia</span>
                            <button class="view-details px-3 py-1 text-xs text-primary border border-primary rounded-button hover:bg-primary hover:text-white whitespace-nowrap" data-id="11">Details</button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="mt-10 flex justify-center">
                <nav class="flex items-center space-x-1">
                    <button class="pagination-btn w-8 h-8 flex items-center justify-center rounded text-gray-600 text-sm">
                        <i class="ri-arrow-left-s-line"></i>
                    </button>
                    <button class="pagination-btn w-8 h-8 flex items-center justify-center rounded text-gray-600 text-sm active">1</button>
                    <button class="pagination-btn w-8 h-8 flex items-center justify-center rounded text-gray-600 text-sm">2</button>
                    <button class="pagination-btn w-8 h-8 flex items-center justify-center rounded text-gray-600 text-sm">3</button>
                    <button class="pagination-btn w-8 h-8 flex items-center justify-center rounded text-gray-600 text-sm">4</button>
                    <button class="pagination-btn w-8 h-8 flex items-center justify-center rounded text-gray-600 text-sm">5</button>
                    <button class="pagination-btn w-8 h-8 flex items-center justify-center rounded text-gray-600 text-sm">
                        <i class="ri-arrow-right-s-line"></i>
                    </button>
                </nav>
            </div>
        </main>
        <button id="backToTop" class="back-to-top fixed bottom-6 right-6 w-12 h-12 bg-primary text-white rounded-full shadow-lg flex items-center justify-center">
            <i class="ri-arrow-up-line text-xl"></i>
        </button>
        <!-- Details Modal -->
        <div id="fishDetailModal" class="modal hidden fixed inset-0 z-50 overflow-auto bg-black bg-opacity-50 flex items-center justify-center">
            <div class="bg-white w-full max-w-4xl rounded-lg shadow-xl mx-4 overflow-hidden">
                <div class="relative">
                    <div class="h-64 md:h-80 bg-gray-100">
                        <img id="modalFishImage" src="" alt="" class="w-full h-full object-cover object-top">
                    </div>
                    <button id="closeModal" class="absolute top-4 right-4 w-10 h-10 flex items-center justify-center bg-white bg-opacity-70 rounded-full text-gray-700 hover:bg-opacity-100">
                        <i class="ri-close-line text-xl"></i>
                    </button>
                    <div class="absolute top-4 left-4 flex space-x-2">
                        <button id="modalBookmarkBtn" class="w-10 h-10 flex items-center justify-center bg-white bg-opacity-70 rounded-full text-gray-700 hover:bg-opacity-100">
                            <i class="ri-bookmark-line text-xl"></i>
                        </button>
                        <button id="modalShareBtn" class="w-10 h-10 flex items-center justify-center bg-white bg-opacity-70 rounded-full text-gray-700 hover:bg-opacity-100">
                            <i class="ri-share-line text-xl"></i>
                        </button>
                    </div>
                </div>
                <div class="p-6">
                    <div class="flex justify-between items-start mb-4">
                        <div>
                            <h2 id="modalFishName" class="text-2xl font-bold text-gray-800">Common Carp</h2>
                            <p id="modalFishScientificName" class="text-lg text-gray-600 italic">Cyprinus carpio</p>
                        </div>
                        <div id="modalFishEnvironment" class="px-3 py-1 bg-blue-100 text-blue-700 rounded-full text-sm">Freshwater</div>
                    </div>
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                        <div class="md:col-span-1">
                            <h3 class="text-lg font-semibold text-gray-800 mb-3">Taxonomy</h3>
                            <ul class="space-y-2 text-sm">
                                <li class="flex">
                                    <span class="w-24 text-gray-500">Phylum:</span>
                                    <span id="modalFishPhylum" class="text-gray-800">Chordata</span>
                                </li>
                                <li class="flex">
                                    <span class="w-24 text-gray-500">Class:</span>
                                    <span id="modalFishClass" class="text-gray-800">Actinopterygii</span>
                                </li>
                                <li class="flex">
                                    <span class="w-24 text-gray-500">Order:</span>
                                    <span id="modalFishOrder" class="text-gray-800">Cypriniformes</span>
                                </li>
                                <li class="flex">
                                    <span class="w-24 text-gray-500">Family:</span>
                                    <span id="modalFishFamily" class="text-gray-800">Cyprinidae</span>
                                </li>
                                <li class="flex">
                                    <span class="w-24 text-gray-500">Genus:</span>
                                    <span id="modalFishGenus" class="text-gray-800">Cyprinus</span>
                                </li>
                                <li class="flex">
                                    <span class="w-24 text-gray-500">Species:</span>
                                    <span id="modalFishSpecies" class="text-gray-800">C. carpio</span>
                                </li>
                            </ul>
                            <h3 class="text-lg font-semibold text-gray-800 mt-6 mb-3">Geographical Distribution</h3>
                            <p id="modalFishDistribution" class="text-sm text-gray-700">The common carp originates from Asia but has been introduced to many countries worldwide. It is now widely distributed in freshwater regions across Asia, Europe, the Americas, and Australia.</p>
                        </div>
                        <div class="md:col-span-2">
                            <h3 class="text-lg font-semibold text-gray-800 mb-3">Identifying Characteristics</h3>
                            <p id="modalFishIdentification" class="text-sm text-gray-700 mb-4">The common carp has an elongated, slightly laterally compressed body. It has a small head with two pairs of barbels on the upper lip. The scales are large, typically bronze or reddish-brown, sometimes with a reddish sheen depending on the environment. The dorsal fin is long with a hard spine at the front. Common carp can grow large, reaching weights up to 20kg and lengths up to 1m.</p>
                            <h3 class="text-lg font-semibold text-gray-800 mb-3">Ecology</h3>
                            <p id="modalFishEcology" class="text-sm text-gray-700 mb-4">Common carp are freshwater fish, inhabiting still or slow-flowing waters such as ponds, lakes, marshes, rice paddies, and rivers. They adapt well to various environmental conditions and can survive in water temperatures ranging from 3-35°C. They are omnivorous, primarily feeding on benthic invertebrates, aquatic plants, and organic detritus. Their average lifespan is 15-20 years, but they can live up to 50 years under favorable conditions.</p>
                            <h3 class="text-lg font-semibold text-gray-800 mb-3">Economic Value</h3>
                            <p id="modalFishEconomicValue" class="text-sm text-gray-700">Common carp is one of the most widely cultured freshwater fish globally. Its meat is flavorful and nutritious, used in many traditional dishes. Beyond its food value, koi carp—a Japanese variety with vibrant colors—is also raised for ornamental purposes, commanding high economic value. Common carp is also utilized in integrated farming systems, such as the VAC model (Garden-Pond-Livestock) in Vietnam.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>