<%-- 
    Document   : eventForm
    Created on : May 24, 2025
    Author     : [Your Name]
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Create Event</title>
        <script src="https://cdn.tailwindcss.com/3.4.16"></script>
        <script>tailwind.config = {theme: {extend: {colors: {primary: '#1E88E5', secondary: '#FFA726'}, borderRadius: {'none': '0px', 'sm': '4px', DEFAULT: '8px', 'md': '12px', 'lg': '16px', 'xl': '20px', '2xl': '24px', '3xl': '32px', 'full': '9999px', 'button': '8px'}}}}</script>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.6.0/remixicon.min.css">
        <link rel="stylesheet" href="assets/css/style.css">
        <style>
            input:focus-visible,
            textarea:focus-visible {
                outline: none;
                box-shadow: none;
            }
        </style>
    </head>

    <body>
        <header class="bg-white shadow-sm">
            <div class="container mx-auto px-4 py-3 flex items-center justify-between">
                <div class="flex items-center">
                    <a href="Home.jsp" class="text-3xl font-['Pacifico'] text-primary">FishingHub</a>
                    <!-- Header navigation links -->
                    <nav class="hidden md:flex ml-10">
                        <a href="Home.jsp" class="px-4 py-2 text-gray-800 font-medium hover:text-primary">Home</a>
                        <a href="Event.jsp" class="px-4 py-2 text-gray-800 font-medium hover:text-primary">Events</a>
                        <a href="NewFeed.jsp" class="px-4 py-2 text-gray-800 font-medium hover:text-primary">News
                            Feed</a>
                        <a href="Product.jsp" class="px-4 py-2 text-gray-800 font-medium hover:text-primary">Shop</a>
                        <a href="FishKnowledge.jsp"
                           class="px-4 py-2 text-gray-800 font-medium hover:text-primary">Knowledge</a>
                        <a href="Achievement.jsp"
                           class="px-4 py-2 text-gray-800 font-medium hover:text-primary">Rankings</a>
                    </nav>
                </div>

                <div class="flex items-center space-x-4">
                    <!-- Cart -->
                    <div class="relative w-10 h-10 flex items-center justify-center">
                        <button class="text-gray-700 hover:text-primary">
                            <i class="ri-shopping-cart-2-line text-xl"></i>
                        </button>
                        <span
                            class="absolute -top-1 -right-1 bg-red-500 text-white text-xs w-5 h-5 flex items-center justify-center rounded-full">3</span>
                    </div>
                    <div class="relative">
                        <div class="w-10 h-10 flex items-center justify-center rounded-full bg-gray-100 cursor-pointer">
                            <i class="ri-notification-3-line text-gray-600"></i>
                        </div>
                        <span
                            class="absolute -top-1 -right-1 flex h-5 w-5 items-center justify-center rounded-full bg-primary text-xs text-white">3</span>
                    </div>

                    <button class="bg-primary text-white px-4 py-2 rounded-button whitespace-nowrap">Log In</button>
                    <button
                        class="bg-white text-primary border border-primary px-4 py-2 rounded-button whitespace-nowrap">Sign
                        Up</button>
                </div>
            </div>
        </header>
        <div class="flex items-center justify-center min-h-screen bg-gray-100">
            <form action="EventController" method="post" id="createEventForm" enctype="multipart/form-data" 
                  class="w-full max-w-4xl bg-white p-10 rounded-lg shadow-md space-y-2">
                <% if (request.getAttribute("success") !=null) { %>
                <div class="success" style="color: green;">
                    <%= request.getAttribute("success") %>
                </div>
                <% } %>
                <% if (request.getAttribute("error") !=null) { %>
                <div class="error" style="color: red;">
                    <%= request.getAttribute("error") %>
                </div>
                <% } %>
                <input type="hidden" name="action" value="add">
                <h1 class="text-3xl font-bold text-center text-primary">Create Event</h1>
                <div>
                    <label for="title" class="block text-sm font-medium text-gray-700">Event Title:</label>
                    <input type="text" id="title" name="title" placeholder=" Enter event title" required
                           class="mt-1 block w-full h-12 rounded-md border-2 shadow-sm focus:border-primary focus:ring-primary">
                </div>

                <div>
                    <label for="description"
                           class="block text-sm font-medium text-gray-700">Description:</label>
                    <textarea id="description" name="description" placeholder=" Enter event description"
                              required rows="5"
                              class="mt-1 block w-full rounded-md border-2 shadow-sm focus:border-primary focus:ring-primary"></textarea>
                </div>

                <div>
                    <label for="location" class="block text-sm font-medium text-gray-700">Location:</label>
                    <input type="text" id="location" name="location" placeholder=" Enter event location"
                           required
                           class="mt-1 block w-full h-12 rounded-md border-2 shadow-sm focus:border-primary focus:ring-primary">
                </div>

                <div>
                    <label for="startTime" class="block text-sm font-medium text-gray-700">Start
                        Time:</label>
                    <input type="datetime-local" id="startTime" name="startTime" required
                           class="mt-1 block w-full h-12 rounded-md border-2 shadow-sm focus:border-primary focus:ring-primary">
                </div>

                <div>
                    <label for="endTime" class="block text-sm font-medium text-gray-700">End Time:</label>
                    <input type="datetime-local" id="endTime" name="endTime" required
                           class="mt-1 block w-full h-12 rounded-md border-2 shadow-sm focus:border-primary focus:ring-primary ">
                </div>

                <div>
                    <label for="maxParticipants" class="block text-sm font-medium text-gray-700">Max
                        Participants:</label>
                    <input type="number" id="maxParticipants" name="maxParticipants" min="1"
                           placeholder=" Enter max participants" required
                           class="mt-1 block w-full h-12 rounded-md border-2  shadow-sm focus:border-primary focus:ring-primary">
                </div>

                <div>
                    <label for="posterFile" class="block text-sm font-medium text-gray-700">Poster
                        Image:</label>
                    <input type="file" id="posterFile" name="posterFile" accept="image/*"
                           class="mt-1 block w-full h-12 text-sm text-gray-500 file:mr-4 file:py-2 file:px-4 file:rounded-md file:border file:border-black file:text-sm file:font-medium file:bg-gray-50 file:text-primary hover:file:bg-gray-100">
                </div>

                <div class="flex justify-end">
                    <button type="submit"
                            class="bg-primary text-white px-6 py-3 rounded-button hover:bg-blue-600">Create
                        Event</button>
                </div>
            </form>
        </div>
    </body>

</html>