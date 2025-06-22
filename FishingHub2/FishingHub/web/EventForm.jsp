
<%-- 
    Document   : eventForm
    Created on : May 24, 2025
    Author     : [Your Name]
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.Users" %>
<%
    Users currentUser = (Users) session.getAttribute("user");
%>
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
                            class="absolute -top-1 -right-1 bg-red-500 text-white text-xs w-5 h-5 flex items-center justify-center rounded-full">3</span>
                    </div>
                    <div class="relative">
                        <div class="w-10 h-10 flex items-center justify-center rounded-full bg-gray-100 cursor-pointer">
                            <i class="ri-notification-3-line text-gray-600"></i>
                        </div>
                        <span
                            class="absolute -top-1 -right-1 flex h-5 w-5 items-center justify-center rounded-full bg-primary text-xs text-white">3</span>
                    </div>

                    <% if (currentUser == null) { %>
                        <a href="Login.jsp" class="bg-primary text-white px-4 py-2 rounded-button whitespace-nowrap">Đăng Nhập</a>
                        <a href="Register.jsp" class="bg-white text-primary border border-primary px-4 py-2 rounded-button whitespace-nowrap">Đăng Ký</a>
                    <% } else { %>
                        <div class="flex items-center space-x-3">
                            <span class="font-semibold text-primary"><i class="ri-user-line mr-1"></i> <%= currentUser.getFullName() %></span>
                            <% if(currentUser.getRoleId() == 2) { %>
                                <a href="dashboard_owner/Dashboard.jsp" class="bg-secondary text-white px-4 py-2 rounded-button whitespace-nowrap hover:bg-secondary/90">Dashboard</a>
                            <% } %>
                            <form action="logout" method="post" style="display:inline;">
                                <button type="submit" class="bg-gray-200 text-gray-800 px-3 py-2 rounded-button hover:bg-gray-300">Đăng Xuất</button>
                            </form>
                        </div>
                    <% } %>
                </div>
            </div>
        </header>
        <div class="flex items-center justify-center min-h-screen mb-12 mt-10">
            <!-- Biểu mẫu tạo sự kiện -->
            <form action="Event" method="post" id="createEventForm" enctype="multipart/form-data" 
                  class="w-full max-w-4xl bg-white p-10 rounded-lg shadow-md space-y-2">

                <!-- Hiển thị thông báo thành công -->
                <% if (request.getAttribute("success") !=null) { %>
                <div class="success" style="color: green;">
                    <%= request.getAttribute("success") %>
                </div>
                <% } %>

                <!-- Hiển thị thông báo lỗi -->
                <% if (request.getAttribute("error") !=null) { %>
                <div class="error" style="color: red;">
                    <%= request.getAttribute("error") %>
                </div>
                <% } %>

                <!-- Trường ẩn dùng để xác định hành động là thêm sự kiện -->
                <input type="hidden" name="action" value="add">

                <!-- Tiêu đề chính của form -->
                <h1 class="text-3xl font-bold text-center text-primary">Tạo Sự Kiện</h1>

                <!-- Tiêu đề sự kiện -->
                <div>
                    <label for="title" class="block text-sm font-medium text-gray-700">Tiêu đề sự kiện:</label>
                    <input type="text" id="title" name="title" placeholder=" Nhập tiêu đề sự kiện" required
                           class="mt-1 block w-full h-12 rounded-md border-2 shadow-sm focus:border-primary focus:ring-primary">
                </div>

                <!-- Mô tả sự kiện -->
                <div>
                    <label for="description" class="block text-sm font-medium text-gray-700">Mô tả:</label>
                    <textarea id="description" name="description" placeholder=" Nhập mô tả sự kiện"
                              required rows="5"
                              class="mt-1 block w-full rounded-md border-2 shadow-sm focus:border-primary focus:ring-primary"></textarea>
                </div>

                <div>
                    <label for="lakeName" class="block text-sm font-medium text-gray-700">Tên hồ câu:</label>
                    <input type="text" id="lakeName" name="lakeName" placeholder=" Nhập tên hồ câu" required
                           class="mt-1 block w-full h-12 rounded-md border-2 shadow-sm focus:border-primary focus:ring-primary">
                </div>

                <!-- Địa điểm tổ chức sự kiện -->
                <div>
                    <label for="location" class="block text-sm font-medium text-gray-700">Địa điểm:</label>
                    <input type="text" id="location" name="location" placeholder=" Nhập địa điểm tổ chức"
                           required
                           class="mt-1 block w-full h-12 rounded-md border-2 shadow-sm focus:border-primary focus:ring-primary">
                </div>

                <!-- Thời gian bắt đầu sự kiện -->
                <div>
                    <label for="startTime" class="block text-sm font-medium text-gray-700">Thời gian bắt đầu:</label>
                    <input type="datetime-local" id="startTime" name="startTime" required
                           class="mt-1 block w-full h-12 rounded-md border-2 shadow-sm focus:border-primary focus:ring-primary">
                </div>

                <!-- Thời gian kết thúc sự kiện -->
                <div>
                    <label for="endTime" class="block text-sm font-medium text-gray-700">Thời gian kết thúc:</label>
                    <input type="datetime-local" id="endTime" name="endTime" required
                           class="mt-1 block w-full h-12 rounded-md border-2 shadow-sm focus:border-primary focus:ring-primary ">
                </div>

                <!-- Số lượng người tham gia tối đa -->
                <div>
                    <label for="maxParticipants" class="block text-sm font-medium text-gray-700">Số người tham gia tối đa:</label>
                    <input type="number" id="maxParticipants" name="maxParticipants" min="1"
                           placeholder=" Nhập số người tối đa" required
                           class="mt-1 block w-full h-12 rounded-md border-2  shadow-sm focus:border-primary focus:ring-primary">
                </div>

                <!-- Tải ảnh poster sự kiện -->
                <div>
                    <label for="posterFile" class="block text-sm font-medium text-gray-700">Ảnh Poster:</label>
                    <input type="file" id="posterFile" name="posterFile" accept="image/*"
                           class="mt-1 block w-full h-12 text-sm text-gray-500 file:mr-4 file:py-2 file:px-4 file:rounded-md file:border file:border-black file:text-sm file:font-medium file:bg-gray-50 file:text-primary hover:file:bg-gray-100">
                </div>

                <!-- Nút gửi biểu mẫu -->
                <div class="flex justify-end">
                    <button type="submit"
                            class="bg-primary text-white px-6 py-3 rounded-button hover:bg-blue-600">
                        Tạo Sự Kiện
                    </button>
                </div>
            </form>
        </div>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const fieldMessages = {
                    title: "Vui lòng nhập tiêu đề sự kiện.",
                    description: "Vui lòng nhập mô tả sự kiện.",
                    lakeName: "Vui lòng nhập tên hồ câu.",
                    location: "Vui lòng nhập địa điểm tổ chức.",
                    startTime: "Vui lòng chọn thời gian bắt đầu.",
                    endTime: "Vui lòng chọn thời gian kết thúc.",
                    maxParticipants: "Vui lòng nhập số người tham gia tối đa."
                };

                for (const [fieldId, message] of Object.entries(fieldMessages)) {
                    const input = document.getElementById(fieldId);
                    if (input) {
                        input.addEventListener("invalid", function () {
                            input.setCustomValidity(message);
                        });

                        input.addEventListener("input", function () {
                            input.setCustomValidity("");
                        });
                    }
                }
            });
        </script>


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