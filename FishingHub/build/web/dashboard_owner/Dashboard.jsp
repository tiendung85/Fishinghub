<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="model.Users" %>
<link rel="stylesheet" href="<c:url value='/css/style.css'/>">
<%
    Users currentUser = (Users) session.getAttribute("user");
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Admin Dashboard</title>
        <script src="https://cdn.tailwindcss.com/3.4.16"></script>
        <script>
            tailwind.config = {
                theme: {
                    extend: {
                        colors: {primary: "#4f46e5", secondary: "#10b981"},
                        borderRadius: {
                            none: "0px",
                            sm: "4px",
                            DEFAULT: "8px",
                            md: "12px",
                            lg: "16px",
                            xl: "20px",
                            "2xl": "24px",
                            "3xl": "32px",
                            full: "9999px",
                            button: "8px",
                        },
                    },
                },
            };
        </script>
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <link
            href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap"
            rel="stylesheet"
            />
        <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.6.0/remixicon.min.css"
            />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/echarts/5.5.0/echarts.min.js"></script>
        <style>
            :where([class^="ri-"])::before {
                content: "\f3c2";
            }
            body {
                font-family: 'Inter', sans-serif;
                background-color: #f9fafb;
            }
            .sidebar-item.active {
                background-color: rgba(79, 70, 229, 0.1);
                color: #4f46e5;
                border-left: 3px solid #4f46e5;
            }
            .custom-scrollbar::-webkit-scrollbar {
                width: 5px;
            }
            .custom-scrollbar::-webkit-scrollbar-track {
                background: #f1f1f1;
            }
            .custom-scrollbar::-webkit-scrollbar-thumb {
                background: #d1d5db;
                border-radius: 8px;
            }
            .custom-scrollbar::-webkit-scrollbar-thumb:hover {
                background: #9ca3af;
            }
            input[type="checkbox"].custom-checkbox {
                display: none;
            }
            input[type="checkbox"].custom-checkbox + label {
                display: inline-block;
                width: 18px;
                height: 18px;
                border: 2px solid #d1d5db;
                border-radius: 4px;
                cursor: pointer;
                position: relative;
            }
            input[type="checkbox"].custom-checkbox:checked + label {
                background-color: #4f46e5;
                border-color: #4f46e5;
            }
            input[type="checkbox"].custom-checkbox:checked + label:after {
                content: "";
                position: absolute;
                left: 5px;
                top: 2px;
                width: 5px;
                height: 10px;
                border: solid white;
                border-width: 0 2px 2px 0;
                transform: rotate(45deg);
            }
            .switch {
                position: relative;
                display: inline-block;
                width: 40px;
                height: 20px;
            }
            .switch input {
                opacity: 0;
                width: 0;
                height: 0;
            }
            .slider {
                position: absolute;
                cursor: pointer;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background-color: #e5e7eb;
                transition: .4s;
                border-radius: 20px;
            }
            .slider:before {
                position: absolute;
                content: "";
                height: 16px;
                width: 16px;
                left: 2px;
                bottom: 2px;
                background-color: white;
                transition: .4s;
                border-radius: 50%;
            }
            input:checked + .slider {
                background-color: #4f46e5;
            }
            input:checked + .slider:before {
                transform: translateX(20px);
            }
            input[type="number"]::-webkit-inner-spin-button,
            input[type="number"]::-webkit-outer-spin-button {
                -webkit-appearance: none;
                margin: 0;
            }
        </style>
    </head>
    <body>
        <div class="flex h-screen overflow-hidden">
            <!-- Sidebar -->
            <div class="hidden md:flex md:flex-shrink-0">
                <div class="flex flex-col w-64 bg-white border-r border-gray-200">
                    <div
                        class="flex items-center justify-center h-16 px-4 border-b border-gray-200"
                        >
                        <h1 class="text-2xl font-['Pacifico'] text-primary">FishingHub</h1>
                    </div>
                    <div
                        class="flex flex-col flex-grow px-2 py-4 overflow-y-auto custom-scrollbar"
                        >
                        <div class="space-y-1">
                            <div
                                class="px-2 py-2 text-xs font-semibold text-gray-500 uppercase"
                                >
                                Tổng quan
                            </div>
                            <a
                                href="#"
                                class="sidebar-item active flex items-center px-2 py-2 text-sm font-medium text-gray-700 rounded-md hover:bg-gray-50 hover:text-primary"
                                >
                                <div
                                    class="w-6 h-6 mr-3 flex items-center justify-center text-gray-500"
                                    >
                                    <i class="ri-dashboard-line"></i>
                                </div>
                                Dashboard
                            </a>


                            <div
                                class="px-2 pt-4 pb-2 text-xs font-semibold text-gray-500 uppercase"
                                >
                                Quản lý sự kiện
                            </div>
                            <a
                                href="#"
                                class="sidebar-item flex items-center px-2 py-2 text-sm font-medium text-gray-700 rounded-md hover:bg-gray-50 hover:text-primary"
                                >
                                <div
                                    class="w-6 h-6 mr-3 flex items-center justify-center text-gray-500"
                                    >
                                    <i class="ri-calendar-event-line"></i>
                                </div>
                                Sự kiện
                            </a>


                            <div
                                class="px-2 pt-4 pb-2 text-xs font-semibold text-gray-500 uppercase"
                                >
                                Quản lý sản phẩm
                            </div>
                            <a
                                href="#"
                                class="sidebar-item flex items-center px-2 py-2 text-sm font-medium text-gray-700 rounded-md hover:bg-gray-50 hover:text-primary"
                                >
                                <div
                                    class="w-6 h-6 mr-3 flex items-center justify-center text-gray-500"
                                    >
                                    <i class="ri-shopping-bag-line"></i>
                                </div>
                                Danh sách sản phẩm
                            </a>
                            <a
                                href="<c:url value='/Order'/>"
                                class="sidebar-item flex items-center px-2 py-2 text-sm font-medium text-gray-700 rounded-md hover:bg-gray-50 hover:text-primary"
                                >
                                <div
                                    class="w-6 h-6 mr-3 flex items-center justify-center text-gray-500"
                                    >
                                    <i class="ri-shopping-cart-line"></i>
                                </div>
                                Đơn hàng
                            </a>

                        </div>
                    </div>
                    <div class="flex items-center p-4 border-t border-gray-200">
                    <div class="flex-shrink-0">
                        <img class="w-10 h-10 rounded-full"
                            src="https://readdy.ai/api/search-image?query=professional%20headshot%20of%20a%20Vietnamese%20male%20administrator%20with%20short%20black%20hair%2C%20wearing%20a%20business%20casual%20outfit%2C%20looking%20confident%20and%20friendly%2C%20high%20quality%2C%20realistic%2C%20studio%20lighting&width=100&height=100&seq=admin123&orientation=squarish"
                            alt="Admin" />
                    </div>
                    <div class="ml-3">
                        <p class="text-sm font-medium text-gray-700">
                            <%= currentUser != null ? currentUser.getFullName() : "Khách" %>
                        </p>
                        <p class="text-xs font-medium text-gray-500">
                            <% if(currentUser != null && currentUser.getRoleId() == 2) { %>
                            Chủ Hồ Câu
                            <% } else { %>
                            Quản trị viên
                            <% } %>
                        </p>
                    </div>
                </div>
               <!-- Nút quay lại Home -->
                <div class="p-4">
                    <a href="../Home.jsp" class="flex items-center justify-center w-full bg-primary text-white py-2 rounded-button font-medium hover:bg-primary/90 transition">
                        <i class="ri-arrow-left-line mr-2"></i> Quay lại Trang Chủ
                    </a>
                </div>
                </div>
            </div>
            <!-- Main content -->
            <div class="flex flex-col flex-1 w-0 overflow-hidden">
                <!-- Top navigation -->
                <div
                    class="relative z-10 flex-shrink-0 flex h-16 bg-white border-b border-gray-200"
                    >
                    <button
                        type="button"
                        class="px-4 border-r border-gray-200 text-gray-500 md:hidden"
                        >
                        <div class="w-6 h-6 flex items-center justify-center">
                            <i class="ri-menu-line"></i>
                        </div>
                    </button>
                    <div class="flex-1 px-4 flex justify-between">
                        <div class="flex-1 flex items-center">
                            <div class="w-full max-w-2xl">
                                <div class="relative w-full">
                                    <div
                                        class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none"
                                        >
                                        <div
                                            class="w-5 h-5 flex items-center justify-center text-gray-400"
                                            >
                                            <i class="ri-search-line"></i>
                                        </div>
                                    </div>
                                    <input
                                        type="text"
                                        class="block w-full pl-10 pr-3 py-2 border border-gray-200 rounded-md text-sm placeholder-gray-500 focus:outline-none focus:ring-1 focus:ring-primary focus:border-primary"
                                        placeholder="Tìm kiếm..."
                                        />
                                </div>
                            </div>
                        </div>
                        <div class="ml-4 flex items-center md:ml-6">
                            <button
                                class="p-1 rounded-full text-gray-400 hover:text-gray-500 focus:outline-none"
                                >
                                <div class="w-6 h-6 flex items-center justify-center">
                                    <i class="ri-notification-3-line"></i>
                                </div>
                            </button>
                            <div class="relative ml-3">
                                <div class="flex items-center">
                                    <span
                                        class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800"
                                        >
                                        Online
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Main content area -->
                <main
                    class="flex-1 relative overflow-y-auto focus:outline-none custom-scrollbar"
                    >
                    <div class="py-6">
                        <div class="max-w-7xl mx-auto px-4 sm:px-6 md:px-8">
                            <div class="flex items-center justify-between mb-6">
                                <h1 class="text-2xl font-semibold text-gray-900">Dashboard</h1>
                                <div class="flex space-x-3">
                                    <span class="text-sm text-gray-500">21/05/2025</span>
                                    <span class="text-sm text-gray-500">|</span>
                                    <span class="text-sm text-gray-500">Wednesday</span>
                                </div>
                            </div>
                        </div>
                        <div class="max-w-7xl mx-auto px-4 sm:px-6 md:px-8">
                            <!-- Stats cards -->
                            <div class="grid grid-cols-1 gap-5 sm:grid-cols-2 lg:grid-cols-4">
                                <div class="bg-white overflow-hidden shadow rounded-lg">
                                    <div class="p-5">
                                        <div class="flex items-center">
                                            <div class="flex-shrink-0 bg-indigo-50 rounded-md p-3">
                                                <div
                                                    class="w-6 h-6 flex items-center justify-center text-primary"
                                                    >
                                                    <i class="ri-shopping-bag-line"></i>
                                                </div>
                                            </div>
                                            <div class="ml-5 w-0 flex-1">
                                                <dl>
                                                    <dt
                                                        class="text-sm font-medium text-gray-500 truncate"
                                                        >
                                                        Tổng sản phẩm
                                                    </dt>
                                                    <dd class="flex items-baseline">
                                                        <div class="text-2xl font-semibold text-gray-900">
                                                            1,482
                                                        </div>
                                                        <div
                                                            class="ml-2 flex items-baseline text-sm font-semibold text-green-600"
                                                            >
                                                            <div
                                                                class="w-3 h-3 flex items-center justify-center"
                                                                >
                                                                <i class="ri-arrow-up-s-line"></i>
                                                            </div>
                                                            <span>12.5%</span>
                                                        </div>
                                                    </dd>
                                                </dl>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="bg-white overflow-hidden shadow rounded-lg">
                                    <div class="p-5">
                                        <div class="flex items-center">
                                            <div class="flex-shrink-0 bg-green-50 rounded-md p-3">
                                                <div
                                                    class="w-6 h-6 flex items-center justify-center text-green-600"
                                                    >
                                                    <i class="ri-shopping-cart-line"></i>
                                                </div>
                                            </div>
                                            <div class="ml-5 w-0 flex-1">
                                                <dl>
                                                    <dt
                                                        class="text-sm font-medium text-gray-500 truncate"
                                                        >
                                                        Đơn hàng mới
                                                    </dt>
                                                    <dd class="flex items-baseline">
                                                        <div class="text-2xl font-semibold text-gray-900">
                                                            58
                                                        </div>
                                                        <div
                                                            class="ml-2 flex items-baseline text-sm font-semibold text-green-600"
                                                            >
                                                            <div
                                                                class="w-3 h-3 flex items-center justify-center"
                                                                >
                                                                <i class="ri-arrow-up-s-line"></i>
                                                            </div>
                                                            <span>8.2%</span>
                                                        </div>
                                                    </dd>
                                                </dl>
                                            </div>
                                        </div>
                                    </div>
                                </div>


                            </div>
                            <!-- Charts -->
                            <div class="mt-8 grid grid-cols-1 gap-5 lg:grid-cols-2">
                                <div class="bg-white shadow rounded-lg p-5">
                                    <div class="flex items-center justify-between mb-4">
                                        <h2 class="text-lg font-medium text-gray-900">
                                            Thống kê sản phẩm
                                        </h2>
                                        <div class="flex space-x-3">
                                            <button
                                                class="inline-flex items-center px-2.5 py-1.5 border border-gray-300 shadow-sm text-xs font-medium rounded text-gray-700 bg-white hover:bg-gray-50 focus:outline-none !rounded-button whitespace-nowrap"
                                                >
                                                7 ngày
                                            </button>
                                            <button
                                                class="inline-flex items-center px-2.5 py-1.5 border border-transparent shadow-sm text-xs font-medium rounded text-white bg-primary hover:bg-indigo-700 focus:outline-none !rounded-button whitespace-nowrap"
                                                >
                                                30 ngày
                                            </button>
                                            <button
                                                class="inline-flex items-center px-2.5 py-1.5 border border-gray-300 shadow-sm text-xs font-medium rounded text-gray-700 bg-white hover:bg-gray-50 focus:outline-none !rounded-button whitespace-nowrap"
                                                >
                                                1 năm
                                            </button>
                                        </div>
                                    </div>
                                    <div id="products-chart" class="h-80"></div>
                                </div>
                                <div class="bg-white shadow rounded-lg p-5">
                                    <div class="flex items-center justify-between mb-4">
                                        <h2 class="text-lg font-medium text-gray-900">
                                            Phân loại sản phẩm
                                        </h2>
                                        <div>
                                            <button
                                                class="inline-flex items-center px-2.5 py-1.5 border border-gray-300 shadow-sm text-xs font-medium rounded text-gray-700 bg-white hover:bg-gray-50 focus:outline-none !rounded-button whitespace-nowrap"
                                                >
                                                <div
                                                    class="w-4 h-4 mr-1 flex items-center justify-center"
                                                    >
                                                    <i class="ri-download-line"></i>
                                                </div>
                                                Xuất báo cáo
                                            </button>
                                        </div>
                                    </div>
                                    <div id="category-chart" class="h-80"></div>
                                </div>
                            </div>
                            <!-- Recent events and pending approvals -->
                            <div class="mt-8 grid grid-cols-1 gap-5 lg:grid-cols-2">
                                <div class="bg-white shadow rounded-lg overflow-hidden">
                                    <div class="px-5 py-4 border-b border-gray-200">
                                        <div class="flex items-center justify-between">
                                            <h2 class="text-lg font-medium text-gray-900">
                                                Sự kiện sắp diễn ra
                                            </h2>
                                            <a
                                                href="#"
                                                class="text-sm font-medium text-primary hover:text-indigo-800"
                                                >
                                                Xem tất cả
                                            </a>
                                        </div>
                                    </div>
                                    <div class="px-5 py-3 divide-y divide-gray-200">
                                        <div class="py-3">
                                            <div class="flex justify-between">
                                                <div class="flex-1">
                                                    <h3 class="text-sm font-medium text-gray-900">
                                                        Triển lãm cá cảnh Hà Nội 2025
                                                    </h3>
                                                    <div
                                                        class="mt-1 flex items-center text-sm text-gray-500"
                                                        >
                                                        <div
                                                            class="w-4 h-4 mr-1 flex items-center justify-center"
                                                            >
                                                            <i class="ri-calendar-line"></i>
                                                        </div>
                                                        <span>25/05/2025 - 28/05/2025</span>
                                                    </div>
                                                    <div
                                                        class="mt-1 flex items-center text-sm text-gray-500"
                                                        >
                                                        <div
                                                            class="w-4 h-4 mr-1 flex items-center justify-center"
                                                            >
                                                            <i class="ri-map-pin-line"></i>
                                                        </div>
                                                        <span>Trung tâm Hội nghị Quốc gia, Hà Nội</span>
                                                    </div>
                                                </div>
                                                <div class="ml-4 flex-shrink-0 flex items-center">
                                                    <span
                                                        class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-blue-100 text-blue-800"
                                                        >
                                                        Sắp diễn ra
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="py-3">
                                            <div class="flex justify-between">
                                                <div class="flex-1">
                                                    <h3 class="text-sm font-medium text-gray-900">
                                                        Hội thảo kỹ thuật nuôi cá Koi
                                                    </h3>
                                                    <div
                                                        class="mt-1 flex items-center text-sm text-gray-500"
                                                        >
                                                        <div
                                                            class="w-4 h-4 mr-1 flex items-center justify-center"
                                                            >
                                                            <i class="ri-calendar-line"></i>
                                                        </div>
                                                        <span>30/05/2025</span>
                                                    </div>
                                                    <div
                                                        class="mt-1 flex items-center text-sm text-gray-500"
                                                        >
                                                        <div
                                                            class="w-4 h-4 mr-1 flex items-center justify-center"
                                                            >
                                                            <i class="ri-map-pin-line"></i>
                                                        </div>
                                                        <span>Khách sạn Mường Thanh, Đà Nẵng</span>
                                                    </div>
                                                </div>
                                                <div class="ml-4 flex-shrink-0 flex items-center">
                                                    <span
                                                        class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-blue-100 text-blue-800"
                                                        >
                                                        Sắp diễn ra
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="py-3">
                                            <div class="flex justify-between">
                                                <div class="flex-1">
                                                    <h3 class="text-sm font-medium text-gray-900">
                                                        Cuộc thi cá Betta toàn quốc
                                                    </h3>
                                                    <div
                                                        class="mt-1 flex items-center text-sm text-gray-500"
                                                        >
                                                        <div
                                                            class="w-4 h-4 mr-1 flex items-center justify-center"
                                                            >
                                                            <i class="ri-calendar-line"></i>
                                                        </div>
                                                        <span>05/06/2025 - 06/06/2025</span>
                                                    </div>
                                                    <div
                                                        class="mt-1 flex items-center text-sm text-gray-500"
                                                        >
                                                        <div
                                                            class="w-4 h-4 mr-1 flex items-center justify-center"
                                                            >
                                                            <i class="ri-map-pin-line"></i>
                                                        </div>
                                                        <span>SECC, Quận 7, TP. Hồ Chí Minh</span>
                                                    </div>
                                                </div>
                                                <div class="ml-4 flex-shrink-0 flex items-center">
                                                    <span
                                                        class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800"
                                                        >
                                                        Đang đăng ký
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="bg-white shadow rounded-lg overflow-hidden">
                                    <div class="px-5 py-4 border-b border-gray-200">
                                        <div class="flex items-center justify-between">
                                            <h2 class="text-lg font-medium text-gray-900">
                                                Bài viết chờ duyệt
                                            </h2>
                                            <a
                                                href="#"
                                                class="text-sm font-medium text-primary hover:text-indigo-800"
                                                >
                                                Xem tất cả
                                            </a>
                                        </div>
                                    </div>
                                    <div class="px-5 py-3 divide-y divide-gray-200">
                                        <div class="py-3">
                                            <div class="flex justify-between">
                                                <div class="flex-1">
                                                    <h3 class="text-sm font-medium text-gray-900">
                                                        Kỹ thuật nuôi cá rồng trong bể kính
                                                    </h3>
                                                    <div
                                                        class="mt-1 flex items-center text-sm text-gray-500"
                                                        >
                                                        <div
                                                            class="w-4 h-4 mr-1 flex items-center justify-center"
                                                            >
                                                            <i class="ri-user-line"></i>
                                                        </div>
                                                        <span>Trần Minh Tuấn</span>
                                                    </div>
                                                    <div
                                                        class="mt-1 flex items-center text-sm text-gray-500"
                                                        >
                                                        <div
                                                            class="w-4 h-4 mr-1 flex items-center justify-center"
                                                            >
                                                            <i class="ri-time-line"></i>
                                                        </div>
                                                        <span>20/05/2025 15:30</span>
                                                    </div>
                                                </div>
                                                <div class="ml-4 flex-shrink-0 flex space-x-2">
                                                    <button
                                                        class="inline-flex items-center p-1 border border-transparent rounded-full shadow-sm text-white bg-primary hover:bg-indigo-700 focus:outline-none"
                                                        >
                                                        <div
                                                            class="w-4 h-4 flex items-center justify-center"
                                                            >
                                                            <i class="ri-check-line"></i>
                                                        </div>
                                                    </button>
                                                    <button
                                                        class="inline-flex items-center p-1 border border-transparent rounded-full shadow-sm text-white bg-red-600 hover:bg-red-700 focus:outline-none"
                                                        >
                                                        <div
                                                            class="w-4 h-4 flex items-center justify-center"
                                                            >
                                                            <i class="ri-close-line"></i>
                                                        </div>
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="py-3">
                                            <div class="flex justify-between">
                                                <div class="flex-1">
                                                    <h3 class="text-sm font-medium text-gray-900">
                                                        Kinh nghiệm chọn thức ăn cho cá Koi
                                                    </h3>
                                                    <div
                                                        class="mt-1 flex items-center text-sm text-gray-500"
                                                        >
                                                        <div
                                                            class="w-4 h-4 mr-1 flex items-center justify-center"
                                                            >
                                                            <i class="ri-user-line"></i>
                                                        </div>
                                                        <span>Nguyễn Thị Hương</span>
                                                    </div>
                                                    <div
                                                        class="mt-1 flex items-center text-sm text-gray-500"
                                                        >
                                                        <div
                                                            class="w-4 h-4 mr-1 flex items-center justify-center"
                                                            >
                                                            <i class="ri-time-line"></i>
                                                        </div>
                                                        <span>20/05/2025 10:15</span>
                                                    </div>
                                                </div>
                                                <div class="ml-4 flex-shrink-0 flex space-x-2">
                                                    <button
                                                        class="inline-flex items-center p-1 border border-transparent rounded-full shadow-sm text-white bg-primary hover:bg-indigo-700 focus:outline-none"
                                                        >
                                                        <div
                                                            class="w-4 h-4 flex items-center justify-center"
                                                            >
                                                            <i class="ri-check-line"></i>
                                                        </div>
                                                    </button>
                                                    <button
                                                        class="inline-flex items-center p-1 border border-transparent rounded-full shadow-sm text-white bg-red-600 hover:bg-red-700 focus:outline-none"
                                                        >
                                                        <div
                                                            class="w-4 h-4 flex items-center justify-center"
                                                            >
                                                            <i class="ri-close-line"></i>
                                                        </div>
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="py-3">
                                            <div class="flex justify-between">
                                                <div class="flex-1">
                                                    <h3 class="text-sm font-medium text-gray-900">
                                                        Bệnh thường gặp ở cá Betta và cách điều trị
                                                    </h3>
                                                    <div
                                                        class="mt-1 flex items-center text-sm text-gray-500"
                                                        >
                                                        <div
                                                            class="w-4 h-4 mr-1 flex items-center justify-center"
                                                            >
                                                            <i class="ri-user-line"></i>
                                                        </div>
                                                        <span>Phạm Văn Hoàng</span>
                                                    </div>
                                                    <div
                                                        class="mt-1 flex items-center text-sm text-gray-500"
                                                        >
                                                        <div
                                                            class="w-4 h-4 mr-1 flex items-center justify-center"
                                                            >
                                                            <i class="ri-time-line"></i>
                                                        </div>
                                                        <span>19/05/2025 18:45</span>
                                                    </div>
                                                </div>
                                                <div class="ml-4 flex-shrink-0 flex space-x-2">
                                                    <button
                                                        class="inline-flex items-center p-1 border border-transparent rounded-full shadow-sm text-white bg-primary hover:bg-indigo-700 focus:outline-none"
                                                        >
                                                        <div
                                                            class="w-4 h-4 flex items-center justify-center"
                                                            >
                                                            <i class="ri-check-line"></i>
                                                        </div>
                                                    </button>
                                                    <button
                                                        class="inline-flex items-center p-1 border border-transparent rounded-full shadow-sm text-white bg-red-600 hover:bg-red-700 focus:outline-none"
                                                        >
                                                        <div
                                                            class="w-4 h-4 flex items-center justify-center"
                                                            >
                                                            <i class="ri-close-line"></i>
                                                        </div>
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- Recent orders -->
                            <div class="mt-8">
                                <div class="bg-white shadow rounded-lg">
                                    <div class="px-5 py-4 border-b border-gray-200">
                                        <div class="flex items-center justify-between">
                                            <h2 class="text-lg font-medium text-gray-900">
                                                Đơn hàng gần đây
                                            </h2>
                                            <a
                                                href="#"
                                                class="text-sm font-medium text-primary hover:text-indigo-800"
                                                >
                                                Xem tất cả
                                            </a>
                                        </div>
                                    </div>
                                    <div class="overflow-x-auto">
                                        <table class="min-w-full divide-y divide-gray-200">
                                            <thead class="bg-gray-50">
                                                <tr>
                                                    <th
                                                        scope="col"
                                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider"
                                                        >
                                                        Mã đơn hàng
                                                    </th>
                                                    <th
                                                        scope="col"
                                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider"
                                                        >
                                                        Khách hàng
                                                    </th>
                                                    <th
                                                        scope="col"
                                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider"
                                                        >
                                                        Sản phẩm
                                                    </th>
                                                    <th
                                                        scope="col"
                                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider"
                                                        >
                                                        Tổng tiền
                                                    </th>
                                                    <th
                                                        scope="col"
                                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider"
                                                        >
                                                        Trạng thái
                                                    </th>
                                                    <th
                                                        scope="col"
                                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider"
                                                        >
                                                        Ngày đặt
                                                    </th>
                                                    <th
                                                        scope="col"
                                                        class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider"
                                                        >
                                                        Thao tác
                                                    </th>
                                                </tr>
                                            </thead>
                                            <tbody class="bg-white divide-y divide-gray-200">
                                                <tr>
                                                    <td
                                                        class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900"
                                                        >
                                                        #ORD-2589
                                                    </td>
                                                    <td
                                                        class="px-6 py-4 whitespace-nowrap text-sm text-gray-500"
                                                        >
                                                        Đỗ Thanh Hà
                                                    </td>
                                                    <td
                                                        class="px-6 py-4 whitespace-nowrap text-sm text-gray-500"
                                                        >
                                                        Bể cá mini + Lọc nước
                                                    </td>
                                                    <td
                                                        class="px-6 py-4 whitespace-nowrap text-sm text-gray-500"
                                                        >
                                                        1.250.000 ₫
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <span
                                                            class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800"
                                                            >
                                                            Đã thanh toán
                                                        </span>
                                                    </td>
                                                    <td
                                                        class="px-6 py-4 whitespace-nowrap text-sm text-gray-500"
                                                        >
                                                        21/05/2025
                                                    </td>
                                                    <td
                                                        class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium"
                                                        >
                                                        <div class="flex justify-end space-x-2">
                                                            <button
                                                                class="text-primary hover:text-indigo-900"
                                                                >
                                                                Chi tiết
                                                            </button>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td
                                                        class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900"
                                                        >
                                                        #ORD-2588
                                                    </td>
                                                    <td
                                                        class="px-6 py-4 whitespace-nowrap text-sm text-gray-500"
                                                        >
                                                        Lê Văn Thành
                                                    </td>
                                                    <td
                                                        class="px-6 py-4 whitespace-nowrap text-sm text-gray-500"
                                                        >
                                                        Cá Koi Kohaku 25cm
                                                    </td>
                                                    <td
                                                        class="px-6 py-4 whitespace-nowrap text-sm text-gray-500"
                                                        >
                                                        3.500.000 ₫
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <span
                                                            class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-yellow-100 text-yellow-800"
                                                            >
                                                            Đang giao hàng
                                                        </span>
                                                    </td>
                                                    <td
                                                        class="px-6 py-4 whitespace-nowrap text-sm text-gray-500"
                                                        >
                                                        20/05/2025
                                                    </td>
                                                    <td
                                                        class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium"
                                                        >
                                                        <div class="flex justify-end space-x-2">
                                                            <button
                                                                class="text-primary hover:text-indigo-900"
                                                                >
                                                                Chi tiết
                                                            </button>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td
                                                        class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900"
                                                        >
                                                        #ORD-2587
                                                    </td>
                                                    <td
                                                        class="px-6 py-4 whitespace-nowrap text-sm text-gray-500"
                                                        >
                                                        Nguyễn Thị Mai Anh
                                                    </td>
                                                    <td
                                                        class="px-6 py-4 whitespace-nowrap text-sm text-gray-500"
                                                        >
                                                        Thức ăn cá Betta + Thuốc xử lý nước
                                                    </td>
                                                    <td
                                                        class="px-6 py-4 whitespace-nowrap text-sm text-gray-500"
                                                        >
                                                        450.000 ₫
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <span
                                                            class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-blue-100 text-blue-800"
                                                            >
                                                            Đang xử lý
                                                        </span>
                                                    </td>
                                                    <td
                                                        class="px-6 py-4 whitespace-nowrap text-sm text-gray-500"
                                                        >
                                                        20/05/2025
                                                    </td>
                                                    <td
                                                        class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium"
                                                        >
                                                        <div class="flex justify-end space-x-2">
                                                            <button
                                                                class="text-primary hover:text-indigo-900"
                                                                >
                                                                Chi tiết
                                                            </button>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td
                                                        class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900"
                                                        >
                                                        #ORD-2586
                                                    </td>
                                                    <td
                                                        class="px-6 py-4 whitespace-nowrap text-sm text-gray-500"
                                                        >
                                                        Trần Quốc Bảo
                                                    </td>
                                                    <td
                                                        class="px-6 py-4 whitespace-nowrap text-sm text-gray-500"
                                                        >
                                                        Bộ lọc Atman AT-3338S
                                                    </td>
                                                    <td
                                                        class="px-6 py-4 whitespace-nowrap text-sm text-gray-500"
                                                        >
                                                        850.000 ₫
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <span
                                                            class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800"
                                                            >
                                                            Hoàn thành
                                                        </span>
                                                    </td>
                                                    <td
                                                        class="px-6 py-4 whitespace-nowrap text-sm text-gray-500"
                                                        >
                                                        19/05/2025
                                                    </td>
                                                    <td
                                                        class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium"
                                                        >
                                                        <div class="flex justify-end space-x-2">
                                                            <button
                                                                class="text-primary hover:text-indigo-900"
                                                                >
                                                                Chi tiết
                                                            </button>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td
                                                        class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900"
                                                        >
                                                        #ORD-2585
                                                    </td>
                                                    <td
                                                        class="px-6 py-4 whitespace-nowrap text-sm text-gray-500"
                                                        >
                                                        Phạm Minh Đức
                                                    </td>
                                                    <td
                                                        class="px-6 py-4 whitespace-nowrap text-sm text-gray-500"
                                                        >
                                                        Cá Rồng Bạch Kim 15cm
                                                    </td>
                                                    <td
                                                        class="px-6 py-4 whitespace-nowrap text-sm text-gray-500"
                                                        >
                                                        5.800.000 ₫
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <span
                                                            class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-red-100 text-red-800"
                                                            >
                                                            Đã hủy
                                                        </span>
                                                    </td>
                                                    <td
                                                        class="px-6 py-4 whitespace-nowrap text-sm text-gray-500"
                                                        >
                                                        18/05/2025
                                                    </td>
                                                    <td
                                                        class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium"
                                                        >
                                                        <div class="flex justify-end space-x-2">
                                                            <button
                                                                class="text-primary hover:text-indigo-900"
                                                                >
                                                                Chi tiết
                                                            </button>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                // Products chart
                const productsChart = echarts.init(document.getElementById("products-chart"));
                const productsOption = {
                    animation: false,
                    tooltip: {
                        trigger: "axis",
                        backgroundColor: "rgba(255, 255, 255, 0.8)",
                        borderColor: "#e5e7eb",
                        borderWidth: 1,
                        textStyle: {
                            color: "#1f2937",
                        },
                    },
                    legend: {
                        data: ["Đã bán", "Còn lại"],
                        textStyle: {
                            color: "#1f2937",
                        },
                    },
                    grid: {
                        left: "3%",
                        right: "4%",
                        bottom: "3%",
                        containLabel: true,
                    },
                    xAxis: {
                        type: "category",
                        boundaryGap: false,
                        data: ["21/04", "26/04", "01/05", "06/05", "11/05", "16/05", "21/05"],
                        axisLine: {
                            lineStyle: {
                                color: "#e5e7eb",
                            },
                        },
                        axisLabel: {
                            color: "#1f2937",
                        },
                    },
                    yAxis: {
                        type: "value",
                        axisLine: {
                            lineStyle: {
                                color: "#e5e7eb",
                            },
                        },
                        axisLabel: {
                            color: "#1f2937",
                        },
                        splitLine: {
                            lineStyle: {
                                color: "#f3f4f6",
                            },
                        },
                    },
                    series: [
                        {
                            name: "Đã bán",
                            type: "line",
                            smooth: true,
                            lineStyle: {
                                width: 3,
                                color: "rgba(87, 181, 231, 1)",
                            },
                            symbol: "none",
                            areaStyle: {
                                color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
                                    {
                                        offset: 0,
                                        color: "rgba(87, 181, 231, 0.3)",
                                    },
                                    {
                                        offset: 1,
                                        color: "rgba(87, 181, 231, 0.1)",
                                    },
                                ]),
                            },
                            data: [120, 132, 101, 134, 90, 230, 210],
                        },
                        {
                            name: "Còn lại",
                            type: "line",
                            smooth: true,
                            lineStyle: {
                                width: 3,
                                color: "rgba(141, 211, 199, 1)",
                            },
                            symbol: "none",
                            areaStyle: {
                                color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
                                    {
                                        offset: 0,
                                        color: "rgba(141, 211, 199, 0.3)",
                                    },
                                    {
                                        offset: 1,
                                        color: "rgba(141, 211, 199, 0.1)",
                                    },
                                ]),
                            },
                            data: [220, 182, 191, 234, 290, 330, 310],
                        },
                    ],
                };
                productsChart.setOption(productsOption);
                // Category chart
                const categoryChart = echarts.init(document.getElementById("category-chart"));
                const categoryOption = {
                    animation: false,
                    tooltip: {
                        trigger: "item",
                        backgroundColor: "rgba(255, 255, 255, 0.8)",
                        borderColor: "#e5e7eb",
                        borderWidth: 1,
                        textStyle: {
                            color: "#1f2937",
                        },
                    },
                    legend: {
                        orient: "vertical",
                        right: 10,
                        top: "center",
                        textStyle: {
                            color: "#1f2937",
                        },
                    },
                    series: [
                        {
                            name: "Phân loại sản phẩm",
                            type: "pie",
                            radius: ["40%", "70%"],
                            center: ["40%", "50%"],
                            avoidLabelOverlap: false,
                            itemStyle: {
                                borderRadius: 8,
                                borderColor: "#fff",
                                borderWidth: 2,
                            },
                            label: {
                                show: false,
                            },
                            emphasis: {
                                label: {
                                    show: false,
                                },
                            },
                            labelLine: {
                                show: false,
                            },
                            data: [
                                {
                                    value: 735,
                                    name: "Cá cảnh",
                                    itemStyle: {color: "rgba(87, 181, 231, 1)"},
                                },
                                {
                                    value: 580,
                                    name: "Thức ăn",
                                    itemStyle: {color: "rgba(141, 211, 199, 1)"},
                                },
                                {
                                    value: 484,
                                    name: "Thiết bị",
                                    itemStyle: {color: "rgba(251, 191, 114, 1)"},
                                },
                                {
                                    value: 300,
                                    name: "Phụ kiện",
                                    itemStyle: {color: "rgba(252, 141, 98, 1)"},
                                },
                            ],
                        },
                    ],
                };
                categoryChart.setOption(categoryOption);
                // Resize charts when window size changes
                window.addEventListener("resize", function () {
                    productsChart.resize();
                    categoryChart.resize();
                });
            });
        </script>
    </body>
</html>