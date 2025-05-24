<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


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
        <jsp:include page="Header.jsp" />
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
                <c:choose>
                    <c:when test="${not empty fishList}">
                        <c:forEach var="fish" items="${fishList}">
                            <div class="card-fish bg-white rounded-lg shadow overflow-hidden">
                                <div class="relative aspect-square w-full">
                                    <img src="${fish.imageUrl}" alt="${fish.commonName}" class="w-full h-full object-cover object-center">
                                </div>
                                <div class="p-4">
                                    <h3 class="font-bold text-gray-800 text-lg mb-1">${fish.commonName}</h3>
                                    <p class="text-sm text-gray-600 mb-2"><i class="ri-map-pin-line mr-1"></i> ${fish.fishingSpots}</p>
                                    <div class="flex items-center space-x-2 mb-4">
                                        <span class="text-xs text-gray-500">Difficulty:</span>
                                        <span class="text-xs font-semibold text-primary">${fish.difficultyLevel}</span>
                                    </div>
                                    <div class="flex justify-end">
                                        <a href="FishDetails?id=${fish.id}"
                                           class="inline-block px-4 py-1 border border-primary text-primary rounded-button text-sm hover:bg-primary hover:text-white transition-colors">
                                            Details
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="col-span-4 text-center text-gray-500">No fish found.</div>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="mt-10 flex justify-center">
                <nav class="flex items-center space-x-1">
                    <button class="pagination-btn w-8 h-8 flex items-center justify-center rounded text-gray-600 text-sm" ${currentPage == 1 ? 'disabled' : ''} onclick="window.location.href='KnowledgeFish?page=${currentPage - 1}'">
                        <i class="ri-arrow-left-s-line"></i>
                    </button>
                    <c:forEach var="i" begin="1" end="${totalPages}">
                        <button class="pagination-btn w-8 h-8 flex items-center justify-center rounded text-gray-600 text-sm ${currentPage == i ? 'active bg-primary text-white' : ''}"
                                onclick="window.location.href='KnowledgeFish?page=${i}'">${i}</button>
                    </c:forEach>
                    <button class="pagination-btn w-8 h-8 flex items-center justify-center rounded text-gray-600 text-sm" ${currentPage == totalPages ? 'disabled' : ''} onclick="window.location.href='KnowledgeFish?page=${currentPage + 1}'">
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