<%-- 
    Document   : Header
    Created on : May 24, 2025, 1:36:55 PM
    Author     : Viehai
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<html lang="en">

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
