<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Fish Details</title>
        <script src="https://cdn.tailwindcss.com/3.4.16"></script>
        <script>tailwind.config = {theme: {extend: {colors: {primary: '#1E88E5', secondary: '#FFA726'}, borderRadius: {'none': '0px', 'sm': '4px', DEFAULT: '8px', 'md': '12px', 'lg': '16px', 'xl': '20px', '2xl': '24px', '3xl': '32px', 'full': '9999px', 'button': '8px'}}}}</script>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.6.0/remixicon.min.css">
        <link rel="stylesheet" href="assets/css/style.css">
    </head>

        <body class="font-roboto bg-gray-100">
            <!-- Header -->
            <jsp:include page="Header.jsp" />

            <!-- Breadcrumb with icons -->
            <div class="bg-white border-b">
                <div class="container mx-auto px-4 py-3">
                    <span class="text-sm text-gray-600 flex items-center space-x-1">
                        <a href="Home.jsp" class="hover:text-blue-800">Home</a>
                        <span>/</span>
                        <a href="FishKnowledge" class="hover:text-blue-800">Knowledge</a>
                        <span>/</span>
                        <span class=" text-blue-800">Details</span>
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
                            <img src="${fish.imageUrl}" alt="${fish.commonName}"
                                class="rounded-xl w-full h-auto max-h-[500px] object-cover shadow" />
                        </div>

                        <!-- Phần bên phải -->
                        <div class="md:w-1/2 space-y-5">
                            <!-- Box: Description -->
                            <div class="bg-gray-50 p-5 rounded-lg shadow-sm border border-gray-200">
                                <h2 class="text-2xl font-semibold text-gray-800 mb-2">Description</h2>
                                <p class="text-gray-800 text-base leading-relaxed">${fish.description}</p>
                            </div>

                            <!-- Box: Fishing Tips -->
                            <div class="bg-gray-50 p-5 rounded-lg shadow-sm border border-gray-200">
                                <h2 class="text-2xl font-semibold text-gray-800 mb-2">Fishing Tips</h2>
                                <p class="text-gray-800 text-base leading-relaxed">${fish.tips}</p>
                            </div>

                            <!-- Box: Details -->
                            <div class="bg-gray-50 p-5 rounded-lg shadow-sm border border-gray-200">
                                <h2 class="text-2xl font-semibold text-gray-800 mb-2">Details</h2>
                                <ul class="list-disc list-inside text-gray-800 text-base space-y-1">
                                    <li><strong>Scientific Name:</strong> ${fish.scientificName}</li>
                                    <li><strong>Difficulty:</strong> ${fish.difficultyLevel}/4</li>
                                    <li><strong>Bait:</strong> ${fish.bait}</li>
                                    <li><strong>Best Season:</strong> ${fish.bestSeason}</li>
                                    <li><strong>Best Time of Day:</strong> ${fish.bestTimeOfDay}</li>
                                    <li><strong>Fishing Spots:</strong> ${fish.fishingSpots}</li>
                                    <li><strong>Techniques:</strong> ${fish.fishingTechniques}</li>
                                    <li><strong>Average Weight (kg):</strong> ${fish.averageWeightKg}</li>
                                    <li><strong>Length (m):</strong> ${fish.length}</li>
                                    <li><strong>Habitat:</strong> ${fish.habitat}</li>
                                    <li><strong>Behavior:</strong> ${fish.behavior}</li>
                                </ul>
                            </div>
                        </div>


                    </div>
                    <div class="mt-6">
                        <a href="KnowledgeFish" class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700">Back
                            to List</a>
                    </div>
                </div>
            </main>

        </body>

        </html>