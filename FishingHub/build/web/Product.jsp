<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.Category" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Sản phẩm</title>
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <link
            href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap"
            rel="stylesheet"
            />
        <link
            href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.6.0/remixicon.min.css"
            rel="stylesheet"
            />
        <script src="https://cdn.tailwindcss.com/3.4.16"></script>
        <script>
            tailwind.config = {
                theme: {
                    extend: {
                        colors: {
                            primary: "#1E88E5",
                            secondary: "#64B5F6",
                        },
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
        <style>
            :where([class^="ri-"])::before {
                content: "\f3c2";
            }
            body {
                font-family: 'Inter', sans-serif;
                background-color: #f9fafb;
            }
            input[type="number"]::-webkit-inner-spin-button,
            input[type="number"]::-webkit-outer-spin-button {
                -webkit-appearance: none;
                margin: 0;
            }
            .custom-checkbox {
                position: relative;
                display: inline-block;
                width: 20px;
                height: 20px;
                border: 2px solid #ccc;
                border-radius: 4px;
                transition: all 0.2s;
            }
            .custom-checkbox.checked {
                background-color: #1E88E5;
                border-color: #1E88E5;
            }
            .custom-checkbox.checked::after {
                content: '';
                position: absolute;
                left: 6px;
                top: 2px;
                width: 6px;
                height: 12px;
                border: solid white;
                border-width: 0 2px 2px 0;
                transform: rotate(45deg);
            }
            .custom-range {
                -webkit-appearance: none;
                width: 100%;
                height: 6px;
                background: #e5e7eb;
                border-radius: 5px;
            }
            .custom-range::-webkit-slider-thumb {
                -webkit-appearance: none;
                appearance: none;
                width: 18px;
                height: 18px;
                background: #1E88E5;
                border-radius: 50%;
                cursor: pointer;
            }
            .custom-range::-moz-range-thumb {
                width: 18px;
                height: 18px;
                background: #1E88E5;
                border-radius: 50%;
                cursor: pointer;
            }
            .product-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 15px rgba(0, 0, 0, 0.1);
            }
            .category-card:hover {
                transform: translateY(-3px);
            }
            .custom-radio {
                position: relative;
                display: inline-block;
                width: 20px;
                height: 20px;
                border: 2px solid #ccc;
                border-radius: 50%;
                transition: all 0.2s;
            }
            .custom-radio.checked {
                border-color: #1E88E5;
            }
            .custom-radio.checked::after {
                content: '';
                position: absolute;
                left: 4px;
                top: 4px;
                width: 8px;
                height: 8px;
                background-color: #1E88E5;
                border-radius: 50%;
            }
            .custom-switch {
                position: relative;
                display: inline-block;
                width: 48px;
                height: 24px;
            }
            .custom-switch-input {
                opacity: 0;
                width: 0;
                height: 0;
            }
            .custom-switch-slider {
                position: absolute;
                cursor: pointer;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background-color: #ccc;
                transition: .4s;
                border-radius: 24px;
            }
            .custom-switch-slider:before {
                position: absolute;
                content: "";
                height: 18px;
                width: 18px;
                left: 3px;
                bottom: 3px;
                background-color: white;
                transition: .4s;
                border-radius: 50%;
            }
            .custom-switch-input:checked + .custom-switch-slider {
                background-color: #1E88E5;
            }
            .custom-switch-input:checked + .custom-switch-slider:before {
                transform: translateX(24px);
            }
        </style>
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
                        <a href="FishKnowledge.jsp" class="px-4 py-2 text-gray-800 font-medium hover:text-primary">Kiến Thức</a>
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
        <div class="bg-white border-b">
            <div class="container mx-auto px-4 py-3">
                <div class="flex items-center text-sm">
                    <a href="Home.jsp" class="text-gray-500 hover:text-primary">Trang Chủ</a>
                    <span class="mx-2 text-gray-400">/</span>
                    <span class="text-primary font-medium">Sản Phẩm</span>
                </div>
            </div>
        </div>

        <!-- Main Content -->
        <div class="container mx-auto px-4 py-8">
            <div class="flex flex-col lg:flex-row gap-8">
                <!-- Filter Sidebar -->
                <div class="lg:w-1/4 space-y-6">
                    <!-- Search Products -->
                    <div class="bg-white rounded-lg shadow-sm p-4">
                        <div class="relative">
                            <form action="ProductServlet" method="GET">
                                <input type="hidden" name="btAction" value="search" />
                                <%
                                    String searchValue = (String) request.getAttribute("searchValue");
                                    if (searchValue == null) searchValue = "";
                                %>
                                <input
                                    type="text"
                                    name="searchValue"
                                    value="<%= searchValue %>"
                                    placeholder="Search products..."
                                    class="w-full pl-10 pr-4 py-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent text-sm"
                                    />
                                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none w-10 h-full">
                                    <i class="ri-search-line text-gray-400"></i>
                                </div>
                            </form>
                        </div>
                    </div>


                    <!-- Brand Filter -->
                    <div class="bg-white rounded-lg shadow-sm p-4">
                        <h3 class="font-bold text-gray-800 mb-3">Thương Hiệu</h3>

                        <form action="ProductServlet" method="get">
                            <ul class="space-y-2">
                                <% 
                                    if (request.getAttribute("categoryList") != null) {
                                        List<Category> categoryList = (List<Category>) request.getAttribute("categoryList");
                                        List<Integer> selectedBrands = (List<Integer>) request.getAttribute("selectedBrands");
                                        if (selectedBrands == null) selectedBrands = new ArrayList<>();
                                        for (Category category : categoryList) {
                                %>
                                <li class="flex items-center">
                                    <input class="custom-checkbox" type="checkbox"
                                           name="brand"
                                           value="<%=category.getCategoryId()%>"
                                           id="brand<%=category.getCategoryId()%>"
                                           <%= selectedBrands.contains(category.getCategoryId()) ? "checked" : "" %> />
                                    <label for="brand<%=category.getCategoryId()%>" class="ml-2 text-gray-700 cursor-pointer">
                                        <%=category.getName()%>
                                    </label>
                                </li>
                                <% } } %>
                            </ul>

                            <button type="submit" name="btAction" value="filterBrand"
                                    class="mt-3 px-4 py-2 bg-blue-500 text-white rounded hover:bg-blue-600">
                                Lọc
                            </button>
                        </form>
                    </div>


<!--                     Rating Filter 
                    <div class="bg-white rounded-lg shadow-sm p-4">
                        <h3 class="font-bold text-gray-800 mb-3">Ratings</h3>
                        <ul class="space-y-2">
                            <li class="flex items-center">
                                <div class="custom-checkbox checked" id="rating5"></div>
                                <label
                                    for="rating5"
                                    class="ml-2 flex items-center cursor-pointer"
                                    >
                                    <div class="flex text-yellow-400">
                                        <i class="ri-star-fill"></i>
                                        <i class="ri-star-fill"></i>
                                        <i class="ri-star-fill"></i>
                                        <i class="ri-star-fill"></i>
                                        <i class="ri-star-fill"></i>
                                    </div>
                                    <span class="ml-1 text-gray-700">5 stars</span>
                                </label>
                                <span class="ml-auto text-gray-500 text-sm">(142)</span>
                            </li>
                            <li class="flex items-center">
                                <div class="custom-checkbox" id="rating4"></div>
                                <label
                                    for="rating4"
                                    class="ml-2 flex items-center cursor-pointer"
                                    >
                                    <div class="flex text-yellow-400">
                                        <i class="ri-star-fill"></i>
                                        <i class="ri-star-fill"></i>
                                        <i class="ri-star-fill"></i>
                                        <i class="ri-star-fill"></i>
                                        <i class="ri-star-line"></i>
                                    </div>
                                    <span class="ml-1 text-gray-700">4 stars</span>
                                </label>
                                <span class="ml-auto text-gray-500 text-sm">(287)</span>
                            </li>
                            <li class="flex items-center">
                                <div class="custom-checkbox" id="rating3"></div>
                                <label
                                    for="rating3"
                                    class="ml-2 flex items-center cursor-pointer"
                                    >
                                    <div class="flex text-yellow-400">
                                        <i class="ri-star-fill"></i>
                                        <i class="ri-star-fill"></i>
                                        <i class="ri-star-fill"></i>
                                        <i class="ri-star-line"></i>
                                        <i class="ri-star-line"></i>
                                    </div>
                                    <span class="ml-1 text-gray-700">3 stars</span>
                                </label>
                                <span class="ml-auto text-gray-500 text-sm">(412)</span>
                            </li>
                        </ul>
                    </div>

                     Reset Filters 
                    <button
                        class="w-full bg-gray-100 hover:bg-gray-200 text-gray-700 py-2 rounded-button font-medium transition duration-300 whitespace-nowrap"
                        >
                        <i class="ri-refresh-line mr-2"></i>Reset Filters
                    </button>-->
                </div>

                <!-- Product Content -->
                <div class="lg:w-3/4">
                    <!--                     Popular Categories 
                                        <div class="mb-8">
                                            <h2 class="text-xl font-bold text-gray-800 mb-4">
                                                Popular Categories
                                            </h2>
                                            <div class="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4">
                                                 Category 1 
                                                <div
                                                    class="bg-white rounded-lg shadow-sm overflow-hidden category-card transition duration-300"
                                                    >
                                                    <div class="h-32 overflow-hidden">
                                                        <img
                                                            src="https://readdy.ai/api/search-image?query=fishing%252520rods%252520collection%252C%252520various%252520types%252C%252520high%252520quality%252520carbon%252520fiber%252520fishing%252520rods%252C%252520clean%252520white%252520background%252C%252520product%252520photography%252C%252520detailed%252520view&width=300&height=200&seq=22101&orientation=landscape"
                                                            alt="Fishing Rods"
                                                            class="w-full h-full object-cover object-top"
                                                            />
                                                    </div>
                                                    <div class="p-3 text-center">
                                                        <h3 class="font-medium text-gray-800">Fishing Rods</h3>
                                                        <p class="text-sm text-gray-500">124 products</p>
                                                    </div>
                                                </div>
                                                 Category 2 
                                                <div
                                                    class="bg-white rounded-lg shadow-sm overflow-hidden category-card transition duration-300"
                                                    >
                                                    <div class="h-32 overflow-hidden">
                                                        <img
                                                            src="https://readdy.ai/api/search-image?query=fishing%252520reels%252520collection%252C%252520various%252520types%252C%252520high%252520quality%252520metal%252520fishing%252520reels%252C%252520clean%252520white%252520background%252C%252520product%252520photography%252C%252520detailed%252520view&width=300&height=200&seq=22102&orientation=landscape"
                                                            alt="Fishing Reels"
                                                            class="w-full h-full object-cover object-top"
                                                            />
                                                    </div>
                                                    <div class="p-3 text-center">
                                                        <h3 class="font-medium text-gray-800">Fishing Reels</h3>
                                                        <p class="text-sm text-gray-500">98 products</p>
                                                    </div>
                                                </div>
                                                 Category 3 
                                                <div
                                                    class="bg-white rounded-lg shadow-sm overflow-hidden category-card transition duration-300"
                                                    >
                                                    <div class="h-32 overflow-hidden">
                                                        <img
                                                            src="https://readdy.ai/api/search-image?query=fishing%252520lures%252520collection%252C%252520various%252520colorful%252520artificial%252520baits%252C%252520clean%252520white%252520background%252C%252520product%252520photography%252C%252520detailed%252520view&width=300&height=200&seq=22103&orientation=landscape"
                                                            alt="Fishing Lures"
                                                            class="w-full h-full object-cover object-top"
                                                            />
                                                    </div>
                                                    <div class="p-3 text-center">
                                                        <h3 class="font-medium text-gray-800">Fishing Lures</h3>
                                                        <p class="text-sm text-gray-500">156 products</p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>-->

                    <!-- Products Header -->
                    <div class="bg-white rounded-lg shadow-sm p-4 mb-6">
                        <div
                            class="flex flex-col md:flex-row md:items-center md:justify-between gap-4"
                            >
                            <div>
                                <h1 class="text-xl font-bold text-gray-800">
                                    Sản Phẩm Câu Cá
                                </h1>
                            </div>
                        </div>
                    </div>
                    <!-- Products Grid -->
                    <div
                        class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6 mb-8"
                        >
                        <%
                        if(request.getAttribute("productList") != null){
                            List<Product> productList=  (List<Product>) request.getAttribute("productList");
                            for(Product product : productList){
                        %>
                        <!-- Product 1 -->
                        <div
                            class="bg-white rounded-lg shadow-sm overflow-hidden product-card transition duration-300"
                            >
                            <div class="relative">
                                <div class="h-48 overflow-hidden">
                                    <img
                                        src="<%=product.getImage()%>"
                                        alt="Fishing Rod"
                                        class="w-full h-full object-cover object-top"
                                        />
                                </div>
                            </div>
                            <div class="p-4">
                                <h3 class="text-lg font-medium mb-1 text-gray-800">
                                    <!--Shimano Stradic Fishing Rod-->
                                    <%=product.getName()%>
                                </h3>
                                <div class="flex items-center mb-2">
                                    <div class="flex text-yellow-400">
                                        <i class="ri-star-fill"></i>
                                        <i class="ri-star-fill"></i>
                                        <i class="ri-star-fill"></i>
                                        <i class="ri-star-fill"></i>
                                        <i class="ri-star-fill"></i>
                                    </div>
                                    <span class="text-xs text-gray-500 ml-1">(126)</span>
                                </div>
                                <div class="flex items-center justify-between mb-3">
                                    <div>
                                        <span class="text-lg font-bold text-gray-800">
                                            <!--                                            2,850,000₫-->
                                            <%= product.getPrice()%>
                                        </span
                                        >
                                    </div>
                                    <span class="text-sm text-gray-500">
                                        Sold <%= product.getSoldQuantity()%>
                                    </span>
                                </div>
                                <button
                                    class="w-full bg-primary hover:bg-blue-600 text-white py-2 rounded-button font-medium transition duration-300 whitespace-nowrap"
                                    >
                                    <i class="ri-shopping-cart-add-line mr-2"></i>Add to Cart
                                </button>
                            </div>
                        </div>
                        <%
                     }
                 }
                        %>         
                    </div>


                    <!-- Pagination -->
                    <%
    int currentPage = (request.getAttribute("currentPage") != null) ? (int) request.getAttribute("currentPage") : 1;
    int totalPages = (request.getAttribute("totalPages") != null) ? (int) request.getAttribute("totalPages") : 1;
    List<Integer> selectedBrands = (List<Integer>) request.getAttribute("selectedBrands");
    if (selectedBrands == null) selectedBrands = new ArrayList<>();
    
    String btAction = (request.getAttribute("btAction") != null) ? (String) request.getAttribute("btAction") : "";
    
    StringBuilder baseUrl = new StringBuilder("ProductServlet?btAction=").append(btAction).append("&searchValue=");
    baseUrl.append(searchValue);
    for (Integer brandId : selectedBrands) {
        baseUrl.append("&brand=").append(brandId);
    }
                    %>

                    <div class="flex justify-center mt-8 mb-12">
                        <nav class="flex items-center">
                            <!-- Previous page -->
                            <a href="<%= baseUrl.toString() %>&page=<%= (currentPage > 1 ? currentPage - 1 : 1) %>"
                               class="w-10 h-10 flex items-center justify-center rounded border border-gray-300 bg-white text-gray-700 hover:bg-gray-50 mr-2">
                                <i class="ri-arrow-left-s-line"></i>
                            </a>

                            <!-- Page numbers -->
                            <%
                                for (int i = 1; i <= totalPages; i++) {
                            %>
                            <a href="<%= baseUrl.toString() %>&page=<%= i %>"
                               class="w-10 h-10 flex items-center justify-center rounded border
                               <%= (i == currentPage ? "border-primary bg-primary text-white" : "border-gray-300 bg-white text-gray-700 hover:bg-gray-50") %> mr-2">
                                <%= i %>
                            </a>
                            <%
                                }
                            %>

                            <!-- Next page -->
                            <a href="<%= baseUrl.toString() %>&page=<%= (currentPage < totalPages ? currentPage + 1 : totalPages) %>"
                               class="w-10 h-10 flex items-center justify-center rounded border border-gray-300 bg-white text-gray-700 hover:bg-gray-50">
                                <i class="ri-arrow-right-s-line"></i>
                            </a>
                        </nav>
                    </div>

                </div>
            </div>
        </div>

        <!-- Footer -->
        <footer class="bg-gray-800 text-white pt-12 pb-6">
            <div class="container mx-auto px-4">
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8 mb-8">
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
                    <div>
                        <h3 class="text-lg font-bold mb-4">Liên Kết Nhanh</h3>
                        <ul class="space-y-2">
                            <li><a href="Home.jsp" class="text-gray-400 hover:text-white">Trang Chủ</a></li>
                            <li><a href="Event.jsp" class="text-gray-400 hover:text-white">Sự Kiện</a></li>
                            <li><a href="NewFeed.jsp" class="text-gray-400 hover:text-white">Bảng Tin</a></li>
                            <li><a href="Product.jsp" class="text-gray-400 hover:text-white">Cửa Hàng</a></li>
                            <li><a href="FishKnowledge.jsp" class="text-gray-400 hover:text-white">Kiến Thức</a></li>
                            <li><a href="Achievement.jsp" class="text-gray-400 hover:text-white">Xếp Hạng</a></li>
                        </ul>
                    </div>
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